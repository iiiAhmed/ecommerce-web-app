package com.watch.model.dao;

import com.watch.model.entities.OrderItem;
import com.watch.util.EntityManagerFactorySingleton;
import jakarta.persistence.EntityManager;

import java.util.List;

public class OrderItemDaoImpl implements OrderItemDao {

    private EntityManager getEm() {
        return EntityManagerFactorySingleton.getInstance().createEntityManager();
    }

    @Override
    public OrderItem getOrderItemById(int id) {
        EntityManager em = getEm();
        try {
            return em.find(OrderItem.class, id);
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public List<OrderItem> getOrderItemsByOrder(int orderId) {
        EntityManager em = getEm();
        try {
            return em.createQuery("SELECT oi FROM OrderItem oi WHERE oi.order.orderId = :orderId", OrderItem.class)
                    .setParameter("orderId", orderId)
                    .getResultList();
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public boolean addOrderItem(OrderItem item) {
        EntityManager em = getEm();
        try {
            em.getTransaction().begin();
            em.persist(item);
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
    public boolean updateOrderItem(OrderItem item) {
        EntityManager em = getEm();
        try {
            em.getTransaction().begin();
            em.merge(item);
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
    public boolean deleteOrderItem(int id) {
        EntityManager em = getEm();
        try {
            em.getTransaction().begin();
            OrderItem item = em.find(OrderItem.class, id);
            if (item == null) return false;
            em.remove(item);
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
