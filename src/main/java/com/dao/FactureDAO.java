package com.dao;

import com.model.FactureModel;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class FactureDAO {
    // Informations de connexion à la base de données
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/gestion_centre_apprentissage";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    // Requêtes SQL adaptées à la table corrigée
    private static final String INSERT_FACTURE_SQL = "INSERT INTO factures (id_credit, pdf_path, date_facture) VALUES (?, ?, ?)";
    private static final String SELECT_FACTURE_BY_ID = "SELECT * FROM factures WHERE id_facture = ?";
    private static final String SELECT_ALL_FACTURES = "SELECT * FROM factures";
    private static final String DELETE_FACTURE_SQL = "DELETE FROM factures WHERE id_facture = ?";
    private static final String UPDATE_FACTURE_SQL = "UPDATE factures SET id_credit = ?, pdf_path = ?, date_facture = ? WHERE id_facture = ?";

    public FactureDAO() {
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
     * Ajouter une nouvelle facture.
     */
    public void insertFacture(FactureModel facture) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_FACTURE_SQL)) {

            preparedStatement.setInt(1, facture.getIdCredit());
            preparedStatement.setString(2, facture.getPdfPath());

            // Convertir LocalDateTime en Timestamp pour la base de données
            preparedStatement.setTimestamp(3, Timestamp.valueOf(facture.getDateFacture()));

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    /**
     * Récupérer une facture par ID.
     */
    public FactureModel selectFacture(int idCredit) throws SQLException {
        String sql = "SELECT * FROM factures WHERE id_credit = ?";  // Vérifiez que id_credit est bien la colonne de jointure

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, idCredit);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int idFacture = resultSet.getInt("id_facture");
                String pdfPath = resultSet.getString("pdf_path");

                FactureModel facture = new FactureModel(idFacture, pdfPath);
                return facture;
            }
        }

        // Si aucune facture n'est trouvée
        System.out.println("Aucune facture trouvée pour idCredit : " + idCredit);
        return null;
    }


    /**
     * Récupérer toutes les factures.
     */
    public List<FactureModel> selectAllFactures() {
        List<FactureModel> factures = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_FACTURES)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int idFacture = rs.getInt("id_facture");
                int idCredit = rs.getInt("id_credit");
                String pdfPath = rs.getString("pdf_path");
                Timestamp dateFacture = rs.getTimestamp("date_facture");

                // Conversion de Timestamp en LocalDateTime
                LocalDateTime localDateTime = dateFacture.toLocalDateTime();

                factures.add(new FactureModel(idFacture, idCredit, pdfPath, localDateTime));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return factures;
    }

    /**
     * Mettre à jour une facture.
     */
    public boolean updateFacture(FactureModel facture) throws SQLException {
        boolean rowUpdated = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_FACTURE_SQL)) {
            preparedStatement.setInt(1, facture.getIdCredit());
            preparedStatement.setString(2, facture.getPdfPath());

            // Convertir LocalDateTime en Timestamp
            preparedStatement.setTimestamp(3, Timestamp.valueOf(facture.getDateFacture()));
            preparedStatement.setInt(4, facture.getIdFacture());

            rowUpdated = preparedStatement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    /**
     * Supprimer une facture par ID.
     */
    public boolean deleteFacture(int idFacture) throws SQLException {
        boolean rowDeleted = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_FACTURE_SQL)) {
            preparedStatement.setInt(1, idFacture);
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
    

 // Récupérer les factures associées à un utilisateur
    public List<FactureModel> selectFacturesByUser(int idApprenant) throws SQLException {
        List<FactureModel> facturesList = new ArrayList<>();
        
        String sql = "SELECT f.id_facture, f.date_facture, f.pdf_path, c.montant " +
                     "FROM factures f " +
                     "JOIN credits c ON f.id_credit = c.id_credit " +
                     "WHERE c.id_apprenant = ?";
        
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setInt(1, idApprenant); // Remplir le paramètre avec l'ID de l'apprenant
            
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    // Créer un objet FactureModel pour chaque facture
                    FactureModel facture = new FactureModel();
                    facture.setIdFacture(resultSet.getInt("id_facture"));
                    
                    // Convertir java.sql.Date en LocalDateTime
                    Date sqlDate = resultSet.getDate("date_facture");
                    if (sqlDate != null) {
                        LocalDate localDate = sqlDate.toLocalDate();
                        LocalDateTime localDateTime = localDate.atStartOfDay(); // Ajouter l'heure à 00:00
                        facture.setDateFacture(localDateTime);  // Assurez-vous que la méthode setDateFacture accepte un LocalDateTime
                    }
                    
                    facture.setPdfPath(resultSet.getString("pdf_path"));
                   
                    
                    // Ajouter la facture à la liste
                    facturesList.add(facture);
                }
            }
        }
        
        return facturesList;
    }

    

}
