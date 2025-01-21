package com.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.dao.FactureDAO;
import com.model.FactureModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/factures-list")
public class FacturesListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer l'ID de l'utilisateur connecté depuis la session
        Integer idApprenant = (Integer) request.getSession().getAttribute("id_user");
        
        // Si l'utilisateur n'est pas connecté, rediriger vers la page de connexion
        if (idApprenant == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // Récupérer la liste des factures pour cet utilisateur
            FactureDAO factureDAO = new FactureDAO();
            List<FactureModel> facturesList = factureDAO.selectFacturesByUser(idApprenant);
            
            // Passer la liste des factures au JSP
            request.setAttribute("facturesList", facturesList);
            
            // Rediriger vers la page JSP pour afficher la liste des factures
            request.getRequestDispatcher("/factures-list.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}
