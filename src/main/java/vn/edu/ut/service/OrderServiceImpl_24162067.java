package vn.edu.ut.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.edu.ut.dao.IBookDao_24162067;
import vn.edu.ut.dao.IOrderDao_24162067;
import vn.edu.ut.entity.Book_24162067;
import vn.edu.ut.entity.OrderItem_24162067;
import vn.edu.ut.entity.Order_24162067;
import vn.edu.ut.entity.User_24162067;
import vn.edu.ut.model.CartItem_24162067;
import vn.edu.ut.model.Cart_24162067;

import java.util.Date;
import java.util.List;

@Service
public class OrderServiceImpl_24162067 implements IOrderService_24162067 {

    @Autowired
    private IOrderDao_24162067 orderDao;

    @Autowired
    private IBookDao_24162067 bookDao;

    @Override
    @Transactional
    public Order_24162067 createCODOrder(User_24162067 user, String recipientName, String recipientPhone,
                                         String address, String note, Cart_24162067 cart) {
        if (cart == null || cart.isEmpty()) {
            throw new IllegalArgumentException("Giỏ hàng của bạn đang trống.");
        }

        Order_24162067 order = new Order_24162067();
        order.setUser(user);
        order.setOrderDate(new Date());
        order.setRecipientName(recipientName);
        order.setRecipientPhone(recipientPhone);
        order.setAddress(address);
        order.setNote(note);
        order.setTotalAmount(cart.getTotalAmount());
        order.setPaymentMethod("COD");
        order.setStatus("Đơn hàng mới");

        for (CartItem_24162067 cItem : cart.getItems()) {
            Book_24162067 book = bookDao.findById(cItem.getBook().getBookid());
            if (book == null) {
                throw new IllegalArgumentException("Sản phẩm '" + cItem.getBook().getTitle() + "' không còn tồn tại.");
            }
            int currentStock = book.getQuantity() != null ? book.getQuantity() : 0;
            if (currentStock < cItem.getQuantity()) {
                throw new IllegalArgumentException("Sản phẩm '" + book.getTitle() + "' chỉ còn lại " 
                        + currentStock + " cuốn trong kho, không đủ đáp ứng số lượng " + cItem.getQuantity() + ".");
            }

            // Deduct inventory stock
            book.setQuantity(currentStock - cItem.getQuantity());
            bookDao.update(book);

            // Create Order Item
            OrderItem_24162067 oItem = new OrderItem_24162067();
            oItem.setBook(book);
            oItem.setQuantity(cItem.getQuantity());
            oItem.setPrice(book.getPrice());
            order.addItem(oItem);
        }

        orderDao.insert(order);
        return order;
    }

    @Override
    @Transactional(readOnly = true)
    public Order_24162067 getOrderById(Integer id) {
        return orderDao.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Order_24162067> getOrdersByUser(Integer userId) {
        return orderDao.findByUserId(userId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Order_24162067> getOrdersByUserAndStatus(Integer userId, String status) {
        if (status == null || status.trim().isEmpty() || "Tất cả".equalsIgnoreCase(status)) {
            return orderDao.findByUserId(userId);
        }
        return orderDao.findByUserIdAndStatus(userId, status.trim());
    }

    @Override
    @Transactional(readOnly = true)
    public List<Order_24162067> getAllOrders() {
        return orderDao.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Order_24162067> getAllOrdersByStatus(String status) {
        if (status == null || status.trim().isEmpty() || "Tất cả".equalsIgnoreCase(status)) {
            return orderDao.findAll();
        }
        return orderDao.findAllByStatus(status.trim());
    }

    @Override
    @Transactional
    public void updateOrderStatus(Integer orderId, String newStatus) {
        Order_24162067 order = orderDao.findById(orderId);
        if (order != null) {
            order.setStatus(newStatus);
            orderDao.update(order);
        }
    }

    @Override
    @Transactional
    public boolean cancelOrder(Integer orderId, Integer userId) {
        Order_24162067 order = orderDao.findById(orderId);
        if (order != null && order.getUser().getId().equals(userId)) {
            if ("Đơn hàng mới".equalsIgnoreCase(order.getStatus())) {
                order.setStatus("Đơn hàng hủy");

                // Restore stock
                for (OrderItem_24162067 item : order.getItems()) {
                    Book_24162067 book = item.getBook();
                    if (book != null) {
                        int stock = book.getQuantity() != null ? book.getQuantity() : 0;
                        book.setQuantity(stock + item.getQuantity());
                        bookDao.update(book);
                    }
                }

                orderDao.update(order);
                return true;
            }
        }
        return false;
    }
}
