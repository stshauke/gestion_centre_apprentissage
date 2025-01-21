<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../pagesParametres/header.jsp" />
<%
    // Récupérer le rôle de l'utilisateur depuis la session
    String role = (String) session.getAttribute("role");

    // Récupérer le paramètre achatReussi pour afficher l'alerte si l'achat a réussi
    String achatReussi = request.getParameter("achatReussi");
    if ("true".equals(achatReussi)) {
%>
<script>
    alert("Votre achat a été effectué avec succès !");
</script>
<% 
    } 
%>

<% if (role == null) { %>
<script>
    alert("Vous devez être connecté pour accéder à cette page !");
    window.location.href = "${pageContext.request.contextPath}/login.jsp";
</script>
<% } %>

<body style="background-color: #fffceb; font-family: Arial, sans-serif;">
    <div class="container mt-4">
        <h3 class="text-center text-dark my-4">Liste des Factures</h3>
        <hr>
        <c:if test="${role == 'Admin'}">
            <!-- Lien pour ajouter une nouvelle facture -->
            <div class="container text-left mb-4">
                <a href="<%= request.getContextPath() %>/factures/new" 
                   class="btn btn-lg" 
                   style="background-color: #fd7e14; color: white; border-radius: 30px; font-weight: bold;">
                    <i class="bi bi-plus-circle"></i> Ajouter une facture
                </a>
            </div>
        </c:if>
        
        <!-- Tableau des factures -->
        <div class="table-responsive" style="max-height: 400px; overflow-y: auto; border: 1px solid #ddd; border-radius: 10px;">
            <table class="table table-striped table-hover" style="overflow: hidden; border-collapse: separate; border-spacing: 0;">
                <thead style="background-color: #FFE4B5; border: none;">
                    <tr>
                        <th>ID Facture</th>
                        <th>Numéro de Facture</th>
                        <th>Date de Facture</th>
                        <th>Mode de Paiement</th>
                        <th>PDF</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Boucle pour afficher les factures -->
                    <c:forEach var="facture" items="${listFactures}" varStatus="status">
                        <tr style="background-color: #F9F9F9; border-bottom: 1px solid rgba(169, 169, 169, 0.8);">
                            <td><c:out value="${facture.idFacture}" /></td>
                            <td><c:out value="${facture.numeroFacture}" /></td>
                            <td><c:out value="${facture.dateFacture}" /></td>
                            <td><c:out value="${facture.modePaiement}" /></td>
                            <td>
                                <a href="<c:out value='${facture.pdfPath}' />" target="_blank" class="btn btn-info btn-sm">
                                    <i class="bi bi-file-earmark-pdf"></i> Télécharger PDF
                                </a>
                            </td>
                            
                            <td>
                                <c:if test="${role == 'Admin'}">
                                    <!-- Lien pour modifier la facture -->
                                    <a href="<%= request.getContextPath() %>/factures/edit?idFacture=${facture.idFacture}"
                                       class="btn btn-primary btn-sm" style="margin-right: 10px;">
                                        <i class="bi bi-pencil-square"></i> Modifier
                                    </a>

                                    <!-- Lien pour supprimer la facture -->
                                    <a href="<%= request.getContextPath() %>/factures/delete?idFacture=${facture.idFacture}" 
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette facture ?');">
                                        <i class="bi bi-trash"></i> Supprimer
                                    </a>
                                </c:if>

                                <c:if test="${role == 'apprenant'}">
                                    <!-- Formulaire pour payer la facture (si applicable) -->
                                    <form action="${pageContext.request.contextPath}/factures/payer" method="post">
                                        <input type="hidden" name="idFacture" value="${facture.idFacture}" />
                                        <button type="submit" class="btn btn-success">Payer</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <jsp:include page="../pagesParametres/footer.jsp" />
</body>
