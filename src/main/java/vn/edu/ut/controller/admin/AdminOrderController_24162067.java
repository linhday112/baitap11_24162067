package vn.edu.ut.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.edu.ut.entity.Order_24162067;
import vn.edu.ut.service.IOrderService_24162067;

import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/admin/orders")
public class AdminOrderController_24162067 {

    @Autowired
    private IOrderService_24162067 orderService;

    private static final List<String> STATUS_LIST = Arrays.asList(
        "Tất cả",
        "Đơn hàng mới",
        "Đã xác nhận",
        "Chuẩn bị hàng",
        "Vận chuyển",
        "Giao hàng",
        "Đã giao",
        "Đơn hàng hủy",
        "Đơn hàng hoàn"
    );

    @GetMapping
    public String listOrders(
            @RequestParam(name = "status", required = false, defaultValue = "Tất cả") String status,
            Model model
    ) {
        List<Order_24162067> orders = orderService.getAllOrdersByStatus(status);
        model.addAttribute("orders", orders);
        model.addAttribute("currentStatus", status);
        model.addAttribute("statusList", STATUS_LIST);
        return "admin/order-list";
    }

    @PostMapping("/update-status")
    public String updateStatus(
            @RequestParam("orderId") Integer orderId,
            @RequestParam("status") String status,
            RedirectAttributes redirectAttributes
    ) {
        orderService.updateOrderStatus(orderId, status);
        redirectAttributes.addFlashAttribute("success", "Đã cập nhật trạng thái đơn hàng #" + orderId + " thành: " + status);
        return "redirect:/admin/orders";
    }
}
