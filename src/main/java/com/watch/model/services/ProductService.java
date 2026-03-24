package com.watch.model.services;

import com.watch.model.dao.ProductDao;
import com.watch.model.dao.ProductDaoImpl;
import com.watch.model.entities.Product;
import com.watch.model.enums.Age;
import com.watch.model.enums.Category;
import com.watch.model.enums.Gender;
import jakarta.persistence.EntityManager;

import java.util.List;

public class ProductService {

    private final EntityManager em;
    private final ProductDao productDao;

    public ProductService(EntityManager em) {
        this.em = em;
        this.productDao = new ProductDaoImpl(em);
    }

    public List<Product> getAllProducts() {
        return productDao.getAllProducts();
    }

    public Product getProductById(int id) {
        if (id <= 0) return null;
        return productDao.getProductById(id);
    }

    public List<Product> getProductsByCategory(Category category) {
        if (category == null) return getAllProducts();
        return productDao.getProductsByCategory(category);
    }

    public List<Product> getProductsByGender(Gender gender) {
        if (gender == null) return getAllProducts();
        return productDao.getProductsByGender(gender);
    }

    public List<Product> getProductsByAge(Age age) {
        if (age == null) return getAllProducts();
        return productDao.getProductsByAge(age);
    }

    public boolean addProduct(Product product) {
        if (!isValidProduct(product)) return false;
        return productDao.addProduct(product);
    }

    public boolean updateProduct(Product product) {
        if (product == null || product.getProductId() <= 0) return false;
        if (!isValidProduct(product)) return false;
        return productDao.updateProduct(product);
    }

    public boolean deleteProduct(int id) {
        if (id <= 0) return false;
        return productDao.deleteProduct(id);
    }

    public List<Product> filterProducts(String[] categories, String[] brands, String gender, Double minPrice, Double maxPrice,int page, int size) {
        return productDao.filterProducts(categories, brands, gender, minPrice, maxPrice, page, size);
    }
    public long countProducts(String[] categories, String[] brands, String gender, Double minPrice, Double maxPrice) {
        return productDao.countProducts(categories, brands, gender, minPrice, maxPrice);
    }
    private boolean isValidProduct(Product product) {
        if (product == null) return false;
        if (product.getName() == null || product.getName().trim().isEmpty()) return false;
        if (product.getPrice() <= 0) return false;
        if (product.getQuantity() < 0) return false;
        if (product.getGender() == null) return false;
        if (product.getAge() == null) return false;
        if (product.getCategory() == null) return false;
        return true;
    }
}