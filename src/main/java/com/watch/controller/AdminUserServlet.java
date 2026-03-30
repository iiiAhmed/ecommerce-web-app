package com.watch.controller;

import com.watch.model.dto.AdminDto;
import com.watch.model.services.UserService;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin-user")
public class AdminUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager em = (EntityManager) req.getAttribute("em");
        UserService userService = new UserService(em);

        List<AdminDto> admins = userService.getAllAdmins();
        req.setAttribute("admins", admins);

        // Pass flash messages from query params
        String msg = req.getParameter("msg");
        String error = req.getParameter("error");
        String name = req.getParameter("name");

        if ("created".equals(msg)) {
            req.setAttribute("successMsg", "Admin '" + (name != null ? name : "") + "' created successfully. Share the temporary password securely.");
        } else if ("revoked".equals(msg)) {
            req.setAttribute("successMsg", "Admin access revoked. User demoted to regular customer.");
        } else if ("deleted".equals(msg)) {
            req.setAttribute("successMsg", "Admin account deleted successfully.");
        }

        if ("email_taken".equals(error)) {
            req.setAttribute("errorMsg", "That email address is already registered.");
        } else if ("invalid".equals(error)) {
            req.setAttribute("errorMsg", "Invalid input. Please check the form and try again.");
        } else if ("not_found".equals(error)) {
            req.setAttribute("errorMsg", "Admin not found.");
        } else if ("failed".equals(error)) {
            req.setAttribute("errorMsg", "Operation failed. Please try again.");
        }

        req.getRequestDispatcher("admin-users.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager em = (EntityManager) req.getAttribute("em");
        UserService userService = new UserService(em);

        String action = req.getParameter("action");

        if ("create".equals(action)) {
            handleCreate(req, resp, userService);
        } else if ("revoke".equals(action)) {
            handleRevoke(req, resp, userService);
        } else if ("delete".equals(action)) {
            handleDelete(req, resp, userService);
        } else {
            resp.sendRedirect("admin-user");
        }
    }

    private void handleCreate(HttpServletRequest req, HttpServletResponse resp, UserService userService)
            throws IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String tempPassword = req.getParameter("tempPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        // ── Server-side validation ──────────────────────────────────────
        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || tempPassword == null || tempPassword.trim().isEmpty()
                || confirmPassword == null || confirmPassword.trim().isEmpty()) {
            resp.sendRedirect("admin-user?error=invalid");
            return;
        }

        name = name.trim();
        email = email.trim().toLowerCase();

        if (name.length() > 100) {
            resp.sendRedirect("admin-user?error=invalid");
            return;
        }

        // Email format
        if (!email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            resp.sendRedirect("admin-user?error=invalid");
            return;
        }

        if (email.length() > 100) {
            resp.sendRedirect("admin-user?error=invalid");
            return;
        }

        // Email uniqueness
        if (userService.isEmailTaken(email)) {
            resp.sendRedirect("admin-user?error=email_taken");
            return;
        }

        // Password length
        if (tempPassword.length() < 6) {
            resp.sendRedirect("admin-user?error=invalid");
            return;
        }

        // Password match
        if (!tempPassword.equals(confirmPassword)) {
            resp.sendRedirect("admin-user?error=invalid");
            return;
        }

        // ── Create admin ────────────────────────────────────────────────
        userService.createAdmin(name, email, tempPassword);
        resp.sendRedirect("admin-user?msg=created&name=" + java.net.URLEncoder.encode(name, "UTF-8"));
    }

    private void handleRevoke(HttpServletRequest req, HttpServletResponse resp, UserService userService)
            throws IOException {
        String idParam = req.getParameter("id");
        if (idParam == null) {
            resp.sendRedirect("admin-user?error=invalid");
            return;
        }

        try {
            int userId = Integer.parseInt(idParam);
            boolean success = userService.revokeAdmin(userId);
            resp.sendRedirect(success ? "admin-user?msg=revoked" : "admin-user?error=failed");
        } catch (NumberFormatException e) {
            resp.sendRedirect("admin-user?error=invalid");
        }
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp, UserService userService)
            throws IOException {
        String idParam = req.getParameter("id");
        if (idParam == null) {
            resp.sendRedirect("admin-user?error=invalid");
            return;
        }

        try {
            int userId = Integer.parseInt(idParam);
            boolean success = userService.deleteAdmin(userId);
            resp.sendRedirect(success ? "admin-user?msg=deleted" : "admin-user?error=failed");
        } catch (NumberFormatException e) {
            resp.sendRedirect("admin-user?error=invalid");
        }
    }
}
