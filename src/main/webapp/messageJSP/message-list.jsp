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
        <h3 class="text-center text-dark my-4">Liste des messages</h3>
        <hr>

        <div class="container text-left mb-4">
            <a href="<%=request.getContextPath()%>/message/new" 
               class="btn btn-lg" 
               style="background-color: #fd7e14; color: white; border-radius: 30px; font-weight: bold;">
                <i class="bi bi-plus-circle"></i> Ajouter un message
            </a>
        </div>

        <div class="table-responsive" style="max-height: 400px; overflow-y: auto; border: 1px solid #ddd; border-radius: 10px;">
            <table class="table table-striped table-hover" style="overflow: hidden; border-collapse: separate; border-spacing: 0;">
                <thead style="background-color: #FFE4B5; border: none;">
                    <tr>
                        <th>ID</th>
                        <th>Nom Apprenant</th>
                        <th>Contenu</th>
                        <th>Langue Cible</th>
                        <th>Date de Publication</th>
                        <% if ("admin".equals(role)) { %>
                        <th>Actions</th>
                        <% } %>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="message" items="${listMessage}" varStatus="status">
                        <tr>
                            <td>${message.idMessage}</td>
                            <td>${nomsApprenants[status.index]}</td>
                            <td>${message.contenu}</td>
                            <td>${message.langueCible}</td>
                            <td>${message.datePublication}</td>
                            <% if ("admin".equals(role)) { %>
                            <td>
                                
                                <a href="${pageContext.request.contextPath}/message/edit?idMessage=${message.idMessage}" 
                                   class="btn btn-sm btn-warning">Modifier</a>
                                <a href="${pageContext.request.contextPath}/message/delete?idMessage=${message.idMessage}" 
                                   class="btn btn-sm btn-danger" 
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce message ?')">Supprimer</a>
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
