package com.apprenant.model;

/**
 * ApprenantModel.java
 * This is a model class representing an Apprenant entity.
 * Corresponds to the 'apprenant' table in the database.
 */
public class ApprenantModel {
    protected int idApprenant;
    protected String nom;
    protected String niveauLangue;
    protected String langueCible;

    // Default constructor
    public ApprenantModel() {}

    // Constructor without ID (useful for insertion)
    public ApprenantModel(String nom, String niveauLangue, String langueCible) {
        this.nom = nom;
        this.niveauLangue = niveauLangue;
        this.langueCible = langueCible;
    }

    // Constructor with ID (useful for updates or queries)
    public ApprenantModel(int idApprenant, String nom, String niveauLangue, String langueCible) {
        this.idApprenant = idApprenant;
        this.nom = nom;
        this.niveauLangue = niveauLangue;
        this.langueCible = langueCible;
    }

    // Getters and setters
    public int getIdApprenant() {
        return idApprenant;
    }

    public void setIdApprenant(int idApprenant) {
        this.idApprenant = idApprenant;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getNiveauLangue() {
        return niveauLangue;
    }

    public void setNiveauLangue(String niveauLangue) {
        this.niveauLangue = niveauLangue;
    }

    public String getLangueCible() {
        return langueCible;
    }

    public void setLangueCible(String langueCible) {
        this.langueCible = langueCible;
    }

    @Override
    public String toString() {
        return "ApprenantModel [idApprenant=" + idApprenant + ", nom=" + nom + 
               ", niveauLangue=" + niveauLangue + ", langueCible=" + langueCible + "]";
    }
}
