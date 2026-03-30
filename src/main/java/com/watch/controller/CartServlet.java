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
import java.util.List;
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


            int productId;
            int delta;

            try {
                productId = Integer.parseInt(req.getParameter("productId"));
                delta = Integer.parseInt(req.getParameter("delta"));
            } catch (Exception e) {
                response.put("status", "error");
                response.put("message", "Invalid format");
                resp.getWriter().print(gson.toJson(response));
                return;
            }


            CartService cartService = new CartService((EntityManager) req.getAttribute("em"));
            cartService.updateCartSession(cart, productId, delta);

            int updatedQty = cart.getOrDefault(productId, 0);

            response.put("status", "success");
            response.put("totalCartItems", cartService.getCartCountSession(cart));
            response.put("updatedQty", updatedQty);
            } catch (Exception e) {
                response.put("status", "error");
                response.put("message", "An error occurred while updating cart");
            }

            resp.getWriter().print(gson.toJson(response));
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
            CartService cartService = new CartService((EntityManager) req.getAttribute("em"));
            List<com.watch.model.dto.CartItemDTO> cartItems = cartService.buildCartDTOs(cart);
            
            double subtotal = cartItems.stream().mapToDouble(com.watch.model.dto.CartItemDTO::getTotalPrice).sum();

            response.put("cartItems", cartItems);
            response.put("cartTotal", subtotal);
            response.put("totalCartItems", cartService.getCartCountSession(cart));
        } catch (Exception e) {
            cart.clear();
            session.setAttribute("cart", cart);
            response.put("cartItems", new java.util.ArrayList<>());
            response.put("cartTotal", 0.0);
            response.put("totalCartItems", 0);
        }

        resp.getWriter().print(gson.toJson(response));
    }

}
