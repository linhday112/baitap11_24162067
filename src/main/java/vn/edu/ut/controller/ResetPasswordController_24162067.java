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

@Controller
public class ResetPasswordController_24162067 {

    @Autowired
    private IUserService_24162067 userService;

    @GetMapping("/reset-password")
    public String resetPasswordForm() {
        return "user/reset-password";
    }

    @PostMapping("/reset-password")
    public String processResetPassword(
            @RequestParam("otp") String inputOtp,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            HttpServletRequest req,
            Model model
    ) {
        HttpSession session = req.getSession(false);
        if (session == null) {
            return "redirect:/forgot-password";
        }

        String resetEmail = (String) session.getAttribute("resetEmail_24162067");
        String sessionOtp = (String) session.getAttribute("resetOtpCode_24162067");
        Long otpExpiry = (Long) session.getAttribute("resetOtpExpiry_24162067");

        if (resetEmail == null || sessionOtp == null) {
            model.addAttribute("error", "Phiên khôi phục mật khẩu đã hết hạn. Vui lòng thực hiện lại.");
            return "user/forgot-password";
        }

        if (otpExpiry != null && System.currentTimeMillis() > otpExpiry) {
            model.addAttribute("error", "Mã OTP đã hết hạn. Vui lòng gửi lại yêu cầu.");
            session.removeAttribute("resetEmail_24162067");
            session.removeAttribute("resetOtpCode_24162067");
            session.removeAttribute("resetOtpExpiry_24162067");
            return "user/forgot-password";
        }

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "Xác nhận mật khẩu mới không trùng khớp.");
            return "user/reset-password";
        }

        if (inputOtp != null && inputOtp.trim().equals(sessionOtp)) {
            User_24162067 user = userService.findByEmail(resetEmail);
            if (user != null) {
                user.setPasswd(PasswordUtils_24162067.hashPassword(newPassword));
                userService.update(user);
            }

            session.removeAttribute("resetEmail_24162067");
            session.removeAttribute("resetOtpCode_24162067");
            session.removeAttribute("resetOtpExpiry_24162067");

            model.addAttribute("message", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập bằng mật khẩu mới.");
            return "user/login";
        } else {
            model.addAttribute("error", "Mã OTP không chính xác. Vui lòng kiểm tra lại.");
            return "user/reset-password";
        }
    }
}
