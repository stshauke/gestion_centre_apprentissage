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

import com.dao.SalleDAO;
import com.model.SalleModel;

@WebServlet("/salles/*") // Utilisation d'un préfixe commun pour toutes les actions liées aux salles
public class SalleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SalleDAO salleDAO;

    // Constantes pour les actions et les chemins JSP
    private static final String ACTION_LIST = "/list-salle";
    private static final String ACTION_NEW = "/new";
    private static final String ACTION_INSERT = "/insert";
    private static final String ACTION_DELETE = "/delete";
    private static final String ACTION_EDIT = "/edit";
    private static final String ACTION_UPDATE = "/update";

    private static final String LIST_JSP = "/salleJSP/salle-list.jsp";
    private static final String FORM_JSP = "/salleJSP/salle-form.jsp";
    private static final String INDEX_JSP = "/index.jsp";

    @Override
    public void init() {
        salleDAO = new SalleDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Récupération de l'action à partir de l'URL
        String action = request.getPathInfo();

        try {
            switch (action) {
                case ACTION_NEW:
                    showNewForm(request, response);
                    break;
                case ACTION_INSERT:
                    insertSalle(request, response);
                    break;
                case ACTION_DELETE:
                    deleteSalle(request, response);
                    break;
                case ACTION_EDIT:
                    showEditForm(request, response);
                    break;
                case ACTION_UPDATE:
                    updateSalle(request, response);
                    break;
                case ACTION_LIST:
                    listSalles(request, response);
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

    private void listSalles(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        // Récupération des salles via le DAO
        List<SalleModel> listSalles = salleDAO.selectAllSalles();
        request.setAttribute("listSalles", listSalles);

        // Redirection vers la JSP d'affichage
        RequestDispatcher dispatcher = request.getRequestDispatcher(LIST_JSP);
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(FORM_JSP);
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int idSalle = Integer.parseInt(request.getParameter("idSalle"));
        SalleModel existingSalle = salleDAO.selectSalle(idSalle);
        request.setAttribute("salle", existingSalle);
        RequestDispatcher dispatcher = request.getRequestDispatcher(FORM_JSP);
        dispatcher.forward(request, response);
    }

    private void insertSalle(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String nomSalle = request.getParameter("nomSalle");
        String equipements = request.getParameter("equipements");

        SalleModel newSalle = new SalleModel(nomSalle, equipements);
        salleDAO.insertSalle(newSalle);
        response.sendRedirect("list-salle");
    }

    private void updateSalle(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int idSalle = Integer.parseInt(request.getParameter("idSalle"));
        String nomSalle = request.getParameter("nomSalle");
        String equipements = request.getParameter("equipements");

        SalleModel updatedSalle = new SalleModel(idSalle, nomSalle, equipements);
        salleDAO.updateSalle(updatedSalle);
        response.sendRedirect("list-salle");
    }

    private void deleteSalle(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int idSalle = Integer.parseInt(request.getParameter("idSalle"));
        salleDAO.deleteSalle(idSalle);
        response.sendRedirect("list-salle");
    }
}
