package com.watch.controller;

import com.watch.model.dto.UserDto;
import com.watch.model.services.UserService;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userDto") == null) {
            resp.sendRedirect("sign-in.jsp");
            return;
        }
        req.getRequestDispatcher("change-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userDto") == null) {
            resp.sendRedirect("sign-in.jsp");
            return;
        }

        UserDto userDto = (UserDto) session.getAttribute("userDto");
        EntityManager em = (EntityManager) req.getAttribute("em");
        UserService userService = new UserService(em);

        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        // ── Server-side validation ──────────────────────────────────────
        if (newPassword == null || newPassword.trim().isEmpty()) {
            req.setAttribute("error", "Password cannot be empty.");
            req.getRequestDispatcher("change-password.jsp").forward(req, resp);
            return;
        }

        if (newPassword.length() < 6) {
            req.setAttribute("error", "Password must be at least 6 characters.");
            req.getRequestDispatcher("change-password.jsp").forward(req, resp);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Passwords do not match.");
            req.getRequestDispatcher("change-password.jsp").forward(req, resp);
            return;
        }

        // ── Update password and clear flag ──────────────────────────────
        boolean success = userService.changePassword(userDto.getId(), newPassword);

        if (success) {
            // Update session DTO
            userDto.setMustChangePassword(false);
            session.setAttribute("userDto", userDto);

            // Redirect to admin panel
            resp.sendRedirect("admin-product");
        } else {
            req.setAttribute("error", "Failed to update password. Please try again.");
            req.getRequestDispatcher("change-password.jsp").forward(req, resp);
        }
    }
}
