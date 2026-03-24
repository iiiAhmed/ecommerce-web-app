package com.watch.controller;

import com.watch.model.services.OrderService;
import com.watch.model.entities.Order;
import com.watch.model.entities.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import jakarta.persistence.EntityManager;

import java.io.IOException;
import java.util.List;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private OrderService orderService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager em = (EntityManager) req.getAttribute("em");
        orderService = new OrderService(em);

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userDto") == null) {
            resp.sendRedirect("sign-in.jsp");
            return;
        }
        com.watch.model.dto.UserDto userDto = (com.watch.model.dto.UserDto) session.getAttribute("userDto");
        int userId = userDto.getId();
        
        com.watch.model.services.UserService userService = new com.watch.model.services.UserService();
        User user = userService.getUserById(userId);

        req.setAttribute("user", user);

        List<Order> userOrders = orderService.getOrdersByUser(userId);
        req.setAttribute("orders", userOrders);

        // Pick up flash success message set by UpdateProfileServlet
        String flashSuccess = (String) session.getAttribute("flashSuccess");
        if (flashSuccess != null) {
            req.setAttribute("successMsg", flashSuccess);
            session.removeAttribute("flashSuccess");
        }

        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }
}
