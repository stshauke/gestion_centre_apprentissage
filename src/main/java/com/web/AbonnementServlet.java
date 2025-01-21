package com.web;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.dao.AbonnementDAO;
import com.dao.CreditDAO;
import com.dao.FactureDAO;
import com.model.AbonnementModel;
import com.model.CreditModel;
import com.model.FactureModel;
import com.util.PDFGenerator;  // Importer la classe où se trouve generateFacturePDF

@WebServlet("/abonnements/*")
public class AbonnementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AbonnementDAO abonnementsDAO;

        
    
    // Constantes pour les actions et les chemins JSP
    private static final String ACTION_LIST = "/list-abonnements";
    private static final String ACTION_NEW = "/new";
    private static final String ACTION_INSERT = "/insert";
    private static final String ACTION_DELETE = "/delete";
    private static final String ACTION_EDIT = "/edit";
    private static final String ACTION_UPDATE = "/update";

    private static final String LIST_JSP = "/abonnementJSP/abonnements-list.jsp";
    private static final String FORM_JSP = "/abonnementJSP/abonnements-form.jsp";
    private static final String INDEX_JSP = "/index.jsp";

    @Override
    public void init() {
        abonnementsDAO = new AbonnementDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();

        try {
            switch (action) {
                case ACTION_NEW:
                    showNewForm(request, response);
                    break;
                case ACTION_INSERT:
                    insertAbonnement(request, response);
                    break;
                case ACTION_DELETE:
                    deleteAbonnement(request, response);
                    break;
                case ACTION_EDIT:
                    showEditForm(request, response);
                    break;
                case ACTION_UPDATE:
                    updateAbonnement(request, response);
                    break;
                case ACTION_LIST:
                    listAbonnement(request, response);
                    break;
                case "/acheter":  // Ajoutez ce bloc
                    acheterAbonnement(request, response);
                    break;
                default:
                    showIndexPage(request, response);
                    break;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("errorMessage", "Une erreur est survenue : " + ex.getMessage());
            request.getRequestDispatcher(INDEX_JSP).forward(request, response);
        }
    }

    private void showIndexPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(INDEX_JSP);
        dispatcher.forward(request, response);
    }

    private void listAbonnement(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<AbonnementModel> listAbonnements = abonnementsDAO.selectAllAbonnements();
        request.setAttribute("listAbonnements", listAbonnements);

        RequestDispatcher dispatcher = request.getRequestDispatcher(LIST_JSP);
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Liste des unités de durée pour le formulaire
        List<String> uniteDureeOptions = List.of("jour", "mois", "an");
        request.setAttribute("uniteDureeOptions", uniteDureeOptions);

        RequestDispatcher dispatcher = request.getRequestDispatcher(FORM_JSP);
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int idAbonnement = Integer.parseInt(request.getParameter("idAbonnement"));
        AbonnementModel existingAbonnement = abonnementsDAO.selectAbonnement(idAbonnement);
        request.setAttribute("abonnement", existingAbonnement);

        List<String> uniteDureeOptions = List.of("jour", "mois", "an");
        request.setAttribute("uniteDureeOptions", uniteDureeOptions);

        RequestDispatcher dispatcher = request.getRequestDispatcher(FORM_JSP);
        dispatcher.forward(request, response);
    }

    private void insertAbonnement(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String nom = request.getParameter("nom");
        String description = request.getParameter("description");
        String prixStr = request.getParameter("prix");
        String dureeStr = request.getParameter("duree");
        String uniteDuree = request.getParameter("uniteDuree");

        if (!isValidAbonnementData(nom, description, prixStr, dureeStr, uniteDuree)) {
            request.setAttribute("errorMessage", "Les données sont invalides ou manquantes.");
            request.getRequestDispatcher(FORM_JSP).forward(request, response);
            return;
        }

        double prix = Double.parseDouble(prixStr);
        int duree = Integer.parseInt(dureeStr);

        AbonnementModel newAbonnement = new AbonnementModel(nom, description, prix, duree, uniteDuree);
        abonnementsDAO.insertAbonnement(newAbonnement);

        response.sendRedirect("list-abonnements");
    }

    private void updateAbonnement(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int idAbonnement = Integer.parseInt(request.getParameter("idAbonnement"));
        String nom = request.getParameter("nom");
        String description = request.getParameter("description");
        String prixStr = request.getParameter("prix");
        String dureeStr = request.getParameter("duree");
        String uniteDuree = request.getParameter("uniteDuree");

        if (!isValidAbonnementData(nom, description, prixStr, dureeStr, uniteDuree)) {
            request.setAttribute("errorMessage", "Les données sont invalides ou manquantes.");
            request.getRequestDispatcher(FORM_JSP).forward(request, response);
            return;
        }

        double prix = Double.parseDouble(prixStr);
        int duree = Integer.parseInt(dureeStr);

        AbonnementModel updateAbonnement = new AbonnementModel(idAbonnement, nom, description, prix, duree, uniteDuree);
        abonnementsDAO.updateAbonnement(updateAbonnement);

        response.sendRedirect("list-abonnements");
    }

    private void deleteAbonnement(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int idAbonnement = Integer.parseInt(request.getParameter("idAbonnement"));
        abonnementsDAO.deleteAbonnement(idAbonnement);
        response.sendRedirect("list-abonnements");
    }

    // Méthode de validation des données d'abonnement
    private boolean isValidAbonnementData(String nom, String description, String prixStr, String dureeStr, String uniteDuree) {
        if (nom == null || nom.trim().isEmpty()) {
            return false;
        }
        if (prixStr == null || !prixStr.matches("\\d+(\\.\\d{1,2})?")) {
            return false;
        }
        if (dureeStr == null || !dureeStr.matches("\\d+")) {
            return false;
        }
        if (uniteDuree == null) {
            return false;
        }
        return true;
    }
    
    private void acheterAbonnement(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        // Récupérer l'ID de l'abonnement et le prix depuis le formulaire
        int idAbonnement = Integer.parseInt(request.getParameter("idAbonnement"));

        // Récupérer l'ID de l'apprenant depuis la session
        Integer idApprenant = (Integer) request.getSession().getAttribute("id_user");
        
        // Si l'utilisateur n'est pas connecté, rediriger vers la page de connexion
        if (idApprenant == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Obtenir les informations sur l'abonnement (prix, etc.) à partir de la base de données
        AbonnementModel abonnement = abonnementsDAO.selectAbonnement(idAbonnement);
        if (abonnement == null) {
            request.setAttribute("errorMessage", "Abonnement introuvable.");
            request.getRequestDispatcher("/abonnementJSP/abonnements-list.jsp").forward(request, response);
            return;
        }

        // Créer un nouvel objet Crédit
        CreditModel nouveauCredit = new CreditModel(idApprenant, idAbonnement, abonnement.getPrix());

        // Appeler le DAO pour enregistrer le crédit dans la base de données
        CreditDAO creditsDAO = new CreditDAO();
        int idCredit = creditsDAO.insertCredit(nouveauCredit); // Enregistrer et obtenir l'ID du crédit

        // Vérifier si l'insertion a réussi
        if (idCredit == 0) {
            request.setAttribute("errorMessage", "Erreur lors de la création du crédit.");
            request.getRequestDispatcher("/abonnementJSP/abonnements-list.jsp").forward(request, response);
            return;
        }

        // Générer le chemin du fichier PDF (par exemple, dans un dossier 'factures')
        String pdfPath = "c:/temp/facture_" + idCredit + ".pdf";
        

        // Créer une nouvelle facture
        FactureModel nouvelleFacture = new FactureModel(idCredit, pdfPath);

        // Appeler le DAO pour enregistrer la facture dans la base de données
        FactureDAO facturesDAO = new FactureDAO();
        facturesDAO.insertFacture(nouvelleFacture);

        // Récupérer l'objet CreditModel correspondant à l'ID du crédit
        CreditModel credit = creditsDAO.selectCreditById(idCredit);

        // Récupérer la facture associée depuis la base de données
        FactureModel facture = facturesDAO.selectFacture(idCredit);
        if (facture == null) {
            System.err.println("Facture non trouvée pour l'ID de crédit : " + idCredit);
            request.setAttribute("errorMessage", "Erreur : Facture non trouvée.");
            request.getRequestDispatcher("/abonnementJSP/abonnements-list.jsp").forward(request, response);
            return;
        }
        // Générer le PDF après l'enregistrement de la facture
        PDFGenerator.generateFacturePDF(credit, facture, pdfPath);

        // Rediriger vers la liste des abonnements ou une page de confirmation
        response.sendRedirect("list-abonnements?achatReussi=true");
    }

   
    
    
    
}
