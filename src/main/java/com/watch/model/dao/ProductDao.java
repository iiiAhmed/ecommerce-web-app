package com.watch.model.dao;

import com.watch.model.entities.Product;
import com.watch.model.enums.Age;
import com.watch.model.enums.Category;
import com.watch.model.enums.Gender;

import java.util.List;
import java.util.Set;

public interface ProductDao {

    List<Product> getAllProducts();
    Product getProductById(int id);
    boolean addProduct(Product product);
    boolean updateProduct(Product product);
    boolean deleteProduct(int id);
    List<Product> getProductsByCategory(Category category);
    List<Product> getProductsByGender(Gender gender);
    List<Product> getProductsByAge(Age age);
    public List<Product> findProductsByIds(Set<Integer> ids);


}
