package com.util;

import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import com.model.CreditModel;
import com.model.FactureModel;

public class PDFGenerator {

    public static void generateFacturePDF(CreditModel credit, FactureModel facture, String pdfPath) throws SQLException, IOException {
        Document document = new Document();

        try {
            // Création d'un fichier PDF
            PdfWriter.getInstance(document, new FileOutputStream(pdfPath));
            document.open();
            
            // Ajout des informations dans le PDF
            document.add(new Paragraph("Facture #" + facture.getIdFacture()+"\n"));
            document.add(new Paragraph("Date : " + facture.getDateFacture()+"\n"));
            document.add(new Paragraph("Montant : " + credit.getMontant()+"\n"));
           document.add(new Paragraph("ID Abonnement : " + credit.getIdAbonnement()+"\n"));
           document.add(new Paragraph("ID Apprenant : " + credit.getIdApprenant()+"\n"));

        } catch (DocumentException e) {
            System.err.println("Erreur lors de la création du document PDF : " + e.getMessage());
            e.printStackTrace();
        } catch (IOException e) {
            System.err.println("Erreur lors de l'écriture dans le fichier PDF : " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Fermeture du document, même en cas d'erreur
            try {
                document.close();
            } catch (Exception e) {
                System.err.println("Erreur lors de la fermeture du document : " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
}
