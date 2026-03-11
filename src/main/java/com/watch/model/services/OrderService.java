package com.watch.model.services;

import com.watch.model.dao.OrderDao;
import com.watch.model.dao.OrderDaoImpl;
import com.watch.model.dao.OrderItemDao;
import com.watch.model.dao.OrderItemDaoImpl;
import com.watch.model.entities.Order;
import com.watch.model.entities.OrderItem;

import java.time.LocalDateTime;
import java.util.List;

public class OrderService {

    private final OrderDao orderDao = new OrderDaoImpl();
    private final OrderItemDao orderItemDao = new OrderItemDaoImpl();

    // ==================== Order Methods ====================

    public Order getOrderById(int id) {
        if (id <= 0) return null;
        return orderDao.getOrderById(id);
    }

    public List<Order> getOrdersByUser(int userId) {
        if (userId <= 0) return null;
        return orderDao.getOrdersByUser(userId);
    }

    public List<Order> getAllOrders() {
        return orderDao.getAllOrders();
    }

    public boolean addOrder(Order order) {
        if (order == null || order.getUser() == null || order.getTotalAmount() < 0) {
            return false;
        }
        if (order.getOrderedAt() == null) {
            order.setOrderedAt(LocalDateTime.now());
        }
        return orderDao.addOrder(order);
    }

    public boolean updateOrder(Order order) {
        if (order == null || order.getOrderId() <= 0 || order.getUser() == null || order.getTotalAmount() < 0) {
            return false;
        }
        return orderDao.updateOrder(order);
    }

    public boolean deleteOrder(int id) {
        if (id <= 0) return false;
        return orderDao.deleteOrder(id);
    }

    // ==================== OrderItem Methods ====================

    public OrderItem getOrderItemById(int id) {
        if (id <= 0) return null;
        return orderItemDao.getOrderItemById(id);
    }

    public List<OrderItem> getOrderItemsByOrder(int orderId) {
        if (orderId <= 0) return null;
        return orderItemDao.getOrderItemsByOrder(orderId);
    }

    public boolean addOrderItem(OrderItem item) {
        if (item == null || item.getOrder() == null || item.getProduct() == null) {
            return false;
        }
        if (item.getQuantity() <= 0) {
            return false;
        }
        if (item.getPrice() <= 0 && item.getProduct().getPrice() > 0) {
            item.setPrice(item.getProduct().getPrice());
        }
        return orderItemDao.addOrderItem(item);
    }

    public boolean updateOrderItem(OrderItem item) {
        if (item == null || item.getId() <= 0 || item.getOrder() == null || item.getProduct() == null) {
            return false;
        }
        if (item.getQuantity() <= 0 || item.getPrice() <= 0) {
            return false;
        }
        return orderItemDao.updateOrderItem(item);
    }

    public boolean deleteOrderItem(int id) {
        if (id <= 0) return false;
        return orderItemDao.deleteOrderItem(id);
    }
}
