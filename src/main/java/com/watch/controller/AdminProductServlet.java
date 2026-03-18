package com.watch.controller;

import com.watch.model.entities.Product;
import com.watch.model.enums.Age;
import com.watch.model.enums.Category;
import com.watch.model.enums.Gender;
import com.watch.model.services.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import com.watch.util.FileUploadUtil;

import java.nio.file.Files;
import java.nio.file.Path;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin-product")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB in memory threshold
        maxFileSize = FileUploadUtil.MAX_IMAGE_SIZE_BYTES,
        maxRequestSize = FileUploadUtil.MAX_IMAGE_SIZE_BYTES * 2
)
public class AdminProductServlet extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> products = productService.getAllProducts();
        req.setAttribute("products", products);
        req.setAttribute("categories", Category.values());
        req.setAttribute("genders", Gender.values());
        req.setAttribute("ages", Age.values());
        req.getRequestDispatcher("/admin-products.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "add";

        try {
            switch (action) {
                case "delete":
                    handleDelete(req);
                    req.getSession().setAttribute("successMessage", "Product removed successfully!");
                    break;
                case "update":
                    Product updated = handleUpdate(req);
                    req.getSession().setAttribute("successMessage", "Product '" + updated.getName() + "' updated successfully!");
                    break;
                case "add":
                default:
                    Product added = handleAdd(req);
                    req.getSession().setAttribute("successMessage", "Product '" + added.getName() + "' added successfully!");
                    break;
            }
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("errorMessage", "Error: Price and Quantity must be valid numbers.");
        } catch (Exception e) {
            req.getSession().setAttribute("errorMessage", "Error: " + e.getMessage());
        }
        resp.sendRedirect("admin-product");
    }

    private void handleDelete(HttpServletRequest req) throws Exception {
        String idParam = req.getParameter("productId");
        if (isEmpty(idParam)) {
            throw new Exception("Product ID is required for deletion");
        }
        int id = Integer.parseInt(idParam);
        boolean deleted = productService.deleteProduct(id);
        if (!deleted) {
            throw new Exception("Failed to delete product. It might not exist.");
        }
    }

    private Product handleAdd(HttpServletRequest req) throws Exception {
        Product product = buildProductFromRequest(req);
        String imageUrl = resolveAndStoreImage(req, true);
        product.setImageUrl(imageUrl);
        productService.addProduct(product);
        return product;
    }

    private Product handleUpdate(HttpServletRequest req) throws Exception {
        Product product = buildProductFromRequest(req);
        String imageUrl = resolveAndStoreImage(req, false);
        product.setImageUrl(imageUrl);
        productService.updateProduct(product);
        return product;
    }

    private Product buildProductFromRequest(HttpServletRequest req) throws Exception {
        // Validate required fields
        String name = req.getParameter("name");
        String priceParam = req.getParameter("price");
        String qtyParam = req.getParameter("quantity");
        String genderParam = req.getParameter("gender");
        String ageParam = req.getParameter("age");
        String catParam = req.getParameter("category");

        if (isEmpty(name) || isEmpty(priceParam) || isEmpty(qtyParam) ||
                isEmpty(genderParam) || isEmpty(ageParam) || isEmpty(catParam)) {
            throw new Exception("Name, Price, Quantity, Category, Gender, and Age are all required.");
        }

        Product product = new Product();
        String idStr = req.getParameter("productId");
        if (!isEmpty(idStr)) {
            product.setProductId(Integer.parseInt(idStr));
        }
        product.setName(name.trim());
        product.setBrand(req.getParameter("brand") != null ? req.getParameter("brand").trim() : "");
        product.setDescription(req.getParameter("description") != null ? req.getParameter("description").trim() : "");
        product.setPrice(Double.parseDouble(priceParam));
        product.setQuantity(Integer.parseInt(qtyParam));
        try {
            product.setGender(Gender.valueOf(genderParam));
            product.setAge(Age.valueOf(ageParam));
            product.setCategory(Category.valueOf(catParam));
        } catch (IllegalArgumentException e) {
            throw new Exception("Invalid selection for Category, Gender, or Age.");
        }

        return product;
    }

    /**
     * @param imageRequired true for add, false for update
     * @return imageUrl to save in Product
     */
    private String resolveAndStoreImage(HttpServletRequest req, boolean imageRequired) throws Exception {
        Part imagePart = req.getPart("imageFile");
        String existingImageUrl = req.getParameter("imageUrl");

        if (imagePart == null || imagePart.getSize() <= 0) {
            if (imageRequired) {
                throw new Exception("Product image is required.");
            }
            return existingImageUrl;
        }

        if (imagePart.getSize() > FileUploadUtil.MAX_IMAGE_SIZE_BYTES) {
            throw new Exception("Image size must be less than or equal to 2MB.");
        }

        String contentType = imagePart.getContentType();
        if (!FileUploadUtil.isAllowedImageContentType(contentType)) {
            throw new Exception("Only JPEG and PNG images are allowed.");
        }

        String extension = FileUploadUtil.getExtensionForContentType(contentType);
        if (isEmpty(extension)) {
            throw new Exception("Unsupported image type.");
        }

        String idStr = req.getParameter("productId");
        int productIdForName;
        if (!isEmpty(idStr)) {
            productIdForName = Integer.parseInt(idStr);
        } else {
            productIdForName = (int) (System.currentTimeMillis() & 0xffff);
        }

        String fileName = productIdForName + "_" + System.currentTimeMillis() + extension;

        Path uploadDir = FileUploadUtil.resolveProductImagesDirectory(getServletContext()::getRealPath);
        Path target = uploadDir.resolve(fileName);
        Files.copy(imagePart.getInputStream(), target);

        return "images/products/" + fileName;
    }

    private boolean isEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }
}