package com.watch.model.dao;

import com.watch.model.entities.Order;
import jakarta.persistence.EntityManager;

import java.util.List;

public class OrderDaoImpl implements OrderDao {

    private final EntityManager em;

    public OrderDaoImpl(EntityManager em) {
        this.em = em;
    }

    @Override
    public Order getOrderById(int id) {
        List<Order> results = em.createQuery(
                "SELECT o FROM Order o LEFT JOIN FETCH o.items LEFT JOIN FETCH o.user WHERE o.orderId = :id", Order.class)
                .setParameter("id", id)
                .getResultList();
        return results.isEmpty() ? null : results.get(0);
    }

    @Override
    public List<Order> getOrdersByUser(int userId) {
        return em.createQuery("SELECT o FROM Order o WHERE o.user.userId = :userId", Order.class)
                .setParameter("userId", userId)
                .getResultList();
    }

    @Override
    public List<Order> getAllOrders() {
        return em.createQuery("SELECT o FROM Order o", Order.class).getResultList();
    }

    @Override
    public boolean addOrder(Order order) {
        try {
            em.persist(order);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public boolean updateOrder(Order order) {
        try {
            em.merge(order);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public boolean deleteOrder(int id) {
        try {
            Order order = em.find(Order.class, id);
            if (order == null) return false;
            em.remove(order);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
