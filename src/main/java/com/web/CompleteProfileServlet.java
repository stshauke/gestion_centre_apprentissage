package com.web;

import com.dao.ApprenantDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "CompleteProfileServlet", urlPatterns = {"/profil"})
public class CompleteProfileServlet extends HttpServlet {
    private ApprenantDAO apprenantDAO = new ApprenantDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String languageLevel = request.getParameter("languageLevel");
        String targetLanguage = request.getParameter("targetLanguage");

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        boolean success = apprenantDAO.addApprenant(userId, name, languageLevel, targetLanguage);
        if (success) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("errorMessage", "Erreur lors de l'enregistrement.");
            request.getRequestDispatcher("/complete-profil.jsp").forward(request, response);
        }
    }
}
