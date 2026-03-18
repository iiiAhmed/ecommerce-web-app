package com.watch.controller;

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
import java.util.Map;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer id = 2;
        HttpSession session = req.getSession();
        session.setAttribute("user_id", id);
        System.out.println("ggggggggggggggggggggggggg");
        CartService cartService = new CartService((EntityManager) req.getAttribute("em"));
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }
        cartService.loadDbCartIntoSession(id, cart);
        session.setAttribute("cart", cart);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getSession().setAttribute("user_id", 2);
        System.out.println("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    }
}
