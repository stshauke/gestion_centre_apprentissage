package com.web;

import com.dao.UserDAO;
import com.model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "InscriptionServlet", urlPatterns = {"/inscription"})
public class InscriptionServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Vérifie la correspondance des mots de passe
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Les mots de passe ne correspondent pas.");
            request.getRequestDispatcher("/inscription.jsp").forward(request, response);
            return;
        }

        // Vérifie si l'email existe
        if (userDAO.emailExists(email)) {
            request.setAttribute("errorMessage", "Cet email est déjà utilisé.");
            request.getRequestDispatcher("/inscription.jsp").forward(request, response);
            return;
        }

        // Créer un nouvel utilisateur
        UserModel user = new UserModel();
        user.setEmail(email);
        user.setPassword(password);
        user.setRole("apprenant"); // Rôle par défaut

        // Ajouter dans la base
        int userId = userDAO.createUserAndGetId(user);
        if (userId > 0) {
            HttpSession session = request.getSession();
            session.setAttribute("userId", userId); // Stocker l'id pour le complete profil
            response.sendRedirect("complete-profil.jsp");
        } else {
            request.setAttribute("errorMessage", "Une erreur est survenue. Veuillez réessayer.");
            request.getRequestDispatcher("/inscription.jsp").forward(request, response);
        }
    }
}
