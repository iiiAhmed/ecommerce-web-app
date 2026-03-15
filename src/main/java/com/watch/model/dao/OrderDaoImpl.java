package com.watch.model.dao;

import com.watch.model.entities.Order;
import com.watch.util.EntityManagerFactorySingleton;
import jakarta.persistence.EntityManager;

import java.util.List;

public class OrderDaoImpl implements OrderDao {

    private EntityManager getEm() {
        return EntityManagerFactorySingleton.getInstance().createEntityManager();
    }

    @Override
    public Order getOrderById(int id) {
        EntityManager em = getEm();
        try {
            List<Order> results = em.createQuery(
                    "SELECT o FROM Order o LEFT JOIN FETCH o.items LEFT JOIN FETCH o.user WHERE o.orderId = :id", Order.class)
                    .setParameter("id", id)
                    .getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public List<Order> getOrdersByUser(int userId) {
        EntityManager em = getEm();
        try {
            return em.createQuery("SELECT o FROM Order o WHERE o.user.userId = :userId", Order.class)
                    .setParameter("userId", userId)
                    .getResultList();
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public List<Order> getAllOrders() {
        EntityManager em = getEm();
        try {
            return em.createQuery("SELECT o FROM Order o", Order.class).getResultList();
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public boolean addOrder(Order order) {
        EntityManager em = getEm();
        try {
            em.getTransaction().begin();
            em.persist(order);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            return false;
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public boolean updateOrder(Order order) {
        EntityManager em = getEm();
        try {
            em.getTransaction().begin();
            em.merge(order);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            return false;
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public boolean deleteOrder(int id) {
        EntityManager em = getEm();
        try {
            em.getTransaction().begin();
            Order order = em.find(Order.class, id);
            if (order == null) return false;
            em.remove(order);
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
