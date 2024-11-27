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
import com.model.AbonnementModel;

@WebServlet("/abonnements/*") // Préfixe pour toutes les actions liées aux cours
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
        // Identifier l'action à partir de l'URL
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
        RequestDispatcher dispatcher = request.getRequestDispatcher(FORM_JSP);
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
    	int idAbonnement = Integer.parseInt(request.getParameter("idAbonnement"));
    	AbonnementModel existingAbonnement = abonnementsDAO.selectAbonnement(idAbonnement);
        request.setAttribute("abonnements", existingAbonnement);

        RequestDispatcher dispatcher = request.getRequestDispatcher(FORM_JSP);
        dispatcher.forward(request, response);
    }

    private void insertAbonnement(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
       
    	int idApprenant = Integer.parseInt(request.getParameter("idApprenant"));
        String dateDebut = request.getParameter("dateDebut");       
        String dateFin = request.getParameter("dateFin");      
        
        
       AbonnementModel newAbonnement = new AbonnementModel(idApprenant, dateDebut,dateFin);
       abonnementsDAO.insertAbonnement(newAbonnement);


        response.sendRedirect("list-abonnements");
    }

    private void updateAbonnement(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        
    	int idAbonnement = Integer.parseInt(request.getParameter("idAbonnement"));
    	int idApprenant = Integer.parseInt(request.getParameter("idApprenant"));
        String dateDebut = request.getParameter("dateDebut");       
        String dateFin = request.getParameter("dateFin");  

        AbonnementModel updateAbonnement = new AbonnementModel(idAbonnement, idApprenant, dateDebut,dateFin);
        abonnementsDAO.updateAbonnement(updateAbonnement);

        response.sendRedirect("list-abonnements");
    }

    private void deleteAbonnement(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int idAbonnement = Integer.parseInt(request.getParameter("idAbonnement"));
        abonnementsDAO.deleteAbonnement(idAbonnement);

        response.sendRedirect("list-abonnements");
    }
}
