package com.watch.model.dao;

import com.watch.model.entities.CartItem;
import com.watch.model.entities.Product;
import com.watch.model.entities.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import java.util.List;

public class CartItemDaoImpl implements CartItemDao {

    private final EntityManager em;

    public CartItemDaoImpl(EntityManager em) {
        this.em = em;
    }

    @Override
    public List<CartItem> getCartItemsByUserId(int userId) {
        return em.createQuery("SELECT ci FROM CartItem ci WHERE ci.user.userId = :userId", CartItem.class)
                .setParameter("userId", userId)
                .getResultList();
    }

    @Override
    public List<CartItem> getCartByUser(User user) {
        return em.createQuery("SELECT c FROM CartItem c WHERE c.user = :user", CartItem.class)
                .setParameter("user", user)
                .getResultList();
    }

    @Override
    public CartItem getCartItem(User user, Product product) {
        try {
            return em.createQuery("SELECT c FROM CartItem c WHERE c.user = :user AND c.product = :product", CartItem.class)
                    .setParameter("user", user)
                    .setParameter("product", product)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public void addToCart(User user, Product product, int quantity) {
        CartItem existing = getCartItem(user, product);
        if (existing != null) {
            existing.setQuantity(existing.getQuantity() + quantity);
        } else {
            em.persist(new CartItem(user, product, quantity));
        }
    }

    @Override
    public void updateCartItemQuantity(User user, Product product, int quantity) {
        em.createQuery("UPDATE CartItem c SET c.quantity = :qty WHERE c.user = :user AND c.product = :product")
                .setParameter("qty", quantity)
                .setParameter("user", user)
                .setParameter("product", product)
                .executeUpdate();
    }

    @Override
    public void removeFromCart(User user, Product product) {
        em.createQuery("DELETE FROM CartItem c WHERE c.user = :user AND c.product = :product")
                .setParameter("user", user)
                .setParameter("product", product)
                .executeUpdate();
    }

    @Override
    public void clearCart(User user) {
        em.createQuery("DELETE FROM CartItem c WHERE c.user = :user")
                .setParameter("user", user)
                .executeUpdate();
    }

    @Override
    public void clearCartByUserId(int userId) {
        em.createQuery("DELETE FROM CartItem c WHERE c.user.userId = :userId")
                .setParameter("userId", userId)
                .executeUpdate();
    }
}