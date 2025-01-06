/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.web;

import com.dao.UserDAO;
import com.model.UserModel;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author snekh
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})

public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Redirection vers la page de connexion
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les données du formulaire
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Valider les informations via le DAO
        UserModel user = userDAO.validateLogin(email, password);

        if (user != null) {
            // Créer une session pour l'utilisateur
            HttpSession session = request.getSession();
            session.setAttribute("id_user", user.getIdUser());
            session.setAttribute("role", user.getRole()); // admin ou student
            session.setAttribute("email", user.getEmail());

            // Rediriger vers l'index.jsp
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            // Revenir au login avec un message d'erreur
            request.setAttribute("errorMessage", "Nom d'utilisateur ou mot de passe incorrect.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}

