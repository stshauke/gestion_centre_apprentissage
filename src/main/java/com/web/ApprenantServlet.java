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

import com.dao.ApprenantDAO;
import com.model.ApprenantModel;

/**
 * ApprenantServlet.java
 * Cette servlet agit comme un contrôleur principal pour l'application.
 * Elle gère toutes les requêtes liées à l'entité Apprenant.
 */
@WebServlet("/")
public class ApprenantServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ApprenantDAO apprenantDAO;

    // Constantes pour les chemins JSP
    private static final String LIST_JSP = "/apprenantJSP/apprenant-list.jsp";
    private static final String FORM_JSP = "/apprenantJSP/apprenant-form.jsp";
    private static final String INDEX_JSP = "/index.jsp";

    @Override
    public void init() {
        apprenantDAO = new ApprenantDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/new":
                    showNewForm(request, response);
                    break;
                case "/insert":
                    insertApprenant(request, response);
                    break;
                case "/delete":
                    deleteApprenant(request, response);
                    break;
                case "/edit":
                    showEditForm(request, response);
                    break;
                case "/update":
                    updateApprenant(request, response);
                    break;
                case "/list":
                    listApprenants(request, response);
                    break;
                default:
                    showIndexPage(request, response);
                    break;
            }
        } catch (SQLException ex) {
            // Log de l'erreur pour déboguer
            ex.printStackTrace();
            // Afficher une page d'erreur
            request.setAttribute("errorMessage", "Une erreur est survenue : " + ex.getMessage());
            request.getRequestDispatcher(INDEX_JSP).forward(request, response);
        }
    }

    /**
     * Affiche la page principale.
     */
    private void showIndexPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(INDEX_JSP);
        dispatcher.forward(request, response);
    }

    /**
     * Affiche la liste des apprenants.
     */
    private void listApprenants(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<ApprenantModel> listApprenants = apprenantDAO.selectAllApprenants();
        request.setAttribute("listApprenants", listApprenants);
        RequestDispatcher dispatcher = request.getRequestDispatcher(LIST_JSP);
        dispatcher.forward(request, response);
    }

    /**
     * Affiche le formulaire pour ajouter un nouvel apprenant.
     */
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(FORM_JSP);
        dispatcher.forward(request, response);
    }

    /**
     * Affiche le formulaire pour modifier un apprenant existant.
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int idApprenant = Integer.parseInt(request.getParameter("idApprenant"));
        ApprenantModel existingApprenant = apprenantDAO.selectApprenant(idApprenant);
        request.setAttribute("apprenant", existingApprenant);
        RequestDispatcher dispatcher = request.getRequestDispatcher(FORM_JSP);
        dispatcher.forward(request, response);
    }

    /**
     * Insère un nouvel apprenant dans la base de données.
     */
    private void insertApprenant(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String nom = request.getParameter("nom");
        String niveauLangue = request.getParameter("niveauLangue");
        String langueCible = request.getParameter("langueCible");

        ApprenantModel newApprenant = new ApprenantModel(nom, niveauLangue, langueCible);
        apprenantDAO.insertApprenant(newApprenant);
        response.sendRedirect("list");
    }

    /**
     * Met à jour un apprenant existant.
     */
    private void updateApprenant(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int idApprenant = Integer.parseInt(request.getParameter("idApprenant"));
        String nom = request.getParameter("nom");
        String niveauLangue = request.getParameter("niveauLangue");
        String langueCible = request.getParameter("langueCible");

        ApprenantModel updatedApprenant = new ApprenantModel(idApprenant, nom, niveauLangue, langueCible);
        apprenantDAO.updateApprenant(updatedApprenant);
        response.sendRedirect("list");
    }

    /**
     * Supprime un apprenant.
     */
    private void deleteApprenant(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int idApprenant = Integer.parseInt(request.getParameter("idApprenant"));
        apprenantDAO.deleteApprenant(idApprenant);
        response.sendRedirect("list");
    }
}
