<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../pagesParametres/header.jsp" />
<%
    // Vérifier si l'utilisateur est connecté
    String role = (String) session.getAttribute("role");
    if (role == null) {
%>
<script>
    alert("Vous devez être connecté pour accéder à cette page !");
    window.location.href = "${pageContext.request.contextPath}/login.jsp";
</script>
<% } %>

<body style="background-color: #fffceb; font-family: Arial, sans-serif;">
    <div class="container mt-4">
        <h3 class="text-center text-dark my-4">
            <c:choose>
                <c:when test="${not empty facture}">
                    Modifier la Facture
                </c:when>
                <c:otherwise>
                    Ajouter une Nouvelle Facture
                </c:otherwise>
            </c:choose>
        </h3>
        <hr>
        
        <form action="<c:choose>
                        <c:when test="${not empty facture}">/factures/update</c:when>
                        <c:otherwise>/factures/insert</c:otherwise>
                    </c:choose>" method="post" enctype="multipart/form-data">
            
            <!-- ID Facture (caché pour la mise à jour) -->
            <input type="hidden" name="idFacture" value="<c:out value='${facture.idFacture}' />" />

            <!-- Sélectionner le Crédit -->
            <div class="form-group">
                <label for="idCredit">Sélectionner un Crédit</label>
                <select class="form-control" id="idCredit" name="idCredit" required>
                    <c:forEach var="credit" items="${listCredits}">
                        <option value="<c:out value='${credit.idCredit}' />" 
                                <c:if test="${facture != null && facture.idCredit == credit.idCredit}">selected</c:if> >
                            <c:out value='${credit.nom}' />
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- Numéro de Facture - Utilisation de l'attribut passé depuis la servlet -->
            <div class="form-group">
                <label for="numeroFacture">Numéro de Facture</label>
                <input type="text" class="form-control" id="numeroFacture" name="numeroFacture" 
                       value="<c:out value='${numeroFacture}' />" readonly>
            </div>

            <!-- Chemin du PDF (Optionnel) - Utilisation de l'attribut passé depuis la servlet -->
            <div class="form-group">
                <label for="pdfPath">Chemin du PDF</label>
                <input type="file" class="form-control" id="pdfPath" name="pdfPath" 
                       accept=".pdf" <c:if test="${facture != null}">disabled</c:if> >
                <!-- Le champ PDF est en lecture seule si la facture existe déjà -->
                <c:if test="${not empty facture}">
                    <small class="text-muted">Fichier PDF actuel: <c:out value="${facture.pdfPath}"/></small>
                </c:if>
            </div>

            <!-- Mode de Paiement -->
            <div class="form-group">
                <label for="modePaiement">Mode de Paiement</label>
                <input type="text" class="form-control" id="modePaiement" name="modePaiement" 
                       value="<c:out value='${facture.modePaiement}' />" required>
            </div>

            <!-- Date de Facture -->
            <div class="form-group">
                <label for="dateFacture">Date de Facture</label>
                <input type="date" class="form-control" id="dateFacture" name="dateFacture" 
                       value="<c:out value='${facture.dateFacture}' />" required>
            </div>

            <div class="form-group text-center mt-4">
                <button type="submit" class="btn btn-primary btn-lg" style="border-radius: 30px;">
                    <c:choose>
                        <c:when test="${not empty facture}">Mettre à jour</c:when>
                        <c:otherwise>Ajouter</c:otherwise>
                    </c:choose>
                </button>
            </div>
        </form>

        <c:if test="${not empty facture}">
            <div class="text-center mt-3">
                <a href="<%= request.getContextPath() %>/factures/list-factures" 
                   class="btn btn-secondary btn-lg" style="border-radius: 30px;">
                    Retour à la liste des factures
                </a>
            </div>
        </c:if>
    </div>

    <jsp:include page="../pagesParametres/footer.jsp" />
</body>
