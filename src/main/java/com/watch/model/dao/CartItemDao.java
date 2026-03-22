package com.watch.model.dao;

import com.watch.model.entities.CartItem;
import com.watch.model.entities.Product;
import com.watch.model.entities.User;
import java.util.List;

public interface CartItemDao {
    List<CartItem> getCartItemsByUserId(int userId);
    List<CartItem> getCartByUser(User user);
    CartItem getCartItem(User user, Product product);
    void addToCart(User user, Product product, int quantity);
    void updateCartItemQuantity(User user, Product product, int quantity);
    void removeFromCart(User user, Product product);
    void clearCart(User user);
    void clearCartByUserId(int userId);
}