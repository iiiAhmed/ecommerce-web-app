package com.watch.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Temporary servlet to verify that environment variables are readable on Render.
 * DELETE THIS after confirming it works.
 */
@WebServlet("/test-env")
public class TestEnvServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/plain; charset=UTF-8");
        PrintWriter out = resp.getWriter();

        String testVar = System.getenv("CLOUDINARY_URL");

        out.println("=== Environment Variable Test ===");
        out.println("CLOUDINARY_URL = " + testVar);
        out.println("Is null? " + (testVar == null));
        out.println();
        out.println("If you see a value above, env vars are working!");
    }
}
