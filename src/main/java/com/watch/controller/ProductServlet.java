package com.watch.controller;

import com.watch.model.entities.Product;
import com.watch.model.enums.Brand;
import com.watch.model.enums.Category;
import com.watch.model.enums.Gender;
import com.watch.model.services.ProductService;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.*;

@WebServlet("/shop")
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        EntityManager em = (EntityManager) req.getAttribute("em");
        ProductService productService = new ProductService(em);

        String[] categories = req.getParameterValues("category");
        String[] brands = req.getParameterValues("brand");
        String gender = req.getParameter("gender");

        Double minPrice = null;
        Double maxPrice = null;

        try {
            String min = req.getParameter("minPrice");
            String max = req.getParameter("maxPrice");

            if (min != null && !min.isEmpty()) {
                minPrice = Double.parseDouble(min);
            }

            if (max != null && !max.isEmpty()) {
                maxPrice = Double.parseDouble(max);
            }

        } catch (Exception e) {
        }

        List<Product> products = productService.filterProducts(categories, brands, gender, minPrice, maxPrice);

        HttpSession session = req.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>();
        }

        int cartCount = cart.values().stream().mapToInt(Integer::intValue).sum();

        req.setAttribute("products", products);
        req.setAttribute("cartCount", cartCount);
        req.setAttribute("cartQuantities", cart);

        req.setAttribute("categories", List.of(Category.values()));
        req.setAttribute("brands", List.of(Brand.values()));
        req.setAttribute("genders", List.of(Gender.values()));

        req.setAttribute("selectedCategories", categories != null ? Arrays.asList(categories) : Collections.emptyList());
        req.setAttribute("selectedBrands", brands != null ? Arrays.asList(brands) : Collections.emptyList());

        req.getRequestDispatcher("/store.jsp").forward(req, resp);
    }
}