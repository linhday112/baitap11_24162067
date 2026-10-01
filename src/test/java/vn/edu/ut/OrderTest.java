package vn.edu.ut;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.web.servlet.MockMvc;
import vn.edu.ut.entity.User_24162067;
import vn.edu.ut.service.IUserService_24162067;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;

@SpringBootTest
@AutoConfigureMockMvc
public class OrderTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private IUserService_24162067 userService;

    @Test
    public void testOrderHistoryEndpoint() throws Exception {
        User_24162067 user = userService.findByEmail("user@example.com");
        MockHttpSession session = new MockHttpSession();
        session.setAttribute("account_24162067", user);

        System.out.println("--- TESTING MOCK MVC GET /order-history ---");
        mockMvc.perform(get("/order-history").session(session))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(view().name("user/order-history"));
    }

    @Test
    public void testAdminOrdersEndpoint() throws Exception {
        User_24162067 admin = userService.findByEmail("admin@example.com");
        MockHttpSession session = new MockHttpSession();
        session.setAttribute("account_24162067", admin);

        System.out.println("--- TESTING MOCK MVC GET /admin/orders ---");
        mockMvc.perform(get("/admin/orders").session(session))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(view().name("admin/order-list"))
                .andExpect(model().attributeExists("orders"))
                .andExpect(model().attributeExists("statusList"));
    }
}
