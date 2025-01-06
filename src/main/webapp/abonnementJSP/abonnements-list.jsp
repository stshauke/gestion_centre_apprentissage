<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<jsp:include page="../pagesParametres/header.jsp" />
<%
    // Récupérer le rôle de l'utilisateur depuis la session
    String role = (String) session.getAttribute("role");
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

        <div class="container text-left mb-4">
            <a href="<%= request.getContextPath() %>/abonnements/new" 
               class="btn btn-lg" 
               style="background-color: #fd7e14; color: white; border-radius: 30px; font-weight: bold;">
                <i class="bi bi-plus-circle"></i> Ajouter un abonnement
            </a>
        </div>

        <div class="table-responsive" style="max-height: 400px; overflow-y: auto; border: 1px solid #ddd; border-radius: 10px;">
            <table class="table table-striped table-hover" style="overflow: hidden; border-collapse: separate; border-spacing: 0;">
                <thead style="background-color: #FFE4B5; border: none;">
                    <tr>
                        <th>ID</th>
                        <th>Apprenant</th>
                        <th>Date Début</th>
                        <th>Date Fin</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="abonnements" items="${listAbonnements}" varStatus="status">
                        <tr style="background-color: #F9F9F9; border-bottom: 1px solid rgba(169, 169, 169, 0.8);">
                            <td><c:out value="${abonnements.idAbonnement}" /></td>
                            <td><c:out value="${nomsApprenants[status.index]}" /></td>
                            <td><c:out value="${abonnements.dateDebut}" /></td>
                            <td><c:out value="${abonnements.dateFin}" /></td>
                            <td>
                                <a href="<%= request.getContextPath() %>/abonnements/edit?idAbonnement=<c:out value='${abonnements.idAbonnement}' />" 
                                   class="btn btn-sm" 
                                   style="background-color: #FF8C00; color: white; border-radius: 25px;">
                                    <i class="bi bi-pencil-fill"></i> Modifier
                                </a>
                                &nbsp;
                                <a href="<%= request.getContextPath() %>/abonnements/delete?idAbonnement=<c:out value='${abonnements.idAbonnement}' />" 
                                   class="btn btn-sm" 
                                   style="background-color: #FF6347; color: white; border-radius: 25px;" 
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet abonnement ?')">
                                    <i class="bi bi-trash"></i> Supprimer
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <jsp:include page="../pagesParametres/footer.jsp" />
</body>
