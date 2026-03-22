package com.watch.controller;

import com.watch.model.entities.User;
import com.watch.model.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name          = req.getParameter("name");
        String email         = req.getParameter("email");
        String password      = req.getParameter("password");
        String birthday      = req.getParameter("birthday");
        String job           = req.getParameter("job");
        String creditLimitStr = req.getParameter("credit_limit");
        String address       = req.getParameter("address");
        String phone         = req.getParameter("phone");
        String[] interests   = req.getParameterValues("interests");

        // Server-side check: email already taken
        if (userService.isEmailTaken(email)) {
            resp.sendRedirect("sign-up.html?error=email_taken");
            return;
        }

        // Server-side Egyptian phone validation: exactly 10 digits (the +20 is fixed text in UI, not sent)
        if (phone == null || !phone.trim().matches("^[0-9]{10}$")) {
            resp.sendRedirect("sign-up.html?error=invalid_phone");
            return;
        }

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password); // will be hashed in UserService.register()
        user.setBirthday(LocalDate.parse(birthday));
        user.setJob(job);
        user.setCreditLimit(Double.parseDouble(creditLimitStr));
        user.setAddress(address);
        user.setPhone(phone.trim());

        if (interests != null && interests.length > 0) {
            user.setInterests(String.join(",", interests));
        }

        userService.register(user);
        resp.sendRedirect("sign-in.html?registered=true");
    }
}
