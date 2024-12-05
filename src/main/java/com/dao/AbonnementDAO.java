package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.model.AbonnementModel;

/**
 * DAO pour les opérations CRUD sur la table 'abonnements'.
 */
public class AbonnementDAO {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/gestion_centre_apprentissage?useSSL=false";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    // Requêtes SQL
    private static final String INSERT_ABONNEMENT_SQL = "INSERT INTO abonnements (id_apprenant, date_debut, date_fin) VALUES (?, ?, ?);";
    private static final String SELECT_ABONNEMENT_BY_ID = "SELECT * FROM abonnements WHERE id_abonnement = ?";
    private static final String SELECT_ALL_ABONNEMENTS = "SELECT * FROM abonnements";
    private static final String DELETE_ABONNEMENT_SQL = "DELETE FROM abonnements WHERE id_abonnement = ?;";
    private static final String UPDATE_ABONNEMENT_SQL = "UPDATE abonnements SET id_apprenant = ?, date_debut = ?, date_fin = ? WHERE id_abonnement = ?;";
    private static final String SELECT_NOM_APPRENANT_BY_ID = "SELECT nom FROM apprenant WHERE id_apprenant = ?";
    
    public AbonnementDAO() {
        // Configuration avancée possible (DataSource, etc.)
    }

    /**
     * Obtenir une connexion à la base de données.
     */
    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    /**
     * Ajouter un nouvel abonnement.
     */
    public void insertAbonnement(AbonnementModel abonnement) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_ABONNEMENT_SQL)) {
            preparedStatement.setInt(1, abonnement.getIdApprenant());
            preparedStatement.setString(2, abonnement.getDateDebut());
            preparedStatement.setString(3, abonnement.getDateFin());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    /**
     * Récupérer un abonnement par ID.
     */
    public AbonnementModel selectAbonnement(int idAbonnement) {
        AbonnementModel abonnement = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ABONNEMENT_BY_ID)) {
            preparedStatement.setInt(1, idAbonnement);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                int idApprenant = rs.getInt("id_apprenant");
                String dateDebut = rs.getString("date_debut");
                String dateFin = rs.getString("date_fin");
                abonnement = new AbonnementModel(idAbonnement, idApprenant, dateDebut, dateFin);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return abonnement;
    }

    /**
     * Récupérer tous les abonnements.
     */
    public List<AbonnementModel> selectAllAbonnements() {
        List<AbonnementModel> abonnementsList = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_ABONNEMENTS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int idAbonnement = rs.getInt("id_abonnement");
                int idApprenant = rs.getInt("id_apprenant");
                String dateDebut = rs.getString("date_debut");
                String dateFin = rs.getString("date_fin");
                abonnementsList.add(new AbonnementModel(idAbonnement, idApprenant, dateDebut, dateFin));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return abonnementsList;
    }

    /**
     * Supprimer un abonnement par ID.
     */
    public boolean deleteAbonnement(int idAbonnement) throws SQLException {
        boolean rowDeleted = false;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_ABONNEMENT_SQL)) {
            statement.setInt(1, idAbonnement);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    /**
     * Mettre à jour un abonnement.
     */
    public boolean updateAbonnement(AbonnementModel abonnement) throws SQLException {
        boolean rowUpdated = false;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(UPDATE_ABONNEMENT_SQL)) {
            statement.setInt(1, abonnement.getIdApprenant());
            statement.setString(2, abonnement.getDateDebut());
            statement.setString(3, abonnement.getDateFin());
            statement.setInt(4, abonnement.getIdAbonnement());
            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    /**
     * Gestion des exceptions SQL.
     */
    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.err.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }

/**
 * Récupérer le nom d'un apprenant par son ID.
 */
    public String getNomApprenantById(int idApprenant) {
        String nomApprenant = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_NOM_APPRENANT_BY_ID)) {
            preparedStatement.setInt(1, idApprenant);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                nomApprenant = rs.getString("nom");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return nomApprenant != null ? nomApprenant : "Inconnu"; // Retourne "Inconnu" si l'apprenant n'est pas trouvé
    }
}
