<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<jsp:include page="pagesParametres/header.jsp" />
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
        <h3 class="text-center text-dark my-4">Liste de vos factures</h3>
        <hr>
  
    
    <!-- Vérifier si la liste des factures est vide -->
    <c:if test="${empty facturesList}">
        <p>Aucune facture disponible.</p>
    </c:if>
    
    <!-- Afficher les factures sous forme de tableau -->
    <c:if test="${not empty facturesList}">
   <div class="table-container">
    <div class="table-responsive" style="max-height: 600px; overflow-y: auto; border: 1px solid #ddd; border-radius: 10px; margin: 0 auto; width: 80%;">
        <table class="table table-striped table-hover" style="overflow: hidden; border-collapse: separate; border-spacing: 0; width: 100%;">
            <thead style="background-color: #FFE4B5; border: none;">
                <tr>
                    <th>ID Facture</th>
                   
                   
                    <th>Télécharger</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="facture" items="${facturesList}">
                    <tr>
    <td>${facture.idFacture}</td>
    <td>
        <a href="<c:url value='/download-facture?idFacture=${facture.idFacture}' />">Télécharger</a>

    </td>
</tr>
                </c:forEach>
            </tbody>
        </table>
        </div>
        </div>
    </c:if>
</div>
    </div>
    <jsp:include page="pagesParametres/footer.jsp" />
</body>

