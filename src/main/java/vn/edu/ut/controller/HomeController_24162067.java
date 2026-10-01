package vn.edu.ut.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import vn.edu.ut.entity.Book_24162067;
import vn.edu.ut.service.IBookService_24162067;

import java.util.List;

@Controller
public class HomeController_24162067 {

    @Autowired
    private IBookService_24162067 bookService;

    @GetMapping({"/home", "/", "/products"})
    public String index(
            @RequestParam(name = "page", defaultValue = "1") int page,
            Model model
    ) {
        int pageSize = 6;
        if (page < 1) page = 1;

        List<Book_24162067> bookList = bookService.findAll(page, pageSize);
        int totalPages = bookService.getTotalPages(pageSize);
        long totalBooks = bookService.countAll();

        model.addAttribute("bookList", bookList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalBooks", totalBooks);

        return "user/home";
    }
}
