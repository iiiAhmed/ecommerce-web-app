package com.watch.controller;

import com.watch.model.services.OrderService;
import com.watch.model.entities.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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

            HttpSession session = req.getSession(false);
            com.watch.model.dto.UserDto userDto = session != null ? (com.watch.model.dto.UserDto) session.getAttribute("userDto") : null;

            if (userDto == null) {
                resp.sendRedirect("sign-in.jsp");
                return;
            }

            // Admins can view any order; regular users can only view their own
            boolean isAdmin = com.watch.model.enums.Role.ADMIN == userDto.getRole();
            boolean isOwner = userDto.getId() == order.getUser().getUserId();

            if (!isAdmin && !isOwner) {
                resp.sendRedirect("profile");
                return;
            }

            req.setAttribute("from", req.getParameter("from"));

            req.setAttribute("order", order);
            req.getRequestDispatcher("order-details.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect("profile");
        }
    }
}
