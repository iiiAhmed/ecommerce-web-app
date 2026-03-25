package com.watch.model.services;

import com.watch.model.dao.*;
import com.watch.model.dto.CartItemDTO;
import com.watch.model.entities.*;
import jakarta.persistence.EntityManager;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class CartService {

    private final EntityManager em;
    private final CartItemDao cartItemDao;

    private final UserDao userDao;
    private final ProductDao productDao;
    public CartService(EntityManager em) {
        this.em = em;
        this.cartItemDao = new CartItemDaoImpl(em);
        this.userDao = new UserDaoImpl();
        this.productDao = new ProductDaoImpl(em);
    }

    public void updateCartSession(Map<Integer, Integer> sessionCart, int productId, int delta) {
        Product product = em.find(Product.class, productId);
        if (product == null)
            throw new IllegalArgumentException("Product not found");

        int currentQty = sessionCart.getOrDefault(productId, 0);
        int newQty = currentQty + delta;

        if (newQty <= 0) {
            sessionCart.remove(productId);
            return;
        }
        int available = product.getQuantity();
        sessionCart.put(productId, Math.min(newQty, available));
    }

    public void saveSessionCartToDb(int userId, Map<Integer, Integer> sessionCart) {
        User user = em.find(User.class, userId);
        if (user == null)
            return;

        for (Map.Entry<Integer, Integer> entry : sessionCart.entrySet()) {
            Product product = em.find(Product.class, entry.getKey());
            if (product != null && entry.getValue() > 0) {
                cartItemDao.addToCart(user, product, entry.getValue());
            }
        }
    }

    public void loadDbCartIntoSession(int userId, Map<Integer, Integer> sessionCart) {
        List<CartItem> dbItems = cartItemDao.getCartItemsByUserId(userId);
        for (CartItem item : dbItems) {
            int productId = item.getProduct().getProductId();
            int sessionQty = sessionCart.getOrDefault(productId, 0);
            sessionCart.put(productId, Math.max(sessionQty, item.getQuantity()));
        }
        cartItemDao.clearCartByUserId(userId);
    }

    public int getCartCountSession(Map<Integer, Integer> cart) {
        if (cart == null) return 0;
        return cart.values().stream().mapToInt(Integer::intValue).sum();
    }

    public List<CartItem> getCartItems(int userId) {
        return cartItemDao.getCartItemsByUserId(userId);
    }

    public List<CartItemDTO> buildCartDTOs(Map<Integer, Integer> sessionCart) {
        if (sessionCart == null || sessionCart.isEmpty()) return new ArrayList<>();

        List<Product> products = productDao.findProductsByIds(sessionCart.keySet());

        List<CartItemDTO> items = new ArrayList<>();
        for (Product product : products) {
            int qty = sessionCart.get(product.getProductId());
            if (qty > 0) {
                items.add(new CartItemDTO(
                        product.getProductId(),
                        product.getName(),
                        product.getImageUrl(),
                        qty,
                        product.getPrice()
                ));
            }
        }
        return items;
    }

    public void checkout(int userId, Map<Integer, Integer> cart) {
        User user = userDao.getUserById(userId);
        if (user == null)
            throw new IllegalStateException("User not found.");

        List<Product> products = productDao.findProductsByIds(cart.keySet());

        double total = 0;
        for (Product product : products) {
            int cartQty = cart.get(product.getProductId());

            if (product.getQuantity() < cartQty)
                throw new IllegalStateException("Only " + product.getQuantity() + " of \"" + product.getName() + "\" left in stock. Please update your cart.");

            total += product.getPrice() * cartQty;
        }

        if (products.size() != cart.size())
            throw new IllegalStateException("A product in your cart no longer exists. Please refresh your cart.");

        if (user.getCreditLimit() < total)
            throw new IllegalStateException(
                    "Insufficient credit. Your total is $" + String.format("%.2f", total) + " but your available credit is $" +
                            String.format("%.2f", user.getCreditLimit()) + ".");

        Order order = new Order();
        List<OrderItem> orderItems = new ArrayList<>();
        for (Product product : products) {
            int cartQty = cart.get(product.getProductId());
            product.setQuantity(product.getQuantity() - cartQty);
            OrderItem orderItem = new OrderItem(cartQty, product, order);
            orderItems.add(orderItem);

        }
        System.out.println(user.getCreditLimit());
        System.out.println(total);
        user.setCreditLimit(user.getCreditLimit() - total);
        System.out.println(user.getCreditLimit());
        order.setUser(user);
        order.setItems(orderItems);
        order.setTotalAmount(total);
        order.setOrderedAt(LocalDateTime.now());

        OrderService orderService = new OrderService(em);
        orderService.addOrder(order);



        cart.clear();
    }
}