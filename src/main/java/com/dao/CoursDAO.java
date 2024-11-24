package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.model.CoursModel;

/**
 * DAO pour les opérations CRUD sur la table 'salles'.
 */
public class CoursDAO {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/gestion_centre_apprentissage?useSSL=false";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    // Requêtes SQL
    private static final String INSERT_COURS_SQL = "INSERT INTO cours (nom_cours, langue_dispensee, descriptions_cours, type_cours, id_salle, tarif_cours) VALUES (?, ?, ?, ?, ?, ?);";
    private static final String SELECT_COURS_BY_ID = "SELECT * FROM cours WHERE id_cours = ?";
    private static final String SELECT_ALL_COURS = "SELECT * FROM cours";
    private static final String DELETE_COURS_SQL = "DELETE FROM cours WHERE id_cours = ?;";
    private static final String UPDATE_COURS_SQL = "UPDATE cours SET nom_cours = ?, langue_dispensee = ?, descriptions_cours = ?, type_cours = ?, id_salle = ?, tarif_cours = ? WHERE id_cours = ?;";

    public CoursDAO() {
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
     * Ajouter un nouveau cours.
     */
    public void insertCours(CoursModel cours) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_COURS_SQL)) {
            preparedStatement.setString(1, cours.getNomCours());
            preparedStatement.setString(2, cours.getLangueDispensee());
            preparedStatement.setString(3, cours.getDescriptionsCours());
            preparedStatement.setString(4, cours.getTypeCours());
            preparedStatement.setInt(5, cours.getIdSalle());
            preparedStatement.setFloat(6, cours.getTarifCours());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    /**
     * Récupérer un cours par ID.
     */
    public CoursModel selectCours(int idCours) {
        CoursModel cours = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_COURS_BY_ID)) {
            preparedStatement.setInt(1, idCours);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                String nomCours = rs.getString("nom_cours");
                String langueDispensee = rs.getString("langue_dispensee");
                String descriptionsCours = rs.getString("descriptions_cours");
                String typeCours = rs.getString("type_cours");
                int idSalle = rs.getInt("id_salle");
                float tarifCours = rs.getFloat("tarif_cours");
                cours = new CoursModel(idCours, nomCours, langueDispensee, descriptionsCours, typeCours, idSalle, tarifCours);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return cours;
    }

    /**
     * Récupérer tous les cours.
     */
    public List<CoursModel> selectAllCours() {
        List<CoursModel> coursList = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_COURS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int idCours = rs.getInt("id_cours");
                String nomCours = rs.getString("nom_cours");
                String langueDispensee = rs.getString("langue_dispensee");
                String descriptionsCours = rs.getString("descriptions_cours");
                String typeCours = rs.getString("type_cours");
                int idSalle = rs.getInt("id_salle");
                float tarifCours = rs.getFloat("tarif_cours");
                coursList.add(new CoursModel(idCours, nomCours, langueDispensee, descriptionsCours, typeCours, idSalle, tarifCours));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return coursList;
    }
    /**
     * Supprimer une salle par ID.
     */
    public boolean deleteCours(int idCours) throws SQLException {
        boolean rowDeleted = false;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_COURS_SQL)) {
            statement.setInt(1, idCours);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    /**
     * Mettre à jour un cours.
     */
    public boolean updateCours(CoursModel cours) throws SQLException {
        boolean rowUpdated = false;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(UPDATE_COURS_SQL)) {
            statement.setString(1, cours.getNomCours());
            statement.setString(2, cours.getLangueDispensee());
            statement.setString(3, cours.getDescriptionsCours());
            statement.setString(4, cours.getTypeCours());
            statement.setInt(5, cours.getIdSalle());
            statement.setFloat(6, cours.getTarifCours());
            statement.setInt(7, cours.getIdCours());
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
