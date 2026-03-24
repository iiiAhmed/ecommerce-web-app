package com.watch.model.enums;

public enum Gender {
    MALE("Men"),
    FEMALE("Women"),
    UNISEX("Unisex");

    private final String displayName;

    Gender(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}