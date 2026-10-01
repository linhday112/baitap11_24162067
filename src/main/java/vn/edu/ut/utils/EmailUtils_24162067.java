package vn.edu.ut.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

@Component
public class EmailUtils_24162067 {

    @Autowired(required = false)
    private JavaMailSender mailSender;

    public boolean sendOtpEmail(String toEmail, String otpCode) {
        try {
            if (mailSender != null) {
                SimpleMailMessage message = new SimpleMailMessage();
                message.setFrom("linhdttv0106@gmail.com");
                message.setTo(toEmail);
                message.setSubject("Mã OTP xác thực tài khoản - MSSV 24162067");
                message.setText("Mã OTP xác nhận đăng ký tài khoản của bạn là: " + otpCode + "\nMã có hiệu lực trong 5 phút.");
                mailSender.send(message);
                System.out.println("[EmailUtils_24162067] OTP email sent successfully to " + toEmail);
                return true;
            }
        } catch (Exception e) {
            System.err.println("[EmailUtils_24162067] Failed to send OTP email: " + e.getMessage());
        }
        // Fallback log for dev/exam testing
        System.out.println("[EmailUtils_24162067] DEV FALLBACK OTP for " + toEmail + " is: " + otpCode);
        return true;
    }
}
