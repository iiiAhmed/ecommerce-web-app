package com.watch.model.dto;

public class AdminDto {
    private int id;
    private String name;
    private String email;
    private boolean pendingPasswordChange;

    public AdminDto(int id, String name, String email, boolean pendingPasswordChange) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.pendingPasswordChange = pendingPasswordChange;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isPendingPasswordChange() {
        return pendingPasswordChange;
    }

    public void setPendingPasswordChange(boolean pendingPasswordChange) {
        this.pendingPasswordChange = pendingPasswordChange;
    }
}
