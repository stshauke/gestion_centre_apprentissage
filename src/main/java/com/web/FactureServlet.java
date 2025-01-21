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
import java.util.Date;

import com.dao.CreditDAO;
import com.dao.FactureDAO;
import com.model.FactureModel;
import com.model.CreditModel;

@WebServlet("/factures/*")
public class FactureServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FactureDAO factureDAO;
    private CreditDAO creditDAO;

    private static final String ACTION_LIST = "/list-factures";
    private static final String ACTION_NEW = "/new";
    private static final String ACTION_INSERT = "/insert";
    private static final String ACTION_DELETE = "/delete";
    private static final String ACTION_EDIT = "/edit";
    private static final String ACTION_UPDATE = "/update";

    private static final String LIST_JSP = "/factureJSP/factures-list.jsp";
    private static final String FORM_JSP = "/factureJSP/factures-form.jsp";
    private static final String INDEX_JSP = "/index.jsp";

    @Override
    public void init() {
        factureDAO = new FactureDAO();
        creditDAO = new CreditDAO();
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
                    insertFacture(request, response);
                    break;
                case ACTION_DELETE:
                    deleteFacture(request, response);
                    break;
                case ACTION_EDIT:
                    showEditForm(request, response);
                    break;
                case ACTION_UPDATE:
                    updateFacture(request, response);
                    break;
                case ACTION_LIST:
                    listFactures(request, response);
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

    private void listFactures(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<FactureModel> listFactures = factureDAO.selectAllFactures();
        request.setAttribute("listFactures", listFactures);

        RequestDispatcher dispatcher = request.getRequestDispatcher(LIST_JSP);
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<CreditModel> listCredits = creditDAO.selectAllCredits();
        request.setAttribute("listCredits", listCredits);

        RequestDispatcher dispatcher = request.getRequestDispatcher(FORM_JSP);
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int idFacture = Integer.parseInt(request.getParameter("idFacture"));
        FactureModel existingFacture = factureDAO.selectFacture(idFacture);
        request.setAttribute("facture", existingFacture);

        List<CreditModel> listCredits = creditDAO.selectAllCredits();
        request.setAttribute("listCredits", listCredits);

        RequestDispatcher dispatcher = request.getRequestDispatcher(FORM_JSP);
        dispatcher.forward(request, response);
    }

    private void insertFacture(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int idCredit = Integer.parseInt(request.getParameter("idCredit"));
        String pdfPath = request.getParameter("pdfPath");

        // Création de la nouvelle facture
        FactureModel newFacture = new FactureModel(idCredit, pdfPath, new Date());
        factureDAO.insertFacture(newFacture);

        response.sendRedirect("list-factures");
    }

    private void updateFacture(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int idFacture = Integer.parseInt(request.getParameter("idFacture"));
        int idCredit = Integer.parseInt(request.getParameter("idCredit"));
        String pdfPath = request.getParameter("pdfPath");

        // Mise à jour de la facture
        FactureModel updatedFacture = new FactureModel(idFacture, idCredit, pdfPath, new Date());
        factureDAO.updateFacture(updatedFacture);

        response.sendRedirect("list-factures");
    }

    private void deleteFacture(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int idFacture = Integer.parseInt(request.getParameter("idFacture"));
        factureDAO.deleteFacture(idFacture);

        response.sendRedirect("list-factures");
    }
}
