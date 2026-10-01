package vn.edu.ut.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.edu.ut.entity.Book_24162067;
import vn.edu.ut.entity.User_24162067;
import vn.edu.ut.model.Cart_24162067;
import vn.edu.ut.model.CartItem_24162067;
import vn.edu.ut.service.IBookService_24162067;
import java.util.Map;

@Controller
@RequestMapping("/cart")
public class CartController_24162067 {

    @Autowired
    private IBookService_24162067 bookService;

    private Cart_24162067 getCartForUser(HttpSession session, User_24162067 user) {
        String cartKey = "cart_24162067_user_" + user.getId();
        Cart_24162067 cart = (Cart_24162067) session.getAttribute(cartKey);
        if (cart == null) {
            cart = new Cart_24162067();
            session.setAttribute(cartKey, cart);
        }
        session.setAttribute("cart_24162067", cart);
        return cart;
    }

    @GetMapping
    public String viewCart(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User_24162067 loggedUser = (User_24162067) session.getAttribute("account_24162067");
        if (loggedUser == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập tài khoản để sử dụng và xem giỏ hàng!");
            return "redirect:/login";
        }

        Cart_24162067 cart = getCartForUser(session, loggedUser);
        model.addAttribute("cart", cart);
        return "user/cart";
    }

    @PostMapping("/add")
    public String addToCart(
            @RequestParam("bookid") Integer bookid,
            @RequestParam(value = "quantity", defaultValue = "1") int quantity,
            HttpSession session,
            RedirectAttributes redirectAttributes,
            @RequestHeader(value = "Referer", required = false) String referer
    ) {
        User_24162067 loggedUser = (User_24162067) session.getAttribute("account_24162067");
        if (loggedUser == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập tài khoản trước khi thêm sản phẩm vào giỏ hàng!");
            return "redirect:/login";
        }

        try {
            Book_24162067 book = bookService.findById(bookid);
            if (book == null) {
                redirectAttributes.addFlashAttribute("error", "Sản phẩm không tồn tại.");
            } else {
                Cart_24162067 cart = getCartForUser(session, loggedUser);
                cart.addItem(book, quantity);
                redirectAttributes.addFlashAttribute("success", "Đã thêm '" + book.getTitle() + "' vào giỏ hàng thành công!");
            }
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        if (referer != null && !referer.contains("/cart")) {
            return "redirect:" + referer;
        }
        return "redirect:/cart";
    }

    @PostMapping("/update")
    public String updateCart(
            @RequestParam("bookid") Integer bookid,
            @RequestParam("quantity") int quantity,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        User_24162067 loggedUser = (User_24162067) session.getAttribute("account_24162067");
        if (loggedUser == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập tài khoản!");
            return "redirect:/login";
        }

        try {
            Cart_24162067 cart = getCartForUser(session, loggedUser);
            cart.updateItem(bookid, quantity);
            redirectAttributes.addFlashAttribute("success", "Cập nhật số lượng giỏ hàng thành công!");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/cart";
    }

    @PostMapping("/update-quantity")
    @ResponseBody
    public ResponseEntity<?> updateQuantity(@RequestParam("bookid") Integer bookid,
                                            @RequestParam("quantity") int quantity,
                                            HttpSession session) {
        User_24162067 user = (User_24162067) session.getAttribute("account_24162067");
        if (user == null) {
            return ResponseEntity.status(401).body(Map.of("error", "Vui lòng đăng nhập lại."));
        }
        Cart_24162067 cart = getCartForUser(session, user);
        synchronized (cart) {
            CartItem_24162067 item = cart.getItemMap().get(bookid);
            Book_24162067 book = bookService.findById(bookid);
            if (item == null || book == null) {
                return ResponseEntity.badRequest().body(Map.of("error", "Sản phẩm không còn trong giỏ hàng."));
            }
            int stock = book.getQuantity() == null ? 0 : book.getQuantity();
            if (quantity < 1 || quantity > stock) {
                return ResponseEntity.badRequest().body(Map.of("error", "Số lượng phải từ 1 đến " + stock + "."));
            }
            item.setBook(book);
            cart.updateItem(bookid, quantity);
            return ResponseEntity.ok(Map.of("quantity", item.getQuantity(),
                    "itemTotal", item.getTotalPrice(), "price", book.getPrice(), "stock", stock,
                    "totalItems", cart.getTotalItems(), "totalAmount", cart.getTotalAmount()));
        }
    }

    @GetMapping("/remove")
    public String removeFromCart(
            @RequestParam("bookid") Integer bookid,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        User_24162067 loggedUser = (User_24162067) session.getAttribute("account_24162067");
        if (loggedUser == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập tài khoản!");
            return "redirect:/login";
        }

        Cart_24162067 cart = getCartForUser(session, loggedUser);
        cart.removeItem(bookid);
        redirectAttributes.addFlashAttribute("success", "Đã xóa sản phẩm khỏi giỏ hàng.");
        return "redirect:/cart";
    }

    @GetMapping("/clear")
    public String clearCart(HttpSession session, RedirectAttributes redirectAttributes) {
        User_24162067 loggedUser = (User_24162067) session.getAttribute("account_24162067");
        if (loggedUser == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập tài khoản!");
            return "redirect:/login";
        }

        Cart_24162067 cart = getCartForUser(session, loggedUser);
        cart.clear();
        redirectAttributes.addFlashAttribute("success", "Đã xóa toàn bộ giỏ hàng.");
        return "redirect:/cart";
    }
}
