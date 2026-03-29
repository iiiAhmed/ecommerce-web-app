package com.watch.model.services;

import com.watch.model.dao.UserDao;
import com.watch.model.dao.UserDaoImpl;
import com.watch.model.dto.AdminDto;
import com.watch.model.dto.CustomerDto;
import com.watch.model.entities.User;
import com.watch.model.enums.Role;
import com.watch.util.PasswordUtil;
import jakarta.persistence.EntityManager;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

public class UserService {

    private final EntityManager em;
    private final UserDao userDao;

    public UserService(EntityManager em) {
        this.em = em;
        this.userDao = new UserDaoImpl(em);
    }

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

    public List<CustomerDto> getCustomers() {
        return userDao.getAllUsers().stream()
                .filter(u -> u.getRole() == Role.USER)
                .map(u -> new CustomerDto(u.getUserId(), u.getName(), u.getEmail()))
                .collect(Collectors.toList());
    }

    // ── Super Admin / Admin Management ──────────────────────────────────

    public User findByRole(Role role) {
        return userDao.findByRole(role);
    }

    /**
     * Create a new admin account with a temporary password.
     * The admin will be forced to change their password on first login.
     */
    public void createAdmin(String name, String email, String tempPassword) {
        User admin = new User();
        admin.setName(name);
        admin.setEmail(email);
        admin.setPassword(PasswordUtil.hash(tempPassword));
        admin.setRole(Role.ADMIN);
        admin.setMustChangePassword(true);
        admin.setBirthday(LocalDate.of(2000, 1, 1));
        admin.setCreditLimit(0.0);
        admin.setJob("Store Administrator");
        admin.setAddress("N/A");
        admin.setInterests("N/A");
        admin.setPhone("N/A");
        userDao.createUser(admin);
    }

    /**
     * Revoke admin access — demote to regular USER.
     */
    public boolean revokeAdmin(int userId) {
        User user = userDao.getUserById(userId);
        if (user == null || user.getRole() != Role.ADMIN) return false;
        user.setRole(Role.USER);
        return userDao.updateUser(user);
    }

    /**
     * Delete an admin account entirely. Cannot delete SUPER_ADMIN.
     */
    public boolean deleteAdmin(int userId) {
        User user = userDao.getUserById(userId);
        if (user == null || user.getRole() == Role.SUPER_ADMIN) return false;
        return userDao.deleteUser(userId);
    }

    /**
     * Get all ADMIN users for the super admin management page.
     */
    public List<AdminDto> getAllAdmins() {
        return userDao.getAllUsers().stream()
                .filter(u -> u.getRole() == Role.ADMIN)
                .map(u -> new AdminDto(u.getUserId(), u.getName(), u.getEmail(), u.isMustChangePassword()))
                .collect(Collectors.toList());
    }

    // ── Password Management ─────────────────────────────────────────────

    /**
     * Change password and clear the force-change flag.
     * Used by both forced change (first login) and voluntary change (profile).
     */
    public boolean changePassword(int userId, String newPassword) {
        User user = userDao.getUserById(userId);
        if (user == null) return false;
        user.setPassword(PasswordUtil.hash(newPassword));
        user.setMustChangePassword(false);
        return userDao.updateUser(user);
    }

    /**
     * Verify a user's current password.
     */
    public boolean verifyPassword(int userId, String currentPassword) {
        User user = userDao.getUserById(userId);
        if (user == null) return false;
        return PasswordUtil.verify(currentPassword, user.getPassword());
    }
}
