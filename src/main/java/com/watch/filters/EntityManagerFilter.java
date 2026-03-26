package com.watch.filters;

import com.watch.util.EntityManagerFactorySingleton;
import jakarta.persistence.EntityManager;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;

import java.io.IOException;

@WebFilter(urlPatterns = "/*")
public class EntityManagerFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        EntityManager em = EntityManagerFactorySingleton.getInstance().createEntityManager();
        request.setAttribute("em", em);
        try {
            em.getTransaction().begin();
            chain.doFilter(request, response);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            throw new ServletException(e);
        } finally {
            if (em.isOpen()) em.close();
        }
    }
}
