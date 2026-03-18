package com.watch.model.services;

import com.watch.model.dao.UserDaoImpl;
import com.watch.model.entities.User;
import com.watch.model.enums.Role;
import com.watch.util.PasswordUtil;

import java.util.List;

public class UserService {

    private final UserDaoImpl userDao = UserDaoImpl.getInstance();

    public List<User> getAllUsers() {
        return userDao.getAllUsers();
    }

    public User getUserById(int id) {
        return userDao.getUserById(id);
    }

    public User authenticate(String email, String password) {
        User user = userDao.findByEmail(email);
        if (user != null && PasswordUtil.verify(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    public void register(User user) {
        user.setPassword(PasswordUtil.hash(user.getPassword()));
        user.setRole(Role.USER);
        userDao.createUser(user);
    }

    public boolean updateUser(User user) {
        return userDao.updateUser(user);
    }

    public boolean deleteUser(int id) {
        return userDao.deleteUser(id);
    }

    public boolean isEmailTaken(String email) {
        return userDao.findByEmail(email) != null;
    }
}
