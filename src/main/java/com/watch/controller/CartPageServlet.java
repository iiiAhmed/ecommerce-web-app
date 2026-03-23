package com.watch.controller;

import com.watch.model.dto.CartItemDTO;
import com.watch.model.dto.UserDto;
import com.watch.model.entities.User;
import com.watch.model.services.CartService;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/shopping-cart")
public class CartPageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        EntityManager em = (EntityManager) req.getAttribute("em");
        UserDto userDto = (UserDto) session.getAttribute("userDto");

        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        CartService cartService = new CartService(em);

        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }

        if (userDto != null) {
            List<CartItemDTO> cartItems = cartService.buildCartDTOs(cart);
            double subtotal = cartItems.stream().mapToDouble(CartItemDTO::getTotalPrice).sum();

            User user = em.find(User.class, userDto.getId());
            double creditLimit = user.getCreditLimit();

            req.setAttribute("cartItems",   cartItems);
            req.setAttribute("subtotal",    subtotal);
            req.setAttribute("creditLimit", creditLimit);
            req.setAttribute("cartCount",   cartService.getCartCountSession(cart));

            req.getRequestDispatcher("/shopping-cart.jsp").forward(req, resp);

        }
        else{
            resp.sendRedirect("sign-in.html");
        }
    }

    //checkout
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserDto userDto = (UserDto) session.getAttribute("userDto");
        if (userDto == null) {
            resp.sendRedirect("sign-in.html");
            return;
        }

        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            req.setAttribute("error", "Your cart is empty.");
            doGet(req, resp);
            return;
        }

        EntityManager em = (EntityManager) req.getAttribute("em");
        try {
            new CartService(em).checkout(userDto.getId(), cart);
            session.setAttribute("cart", cart);
            resp.sendRedirect("shopping-cart?success=true");
        } catch (IllegalStateException e) {
            req.setAttribute("error", e.getMessage());
            doGet(req, resp);
        }
    }

}
