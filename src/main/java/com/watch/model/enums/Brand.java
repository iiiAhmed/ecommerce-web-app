package com.watch.model.enums;


public enum Brand {

    ROLEX("Rolex"),
    OMEGA("Omega"),
    TAG_HEUER("Tag Heuer"),
    CASIO("Casio"),
    SEIKO("Seiko"),
    TISSOT("Tissot"),
    PATEK_PHILIPPE("Patek Philippe"),
    AUDEMARS_PIGUET("Audemars Piguet"),
    HUBLOT("Hublot"),
    BREITLING("Breitling"),
    LONGINES("Longines"),
    CITIZEN("Citizen");

    private final String displayName;

    Brand(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}