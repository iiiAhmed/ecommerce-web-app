package com.watch.model.dao;

import com.watch.model.entities.User;
import com.watch.model.enums.Role;
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
    public User findByRole(Role role) {
        try {
            return em.createQuery("SELECT u FROM User u WHERE u.role = :role", User.class)
                    .setParameter("role", role)
                    .setMaxResults(1)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public boolean createUser(User user) {
        em.persist(user);
        return true;
    }

    @Override
    public boolean updateUser(User user) {
        em.merge(user);
        return true;
    }

    @Override
    public boolean deleteUser(int id) {
        User user = em.find(User.class, id);
        if (user == null) return false;
        em.remove(user);
        return true;
    }
}
