# Sync Store - E-Commerce Web Application

**Sync Store** is a full-featured, mobile-first e-commerce web application built to provide a secure and seamless online shopping experience. It features strict role-based access control, real-time cart management, a virtual credit system, and robust concurrency control against double-spending and overselling.

## Core Features
*   **User Roles:** Distinct dashboards and permissions for Customers, Administrators, and Super Administrators.
*   **Shopping Cart & Checkout:** Asynchronous cart updates and a robust virtual checkout system that instantly validates user credit and updates product inventory lock-step.
*   **Admin Dashboard:** Secure interface for managing products, adjusting inventory, and reviewing customer profiles.
*   **Concurrency Safety:** Utilizes advanced database-level pessimistic and optimistic locking to prevent checkout collisions and stale admin updates.

## Technology Stack
*   **Backend:** Java 17, Jakarta EE 9.0 (Servlets, JSP)
*   **Database & ORM:** MySQL 8, Hibernate Core 6.4 (JPA), HikariCP for connection pooling
*   **Frontend:** HTML5, CSS3, Vanilla JavaScript, JSTL
*   **Security:** jBcrypt for password hashing
*   **Server / Build Tool:** Apache Tomcat / Apache Maven

## Database Entities
The completely normalized schema is organized into the following models:
*   **Users:** Manages account details, hashed passwords, access roles, and virtual credit limits.
*   **Products:** The core catalog managing pricing and available stock (tracked with optimistic locking).
*   **Product Images:** Stores and orders the multi-image gallery for each product.
*   **Orders & Order Items:** Immutable historical snapshots of completed purchases.
*   **Cart Items:** Maintains the persistent state of users' active shopping carts.

## How to Run Locally
The project uses the Apache Tomcat Maven plugin for rapid deployment. 

1. Ensure your local **MySQL server** is running.
2. Verify the database credentials inside `src/main/resources/META-INF/persistence.xml`.
3. Open a terminal at the project root and execute:
   ```bash
   mvn tomcat7:redeploy
   ```
4. Access the store in your browser via the configured Tomcat path (usually `http://localhost:8080/watches`).

---
*Built as a comprehensive deliverable evaluating Client-Side Technologies, Servlets/JSP, Asynchronous APIs, and ORM.*