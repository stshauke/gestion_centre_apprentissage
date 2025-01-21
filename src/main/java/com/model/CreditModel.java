package com.model;

import java.util.Date;

public class CreditModel {
    private int idCredit;          // ID unique pour le crédit
    private int idApprenant;       // Référence à l'ID de l'apprenant
    private int idAbonnement;      // Référence à l'ID de l'abonnement
    private double montant;        // Montant du crédit
    private Date dateAcquisition;  // Date d'acquisition du crédit

    // Constructeur sans arguments
    public CreditModel() {}

    // Constructeur avec les paramètres nécessaires (sans idCredit)
    public CreditModel(int idApprenant, int idAbonnement, double montant) {
        this.idApprenant = idApprenant;
        this.idAbonnement = idAbonnement;
        this.montant = montant;
        this.dateAcquisition = new Date();  // Date d'acquisition est la date actuelle
    }

    // Constructeur avec tous les paramètres, y compris l'ID du crédit
    public CreditModel(int idCredit, int idApprenant, int idAbonnement, double montant, Date dateAcquisition) {
        this.idCredit = idCredit;
        this.idApprenant = idApprenant;
        this.idAbonnement = idAbonnement;
        this.montant = montant;
        this.dateAcquisition = (dateAcquisition != null) ? dateAcquisition : new Date(); // Définit la date actuelle si elle est null
    }

    // Getters et setters pour tous les attributs
    public int getIdCredit() {
        return idCredit;
    }

    public void setIdCredit(int idCredit) {
        this.idCredit = idCredit;
    }

    public int getIdApprenant() {
        return idApprenant;
    }

    public void setIdApprenant(int idApprenant) {
        this.idApprenant = idApprenant;
    }

    public int getIdAbonnement() {
        return idAbonnement;
    }

    public void setIdAbonnement(int idAbonnement) {
        this.idAbonnement = idAbonnement;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public Date getDateAcquisition() {
        return dateAcquisition;
    }

    public void setDateAcquisition(Date dateAcquisition) {
        this.dateAcquisition = (dateAcquisition != null) ? dateAcquisition : new Date();  // Définit la date actuelle si elle est null
    }
}
