package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.model.CreditModel;

public class CreditDAO {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/gestion_centre_apprentissage";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";
    private static final String SELECT_CREDIT_BY_ID = "SELECT * FROM credits WHERE id_credit = ?";
    // Méthode pour insérer un crédit dans la base de données
    /*public void insertCredit(CreditModel credit) throws SQLException {
        String sql = "INSERT INTO credits (id_apprenant, id_abonnement, montant, date_acquisition) VALUES (?, ?, ?, NOW())";

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setInt(1, credit.getIdApprenant());
            statement.setInt(2, credit.getIdAbonnement());
            statement.setDouble(3, credit.getMontant());

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Erreur lors de l'insertion du crédit", e);
        }
    }*/
    public int insertCredit(CreditModel credit) throws SQLException {
        String sql = "INSERT INTO credits (id_apprenant, id_abonnement, montant, date_acquisition) VALUES (?, ?, ?, NOW())";
        int generatedId = -1;  // Initialisation à une valeur invalide

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            // Remplir les paramètres de la requête
            statement.setInt(1, credit.getIdApprenant());
            statement.setInt(2, credit.getIdAbonnement());
            statement.setDouble(3, credit.getMontant());

            // Exécuter la mise à jour
            int affectedRows = statement.executeUpdate();

            // Vérifier si l'insertion a réussi
            if (affectedRows == 0) {
                throw new SQLException("Échec de l'insertion du crédit, aucune ligne affectée.");
            }

            // Récupérer l'ID généré (la clé primaire auto-incrémentée)
            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    generatedId = generatedKeys.getInt(1);  // Retourner l'ID du crédit nouvellement inséré
                } else {
                    throw new SQLException("Échec de l'insertion du crédit, aucun ID généré.");
                }
            }
        } catch (SQLException e) {
            // Affichage de l'erreur dans la console et remontée de l'exception
            e.printStackTrace();
            throw new SQLException("Erreur lors de l'insertion du crédit", e);
        }

        return generatedId;  // Retourner l'ID généré
    }



    // Méthode pour récupérer tous les crédits
    public List<CreditModel> selectAllCredits() throws SQLException {
        List<CreditModel> credits = new ArrayList<>();
        String sql = "SELECT * FROM credits"; // Requête pour récupérer tous les crédits

        try (Connection connection = getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            
            while (resultSet.next()) {
                int idCredit = resultSet.getInt("id_credit");
                int idApprenant = resultSet.getInt("id_apprenant");
                int idAbonnement = resultSet.getInt("id_abonnement");
                double montant = resultSet.getDouble("montant");
                Timestamp dateAcquisition = resultSet.getTimestamp("date_acquisition");

                // Ajouter chaque crédit dans la liste
                credits.add(new CreditModel(idCredit, idApprenant, idAbonnement, montant, dateAcquisition));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Erreur lors de la récupération des crédits", e);
        }
        return credits;
    }

 // Méthode pour récupérer un crédit par son ID
    public CreditModel selectCreditById(int idCredit) {
        CreditModel credit = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_CREDIT_BY_ID)) {
            preparedStatement.setInt(1, idCredit); // Paramétrer l'ID du crédit
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                int idApprenant = rs.getInt("id_apprenant");
                int idAbonnement = rs.getInt("id_abonnement");
                double montant = rs.getDouble("montant");
                credit = new CreditModel(idApprenant, idAbonnement, montant); // Créer un objet CreditModel
            }
        } catch (SQLException e) {
           // printSQLException(e);
        }
        return credit; // Retourner l'objet CreditModel
    }
    
    // Connexion à la base de données
    private Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }
}
