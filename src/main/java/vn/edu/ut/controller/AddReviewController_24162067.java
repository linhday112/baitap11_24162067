package vn.edu.ut.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import vn.edu.ut.entity.Book_24162067;
import vn.edu.ut.entity.RatingId_24162067;
import vn.edu.ut.entity.Rating_24162067;
import vn.edu.ut.entity.User_24162067;
import vn.edu.ut.service.IBookService_24162067;
import vn.edu.ut.service.IRatingService_24162067;

@Controller
public class AddReviewController_24162067 {

    @Autowired
    private IBookService_24162067 bookService;

    @Autowired
    private IRatingService_24162067 ratingService;

    @PostMapping("/add-review")
    public String addReview(
            @RequestParam("bookid") Integer bookid,
            @RequestParam("rating") Integer ratingVal,
            @RequestParam("review_text") String reviewText,
            HttpServletRequest req
    ) {
        HttpSession session = req.getSession(false);
        User_24162067 user = (session != null) ? (User_24162067) session.getAttribute("account_24162067") : null;

        if (user == null) {
            return "redirect:/login";
        }

        if (bookid != null) {
            Book_24162067 book = bookService.findById(bookid);
            if (book != null) {
                Rating_24162067 rating = new Rating_24162067();
                rating.setId(new RatingId_24162067(user.getId(), bookid));
                rating.setUser(user);
                rating.setBook(book);
                rating.setRating(ratingVal);
                rating.setReviewText(reviewText);

                ratingService.insertOrUpdate(rating);
            }
            return "redirect:/book-detail?id=" + bookid;
        }

        return "redirect:/home";
    }
}
