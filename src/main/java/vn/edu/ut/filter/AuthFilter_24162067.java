package vn.edu.ut.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.ut.entity.User_24162067;

import java.io.IOException;

public class AuthFilter_24162067 implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        User_24162067 loggedInUser = (session != null) ? (User_24162067) session.getAttribute("account_24162067") : null;

        if (loggedInUser == null) {
            req.setAttribute("error", "Vui lòng đăng nhập bằng tài khoản Quản trị để tiếp tục.");
            req.getRequestDispatcher("/WEB-INF/views/user/login.jsp").forward(req, resp);
            return;
        }

        if (!Boolean.TRUE.equals(loggedInUser.getIsAdmin())) {
            req.setAttribute("error", "Tài khoản của bạn không có quyền truy cập trang Quản trị.");
            req.getRequestDispatcher("/WEB-INF/views/user/login.jsp").forward(req, resp);
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
