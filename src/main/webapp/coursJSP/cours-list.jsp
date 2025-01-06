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
    <div class="container-fluid mt-4">
        <h3 class="text-center text-dark my-4">Liste des Cours</h3>
        <hr>

        <% if ("admin".equals(role)) { %>
        <div class="container text-left mb-4">
            <a href="<%= request.getContextPath() %>/cours/new" 
               class="btn btn-lg" 
               style="background-color: #fd7e14; color: white; border-radius: 30px; font-weight: bold;">
                <i class="bi bi-plus-circle"></i> Ajouter un Cours
            </a>
        </div>
        <% } %>

        <div class="table-responsive" style="max-height: 600px; overflow-y: auto; border: 1px solid #ddd; border-radius: 10px;">
            <table class="table table-striped table-hover" style="overflow: hidden; border-collapse: separate; border-spacing: 0; width: 100%;">
                <thead style="background-color: #FFE4B5; border: none;">
                    <tr>
                        <th>Nom du Cours</th>
                        <th>Langue</th>
                        <th>Description</th>
                        <th>Type</th>
                        <th>Salle</th>
                        <th>Tarif</th>
                        <% if ("admin".equals(role)) { %>
                        <th>Actions</th>
                        <% } %>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="cours" items="${listCours}">
                        <tr style="background-color: #F9F9F9; border-bottom: 1px solid rgba(169, 169, 169, 0.8);">
                            <td><c:out value="${cours.nomCours}" /></td>
                            <td><c:out value="${cours.langueDispensee}" /></td>
                            <td style="max-width: 400px; word-wrap: break-word;">
                                <div style="max-height: 120px; overflow-y: auto;">
                                    <c:out value="${cours.descriptionsCours}" />
                                </div>
                            </td>
                            <td><c:out value="${cours.typeCours}" /></td>
                            <td><c:out value="${cours.idSalle}" /></td>
                            <td><c:out value="${cours.tarifCours}€" /></td>
                            <% if ("admin".equals(role)) { %>
                            <td>
                                <a href="<%= request.getContextPath() %>/cours/edit?idCours=<c:out value='${cours.idCours}' />" 
                                   class="btn btn-sm" 
                                   style="background-color: #FF8C00; color: white; border-radius: 25px; margin-right: 10px;">
                                    <i class="bi bi-pencil-fill"></i> Modifier
                                </a>
                                <a href="<%= request.getContextPath() %>/cours/delete?idCours=<c:out value='${cours.idCours}' />" 
                                   class="btn btn-sm" 
                                   style="background-color: #FF6347; color: white; border-radius: 25px;" 
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce cours ?')">
                                    <i class="bi bi-trash"></i> Supprimer
                                </a>
                            </td>
                            <% } %>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <jsp:include page="../pagesParametres/footer.jsp" />
</body>
