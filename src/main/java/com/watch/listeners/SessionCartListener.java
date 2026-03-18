package com.watch.listeners;

import com.watch.model.services.CartService;
import com.watch.util.EntityManagerFactorySingleton;
import jakarta.persistence.EntityManager;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

import java.util.Map;

@WebListener
public class SessionCartListener implements HttpSessionListener {
    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");
        Map<Integer, Integer> sessionCart = (Map<Integer, Integer>) session.getAttribute("cart");


        if (userId != null && sessionCart != null && !sessionCart.isEmpty()) {
            EntityManager em = EntityManagerFactorySingleton.getInstance().createEntityManager();
            try {
                em.getTransaction().begin();
                new CartService(em).saveSessionCartToDb(userId, sessionCart);
                em.getTransaction().commit();
            } catch (Exception e) {
                if (em.getTransaction().isActive())
                    em.getTransaction().rollback();
            } finally {
                if (em.isOpen())
                    em.close();
            }
        }

    }
}
