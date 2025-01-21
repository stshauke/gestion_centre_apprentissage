package com.model;

import java.time.LocalDateTime;

public class FactureModel {
    private int idFacture;           // ID unique pour la facture
    private int idCredit;            // Référence à l'ID du crédit
    private String pdfPath;          // Chemin du fichier PDF
    private LocalDateTime dateFacture; // Date de génération de la facture

    // Constructeur sans arguments
    public FactureModel() {}

    // Constructeur avec les paramètres nécessaires (sans idFacture)
    public FactureModel(int idCredit, String pdfPath) {
        this.idCredit = idCredit;
        this.pdfPath = pdfPath;
        this.dateFacture = LocalDateTime.now(); // Définit la date actuelle par défaut
    }

    // Constructeur avec tous les paramètres, y compris l'ID de la facture
    public FactureModel(int idFacture, int idCredit, String pdfPath, LocalDateTime dateFacture) {
        this.idFacture = idFacture;
        this.idCredit = idCredit;
        this.pdfPath = pdfPath;
        this.dateFacture = (dateFacture != null) ? dateFacture : LocalDateTime.now();  // Définit la date actuelle si elle est null
    }

    // Getters et setters pour tous les attributs
    public int getIdFacture() {
        return idFacture;
    }

    public void setIdFacture(int idFacture) {
        this.idFacture = idFacture;
    }

    public int getIdCredit() {
        return idCredit;
    }

    public void setIdCredit(int idCredit) {
        this.idCredit = idCredit;
    }

    public String getPdfPath() {
        return pdfPath;
    }

    public void setPdfPath(String pdfPath) {
        this.pdfPath = pdfPath;
    }

    public LocalDateTime getDateFacture() {
        return dateFacture;
    }

    public void setDateFacture(LocalDateTime dateFacture) {
        this.dateFacture = (dateFacture != null) ? dateFacture : LocalDateTime.now();  // Définit la date actuelle si elle est null
    }
}
