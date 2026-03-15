package com.watch.model.dao;

import com.watch.model.entities.CartItem;
import com.watch.model.entities.Product;
import com.watch.model.entities.User;

import java.util.List;

public interface CartItemDao {
    List<CartItem> getCartItemsByUserId(int userId);
    List<CartItem> getCartByUser(User user);
    CartItem getCartItem(User user, Product product);
    boolean addToCart(User user, Product product, int quantity);
    boolean updateCartItemQuantity(User user, Product product, int quantity);
    boolean removeFromCart(User user, Product product);
    boolean clearCart(User user);





}
