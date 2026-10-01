package vn.edu.ut;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import vn.edu.ut.controller.CartController_24162067;
import vn.edu.ut.entity.Book_24162067;
import vn.edu.ut.entity.User_24162067;
import vn.edu.ut.model.Cart_24162067;
import vn.edu.ut.service.IBookService_24162067;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
class CartQuantityTest {
    @Mock IBookService_24162067 bookService;
    @InjectMocks CartController_24162067 controller;
    MockMvc mvc;
    MockHttpSession session;
    Cart_24162067 cart;
    Book_24162067 book;

    @BeforeEach
    void setUp() {
        mvc = MockMvcBuilders.standaloneSetup(controller).build();
        User_24162067 user = new User_24162067();
        user.setId(2);
        book = new Book_24162067();
        book.setBookid(1);
        book.setPrice(new BigDecimal("75000"));
        book.setQuantity(5);
        cart = new Cart_24162067();
        cart.addItem(book, 1);
        session = new MockHttpSession();
        session.setAttribute("account_24162067", user);
        session.setAttribute("cart_24162067_user_2", cart);
    }

    @Test
    void savesIncreasesAndDecreasesAndReturnsTotals() throws Exception {
        when(bookService.findById(1)).thenReturn(book);
        mvc.perform(post("/cart/update-quantity").session(session).param("bookid", "1").param("quantity", "3"))
                .andExpect(status().isOk()).andExpect(jsonPath("$.itemTotal").value(225000))
                .andExpect(jsonPath("$.totalAmount").value(225000)).andExpect(jsonPath("$.totalItems").value(3));
        mvc.perform(post("/cart/update-quantity").session(session).param("bookid", "1").param("quantity", "2"))
                .andExpect(status().isOk()).andExpect(jsonPath("$.totalAmount").value(150000));
        assertEquals(2, cart.getItemMap().get(1).getQuantity());
    }

    @Test
    void invalidQuantitiesKeepTheSavedCart() throws Exception {
        when(bookService.findById(1)).thenReturn(book);
        for (String quantity : new String[]{"0", "-1", "6"}) {
            mvc.perform(post("/cart/update-quantity").session(session).param("bookid", "1").param("quantity", quantity))
                    .andExpect(status().isBadRequest()).andExpect(jsonPath("$.error").exists());
        }
        assertEquals(1, cart.getTotalItems());
    }

    @Test
    void requiresLogin() throws Exception {
        mvc.perform(post("/cart/update-quantity").param("bookid", "1").param("quantity", "2"))
                .andExpect(status().isUnauthorized());
    }
}
