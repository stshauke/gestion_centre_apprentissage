/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

/**
 *
 * @author snekh
 */

public class UserModel {
    private int idUser;
    private String email;
    private String password;
    private String role; // "admin" ou "apprenant"
    private ApprenantModel apprenant; // Relation avec Apprenant (si rôle = apprenant)

    // Constructeurs
    public UserModel() {}

    public UserModel(int idUser, String email, String password, String role) {
        this.idUser = idUser;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    public UserModel (int idUser, String email, String password, String role, ApprenantModel apprenant) {
        this.idUser = idUser;
        this.email = email;
        this.password = password;
        this.role = role;
        this.apprenant = apprenant;
    }

    // Getters et Setters
    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public ApprenantModel getApprenant() {
        return apprenant;
    }

    public void setApprenant(ApprenantModel apprenant) {
        this.apprenant = apprenant;
    }
    
}
