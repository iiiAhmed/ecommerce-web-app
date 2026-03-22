package com.watch.model.dao;

import com.watch.model.entities.User;
import jakarta.persistence.EntityManager;

public class UserDaoImpl implements UserDao {

    private final EntityManager em;

    public UserDaoImpl(EntityManager em) {
        this.em = em;
    }
    //for testing only
    public User findById(int userId){
        return em.find(User.class, userId);
    }
}
