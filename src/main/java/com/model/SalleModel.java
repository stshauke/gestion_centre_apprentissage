package com.model;

/**
 * SallesModel.java
 * This is a model class representing a Salles entity.
 * Corresponds to the 'salles' table in the database.
 */
public class SalleModel {
    protected int idSalle;
    protected String nomSalle;
    protected String equipements;

    // Default constructor
    public SalleModel() {}

    // Constructor without ID (useful for insertion)
    public SalleModel(String nomSalle, String equipements) {
        this.nomSalle = nomSalle;
        this.equipements = equipements;
    }

    // Constructor with ID (useful for updates or queries)
    public SalleModel(int idSalle, String nomSalle, String equipements) {
        this.idSalle = idSalle;
        this.nomSalle = nomSalle;
        this.equipements = equipements;
    }

    // Getters and setters
    public int getIdSalle() {
        return idSalle;
    }

    public void setIdSalle(int idSalle) {
        this.idSalle = idSalle;
    }

    public String getNomSalle() {
        return nomSalle;
    }

    public void setNomSalle(String nomSalle) {
        this.nomSalle = nomSalle;
    }

    public String getEquipements() {
        return equipements;
    }

    public void setEquipements(String equipements) {
        this.equipements = equipements;
    }

    @Override
    public String toString() {
        return "SallesModel [idSalle=" + idSalle + ", nomSalle=" + nomSalle + 
               ", equipements=" + equipements + "]";
    }
}
