package com.watch.model.dao;

import com.watch.model.entities.User;
import com.watch.util.EntityManagerFactorySingleton;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

import java.util.List;

public class UserDaoImpl implements UserDao {

    private static final UserDaoImpl instance = new UserDaoImpl();

    private UserDaoImpl() {
    }

    public static UserDaoImpl getInstance() {
        return instance;
    }

    private EntityManager getEm() {
        return EntityManagerFactorySingleton.getInstance().createEntityManager();
    }

    @Override
    public List<User> getAllUsers() {
        EntityManager em = getEm();
        try {
            return em.createQuery("SELECT u FROM User u", User.class).getResultList();
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public User getUserById(int id) {
        EntityManager em = getEm();
        try {
            return em.find(User.class, id);
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public User findByEmail(String email) {
        EntityManager em = getEm();
        try {
            return em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            if (em.isOpen()) em.close();
        }
    }

    @Override
    public boolean createUser(User user) {
        EntityManager em = getEm();
        try {
            em.getTransaction().begin();
            em.persist(user);
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
    public boolean updateUser(User user) {
        EntityManager em = getEm();
        try {
            em.getTransaction().begin();
            em.merge(user);
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
    public boolean deleteUser(int id) {
        EntityManager em = getEm();
        try {
            em.getTransaction().begin();
            User user = em.find(User.class, id);
            if (user == null) return false;
            em.remove(user);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            return false;
        } finally {
            if (em.isOpen()) em.close();
        }
    }
}
