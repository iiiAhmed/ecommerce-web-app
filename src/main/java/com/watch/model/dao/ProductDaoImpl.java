package com.watch.model.dao;


import com.watch.model.entities.Product;
import com.watch.model.enums.Age;
import com.watch.model.enums.Category;
import com.watch.model.enums.Gender;
import com.watch.util.EntityManagerFactorySingleton;
import jakarta.persistence.EntityManager;

import java.util.List;

public class ProductDaoImpl implements ProductDao {

    private EntityManager getEm() {
        return EntityManagerFactorySingleton.getInstance().createEntityManager();
    }

    @Override
    public List<Product> getAllProducts() {
        EntityManager em = getEm();
        try {
            return em.createQuery("SELECT p FROM Product p", Product.class).getResultList();
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public Product getProductById(int id) {
        EntityManager em = getEm();
        try {
            return em.find(Product.class, id);
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public boolean addProduct(Product product) {
        EntityManager em = getEm();
        try {
            em.getTransaction().begin();
            em.persist(product);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            return false;
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public boolean updateProduct(Product product) {
        EntityManager em = getEm();
        try {
            em.getTransaction().begin();
            em.merge(product);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            return false;
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public boolean deleteProduct(int id) {
        EntityManager em = getEm();
        try {
            em.getTransaction().begin();
            Product product = em.find(Product.class, id);
            if (product == null) return false;
            em.remove(product);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            return false;
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public List<Product> getProductsByCategory(Category category) {
        EntityManager em = getEm();
        try {
            return em.createQuery("SELECT p FROM Product p WHERE p.category = :category", Product.class)
                    .setParameter("category", category).getResultList();
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public List<Product> getProductsByGender(Gender gender) {
        EntityManager em = getEm();
        try {
            return em.createQuery("SELECT p FROM Product p WHERE p.gender = :gender", Product.class)
                    .setParameter("gender", gender).getResultList();
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public List<Product> getProductsByAge(Age age) {
        EntityManager em = getEm();
        try {
            return em.createQuery("SELECT p FROM Product p WHERE p.age = :age", Product.class)
                    .setParameter("age", age).getResultList();
        } finally {
            if (em.isOpen()) em.close();
        }
    }
}