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
public class RegisterController_24162067 {

    @Autowired
    private IUserService_24162067 userService;

    @Autowired
    private EmailUtils_24162067 emailUtils;

    @GetMapping("/register")
    public String registerForm() {
        return "user/register";
    }

    @PostMapping("/register")
    public String processRegister(
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            @RequestParam("fullname") String fullname,
            @RequestParam(name = "phone", required = false) String phone,
            HttpServletRequest req,
            Model model
    ) {
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            model.addAttribute("error", "Vui lòng điền đầy đủ các thông tin bắt buộc.");
            return "user/register";
        }

        email = email.trim();
        if (userService.findByEmail(email) != null) {
            model.addAttribute("error", "Email đã tồn tại trên hệ thống.");
            return "user/register";
        }

        // Generate 6-digit OTP
        String otpCode = String.format("%06d", new Random().nextInt(900000) + 100000);

        User_24162067 tempUser = new User_24162067();
        tempUser.setEmail(email);
        tempUser.setPasswd(password);
        tempUser.setFullname(fullname);
        tempUser.setPhone(phone);
        tempUser.setIsAdmin(false);

        HttpSession session = req.getSession(true);
        session.setAttribute("pendingUser_24162067", tempUser);
        session.setAttribute("otpCode_24162067", otpCode);
        session.setAttribute("otpExpiry_24162067", System.currentTimeMillis() + (5 * 60 * 1000));

        // Send OTP email
        emailUtils.sendOtpEmail(email, otpCode);

        return "redirect:/verify-otp";
    }
}
