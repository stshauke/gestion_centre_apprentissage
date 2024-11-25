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

import com.dao.CoursDAO;
import com.model.CoursModel;

@WebServlet("/cours/*") // Préfixe pour toutes les actions liées aux cours
public class CoursServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CoursDAO coursDAO;

    // Constantes pour les actions et les chemins JSP
    private static final String ACTION_LIST = "/list-cours";
    private static final String ACTION_NEW = "/new";
    private static final String ACTION_INSERT = "/insert";
    private static final String ACTION_DELETE = "/delete";
    private static final String ACTION_EDIT = "/edit";
    private static final String ACTION_UPDATE = "/update";

    private static final String LIST_JSP = "/coursJSP/cours-list.jsp";
    private static final String FORM_JSP = "/coursJSP/cours-form.jsp";
    private static final String INDEX_JSP = "/index.jsp";

    @Override
    public void init() {
        coursDAO = new CoursDAO();
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
                    insertCours(request, response);
                    break;
                case ACTION_DELETE:
                    deleteCours(request, response);
                    break;
                case ACTION_EDIT:
                    showEditForm(request, response);
                    break;
                case ACTION_UPDATE:
                    updateCours(request, response);
                    break;
                case ACTION_LIST:
                    listCours(request, response);
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

    private void listCours(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<CoursModel> listCours = coursDAO.selectAllCours();
        request.setAttribute("listCours", listCours);

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
        
    	int idCours = Integer.parseInt(request.getParameter("idCours"));
        CoursModel existingCours = coursDAO.selectCours(idCours);
        request.setAttribute("cours", existingCours);

        RequestDispatcher dispatcher = request.getRequestDispatcher(FORM_JSP);
        dispatcher.forward(request, response);
    }

    private void insertCours(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
       
    	String nomCours = request.getParameter("nomCours");
        String langueDispensee = request.getParameter("langueDispensee");       
        String descriptionsCours = request.getParameter("descriptionsCours");      
        String typeCours = request.getParameter("typeCours");       
        int idSalle = Integer.parseInt(request.getParameter("idSalle"));
        float tarifCours =Float.parseFloat(request.getParameter("tarifCours"));
        
        CoursModel newCours = new CoursModel(nomCours, langueDispensee, descriptionsCours,typeCours,idSalle, tarifCours);
        coursDAO.insertCours(newCours);

        response.sendRedirect("list-cours");
    }

    private void updateCours(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        
    	int idCours = Integer.parseInt(request.getParameter("idCours"));
        String nomCours = request.getParameter("nomCours");
        String langueDispensee = request.getParameter("langueDispensee");        
        String descriptionsCours = request.getParameter("descriptionsCours");      
        String typeCours = request.getParameter("typeCours");      
        int idSalle = Integer.parseInt(request.getParameter("idSalle"));
        float tarifCours =Float.parseFloat(request.getParameter("tarifCours"));

        CoursModel updatedCours = new CoursModel(idCours, nomCours, langueDispensee, descriptionsCours,typeCours,idSalle, tarifCours);
        coursDAO.updateCours(updatedCours);

        response.sendRedirect("list-cours");
    }

    private void deleteCours(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int idCours = Integer.parseInt(request.getParameter("idCours"));
        coursDAO.deleteCours(idCours);

        response.sendRedirect("list-cours");
    }
}
