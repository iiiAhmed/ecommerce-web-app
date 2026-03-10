package com.watch.model.dao;

public class UserDaoImpl implements UserDao {

    private static final UserDaoImpl instance = new UserDaoImpl();

    private UserDaoImpl() {
    }

    public static UserDaoImpl getInstance() {
        return instance;
    }
}
