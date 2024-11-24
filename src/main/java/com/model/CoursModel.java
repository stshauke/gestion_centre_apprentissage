package com.model;

/**
 * SallesModel.java
 * This is a model class representing a Salles entity.
 * Corresponds to the 'salles' table in the database.
 */
public class CoursModel {
    protected int idCours;
    protected String nomCours;
    protected String langueDispensee;
    protected String descriptionsCours;
    protected String typeCours;
    protected int idSalle;
    protected float tarifCours;
    
    // Default constructor
    public CoursModel() {}

    // Constructor without ID (useful for insertion)
    public CoursModel(String nomCours, String langueDispensee,String descriptionsCours,String typeCours,int idSalle, float tarifCours) {
    	this.nomCours=nomCours;
        this.langueDispensee=langueDispensee;
        this.descriptionsCours=descriptionsCours;
        this.typeCours=typeCours;
        this.idSalle= idSalle;
        this.tarifCours=tarifCours;
    }

    // Constructor with ID (useful for updates or queries)
    public CoursModel(int idCours,String nomCours, String langueDispensee,String descriptionsCours,String typeCours,int idSalle, float tarifCours) {
    	this.idCours=idCours;
    	this.nomCours=nomCours;
        this.langueDispensee=langueDispensee;
        this.descriptionsCours=descriptionsCours;
        this.typeCours=typeCours;
        this.idSalle= idSalle;
        this.tarifCours=tarifCours;
    }

    // Getters and setters
    public int getIdCours() {
        return idCours;
    }

    public void setIdCours(int idCours) {
        this.idCours = idCours;
    }

    public String getNomCours() {
        return nomCours;
    }

    public void setNomCours(String nomCours) {
        this.nomCours = nomCours;
    }

    public String getLangueDispensee() {
        return langueDispensee;
    }

    public void setLangueDispensee(String langueDispensee) {
        this.langueDispensee = langueDispensee;
    }
    ///DescriptionsCours
    public String getDescriptionsCours() {
        return descriptionsCours;
    }

    public void setDescriptionsCours(String descriptionsCours) {
        this.descriptionsCours = descriptionsCours;
    }
    
     ///TypesCours
    public String getTypeCours() {
        return typeCours;
    }

    public void setTypeCours(String typeCours) {
        this.typeCours = typeCours;
    }
    //Id salle
    public int getIdSalle() {
        return idSalle;
    }

    public void setIdSalle(int idSalle) {
        this.idSalle = idSalle;
    }
    
    //Tarif
    public float getTarifCours() {
        return tarifCours;
    }

    public void setTarifCours(float tarifCours) {
        this.tarifCours = tarifCours;
    }
    

    @Override
    public String toString() {
        return "CoursModel [idCours=" + idCours + ", nomCours=" + nomCours + 
                ", langueDispensee=" + langueDispensee + ", descriptionsCours=" + descriptionsCours +
                ", typeCours=" + typeCours + ", idSalle=" + idSalle + ", tarifCours=" + tarifCours + "]";
    }
}
