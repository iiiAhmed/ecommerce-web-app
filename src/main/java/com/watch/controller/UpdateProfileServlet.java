package com.watch.controller;

import com.watch.model.dto.UserDto;
import com.watch.model.entities.User;
import com.watch.model.services.UserService;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.Arrays;
import java.util.stream.Collectors;


@WebServlet("/update-profile")
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager em = (EntityManager) req.getAttribute("em");
        UserService userService = new UserService(em);

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userDto") == null) {
            resp.sendRedirect("sign-in.jsp");
            return;
        }

        UserDto userDto = (UserDto) session.getAttribute("userDto");
        User user = userService.getUserById(userDto.getId());

        // Collect form parameters
        String name        = req.getParameter("name");
        String birthdayStr = req.getParameter("birthday");
        String job         = req.getParameter("job");
        String address     = req.getParameter("address");
        String phone       = req.getParameter("phone");
        String[] interestsArr = req.getParameterValues("interests");
        String newCreditStr   = req.getParameter("newCredit");
        String currentPassword = req.getParameter("currentPassword");

        // ── Determine which form was submitted ────────────────────────────────
        boolean isProfileForm  = (name != null);
        boolean isCreditForm   = !isProfileForm && (newCreditStr != null && !newCreditStr.trim().isEmpty());
        boolean isPasswordForm = !isProfileForm && !isCreditForm && (currentPassword != null);

        if (isProfileForm) {
            // ── Server-side validation for profile details ──────────────────────

            // Name: must not be blank
            if (name.trim().isEmpty()) {
                forwardWithError(req, resp, user, "Name cannot be empty.");
                return;
            }

            // Birthday: must be in the past (not today or future)
            LocalDate birthday = null;
            if (birthdayStr != null && !birthdayStr.trim().isEmpty()) {
                try {
                    birthday = LocalDate.parse(birthdayStr.trim());
                    if (!birthday.isBefore(LocalDate.now())) {
                        forwardWithError(req, resp, user, "Birthday cannot be today or in the future.");
                        return;
                    }
                } catch (DateTimeParseException e) {
                    forwardWithError(req, resp, user, "Invalid date format for birthday.");
                    return;
                }
            }

            // Phone: exactly 10 digits
            if (phone != null && !phone.trim().isEmpty()) {
                String digitsOnly = phone.trim().replaceAll("[\\s\\-]", "");
                if (!digitsOnly.matches("^[0-9]{10}$")) {
                    forwardWithError(req, resp, user, "Phone must be exactly 10 digits.");
                    return;
                }
            }

            // ── Apply profile updates ───────────────────────────────────────────
            user.setName(name.trim());

            if (birthday != null) {
                user.setBirthday(birthday);
            }
            if (job != null) {
                user.setJob(job.trim());
            }
            if (address != null) {
                user.setAddress(address.trim());
            }
            if (phone != null) {
                user.setPhone(phone.trim());
            }

            // Interests from checkbox group (multi-value)
            if (interestsArr != null && interestsArr.length > 0) {
                String interests = Arrays.stream(interestsArr)
                        .map(String::trim)
                        .filter(s -> !s.isEmpty())
                        .collect(Collectors.joining(","));
                user.setInterests(interests);
            } else {
                user.setInterests("");
            }

        } else if (isCreditForm) {
            // ── Credit limit update ─────────────────────────────────────────────
            try {
                double credit = Double.parseDouble(newCreditStr);
                if (credit < 0) {
                    forwardWithError(req, resp, user, "Credit limit cannot be negative.");
                    return;
                }
                user.setCreditLimit(credit);
            } catch (NumberFormatException e) {
                forwardWithError(req, resp, user, "Invalid credit limit value.");
                return;
            }

        } else if (isPasswordForm) {
            // ── Password change ─────────────────────────────────────────────────
            String newPassword = req.getParameter("newPassword");
            String confirmNewPassword = req.getParameter("confirmNewPassword");

            // Verify current password
            if (!userService.verifyPassword(userDto.getId(), currentPassword)) {
                forwardWithError(req, resp, user, "Current password is incorrect.");
                return;
            }

            // New password validation
            if (newPassword == null || newPassword.length() < 6) {
                forwardWithError(req, resp, user, "New password must be at least 6 characters.");
                return;
            }

            if (!newPassword.equals(confirmNewPassword)) {
                forwardWithError(req, resp, user, "New passwords do not match.");
                return;
            }

            if (newPassword.equals(currentPassword)) {
                forwardWithError(req, resp, user, "New password must be different from current password.");
                return;
            }

            // Update password
            userService.changePassword(userDto.getId(), newPassword);

            session.setAttribute("flashSuccess", "Password updated successfully!");
            resp.sendRedirect("profile");
            return;

        } else {
            // Nothing meaningful submitted
            resp.sendRedirect("profile");
            return;
        }

        // Persist to database
        userService.updateUser(user);

        // Update session name in UserDto
        userDto.setName(user.getName());
        session.setAttribute("userDto", userDto);

        // Flash success message via session
        session.setAttribute("flashSuccess", "Profile updated successfully!");
        resp.sendRedirect("profile");
    }

    private void forwardWithError(HttpServletRequest req, HttpServletResponse resp, User user, String errorMsg)
            throws ServletException, IOException {
        req.setAttribute("user", user);
        req.setAttribute("errorMsg", errorMsg);
        // Re-populate orders so the page renders correctly
        EntityManager em = (EntityManager) req.getAttribute("em");
        com.watch.model.services.OrderService orderService = new com.watch.model.services.OrderService(em);
        req.setAttribute("orders", orderService.getOrdersByUser(user.getUserId()));
        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }
}
