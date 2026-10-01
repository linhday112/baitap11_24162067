package vn.edu.ut.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletResponseWrapper;
import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;

public class SiteMeshFilter_24162067 implements Filter {

    private static final String ALREADY_FILTERED_KEY = "sitemesh_filter_already_applied_24162067";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        if (uri.endsWith(".css") || uri.endsWith(".js") || uri.endsWith(".png") 
                || uri.endsWith(".jpg") || uri.endsWith(".jpeg") || uri.endsWith(".gif")
                || Boolean.TRUE.equals(req.getAttribute(ALREADY_FILTERED_KEY))) {
            chain.doFilter(request, response);
            return;
        }

        req.setAttribute(ALREADY_FILTERED_KEY, Boolean.TRUE);
        req.setAttribute("navigationPath_24162067", uri.substring(req.getContextPath().length()));

        CharResponseWrapper wrapper = new CharResponseWrapper(resp);
        chain.doFilter(request, wrapper);

        String content = wrapper.toString();
        if (content != null && (content.contains("<div") || content.contains("<html") || content.contains("<body"))) {
            req.setAttribute("pageContent_24162067", content);
            String decorator = uri.startsWith(req.getContextPath() + "/admin") ?
                    "/WEB-INF/views/decorators/admin.jsp" : "/WEB-INF/views/decorators/web.jsp";
            req.getRequestDispatcher(decorator).forward(req, resp);
        } else {
            resp.getWriter().write(content);
        }
    }

    @Override
    public void destroy() {
    }

    private static class CharResponseWrapper extends HttpServletResponseWrapper {
        private final CharArrayWriter charArrayWriter = new CharArrayWriter();
        private final PrintWriter writer = new PrintWriter(charArrayWriter);
        private final ServletOutputStream outputStream = new ServletOutputStream() {
            @Override
            public boolean isReady() {
                return true;
            }

            @Override
            public void setWriteListener(WriteListener writeListener) {
            }

            @Override
            public void write(int b) throws IOException {
                charArrayWriter.write(b);
            }

            @Override
            public void write(byte[] b, int off, int len) throws IOException {
                charArrayWriter.write(new String(b, off, len, StandardCharsets.UTF_8));
            }
        };

        public CharResponseWrapper(HttpServletResponse response) {
            super(response);
        }

        @Override
        public PrintWriter getWriter() {
            return writer;
        }

        @Override
        public ServletOutputStream getOutputStream() {
            return outputStream;
        }

        @Override
        public String toString() {
            writer.flush();
            return charArrayWriter.toString();
        }
    }
}
