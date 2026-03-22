package com.watch.filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/admin-*")
public class AdminAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String loginURI = httpRequest.getContextPath() + "/sign-in.html";
        String indexURI = httpRequest.getContextPath() + "/index.jsp";

        boolean loggedIn = (session != null && session.getAttribute("user") != null);
        
        if (loggedIn) {
            String role = (String) session.getAttribute("userRole");
            if ("admin".equalsIgnoreCase(role)) {
                // User is logged in and is an admin, allow request
                chain.doFilter(request, response);
            } else {
                // User is logged in but NOT an admin, redirect to home
                httpResponse.sendRedirect(indexURI);
            }
        } else {
            // User is not logged in, redirect to login page
            httpResponse.sendRedirect(loginURI + "?error=auth");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void destroy() {

    }
}
