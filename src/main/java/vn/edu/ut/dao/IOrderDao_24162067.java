package vn.edu.ut.dao;

import vn.edu.ut.entity.Order_24162067;
import java.util.List;

public interface IOrderDao_24162067 {
    Order_24162067 findById(Integer id);
    List<Order_24162067> findByUserId(Integer userId);
    List<Order_24162067> findByUserIdAndStatus(Integer userId, String status);
    List<Order_24162067> findAll();
    List<Order_24162067> findAllByStatus(String status);
    void insert(Order_24162067 order);
    void update(Order_24162067 order);
    void delete(Integer id);
}
