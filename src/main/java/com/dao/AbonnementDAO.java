package com.dao;

import com.model.AbonnementModel;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AbonnementDAO {
    // Informations de connexion à la base de données
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/gestion_centre_apprentissage";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    // Requêtes SQL
    private static final String INSERT_ABONNEMENT_SQL = "INSERT INTO abonnements (nom, description, prix, duree, unite_duree) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_ABONNEMENT_BY_ID = "SELECT * FROM abonnements WHERE id_abonnement = ?";
    private static final String SELECT_ALL_ABONNEMENTS = "SELECT * FROM abonnements";
    private static final String DELETE_ABONNEMENT_SQL = "DELETE FROM abonnements WHERE id_abonnement = ?";
    private static final String UPDATE_ABONNEMENT_SQL = "UPDATE abonnements SET nom = ?, description = ?, prix = ?, duree = ?, unite_duree = ? WHERE id_abonnement = ?";

    public AbonnementDAO() {
        // Constructeur par défaut
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
            preparedStatement.setString(1, abonnement.getNom());
            preparedStatement.setString(2, abonnement.getDescription());
            preparedStatement.setDouble(3, abonnement.getPrix());
            preparedStatement.setInt(4, abonnement.getDuree());
            preparedStatement.setString(5, abonnement.getUniteDuree());
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
                String nom = rs.getString("nom");
                String description = rs.getString("description");
                double prix = rs.getDouble("prix");
                int duree = rs.getInt("duree");
                String uniteDuree = rs.getString("unite_duree");
                abonnement = new AbonnementModel(idAbonnement, nom, description, prix, duree, uniteDuree);
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
        List<AbonnementModel> abonnements = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_ABONNEMENTS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int idAbonnement = rs.getInt("id_abonnement");
                String nom = rs.getString("nom");
                String description = rs.getString("description");
                double prix = rs.getDouble("prix");
                int duree = rs.getInt("duree");
                String uniteDuree = rs.getString("unite_duree");
                abonnements.add(new AbonnementModel(idAbonnement, nom, description, prix, duree, uniteDuree));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return abonnements;
    }

    /**
     * Mettre à jour un abonnement.
     */
    public boolean updateAbonnement(AbonnementModel abonnement) throws SQLException {
        boolean rowUpdated = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_ABONNEMENT_SQL)) {
            preparedStatement.setString(1, abonnement.getNom());
            preparedStatement.setString(2, abonnement.getDescription());
            preparedStatement.setDouble(3, abonnement.getPrix());
            preparedStatement.setInt(4, abonnement.getDuree());
            preparedStatement.setString(5, abonnement.getUniteDuree());
            preparedStatement.setInt(6, abonnement.getIdAbonnement());
            rowUpdated = preparedStatement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    /**
     * Supprimer un abonnement par ID.
     */
    public boolean deleteAbonnement(int idAbonnement) throws SQLException {
        boolean rowDeleted = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_ABONNEMENT_SQL)) {
            preparedStatement.setInt(1, idAbonnement);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        }
        return rowDeleted;
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
}
