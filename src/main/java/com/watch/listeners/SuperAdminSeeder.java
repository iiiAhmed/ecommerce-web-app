package com.watch.listeners;

import com.watch.model.entities.User;
import com.watch.model.enums.Role;
import com.watch.util.EntityManagerFactorySingleton;
import com.watch.util.PasswordUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebListener
public class SuperAdminSeeder implements ServletContextListener {

    private static final Logger LOG = Logger.getLogger(SuperAdminSeeder.class.getName());

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        String email = System.getenv("SUPER_ADMIN_EMAIL");
        String password = System.getenv("SUPER_ADMIN_PASSWORD");
        String name = System.getenv("SUPER_ADMIN_NAME");

        if (email == null || email.isBlank() || password == null || password.isBlank()) {
            LOG.warning("SUPER_ADMIN_EMAIL or SUPER_ADMIN_PASSWORD env vars not set. Skipping super admin seeding.");
            return;
        }

        if (name == null || name.isBlank()) {
            name = "Super Admin";
        }

        EntityManager em = EntityManagerFactorySingleton.getInstance().createEntityManager();
        try {
            // Check if a super admin already exists
            User existing = null;
            try {
                existing = em.createQuery("SELECT u FROM User u WHERE u.role = :role", User.class)
                        .setParameter("role", Role.SUPER_ADMIN)
                        .setMaxResults(1)
                        .getSingleResult();
            } catch (NoResultException ignored) {
                // No super admin exists yet — we'll create one
            }

            if (existing != null) {
                LOG.info("Super Admin already exists (id=" + existing.getUserId() + "). Skipping seeding.");
                return;
            }

            // Create the super admin
            User superAdmin = new User();
            superAdmin.setName(name);
            superAdmin.setEmail(email);
            superAdmin.setPassword(PasswordUtil.hash(password));
            superAdmin.setRole(Role.SUPER_ADMIN);
            superAdmin.setMustChangePassword(false);
            superAdmin.setBirthday(LocalDate.of(2000, 1, 1));
            superAdmin.setCreditLimit(0.0);
            superAdmin.setJob("System Administrator");
            superAdmin.setAddress("N/A");
            superAdmin.setInterests("N/A");
            superAdmin.setPhone("N/A");

            em.getTransaction().begin();
            em.persist(superAdmin);
            em.getTransaction().commit();

            LOG.info("Super Admin seeded successfully with email: " + email);

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            LOG.log(Level.SEVERE, "Failed to seed Super Admin", e);
        } finally {
            if (em.isOpen()) {
                em.close();
            }
        }
    }
}
