package com.model;



public class AbonnementModel {
    private int idAbonnement;  // ID unique pour l'abonnement
    private String nom;        // Nom de l'abonnement
    private String description; // Description de l'abonnement
    private double prix;   // Prix de l'abonnement (utilisation de BigDecimal pour plus de précision)
    private int duree;         // Durée de l'abonnement
    private String uniteDuree; // Unité de durée (jour, mois, an)

    // Constructeur sans arguments
    public AbonnementModel() {}

    // Constructeur avec les paramètres nécessaires
    public AbonnementModel(String nom, String description, double prix, int duree, String uniteDuree) {
        this.nom = nom;
        this.description = description;
        this.prix = prix;
        this.duree = duree;
        this.uniteDuree = uniteDuree;
    }

    // Constructeur avec tous les paramètres, y compris l'ID d'abonnement
    public AbonnementModel(int idAbonnement, String nom, String description, double prix, int duree, String uniteDuree) {
        this.idAbonnement = idAbonnement;
        this.nom = nom;
        this.description = description;
        this.prix = prix;
        this.duree = duree;
        this.uniteDuree = uniteDuree;
    }

    // Getters et setters pour tous les attributs

    public int getIdAbonnement() {
        return idAbonnement;
    }

    public void setIdAbonnement(int idAbonnement) {
        this.idAbonnement = idAbonnement;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }

    public int getDuree() {
        return duree;
    }

    public void setDuree(int duree) {
        this.duree = duree;
    }

    public String getUniteDuree() {
        return uniteDuree;
    }

    public void setUniteDuree(String uniteDuree) {
        this.uniteDuree = uniteDuree;
    }
}
