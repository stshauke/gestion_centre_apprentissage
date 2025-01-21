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
        <h3 class="text-center text-dark my-4">Liste des Abonnements</h3>
        <hr>
        <% if ("admin".equals(role)) { %>
            <!-- Lien pour ajouter un nouvel abonnement -->
            <div class="container text-left mb-4">
                <a href="<%= request.getContextPath() %>/abonnements/new" 
                   class="btn btn-lg" 
                   style="background-color: #fd7e14; color: white; border-radius: 30px; font-weight: bold;">
                    <i class="bi bi-plus-circle"></i> Ajouter un abonnement
                </a>
            </div>
       <% } %>
        
        <!-- Tableau des abonnements -->
        <div class="table-responsive" style="max-height: 400px; overflow-y: auto; border: 1px solid #ddd; border-radius: 10px;">
            <table class="table table-striped table-hover" style="overflow: hidden; border-collapse: separate; border-spacing: 0;">
                <thead style="background-color: #FFE4B5; border: none;">
                    <tr>
                        <th>ID</th>
                        <th>Nom</th>
                        <th>Description</th>
                        <th>Prix</th>
                        <th>Durée</th>
                        <th>Unité de Durée</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Boucle pour afficher les abonnements -->
                    <c:forEach var="abonnement" items="${listAbonnements}" varStatus="status">
                        <tr style="background-color: #F9F9F9; border-bottom: 1px solid rgba(169, 169, 169, 0.8);">
                            <td><c:out value="${abonnement.idAbonnement}" /></td>
                            <td><c:out value="${abonnement.nom}" /></td>
                            <td><c:out value="${abonnement.description}" /></td>
                            <td><c:out value="${abonnement.prix}" /></td>
                            <td><c:out value="${abonnement.duree}" /></td>
                            <td><c:out value="${abonnement.uniteDuree}" /></td>
                            
                            <td>
                                <% if ("admin".equals(role)) { %>
                                    <!-- Lien pour modifier l'abonnement -->
                                    <a href="<%= request.getContextPath() %>/abonnements/edit?idAbonnement=${abonnement.idAbonnement}"
                                       class="btn btn-primary btn-sm" style="margin-right: 10px;">
                                        <i class="bi bi-pencil-square"></i> Modifier
                                    </a>

                                    <!-- Lien pour supprimer l'abonnement -->
                                    <a href="<%= request.getContextPath() %>/abonnements/delete?idAbonnement=${abonnement.idAbonnement}" 
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet abonnement ?');">
                                        <i class="bi bi-trash"></i> Supprimer
                                    </a>
                                <% } %>

                                <c:if test="${role == 'apprenant'}">
                                    <form action="${pageContext.request.contextPath}/abonnements/acheter" method="post">
                                        <input type="hidden" name="idAbonnement" value="${abonnement.idAbonnement}" />
                                        <button type="submit" class="btn btn-success">Acheter</button>
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
