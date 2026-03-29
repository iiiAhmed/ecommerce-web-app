package com.watch.filters;

import com.watch.model.dto.UserDto;
import com.watch.model.enums.Role;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {"/admin-users.jsp", "/admin-user"})
public class SuperAdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        if (session != null && session.getAttribute("userDto") != null) {
            UserDto userDto = (UserDto) session.getAttribute("userDto");
            if (userDto.getRole() == Role.SUPER_ADMIN) {
                chain.doFilter(request, response);
                return;
            }
        }

        // Not a super admin — redirect to admin home
        resp.sendRedirect("admin-product");
    }
}
