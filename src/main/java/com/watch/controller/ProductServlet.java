package com.watch.controller;



import com.watch.model.entities.Product;
import com.watch.model.services.CartService;
import com.watch.model.services.ProductService;
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

@WebServlet("/shop")
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        ProductService productService = new ProductService((EntityManager) req.getAttribute("em"));

        List<Product> products = productService.getAllProducts();

        req.setAttribute("products", products);
        HttpSession session = req.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        if (cart == null)
            cart = new HashMap<>();

        int cartCount = cart.values().stream().mapToInt(Integer::intValue).sum();
        req.setAttribute("cartCount", cartCount);
        req.setAttribute("cartQuantities", cart);
        req.getRequestDispatcher("/store.jsp").forward(req, resp);


    }
}

