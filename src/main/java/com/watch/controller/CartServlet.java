package com.watch.controller;

import com.google.gson.Gson;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.watch.model.services.CartService;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }
        Map<String, Object> response = new HashMap<>();

        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            int delta = Integer.parseInt(req.getParameter("delta"));

            CartService cartService = new CartService((EntityManager) req.getAttribute("em"));
            cartService.updateCartSession(cart, productId, delta);

            response.put("status", "success");
            response.put("totalCartItems", cartService.getCartCountSession(cart));
        } catch (IllegalArgumentException e) {
            response.put("status", "error");
            response.put("message", e.getMessage());
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Something went wrong");
        }

        resp.getWriter().print(gson.toJson(response));
    }

}
