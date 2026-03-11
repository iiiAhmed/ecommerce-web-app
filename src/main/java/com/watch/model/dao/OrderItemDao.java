package com.watch.model.dao;

import com.watch.model.entities.OrderItem;
import java.util.List;

public interface OrderItemDao {
    OrderItem getOrderItemById(int id);
    List<OrderItem> getOrderItemsByOrder(int orderId);
    boolean addOrderItem(OrderItem item);
    boolean updateOrderItem(OrderItem item);
    boolean deleteOrderItem(int id);
}
