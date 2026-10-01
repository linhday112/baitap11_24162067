package vn.edu.ut.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import vn.edu.ut.entity.User_24162067;
import vn.edu.ut.service.IUserService_24162067;

@Controller
public class LoginController_24162067 {

    @Autowired
    private IUserService_24162067 userService;

    @GetMapping("/login")
    public String loginForm() {
        return "user/login";
    }

    @PostMapping("/login")
    public String processLogin(
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            HttpServletRequest req,
            Model model
    ) {
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            model.addAttribute("error", "Email và Mật khẩu không được để trống.");
            return "user/login";
        }

        User_24162067 user = userService.login(email.trim(), password);

        if (user != null) {
            HttpSession session = req.getSession(true);
            session.setAttribute("account_24162067", user);

            // Bind user-specific cart
            String cartKey = "cart_24162067_user_" + user.getId();
            vn.edu.ut.model.Cart_24162067 userCart = (vn.edu.ut.model.Cart_24162067) session.getAttribute(cartKey);
            if (userCart == null) {
                userCart = new vn.edu.ut.model.Cart_24162067();
                session.setAttribute(cartKey, userCart);
            }
            session.setAttribute("cart_24162067", userCart);

            if (Boolean.TRUE.equals(user.getIsAdmin())) {
                return "redirect:/admin/home";
            } else {
                return "redirect:/home";
            }
        } else {
            model.addAttribute("error", "Email hoặc mật khẩu không chính xác.");
            return "user/login";
        }
    }
}
