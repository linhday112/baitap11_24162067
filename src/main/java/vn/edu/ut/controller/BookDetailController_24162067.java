package vn.edu.ut.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import vn.edu.ut.entity.Book_24162067;
import vn.edu.ut.entity.Rating_24162067;
import vn.edu.ut.service.IBookService_24162067;
import vn.edu.ut.service.IRatingService_24162067;

import java.util.List;

@Controller
public class BookDetailController_24162067 {

    @Autowired
    private IBookService_24162067 bookService;

    @Autowired
    private IRatingService_24162067 ratingService;

    @GetMapping("/book-detail")
    public String detail(@RequestParam(name = "id", required = false) Integer id, Model model) {
        if (id == null) {
            return "redirect:/home";
        }

        Book_24162067 book = bookService.findById(id);
        if (book == null) {
            return "redirect:/home";
        }

        List<Rating_24162067> ratingList = ratingService.findByBookId(id);
        long reviewCount = ratingService.countByBookId(id);

        model.addAttribute("book", book);
        model.addAttribute("ratingList", ratingList);
        model.addAttribute("reviewCount", reviewCount);

        return "user/book-detail";
    }
}
