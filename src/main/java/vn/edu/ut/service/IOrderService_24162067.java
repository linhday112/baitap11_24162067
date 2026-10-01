package vn.edu.ut.service;

import vn.edu.ut.entity.Order_24162067;
import vn.edu.ut.entity.User_24162067;
import vn.edu.ut.model.Cart_24162067;

import java.util.List;

public interface IOrderService_24162067 {
    Order_24162067 createCODOrder(User_24162067 user, String recipientName, String recipientPhone, 
                                  String address, String note, Cart_24162067 cart);
    Order_24162067 getOrderById(Integer id);
    List<Order_24162067> getOrdersByUser(Integer userId);
    List<Order_24162067> getOrdersByUserAndStatus(Integer userId, String status);
    List<Order_24162067> getAllOrders();
    List<Order_24162067> getAllOrdersByStatus(String status);
    void updateOrderStatus(Integer orderId, String newStatus);
    boolean cancelOrder(Integer orderId, Integer userId);
}
