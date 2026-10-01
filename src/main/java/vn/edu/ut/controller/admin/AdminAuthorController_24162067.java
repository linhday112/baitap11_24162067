package vn.edu.ut.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import vn.edu.ut.entity.Author_24162067;
import vn.edu.ut.service.IAuthorService_24162067;

import java.text.SimpleDateFormat;
import java.util.List;

@Controller
public class AdminAuthorController_24162067 {

    @Autowired
    private IAuthorService_24162067 authorService;

    @GetMapping("/admin/authors")
    public String adminAuthors(
            @RequestParam(name = "action", defaultValue = "list") String action,
            @RequestParam(name = "id", required = false) Integer id,
            @RequestParam(name = "page", defaultValue = "1") int page,
            Model model
    ) {
        if ("add".equals(action)) {
            return "admin/author-form";
        } else if ("edit".equals(action) && id != null) {
            Author_24162067 author = authorService.findById(id);
            model.addAttribute("author", author);
            return "admin/author-form";
        } else if ("delete".equals(action) && id != null) {
            authorService.delete(id);
            return "redirect:/admin/authors";
        }

        int pageSize = 5;
        if (page < 1) page = 1;

        List<Author_24162067> authorList = authorService.findAll(page, pageSize);
        int totalPages = authorService.getTotalPages(pageSize);

        model.addAttribute("authorList", authorList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "admin/author-list";
    }

    @PostMapping("/admin/authors")
    public String saveAuthor(
            @RequestParam(name = "authorId", required = false) Integer authorId,
            @RequestParam("authorName") String name,
            @RequestParam(name = "dateOfBirth", required = false) String dobStr,
            Model model
    ) {
        try {
            Author_24162067 author;
            if (authorId != null) {
                author = authorService.findById(authorId);
                if (author == null) author = new Author_24162067();
            } else {
                author = new Author_24162067();
            }

            author.setAuthorName(name);

            if (dobStr != null && !dobStr.trim().isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                author.setDateOfBirth(sdf.parse(dobStr));
            }

            if (author.getAuthorId() != null) {
                authorService.update(author);
            } else {
                authorService.insert(author);
            }

            return "redirect:/admin/authors";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Lỗi xử lý dữ liệu: " + e.getMessage());
            return "admin/author-form";
        }
    }
}
