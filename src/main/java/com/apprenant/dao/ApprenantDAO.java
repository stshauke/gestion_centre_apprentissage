package com.apprenant.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.apprenant.model.ApprenantModel;

/**
 * ApprenantDAO.java
 * This DAO class provides CRUD database operations for the
 * 'apprenant' table in the database.
 */
public class ApprenantDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/gestion_centre_apprentissage?useSSL=false";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    private static final String INSERT_APPRENANT_SQL = "INSERT INTO apprenant (nom, niveau_langue, langue_cible) VALUES (?, ?, ?);";
    private static final String SELECT_APPRENANT_BY_ID = "SELECT id_apprenant, nom, niveau_langue, langue_cible FROM apprenant WHERE id_apprenant = ?";
    private static final String SELECT_ALL_APPRENANTS = "SELECT * FROM apprenant";
    private static final String DELETE_APPRENANT_SQL = "DELETE FROM apprenant WHERE id_apprenant = ?;";
    private static final String UPDATE_APPRENANT_SQL = "UPDATE apprenant SET nom = ?, niveau_langue = ?, langue_cible = ? WHERE id_apprenant = ?;";

    public ApprenantDAO() {}

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public void insertApprenant(ApprenantModel apprenant) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_APPRENANT_SQL)) {
            preparedStatement.setString(1, apprenant.getNom());
            preparedStatement.setString(2, apprenant.getNiveauLangue());
            preparedStatement.setString(3, apprenant.getLangueCible());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public ApprenantModel selectApprenant(int idApprenant) {
        ApprenantModel apprenant = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_APPRENANT_BY_ID)) {
            preparedStatement.setInt(1, idApprenant);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                String nom = rs.getString("nom");
                String niveauLangue = rs.getString("niveau_langue");
                String langueCible = rs.getString("langue_cible");
                apprenant = new ApprenantModel(idApprenant, nom, niveauLangue, langueCible);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return apprenant;
    }

    public List<ApprenantModel> selectAllApprenants() {
        List<ApprenantModel> apprenants = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_APPRENANTS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int idApprenant = rs.getInt("id_apprenant");
                String nom = rs.getString("nom");
                String niveauLangue = rs.getString("niveau_langue");
                String langueCible = rs.getString("langue_cible");
                apprenants.add(new ApprenantModel(idApprenant, nom, niveauLangue, langueCible));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return apprenants;
    }

    public boolean deleteApprenant(int idApprenant) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_APPRENANT_SQL)) {
            statement.setInt(1, idApprenant);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean updateApprenant(ApprenantModel apprenant) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(UPDATE_APPRENANT_SQL)) {
            statement.setString(1, apprenant.getNom());
            statement.setString(2, apprenant.getNiveauLangue());
            statement.setString(3, apprenant.getLangueCible());
            statement.setInt(4, apprenant.getIdApprenant());
            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e: ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
