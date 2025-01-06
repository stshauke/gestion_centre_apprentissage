/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dao;

/**
 *
 * @author snekh
 */
import com.model.UserModel;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/gestion_centre_apprentissage";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";


    // Constructeur 
    public UserDAO() {

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

    // Méthode pour insérer un utilisateur
    public int createUserAndGetId(UserModel user) {
        String sql = "INSERT INTO user (email, password, role) VALUES (?, ?, ?)";
        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getRole());
            stmt.executeUpdate();

            // Récupérer l'id généré
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Échec
    }


    // Méthode pour récupérer un utilisateur par email
    public UserModel getUserByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM user WHERE email = ?";
        try (
            Connection connection = getConnection();
            PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return new UserModel(
                            rs.getInt("id_user"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getString("role")
                    );
                }
            }
        }
        return null; // Aucun utilisateur trouvé
    }

    // Méthode pour récupérer tous les utilisateurs
    public List<UserModel> getAllUsers() throws SQLException {
        List<UserModel> users = new ArrayList<>();
        String sql = "SELECT * FROM user";
        try (
            Connection connection = getConnection();
            PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {
            while (rs.next()) {
                users.add(new UserModel(
                        rs.getInt("id_user"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("role")
                ));
            }
        }
        return users;
    }

    // Méthode pour mettre à jour un utilisateur
    public void updateUser(UserModel user) throws SQLException {
        String sql = "UPDATE user SET email = ?, password = ?, role = ? WHERE id_user = ?";
        try (
            Connection connection = getConnection();
            PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, user.getEmail());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getRole());
            statement.setInt(4, user.getIdUser());
            statement.executeUpdate();
        }
    }

    // Méthode pour supprimer un utilisateur
    public void deleteUser(int idUser) throws SQLException {
        String sql = "DELETE FROM user WHERE id_user = ?";
        try (
            Connection connection = getConnection();
            PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, idUser);
            statement.executeUpdate();
        }
    }
    
    // Méthode pour le login
    public UserModel validateLogin(String email, String password) {
        String sql = "SELECT * FROM user WHERE email = ? AND password = ?";
        try (
            Connection connection = getConnection();
            PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setString(1, email);
            statement.setString(2, password);

            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                // Construire un utilisateur à partir des données
                return new UserModel(
                    rs.getInt("id_user"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("role") // Récupérer le rôle
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Retourner null si pas trouvé
    }
    
    public boolean emailExists(String email) {
        String sql = "SELECT id_user FROM user WHERE email = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);
            try (ResultSet rs = statement.executeQuery()) {
                return rs.next(); // Retourne true si un email existe déjà
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Retourne false en cas de problème ou si l'email n'existe pas
    }

}
