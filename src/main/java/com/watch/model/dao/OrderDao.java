package com.watch.model.dao;

import com.watch.model.entities.Order;
import java.util.List;

public interface OrderDao {
    Order getOrderById(int id);
    List<Order> getOrdersByUser(int userId);
    List<Order> getAllOrders();
    boolean addOrder(Order order);
    boolean updateOrder(Order order);
    boolean deleteOrder(int id);
}
