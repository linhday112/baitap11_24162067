package vn.edu.ut.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.edu.ut.entity.Order_24162067;
import vn.edu.ut.entity.User_24162067;
import vn.edu.ut.service.IOrderService_24162067;

import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/order-history")
public class OrderHistoryController_24162067 {

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
    public String showOrderHistory(
            @RequestParam(name = "status", required = false, defaultValue = "Tất cả") String status,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes
    ) {
        User_24162067 loggedUser = (User_24162067) session.getAttribute("account_24162067");
        if (loggedUser == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để xem lịch sử đặt hàng.");
            return "redirect:/login";
        }

        List<Order_24162067> orders = orderService.getOrdersByUserAndStatus(loggedUser.getId(), status);

        model.addAttribute("orders", orders);
        model.addAttribute("currentStatus", status);
        model.addAttribute("statusList", STATUS_LIST);
        return "user/order-history";
    }

    @PostMapping("/cancel")
    public String cancelOrder(
            @RequestParam("orderId") Integer orderId,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        User_24162067 loggedUser = (User_24162067) session.getAttribute("account_24162067");
        if (loggedUser == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập.");
            return "redirect:/login";
        }

        boolean success = orderService.cancelOrder(orderId, loggedUser.getId());
        if (success) {
            redirectAttributes.addFlashAttribute("success", "Đã hủy đơn hàng #" + orderId + " thành công.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Không thể hủy đơn hàng #" + orderId + ". Chỉ đơn hàng ở trạng thái 'Đơn hàng mới' mới được phép hủy.");
        }
        return "redirect:/order-history";
    }
}
