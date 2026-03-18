package com.watch.model.dao;

import com.watch.model.entities.User;

import java.util.List;

public interface UserDao {
    List<User> getAllUsers();
    User getUserById(int id);
    User findByEmail(String email);
    boolean createUser(User user);
    boolean updateUser(User user);
    boolean deleteUser(int id);
}
