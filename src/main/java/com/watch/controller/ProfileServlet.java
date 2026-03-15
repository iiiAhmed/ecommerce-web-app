package com.watch.controller;

import com.watch.model.dao.OrderDao;
import com.watch.model.dao.OrderDaoImpl;
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

    private OrderDao orderDao;

    @Override
    public void init() throws ServletException {
        super.init();
        orderDao = new OrderDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        /* // TODO: Uncomment this when auth finshed
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("sign-in.html");
            return;
        }
        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();
        */

        // Hardcoded User ID for testing
        int userId = 2; // Testing with user ID 2 

        List<Order> userOrders = orderDao.getOrdersByUser(userId);

        req.setAttribute("orders", userOrders);
        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }
}
