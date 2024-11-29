package com.model;

/**
 * SallesModel.java
 * This is a model class representing a Salles entity.
 * Corresponds to the 'salles' table in the database.
 */
public class MessageModel {
	protected int idMessage;         // Identifiant unique du message
    protected int idApprenant;       // Référence à l'apprenant qui poste le message
    protected String contenu;        // Contenu du message
    protected String langueCible;    // Langue ciblée pour l'échange
    protected String datePublication; // Date de publication du message

    // Default constructor
    public MessageModel() {}

    // Constructor without ID (useful for insertion)
    public MessageModel(int idApprenant, String contenu, String langueCible, String datePublication) {
        this.idApprenant = idApprenant;
        this.contenu = contenu;
        this.langueCible = langueCible;
        this.datePublication = datePublication;
    }
    // Constructor with ID (useful for updates or queries)
    public MessageModel(int idMessage,int idApprenant, String contenu, String langueCible, String datePublication) {
        this.idMessage = idMessage;
        this.idApprenant = idApprenant;
        this.contenu = contenu;
        this.langueCible = langueCible;
        this.datePublication = datePublication;
    }
    // Getters and setters
    public int getIdMessage() {
        return idMessage;
    }

    public void setIdMessage(int idMessage) {
        this.idMessage = idMessage;
    }
    public int getIdApprenant() {
        return idApprenant;
    }

    public void setIdApprenant(int idApprenant) {
        this.idApprenant = idApprenant;
    }
    public String getContenu() {
        return contenu;
    }

    public void setContenu(String contenu) {
        this.contenu = contenu;
    }
    public String getLangueCible() {
        return langueCible;
    }

    public void setLangueCible(String langueCible) {
        this.langueCible = langueCible;
    }
    public String getDatePublication() {
        return datePublication;
    }

    public void setDatePublication(String datePublication) {
        this.datePublication = datePublication;
    }
    
    

    @Override
    public String toString() {
        return "MessageModel [idMessage=" + idMessage +
                ", idApprenant=" + idApprenant +
                ", contenu=" + contenu +
                ", langueCible=" + langueCible +
                ", datePublication=" + datePublication + "]";
    }
}
