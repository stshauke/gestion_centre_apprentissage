package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.model.MessageModel;

/**
 * DAO pour les opérations CRUD sur la table 'salles'.
 */
public class MessageDAO {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/gestion_centre_apprentissage?useSSL=false";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    // Requêtes SQL
    private static final String INSERT_MESSAGE_SQL = "INSERT INTO message (id_apprenant, contenu, langue_cible, date_publication) VALUES (?, ?, ?, ?);";
    private static final String SELECT_MESSAGE_BY_ID = "SELECT * FROM message WHERE id_message = ?";
    private static final String SELECT_ALL_MESSAGES = "SELECT * FROM message";
    private static final String DELETE_MESSAGE_SQL = "DELETE FROM message WHERE id_message = ?;";
    private static final String UPDATE_MESSAGE_SQL = "UPDATE message SET id_apprenant = ?, contenu = ?, langue_cible = ?, date_publication = ? WHERE id_message = ?;";
    private static final String SELECT_NOM_APPRENANT_BY_ID = "SELECT nom FROM apprenant WHERE id_apprenant = ?";

    public MessageDAO() {
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
     * Ajouter un nouveau message.
     */
    public void insertMessage(MessageModel message) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_MESSAGE_SQL)) {
            preparedStatement.setInt(1, message.getIdApprenant());
            preparedStatement.setString(2, message.getContenu());
            preparedStatement.setString(3, message.getLangueCible());
            preparedStatement.setString(4, message.getDatePublication());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }
    /**
     * Récupérer un message par ID.
     */
    public MessageModel selectMessage(int idMessage) {
        MessageModel message = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_MESSAGE_BY_ID)) {
            preparedStatement.setInt(1, idMessage);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                int idApprenant = rs.getInt("id_apprenant");
                String contenu = rs.getString("contenu");
                String langueCible = rs.getString("langue_cible");
                String datePublication = rs.getString("date_publication");
                message = new MessageModel(idMessage, idApprenant, contenu, langueCible, datePublication);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return message;
    }

    /**
     * Récupérer tous les messages.
     */
    public List<MessageModel> selectAllMessages() {
        List<MessageModel> messagesList = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_MESSAGES)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int idMessage = rs.getInt("id_message");
                int idApprenant = rs.getInt("id_apprenant");
                String contenu = rs.getString("contenu");
                String langueCible = rs.getString("langue_cible");
                String datePublication = rs.getString("date_publication");
                messagesList.add(new MessageModel(idMessage, idApprenant, contenu, langueCible, datePublication));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return messagesList;
    }
    /**
     * Supprimer une salle par ID.
     */
    public boolean deleteMessage(int idMessage) throws SQLException {
        boolean rowDeleted = false;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_MESSAGE_SQL)) {
            statement.setInt(1, idMessage);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    /**
     * Mettre à jour un message.
     */
    public boolean updateMessage(MessageModel message) throws SQLException {
        boolean rowUpdated = false;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(UPDATE_MESSAGE_SQL)) {
        	 statement.setInt(1, message.getIdApprenant());
             statement.setString(2, message.getContenu());
             statement.setString(3, message.getLangueCible());
           statement.setString(4, message.getDatePublication());
           statement.setInt(5, message.getIdMessage());
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
