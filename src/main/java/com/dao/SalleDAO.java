package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.model.SalleModel;

/**
 * DAO pour les opérations CRUD sur la table 'salles'.
 */
public class SalleDAO {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/gestion_centre_apprentissage?useSSL=false";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    // Requêtes SQL
    private static final String INSERT_SALLE_SQL = "INSERT INTO salles (nom_salle, equipements) VALUES (?, ?);";
    private static final String SELECT_SALLE_BY_ID = "SELECT id_salle, nom_salle, equipements FROM salles WHERE id_salle = ?";
    private static final String SELECT_ALL_SALLES = "SELECT * FROM salles";
    private static final String DELETE_SALLE_SQL = "DELETE FROM salles WHERE id_salle = ?;";
    private static final String UPDATE_SALLE_SQL = "UPDATE salles SET nom_salle = ?, equipements = ? WHERE id_salle = ?;";

    public SalleDAO() {
        // Vous pouvez utiliser une configuration avancée comme un DataSource ici.
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
     * Ajouter une nouvelle salle.
     */
    public void insertSalle(SalleModel salle) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_SALLE_SQL)) {
            preparedStatement.setString(1, salle.getNomSalle());
            preparedStatement.setString(2, salle.getEquipements());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    /**
     * Récupérer une salle par ID.
     */
    public SalleModel selectSalle(int idSalle) {
        SalleModel salle = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_SALLE_BY_ID)) {
            preparedStatement.setInt(1, idSalle);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                String nomSalle = rs.getString("nom_salle");
                String equipements = rs.getString("equipements");
                salle = new SalleModel(idSalle, nomSalle, equipements);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return salle;
    }

    /**
     * Récupérer toutes les salles.
     */
    public List<SalleModel> selectAllSalles() {
        List<SalleModel> salles = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_SALLES)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int idSalle = rs.getInt("id_salle");
                String nomSalle = rs.getString("nom_salle");
                String equipements = rs.getString("equipements");
                salles.add(new SalleModel(idSalle, nomSalle, equipements));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return salles;
    }

    /**
     * Supprimer une salle par ID.
     */
    public boolean deleteSalle(int idSalle) throws SQLException {
        boolean rowDeleted = false;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_SALLE_SQL)) {
            statement.setInt(1, idSalle);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    /**
     * Mettre à jour une salle.
     */
    public boolean updateSalle(SalleModel salle) throws SQLException {
        boolean rowUpdated = false;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(UPDATE_SALLE_SQL)) {
            statement.setString(1, salle.getNomSalle());
            statement.setString(2, salle.getEquipements());
            statement.setInt(3, salle.getIdSalle());
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
}
