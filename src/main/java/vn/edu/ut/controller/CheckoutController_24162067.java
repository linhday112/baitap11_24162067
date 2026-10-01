package vn.edu.ut.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.edu.ut.entity.User_24162067;
import vn.edu.ut.model.Cart_24162067;
import vn.edu.ut.service.IOrderService_24162067;

@Controller
@RequestMapping("/checkout")
public class CheckoutController_24162067 {

    @Autowired
    private IOrderService_24162067 orderService;

    @GetMapping
    public String showCheckoutPage(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User_24162067 loggedUser = (User_24162067) session.getAttribute("account_24162067");
        if (loggedUser == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để tiến hành thanh toán đơn hàng.");
            return "redirect:/login";
        }

        Cart_24162067 cart = (Cart_24162067) session.getAttribute("cart_24162067");
        if (cart == null || cart.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Giỏ hàng của bạn đang trống. Vui lòng chọn sản phẩm trước khi thanh toán.");
            return "redirect:/cart";
        }

        model.addAttribute("cart", cart);
        model.addAttribute("user", loggedUser);
        return "user/checkout";
    }

    @PostMapping("/process")
    public String processCheckout(
            @RequestParam("recipientName") String recipientName,
            @RequestParam("recipientPhone") String recipientPhone,
            @RequestParam("address") String address,
            @RequestParam(value = "note", required = false) String note,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        User_24162067 loggedUser = (User_24162067) session.getAttribute("account_24162067");
        if (loggedUser == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để hoàn tất đơn hàng.");
            return "redirect:/login";
        }

        Cart_24162067 cart = (Cart_24162067) session.getAttribute("cart_24162067");
        if (cart == null || cart.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Giỏ hàng của bạn đang trống.");
            return "redirect:/cart";
        }

        try {
            orderService.createCODOrder(loggedUser, recipientName, recipientPhone, address, note, cart);
            cart.clear(); // Clear cart after successful checkout
            redirectAttributes.addFlashAttribute("success", 
                "Đặt hàng thành công theo phương thức COD (Thanh toán khi nhận hàng)! Đơn hàng của bạn đã được tiếp nhận.");
            return "redirect:/order-history";
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/checkout";
        }
    }
}
