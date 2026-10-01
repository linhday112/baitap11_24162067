package vn.edu.ut.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import vn.edu.ut.service.IAuthorService_24162067;
import vn.edu.ut.service.IBookService_24162067;
import vn.edu.ut.service.IOrderService_24162067;
import vn.edu.ut.service.IUserService_24162067;

@Controller
public class AdminHomeController_24162067 {

    @Autowired
    private IBookService_24162067 bookService;

    @Autowired
    private IAuthorService_24162067 authorService;

    @Autowired
    private IUserService_24162067 userService;

    @Autowired
    private IOrderService_24162067 orderService;

    @GetMapping({"/admin/home", "/admin"})
    public String adminHome(Model model) {
        model.addAttribute("totalBooks", bookService.countAll());
        model.addAttribute("totalAuthors", authorService.countAll());
        model.addAttribute("totalUsers", userService.findAll().size());
        model.addAttribute("totalOrders", orderService.getAllOrders().size());
        model.addAttribute("newOrdersCount", orderService.getAllOrdersByStatus("Đơn hàng mới").size());

        return "admin/home";
    }
}
