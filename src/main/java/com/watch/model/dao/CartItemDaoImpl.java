package com.watch.model.dao;

import com.watch.model.entities.CartItem;
import com.watch.model.entities.Product;
import com.watch.model.entities.User;
import com.watch.util.EntityManagerFactorySingleton;
import jakarta.persistence.EntityManager;

import java.util.List;

public class CartItemDaoImpl implements CartItemDao{
    private EntityManager getEm() {
        return EntityManagerFactorySingleton.getInstance().createEntityManager();
    }
    @Override
    public List<CartItem> getCartItemsByUserId(int userId) {
        EntityManager em = getEm();
        try {
            return em.createQuery("SELECT ci FROM CartItem ci WHERE ci.user.userId = :userId", CartItem.class).setParameter("userId", userId)
                    .getResultList();
        }finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public List<CartItem> getCartByUser(User user) {
        EntityManager em = getEm();
        try {
            return em.createQuery("SELECT c FROM CartItem c WHERE c.user = :user", CartItem.class).setParameter("user", user).getResultList();
        } finally {
            if (em.isOpen()) em.close();
        }
    }
    @Override
    public CartItem getCartItem(User user, Product product) {
        EntityManager em = getEm();
        try {
            return em.createQuery("SELECT c FROM CartItem c WHERE c.user = :user AND c.product = :product", CartItem.class)
                    .setParameter("user", user)
                    .setParameter("product", product)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public boolean addToCart(User user, Product product, int quantity) {
        EntityManager em = getEm();
        try {
            CartItem cartItem = getCartItem(user, product);
            em.getTransaction().begin();
            if (cartItem != null) {
                cartItem.setQuantity(cartItem.getQuantity() + quantity);
                em.merge(cartItem);
            } else {
                CartItem newCartItem = new CartItem(user, product, quantity);
                em.persist(newCartItem);
            }
            em.getTransaction().commit();
            return true;
        }catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            return false;
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public boolean updateCartItemQuantity(User user, Product product, int quantity) {
        EntityManager em = getEm();
        try {
            em.getTransaction().begin();

            if (quantity <= 0) {
                em.getTransaction().rollback();
                return removeFromCart(user, product);
            }

            int updated = em.createQuery("UPDATE CartItem c SET c.quantity = :quantity WHERE c.user = :user AND c.product = :product")
                    .setParameter("quantity", quantity)
                    .setParameter("user", user)
                    .setParameter("product", product)
                    .executeUpdate();

            em.getTransaction().commit();
            return updated > 0;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            return false;
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public boolean removeFromCart(User user, Product product) {
        EntityManager em = getEm();
        try {
            em.getTransaction().begin();

            int deleted = em.createQuery("DELETE FROM CartItem c WHERE c.user = :user AND c.product = :product")
                    .setParameter("user", user)
                    .setParameter("product", product)
                    .executeUpdate();

            em.getTransaction().commit();
            return deleted > 0;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            return false;
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public boolean clearCart(User user) {
        EntityManager em = getEm();
        try {
            em.getTransaction().begin();

            em.createQuery("DELETE FROM CartItem c WHERE c.user = :user")
                    .setParameter("user", user)
                    .executeUpdate();

            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            return false;
        } finally {
            if (em.isOpen()) em.close();
        }
    }
}
