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
import vn.edu.ut.utils.EmailUtils_24162067;

import java.util.Random;

@Controller
public class ForgotPasswordController_24162067 {

    @Autowired
    private IUserService_24162067 userService;

    @Autowired
    private EmailUtils_24162067 emailUtils;

    @GetMapping("/forgot-password")
    public String forgotPasswordForm() {
        return "user/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(
            @RequestParam("email") String email,
            HttpServletRequest req,
            Model model
    ) {
        if (email == null || email.trim().isEmpty()) {
            model.addAttribute("error", "Vui lòng nhập địa chỉ email của bạn.");
            return "user/forgot-password";
        }

        email = email.trim();
        User_24162067 user = userService.findByEmail(email);

        if (user == null) {
            model.addAttribute("error", "Email này chưa được đăng ký trên hệ thống.");
            return "user/forgot-password";
        }

        // Generate 6-digit OTP for password reset
        String otpCode = String.format("%06d", new Random().nextInt(900000) + 100000);

        HttpSession session = req.getSession(true);
        session.setAttribute("resetEmail_24162067", email);
        session.setAttribute("resetOtpCode_24162067", otpCode);
        session.setAttribute("resetOtpExpiry_24162067", System.currentTimeMillis() + (5 * 60 * 1000));

        // Send OTP email
        emailUtils.sendOtpEmail(email, otpCode);

        return "redirect:/reset-password";
    }
}
