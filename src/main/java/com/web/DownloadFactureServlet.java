package com.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import com.dao.FactureDAO;
import com.model.FactureModel;

@WebServlet("/download-facture")
public class DownloadFactureServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idFactureStr = request.getParameter("idFacture");

        if (idFactureStr != null && !idFactureStr.isEmpty()) {
            try {
                // Convertir l'ID de la facture en entier
                int idFacture = Integer.parseInt(idFactureStr);
                System.out.println("ID Facture : " + idFacture);
                
                // Récupérer la facture depuis la base de données
                FactureDAO factureDAO = new FactureDAO();
                FactureModel facture = factureDAO.selectFacture(idFacture);

                // Vérifier si la facture a été trouvée
                if (facture != null) {
                    System.out.println("Facture trouvée : " + facture.getIdFacture());
                    System.out.println("Chemin du fichier PDF : " + facture.getPdfPath());

                    // Vérifier si le chemin du fichier PDF est valide
                    if (facture.getPdfPath() != null && !facture.getPdfPath().isEmpty()) {
                        File file = new File("c:/temp/facture_28.pdf");  // Chemin absolu du fichier PDF

                        // Vérifier si le fichier existe
                        if (file.exists() && file.isFile()) {
                            // Configuration de la réponse pour télécharger le fichier
                            response.setContentType("application/pdf");
                            response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");

                            // Envoi du fichier PDF dans la réponse
                            try (BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
                                 BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream())) {
                                byte[] buffer = new byte[1024];
                                int length;
                                while ((length = in.read(buffer)) > 0) {
                                    out.write(buffer, 0, length);
                                }
                            } catch (IOException e) {
                                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de l'envoi du fichier PDF.");
                                e.printStackTrace();
                            }
                        } else {
                            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Fichier PDF introuvable.");
                        }
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Chemin PDF manquant ou invalide.");
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Facture non trouvée.");
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de la facture invalide.");
                e.printStackTrace();
            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors du téléchargement de la facture.");
                e.printStackTrace();
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de la facture manquant.");
        }
    }
}
