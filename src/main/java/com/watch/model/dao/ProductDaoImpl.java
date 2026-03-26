package com.watch.model.dao;

import com.watch.model.entities.Product;
import com.watch.model.enums.Age;
import com.watch.model.enums.Brand;
import com.watch.model.enums.Category;
import com.watch.model.enums.Gender;
import jakarta.persistence.EntityManager;
import jakarta.persistence.LockModeType;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.criteria.Root;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Set;

public class ProductDaoImpl implements ProductDao {

    private final EntityManager em;

    public ProductDaoImpl(EntityManager em) {
        this.em = em;
    }

    @Override
    public List<Product> getAllProducts() {
        return em.createQuery("SELECT p FROM Product p", Product.class)
                .getResultList();
    }

    @Override
    public Product getProductById(int id) {
        return em.find(Product.class, id);
    }

    @Override
    public boolean addProduct(Product product) {
        em.persist(product);
        return true;
    }

    @Override
    public boolean updateProduct(Product product) {
        em.merge(product);
        return true;
    }

    @Override
    public boolean deleteProduct(int id) {
        Product product = em.find(Product.class, id);
        if (product == null) return false;

        Long orderRefs = em.createQuery(
                "SELECT COUNT(oi) FROM OrderItem oi WHERE oi.product.productId = :pid", Long.class)
                .setParameter("pid", id)
                .getSingleResult();
        if (orderRefs > 0) {
            throw new IllegalStateException("Cannot delete product: it is referenced by " + orderRefs + " order item(s).");
        }

        Long cartRefs = em.createQuery(
                "SELECT COUNT(ci) FROM CartItem ci WHERE ci.product.productId = :pid", Long.class)
                .setParameter("pid", id)
                .getSingleResult();
        if (cartRefs > 0) {
            throw new IllegalStateException("Cannot delete product: it is in " + cartRefs + " user cart(s).");
        }

        em.remove(product);
        return true;
    }

    @Override
    public List<Product> getProductsByCategory(Category category) {
        return em.createQuery("SELECT p FROM Product p WHERE p.category = :category", Product.class)
                .setParameter("category", category)
                .getResultList();
    }

    @Override
    public List<Product> getProductsByGender(Gender gender) {
        return em.createQuery("SELECT p FROM Product p WHERE p.gender = :gender", Product.class)
                .setParameter("gender", gender)
                .getResultList();
    }

    @Override
    public List<Product> getProductsByAge(Age age) {
        return em.createQuery("SELECT p FROM Product p WHERE p.age = :age", Product.class)
                .setParameter("age", age)
                .getResultList();
    }

    @Override
    public List<Product> findProductsByIds(Set<Integer> ids) {
        return em.createQuery("SELECT p FROM Product p WHERE p.productId IN :ids", Product.class)
                .setParameter("ids", ids)
                .setLockMode(LockModeType.PESSIMISTIC_WRITE)
                .getResultList();
    }

    @Override
    public List<Product> filterProducts(String[] categories, String[] brands, String gender, Double minPrice, Double maxPrice,int page, int size) {

        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<Product> cq = cb.createQuery(Product.class);
        Root<Product> p = cq.from(Product.class);

        List<Predicate> predicates = new ArrayList<>();

        if (categories != null && categories.length > 0) {
            List<Category> categoryEnums = Arrays.stream(categories).map(Category::valueOf).toList();
            predicates.add(p.get("category").in(categoryEnums));
        }

        if (brands != null && brands.length > 0) {
            List<Brand> brandEnums = Arrays.stream(brands).map(Brand::valueOf).toList();

            predicates.add(p.get("brand").in(brandEnums));
        }

        if (gender != null && !gender.isEmpty()) {
            predicates.add(cb.equal(p.get("gender"), Gender.valueOf(gender)));
        }

//        if (age != null && !age.isEmpty()) {
//            predicates.add(cb.equal(p.get("age"), Age.valueOf(age)));
//        }

        if (minPrice != null && minPrice >= 0) {
            predicates.add(cb.ge(p.get("price"), minPrice));
        }

        if (maxPrice != null && maxPrice >= 0) {
            predicates.add(cb.le(p.get("price"), maxPrice));
        }

        cq.where(predicates.toArray(new Predicate[0]));

        cq.orderBy(cb.asc(p.get("price")));
        return em.createQuery(cq).setFirstResult((page-1)*size).setMaxResults(size).getResultList();
    }
    @Override
    public long countProducts(String[] categories, String[] brands, String gender, Double minPrice, Double maxPrice) {

        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<Long> cq = cb.createQuery(Long.class);
        Root<Product> p = cq.from(Product.class);

        cq.select(cb.count(p));

        List<Predicate> predicates = new ArrayList<>();
        if (categories != null && categories.length > 0) {
            List<Category> categoryEnums = Arrays.stream(categories).map(Category::valueOf).toList();
            predicates.add(p.get("category").in(categoryEnums));
        }

        if (brands != null && brands.length > 0) {
            List<Brand> brandEnums = Arrays.stream(brands).map(Brand::valueOf).toList();

            predicates.add(p.get("brand").in(brandEnums));
        }

        if (gender != null && !gender.isEmpty()) {
            predicates.add(cb.equal(p.get("gender"), Gender.valueOf(gender)));
        }


        if (minPrice != null && minPrice >= 0) {
            predicates.add(cb.ge(p.get("price"), minPrice));
        }

        if (maxPrice != null && maxPrice >= 0) {
            predicates.add(cb.le(p.get("price"), maxPrice));
        }

        cq.where(predicates.toArray(new Predicate[0]));

        return em.createQuery(cq).getSingleResult();
    }
}