package com.watch.filters;

import com.watch.model.dto.UserDto;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Intercepts ALL requests. If the logged-in user has mustChangePassword = true,
 * they are forced to the /change-password page before doing anything else.
 */
@WebFilter(urlPatterns = "/*")
public class PasswordChangeFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userDto") == null) {
            // Not logged in — let other filters handle auth
            chain.doFilter(request, response);
            return;
        }

        UserDto userDto = (UserDto) session.getAttribute("userDto");
        if (!userDto.isMustChangePassword()) {
            // Password already changed — pass through
            chain.doFilter(request, response);
            return;
        }

        // User MUST change their password — only allow specific paths
        String uri = req.getRequestURI();
        String ctx = req.getContextPath();
        String path = uri.substring(ctx.length());

        // Allow these paths so the change-password flow and static resources work
        if (path.equals("/change-password")
                || path.equals("/logout")
                || path.startsWith("/css/")
                || path.startsWith("/js/")
                || path.startsWith("/fonts/")
                || path.startsWith("/images/")
                || path.startsWith("/vendor/")
                || path.startsWith("/includes/")) {
            chain.doFilter(request, response);
            return;
        }

        // Block everything else — redirect to change password page
        resp.sendRedirect(ctx + "/change-password");
    }
}
