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

import java.io.IOException;
import java.util.List;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        super.init();
        orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("sign-in.html");
            return;
        }
        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();

        req.setAttribute("user", user);

        List<Order> userOrders = orderService.getOrdersByUser(userId);

        req.setAttribute("orders", userOrders);
        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }
}
