package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtil {

    // Informations de connexion à la base de données
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/gestion_centre_apprentissage";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    // Méthode pour obtenir une connexion à la base de données
    public static Connection getConnection() throws SQLException {
        try {
            // Charger le driver JDBC si nécessaire (il n'est peut-être plus nécessaire avec les versions récentes de JDBC)
            // Class.forName("com.mysql.cj.jdbc.Driver");

            // Retourner la connexion à la base de données
            return DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
        } catch (SQLException e) {
            throw new SQLException("Erreur de connexion à la base de données", e);
        }
    }
}
