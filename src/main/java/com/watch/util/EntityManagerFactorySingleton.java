package com.watch.util;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class EntityManagerFactorySingleton {

    private static EntityManagerFactory instance;

    private EntityManagerFactorySingleton() {}

    public static synchronized EntityManagerFactory getInstance() {
        if (instance == null) {
            instance = Persistence.createEntityManagerFactory("watches");
        }
        return instance;
    }

    public static synchronized void shutdown() {
        if (instance != null && instance.isOpen()) {
            instance.close();
        }
    }
}