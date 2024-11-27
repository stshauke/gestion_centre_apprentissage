package com.model;

/**
 * AbonnementsModel.java
 * This is a model class representing an Abonnement entity.
 * Corresponds to the 'abonnements' table in the database.
 */
public class AbonnementModel {
    protected int idAbonnement;
    protected int idApprenant;
    protected String dateDebut;
    protected String dateFin;

    // Default constructor
    public AbonnementModel() {}

    // Constructor without ID (useful for insertion)
    public AbonnementModel(int idApprenant, String dateDebut, String dateFin) {
        this.idApprenant = idApprenant;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
    }

    // Constructor with ID (useful for updates or queries)
    public AbonnementModel(int idAbonnement, int idApprenant, String dateDebut, String dateFin) {
        this.idAbonnement = idAbonnement;
        this.idApprenant = idApprenant;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
    }

    // Getters and setters
    public int getIdAbonnement() {
        return idAbonnement;
    }

    public void setIdAbonnement(int idAbonnement) {
        this.idAbonnement = idAbonnement;
    }

    public int getIdApprenant() {
        return idApprenant;
    }

    public void setIdApprenant(int idApprenant) {
        this.idApprenant = idApprenant;
    }

    public String getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(String dateDebut) {
        this.dateDebut = dateDebut;
    }

    public String getDateFin() {
        return dateFin;
    }

    public void setDateFin(String dateFin) {
        this.dateFin = dateFin;
    }

    @Override
    public String toString() {
        return "AbonnementModel [idAbonnement=" + idAbonnement + 
                ", idApprenant=" + idApprenant + 
                ", dateDebut=" + dateDebut + 
                ", dateFin=" + dateFin + "]";
    }
}
