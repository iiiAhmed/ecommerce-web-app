package com.watch.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.watch.model.entities.Order;
import com.watch.model.entities.User;
import com.watch.model.services.OrderService;
import com.watch.model.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/admin-customer")
public class AdminCustomerServlet extends HttpServlet {

    private final UserService userService = new UserService();
    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("profile".equals(action)) {
            getUserDataJSON(req, resp);
        } else {
            // Default: load customer list page
            List<com.watch.model.dto.CustomerDto> customers = userService.getCustomers();
            req.setAttribute("customers", customers);
            req.getRequestDispatcher("/admin-" +
                    "customers.jsp").forward(req, resp);
        }
    }

    // json
    private void getUserDataJSON(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();

        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.setStatus(400);
            out.write("{\"error\": \"Missing customer ID\"}");
            return;
        }

        try {
            int userId = Integer.parseInt(idParam);
            User user = userService.getUserById(userId);

            if (user == null) {
                resp.setStatus(404);
                out.write("{\"error\": \"Customer not found\"}");
                return;
            }

            List<Order> orders = orderService.getOrdersByUser(userId);

            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("name", user.getName() != null ? user.getName() : "");
            jsonResponse.addProperty("email", user.getEmail() != null ? user.getEmail() : "");
            jsonResponse.addProperty("birthday", user.getBirthday() != null ? user.getBirthday().toString() : "");
            jsonResponse.addProperty("job", user.getJob() != null ? user.getJob() : "");
            jsonResponse.addProperty("address", user.getAddress() != null ? user.getAddress() : "");
            jsonResponse.addProperty("phone", user.getPhone() != null ? user.getPhone() : "");
            jsonResponse.addProperty("interests", user.getInterests() != null ? user.getInterests() : "");
            jsonResponse.addProperty("creditLimit", user.getCreditLimit());

            JsonArray ordersArray = new JsonArray();
            if (orders != null && !orders.isEmpty()) {
                DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
                for (Order o : orders) {
                    JsonObject orderObj = new JsonObject();
                    orderObj.addProperty("orderId", o.getOrderId());
                    orderObj.addProperty("date", o.getOrderedAt() != null ? o.getOrderedAt().format(fmt) : "");
                    orderObj.addProperty("totalAmount", o.getTotalAmount());
                    ordersArray.add(orderObj);
                }
            }
            jsonResponse.add("orders", ordersArray);

            Gson gson = new GsonBuilder().create();
            out.write(gson.toJson(jsonResponse));

        } catch (NumberFormatException e) {
            resp.setStatus(400);
            out.write("{\"error\": \"Invalid customer ID\"}");
        }
    }
}
