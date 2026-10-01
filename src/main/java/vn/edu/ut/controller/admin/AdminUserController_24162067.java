package vn.edu.ut.controller.admin;

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
import java.util.List;

@Controller
public class AdminUserController_24162067 {

    @Autowired
    private IUserService_24162067 userService;

    @GetMapping("/admin/users")
    public String adminUsers(
            @RequestParam(name = "action", defaultValue = "list") String action,
            @RequestParam(name = "id", required = false) Integer id,
            Model model
    ) {
        if ("add".equals(action)) {
            return "admin/user-form";
        } else if ("edit".equals(action) && id != null) {
            User_24162067 user = userService.findById(id);
            model.addAttribute("user", user);
            return "admin/user-form";
        } else if ("delete".equals(action) && id != null) {
            userService.delete(id);
            return "redirect:/admin/users";
        }

        List<User_24162067> userList = userService.findAll();
        model.addAttribute("userList", userList);

        return "admin/user-list";
    }

    @PostMapping("/admin/users")
    public String saveUser(
            @RequestParam(name = "id", required = false) Integer id,
            @RequestParam("email") String email,
            @RequestParam("fullname") String fullname,
            @RequestParam(name = "phone", required = false) String phone,
            @RequestParam(name = "password", required = false) String password,
            @RequestParam(name = "isAdmin", defaultValue = "false") Boolean isAdmin,
            Model model
    ) {
        try {
            User_24162067 user;
            if (id != null) {
                user = userService.findById(id);
                if (user == null) user = new User_24162067();
            } else {
                user = new User_24162067();
                user.setSignupDate(new Date());
            }

            user.setEmail(email.trim());
            user.setFullname(fullname);
            user.setPhone(phone);
            user.setIsAdmin(isAdmin);

            if (password != null && !password.trim().isEmpty()) {
                user.setPasswd(PasswordUtils_24162067.hashPassword(password));
            }

            if (user.getId() != null) {
                userService.update(user);
            } else {
                userService.register(user);
            }

            return "redirect:/admin/users";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Lỗi xử lý dữ liệu: " + e.getMessage());
            return "admin/user-form";
        }
    }
}
