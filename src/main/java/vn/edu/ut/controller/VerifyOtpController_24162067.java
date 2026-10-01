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
import vn.edu.ut.utils.PasswordUtils_24162067;

import java.util.Date;

@Controller
public class VerifyOtpController_24162067 {

    @Autowired
    private IUserService_24162067 userService;

    @GetMapping("/verify-otp")
    public String verifyOtpForm() {
        return "user/verify-otp";
    }

    @PostMapping("/verify-otp")
    public String processVerifyOtp(
            @RequestParam("otp") String inputOtp,
            HttpServletRequest req,
            Model model
    ) {
        HttpSession session = req.getSession(false);
        if (session == null) {
            return "redirect:/register";
        }

        User_24162067 pendingUser = (User_24162067) session.getAttribute("pendingUser_24162067");
        String sessionOtp = (String) session.getAttribute("otpCode_24162067");
        Long otpExpiry = (Long) session.getAttribute("otpExpiry_24162067");

        if (pendingUser == null || sessionOtp == null) {
            model.addAttribute("error", "Phiên đăng ký đã hết hạn. Vui lòng thử lại.");
            return "user/register";
        }

        if (otpExpiry != null && System.currentTimeMillis() > otpExpiry) {
            model.addAttribute("error", "Mã OTP đã hết hạn. Vui lòng đăng ký lại.");
            session.removeAttribute("pendingUser_24162067");
            session.removeAttribute("otpCode_24162067");
            session.removeAttribute("otpExpiry_24162067");
            return "user/register";
        }

        if (inputOtp != null && inputOtp.trim().equals(sessionOtp)) {
            pendingUser.setPasswd(PasswordUtils_24162067.hashPassword(pendingUser.getPasswd()));
            pendingUser.setSignupDate(new Date());

            userService.register(pendingUser);

            session.removeAttribute("pendingUser_24162067");
            session.removeAttribute("otpCode_24162067");
            session.removeAttribute("otpExpiry_24162067");

            model.addAttribute("message", "Đăng ký tài khoản thành công! Vui lòng đăng nhập.");
            return "user/login";
        } else {
            model.addAttribute("error", "Mã OTP không chính xác. Vui lòng thử lại.");
            return "user/verify-otp";
        }
    }
}
