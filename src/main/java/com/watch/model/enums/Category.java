package com.watch.model.enums;

public enum Category {
    LUXURY("Luxury"),
    SPORT("Sport"),
    CASUAL("Casual"),
    CLASSIC("Classic"),
    DIGITAL( "Digital"),
    SMART( "Smart"),
    DIVING( "Diving");

    private final String displayName;

    Category(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
