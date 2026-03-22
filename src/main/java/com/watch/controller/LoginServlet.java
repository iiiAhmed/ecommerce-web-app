package com.watch.controller;

import com.watch.model.entities.User;
import com.watch.model.enums.Role;
import com.watch.model.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("sign-in.html");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = userService.authenticate(email, password);

        if (user != null) {
            HttpSession session = req.getSession();
            com.watch.model.dto.UserDto userDto = new com.watch.model.dto.UserDto(user.getUserId(), user.getName(), user.getRole());
            session.setAttribute("userDto", userDto);

            // Role-based redirect
            if (user.getRole() == Role.ADMIN) {
                resp.sendRedirect("admin-products.jsp");
            } else {
                resp.sendRedirect("index.jsp");
            }
        } else {
            resp.sendRedirect("sign-in.html?error=invalid");
        }
    }
}
