package com.watch.model.services;

import com.watch.model.dao.CartItemDao;
import com.watch.model.dao.CartItemDaoImpl;
import com.watch.model.entities.CartItem;
import com.watch.model.entities.Product;
import com.watch.model.entities.User;
import jakarta.persistence.EntityManager;
import java.util.List;
import java.util.Map;

public class CartService {

    private final EntityManager em;
    private final CartItemDao cartItemDao;

    public CartService(EntityManager em) {
        this.em = em;
        this.cartItemDao = new CartItemDaoImpl(em);
    }

    public void updateCartSession(Map<Integer, Integer> sessionCart, int productId, int delta) {
        Product product = em.find(Product.class, productId);
        if (product == null)
            throw new IllegalArgumentException("Product not found");

        int currentQty = sessionCart.getOrDefault(productId, 0);
        int newQty = currentQty + delta;

        if (newQty <= 0) {
            sessionCart.remove(productId);
        } else if (newQty > product.getQuantity()) {
            throw new IllegalArgumentException("Only " + product.getQuantity() + " in stock for " + product.getName());
        } else {
            sessionCart.put(productId, newQty);
        }
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
}