package vn.edu.ut.controller.admin;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import vn.edu.ut.entity.Author_24162067;
import vn.edu.ut.entity.Book_24162067;
import vn.edu.ut.service.IAuthorService_24162067;
import vn.edu.ut.service.IBookService_24162067;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Controller
public class AdminBookController_24162067 {

    @Autowired
    private IBookService_24162067 bookService;

    @Autowired
    private IAuthorService_24162067 authorService;

    @GetMapping("/admin/books")
    public String adminBooks(
            @RequestParam(name = "action", defaultValue = "list") String action,
            @RequestParam(name = "id", required = false) Integer id,
            @RequestParam(name = "page", defaultValue = "1") int page,
            Model model
    ) {
        if ("add".equals(action)) {
            model.addAttribute("authorList", authorService.findAll());
            return "admin/book-form";
        } else if ("edit".equals(action) && id != null) {
            Book_24162067 book = bookService.findById(id);
            model.addAttribute("book", book);
            model.addAttribute("authorList", authorService.findAll());
            return "admin/book-form";
        } else if ("delete".equals(action) && id != null) {
            bookService.delete(id);
            return "redirect:/admin/books";
        }

        int pageSize = 5;
        if (page < 1) page = 1;

        List<Book_24162067> bookList = bookService.findAll(page, pageSize);
        int totalPages = bookService.getTotalPages(pageSize);

        model.addAttribute("bookList", bookList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "admin/book-list";
    }

    @PostMapping("/admin/books")
    public String saveBook(
            @RequestParam(name = "bookid", required = false) Integer bookid,
            @RequestParam("isbn") Integer isbn,
            @RequestParam("title") String title,
            @RequestParam("publisher") String publisher,
            @RequestParam("price") BigDecimal price,
            @RequestParam(name = "description", required = false) String description,
            @RequestParam("publishDate") String publishDateStr,
            @RequestParam(name = "coverImage", required = false) String coverImage,
            @RequestParam("quantity") Integer quantity,
            @RequestParam(name = "authorIds", required = false) String[] authorIdsStr,
            Model model
    ) {
        try {
            Book_24162067 book;
            if (bookid != null) {
                book = bookService.findById(bookid);
                if (book == null) book = new Book_24162067();
            } else {
                book = new Book_24162067();
            }

            book.setTitle(title);
            book.setIsbn(isbn);
            book.setPublisher(publisher);
            book.setPrice(price);
            book.setDescription(description);
            book.setQuantity(quantity);
            book.setCoverImage(coverImage != null && !coverImage.trim().isEmpty() ? coverImage : "default_book.jpg");

            if (publishDateStr != null && !publishDateStr.trim().isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                book.setPublishDate(sdf.parse(publishDateStr));
            }

            List<Author_24162067> authors = new ArrayList<>();
            if (authorIdsStr != null) {
                for (String aId : authorIdsStr) {
                    Author_24162067 a = authorService.findById(Integer.parseInt(aId));
                    if (a != null) authors.add(a);
                }
            }
            book.setAuthors(authors);

            if (book.getBookid() != null) {
                bookService.update(book);
            } else {
                bookService.insert(book);
            }

            return "redirect:/admin/books";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Lỗi xử lý dữ liệu: " + e.getMessage());
            model.addAttribute("authorList", authorService.findAll());
            return "admin/book-form";
        }
    }
}
