package com.watch.model.dao;

import com.watch.model.entities.OrderItem;
import jakarta.persistence.EntityManager;

import java.util.List;

public class OrderItemDaoImpl implements OrderItemDao {

    private final EntityManager em;

    public OrderItemDaoImpl(EntityManager em) {
        this.em = em;
    }

    @Override
    public OrderItem getOrderItemById(int id) {
        return em.find(OrderItem.class, id);
    }

    @Override
    public List<OrderItem> getOrderItemsByOrder(int orderId) {
        return em.createQuery("SELECT oi FROM OrderItem oi WHERE oi.order.orderId = :orderId", OrderItem.class)
                .setParameter("orderId", orderId)
                .getResultList();
    }

    @Override
    public boolean addOrderItem(OrderItem item) {
        try {
            em.persist(item);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public boolean updateOrderItem(OrderItem item) {
        try {
            em.merge(item);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public boolean deleteOrderItem(int id) {
        try {
            OrderItem item = em.find(OrderItem.class, id);
            if (item == null) return false;
            em.remove(item);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
