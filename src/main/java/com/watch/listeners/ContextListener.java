package com.watch.listeners;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import com.watch.util.EntityManagerFactorySingleton;

@WebListener
public class ContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        EntityManagerFactorySingleton.getInstance();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        EntityManagerFactorySingleton.shutdown();
    }
}
