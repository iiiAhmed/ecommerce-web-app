package com.watch.controller;

import com.watch.model.services.OrderService;
import com.watch.model.entities.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/orderDetails")
public class OrderDetailsServlet extends HttpServlet {

    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        super.init();
        orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendRedirect("profile");
            return;
        }

        try {
            int orderId = Integer.parseInt(idParam);
            Order order = orderService.getOrderById(orderId);

            if (order == null) {
                resp.sendRedirect("profile");
                return;
            }

            // // TODO: Uncomment when login is complete
            // HttpSession session = req.getSession(false);
            // User user = session != null ? (User) session.getAttribute("user") : null;
            // if (user == null || user.getUserId() != order.getUser().getUserId()) {
            //      resp.sendRedirect("profile");
            //      return;
            // }

            // TODO: remove when auth implemented
            if (order.getUser().getUserId() != 2) {
                resp.sendRedirect("profile");
                return;
            }

            req.setAttribute("order", order);
            req.getRequestDispatcher("order-details.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect("profile");
        }
    }
}
