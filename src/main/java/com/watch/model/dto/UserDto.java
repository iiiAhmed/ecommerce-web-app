package com.watch.model.dto;

import com.watch.model.enums.Role;

public class UserDto {
    private int id;
    private String name;
    private Role role;
    private boolean mustChangePassword;

    public UserDto(int id, String name, Role role, boolean mustChangePassword) {
        this.id = id;
        this.name = name;
        this.role = role;
        this.mustChangePassword = mustChangePassword;
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

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public boolean isMustChangePassword() {
        return mustChangePassword;
    }

    public void setMustChangePassword(boolean mustChangePassword) {
        this.mustChangePassword = mustChangePassword;
    }
}
