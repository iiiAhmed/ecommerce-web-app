package com.watch.controller;

import com.watch.model.entities.User;
import com.watch.model.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/update-profile")
public class UpdateProfileServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("sign-in.html");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Update fields from form
        String name = req.getParameter("name");
        String birthday = req.getParameter("birthday");
        String job = req.getParameter("job");
        String address = req.getParameter("address");
        String interests = req.getParameter("interests");
        String newCreditStr = req.getParameter("newCredit");

        if (name != null && !name.trim().isEmpty()) {
            user.setName(name.trim());
        }
        if (birthday != null && !birthday.trim().isEmpty()) {
            user.setBirthday(LocalDate.parse(birthday));
        }
        if (job != null) {
            user.setJob(job.trim());
        }
        if (address != null) {
            user.setAddress(address.trim());
        }
        if (interests != null) {
            user.setInterests(interests.trim());
        }
        if (newCreditStr != null && !newCreditStr.trim().isEmpty()) {
            user.setCreditLimit(Double.parseDouble(newCreditStr));
        }

        // Persist to database
        userService.updateUser(user);

        // Update session with latest data
        session.setAttribute("user", user);

        resp.sendRedirect("profile");
    }
}
