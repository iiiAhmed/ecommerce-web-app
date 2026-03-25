package com.watch.model.dao;

import com.watch.model.entities.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

import java.util.List;

public class UserDaoImpl implements UserDao {

    private final EntityManager em;

    public UserDaoImpl(EntityManager em) {
        this.em = em;
    }

    @Override
    public List<User> getAllUsers() {
        return em.createQuery("SELECT u FROM User u", User.class).getResultList();
    }

    @Override
    public User getUserById(int id) {
        return em.find(User.class, id);
    }

    @Override
    public User findByEmail(String email) {
        try {
            return em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public boolean createUser(User user) {
        try {
            em.persist(user);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public boolean updateUser(User user) {
        try {
            em.merge(user);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public boolean deleteUser(int id) {
        try {
            User user = em.find(User.class, id);
            if (user == null) return false;
            em.remove(user);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
