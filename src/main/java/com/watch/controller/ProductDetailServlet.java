package com.watch.controller;

import com.watch.model.entities.Product;
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
import java.util.Map;

@WebServlet("/product")
public class ProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String productIdParam = req.getParameter("id");

        if (productIdParam == null || productIdParam.isEmpty()) {
            resp.sendRedirect("shop");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdParam);

            EntityManager em = (EntityManager) req.getAttribute("em");
            ProductService productService = new ProductService(em);

            Product product = productService.getProductById(productId);

            if (product == null) {
                resp.sendRedirect("shop");
                return;
            }

            HttpSession session = req.getSession();
            Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

            if (cart == null) {
                cart = new HashMap<>();
            }

            int cartCount = cart.values().stream().mapToInt(Integer::intValue).sum();

            req.setAttribute("product", product);
            req.setAttribute("cartCount", cartCount);
            req.setAttribute("cartQuantities", cart);

            req.getRequestDispatcher("/product.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect("shop");
        }
    }
}
