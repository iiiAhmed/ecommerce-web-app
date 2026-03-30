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
        String sortBy = req.getParameter("sortBy");

        // Validate category enum values
        if (categories != null && categories.length > 0) {
            List<String> validCategories = new ArrayList<>();
            for (String cat : categories) {
                if (cat != null && !cat.trim().isEmpty()) {
                    String trimmedCat = cat.trim();
                    if (trimmedCat.length() > 50) {
                        continue;
                    }
                    try {
                        Category.valueOf(trimmedCat);
                        validCategories.add(trimmedCat);
                    } catch (IllegalArgumentException e) {
                        // Invalid enum value
                    }
                }
            }
            categories = validCategories.isEmpty() ? null : validCategories.toArray(new String[0]);
        }

        // Validate brand enum values
        if (brands != null && brands.length > 0) {
            List<String> validBrands = new ArrayList<>();
            for (String brand : brands) {
                if (brand != null && !brand.trim().isEmpty()) {
                    String trimmedBrand = brand.trim();
                    if (trimmedBrand.length() > 50) {
                        continue;
                    }
                    try {
                        Brand.valueOf(trimmedBrand);
                        validBrands.add(trimmedBrand);
                    } catch (IllegalArgumentException e) {
                        // Invalid enum value
                    }
                }
            }
            brands = validBrands.isEmpty() ? null : validBrands.toArray(new String[0]);
        }

        // Validate gender enum value
        if (gender != null && !gender.trim().isEmpty()) {
            gender = gender.trim();
            if (gender.length() > 50) {
                gender = null;
            } else {
                try {
                    Gender.valueOf(gender);
                } catch (IllegalArgumentException e) {
                    // Invalid enum value - set to null
                    gender = null;
                }
            }
        }

        if (sortBy != null && !sortBy.trim().isEmpty()) {
            sortBy = sortBy.trim();
            if (sortBy.length() > 50) {
                sortBy = null;
            }
        }
        Double minPrice = null;
        Double maxPrice = null;

        try {
            String min = req.getParameter("minPrice");
            String max = req.getParameter("maxPrice");

            if (min != null && !min.trim().isEmpty()) {
                double parsedMin = Double.parseDouble(min.trim());
                if (parsedMin < 0) {
                    throw new IllegalArgumentException("Price cannot be negative");
                }
                if (parsedMin > 1000000) {
                    throw new IllegalArgumentException("Price exceeds maximum limit");
                }

                minPrice = parsedMin;
            }

            if (max != null && !max.trim().isEmpty()) {
                double parsedMax = Double.parseDouble(max.trim());
                if (parsedMax < 0) {
                    throw new IllegalArgumentException("Price cannot be negative");
                }
                if (parsedMax > 1000000) {
                    throw new IllegalArgumentException("Price exceeds maximum limit");
                }

                maxPrice = parsedMax;
            }

        } catch (Exception e) {
            minPrice = null;
            maxPrice = null;
        }

        int page = 1;
        int size = 12;
        long totalProducts = productService.countProducts(categories, brands, gender, minPrice, maxPrice);
        int totalPages = (int) Math.ceil((double) totalProducts / size);

        try {
            if (req.getParameter("page") != null) {
                int parsedPage = Integer.parseInt(req.getParameter("page").trim());
                if (parsedPage <= 0 ) {
                    page = 1;
                } else if(parsedPage > totalPages)
                    page = totalPages;
                else {
                    page = parsedPage;
                }
            }
        } catch (Exception e) {
            page = 1;
        }

        List<Product> products = productService.filterProducts(categories, brands, gender, minPrice, maxPrice, page, size, sortBy);


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

        req.setAttribute("selectedCategories", categories != null ? new HashSet<>(Arrays.asList(categories)) : Collections.emptySet());
        req.setAttribute("selectedBrands", brands != null ? new HashSet<>(Arrays.asList(brands)) : Collections.emptySet());
        req.setAttribute("selectedGender", gender);
        req.setAttribute("selectedMinPrice", minPrice);
        req.setAttribute("selectedMaxPrice", maxPrice);
        req.setAttribute("selectedSort", sortBy);

        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalProducts", totalProducts);
        req.setAttribute("pageSize", size);

        req.getRequestDispatcher("/store.jsp").forward(req, resp);
    }
}