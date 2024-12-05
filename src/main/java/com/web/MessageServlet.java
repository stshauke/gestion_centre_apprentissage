package com.web;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.dao.ApprenantDAO;
import com.dao.MessageDAO;
import com.model.AbonnementModel;
import com.model.ApprenantModel;
import com.model.MessageModel;

@WebServlet("/message/*") // Préfixe pour toutes les actions liées aux messages
public class MessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MessageDAO messageDAO;

    // Constantes pour les actions et les chemins JSP
    private static final String ACTION_LIST = "/list-message";
    private static final String ACTION_NEW = "/new";
    private static final String ACTION_INSERT = "/insert";
    private static final String ACTION_DELETE = "/delete";
    private static final String ACTION_EDIT = "/edit";
    private static final String ACTION_UPDATE = "/update";

    private static final String LIST_JSP = "/messageJSP/message-list.jsp";
    private static final String FORM_JSP = "/messageJSP/message-form.jsp";
    private static final String INDEX_JSP = "/index.jsp";

    @Override
    public void init() {
    	messageDAO = new MessageDAO();
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
                    insertMessage(request, response);
                    break;
                case ACTION_DELETE:
                    deleteMessage(request, response);
                    break;
                case ACTION_EDIT:
                    showEditForm(request, response);
                    break;
                case ACTION_UPDATE:
                    updateMessage(request, response);
                    break;
                case ACTION_LIST:
                    listMessage(request, response);
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

    private void listMessage(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<MessageModel> listMessage = messageDAO.selectAllMessages();
        request.setAttribute("listMessage", listMessage);
        // Créer une liste pour stocker les noms des apprenants
        List<String> nomsApprenants = new ArrayList<>();
        for (MessageModel message: listMessage) {
            String nomApprenant = messageDAO.getNomApprenantById(message.getIdApprenant());
            nomsApprenants.add(nomApprenant);
        }

        // Passer la liste des noms à la JSP
        request.setAttribute("nomsApprenants", nomsApprenants);
        RequestDispatcher dispatcher = request.getRequestDispatcher(LIST_JSP);
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	ApprenantDAO apprenantDAO = new ApprenantDAO();
        List<ApprenantModel> listApprenants = apprenantDAO.selectAllApprenants();
        System.out.println("Liste des apprenants: " + listApprenants);
        request.setAttribute("listApprenants", listApprenants);

    	
        RequestDispatcher dispatcher = request.getRequestDispatcher(FORM_JSP);
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
    	int idMessage = Integer.parseInt(request.getParameter("idMessage"));
    	MessageModel existingMessage = messageDAO.selectMessage(idMessage);
        request.setAttribute("message", existingMessage);

        RequestDispatcher dispatcher = request.getRequestDispatcher(FORM_JSP);
        dispatcher.forward(request, response);
    }

    private void insertMessage(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {    	
    	
    	int idApprenant = Integer.parseInt(request.getParameter("idApprenant"));
        String contenu = request.getParameter("contenu");
        String langueCible = request.getParameter("langueCible");
        String datePublication =request.getParameter("datePublication");
        
        MessageModel newMessage = new MessageModel( idApprenant, contenu, langueCible, datePublication);
        messageDAO.insertMessage(newMessage);

        response.sendRedirect("list-message");
    }

    private void updateMessage(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        
    	int idMessage = Integer.parseInt(request.getParameter("idMessage"));
    	int idApprenant = Integer.parseInt(request.getParameter("idApprenant"));
    	 String contenu = request.getParameter("contenu");
         String langueCible = request.getParameter("langueCible");
         String datePublication =request.getParameter("datePublication");

        MessageModel updatedMessage = new MessageModel(idMessage, idApprenant, contenu, langueCible, datePublication);
        messageDAO.updateMessage(updatedMessage);

        response.sendRedirect("list-message");
    }

    private void deleteMessage(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int idMessage = Integer.parseInt(request.getParameter("idMessage"));
        messageDAO.deleteMessage(idMessage);

        response.sendRedirect("list-message");
    }
}
