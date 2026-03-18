package com.watch.util;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * Simple file upload utility for storing product images.
 */
public class FileUploadUtil {

    private FileUploadUtil() {
    }

    public static final long MAX_IMAGE_SIZE_BYTES = 2L * 1024 * 1024; // 2 MB

    private static final String[] ALLOWED_CONTENT_TYPES = {
            "image/jpeg",
            "image/png"
    };

    /**
     * Returns true if the given content type is an allowed image type.
     */
    public static boolean isAllowedImageContentType(String contentType) {
        if (contentType == null) {
            return false;
        }
        for (String allowed : ALLOWED_CONTENT_TYPES) {
            if (allowed.equalsIgnoreCase(contentType)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Returns the filename extension (including dot) based on content type.
     * Defaults to ".jpg" when unknown jpeg subtype.
     */
    public static String getExtensionForContentType(String contentType) {
        if (contentType == null) {
            return "";
        }
        if (contentType.equalsIgnoreCase("image/png")) {
            return ".png";
        }
        if (contentType.equalsIgnoreCase("image/jpeg") || contentType.equalsIgnoreCase("image/jpg")) {
            return ".jpg";
        }
        return "";
    }

    /**
     * Resolve the absolute upload directory for product images and ensure it exists.
     * The directory is under the webapp "images/products" folder.
     *
     * @param realPathResolver typically ServletContext::getRealPath
     * @return Path to the upload directory
     */
    public static Path resolveProductImagesDirectory(java.util.function.Function<String, String> realPathResolver) throws java.io.IOException {
        String realPath = realPathResolver.apply("/images/products");
        if (realPath == null) {
            throw new java.io.IOException("Cannot resolve real path for /images/products");
        }
        Path uploadDir = Paths.get(realPath);
        if (!Files.exists(uploadDir)) {
            Files.createDirectories(uploadDir);
        }
        return uploadDir;
    }
}

