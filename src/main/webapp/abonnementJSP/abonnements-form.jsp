<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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

<br><br>

<div class="container col-md-5">
    <div class="card">
        <div class="card-body">
            <!-- Vérification si un abonnement est passé en paramètre pour la modification -->
            <form action="${pageContext.request.contextPath}/abonnements/${abonnement != null ? 'update' : 'insert'}" method="post">
                <h2 class="text-center">
                    <c:choose>
                        <c:when test="${abonnement != null}">
                            Modifier un abonnement
                        </c:when>
                        <c:otherwise>
                            Ajouter un abonnement
                        </c:otherwise>
                    </c:choose>
                </h2>
                <hr>

                <!-- Champ caché pour l'ID de l'abonnement (si modification) -->
                <c:if test="${abonnement != null}">
                    <input type="hidden" name="idAbonnement" value="${abonnement.idAbonnement}" />
                </c:if>

                <!-- Champ Nom de l'abonnement -->
                <fieldset class="form-group">
                    <label>Nom</label>
                    <input type="text" class="form-control" name="nom" value="${abonnement != null ? abonnement.nom : ''}" required="required">
                </fieldset>

                <!-- Champ Description -->
                <fieldset class="form-group">
                    <label>Description</label>
                    <textarea class="form-control" name="description" required="required">${abonnement != null ? abonnement.description : ''}</textarea>
                </fieldset>

                <!-- Champ Prix -->
                <fieldset class="form-group">
                    <label>Prix</label>
                    <input type="number" step="0.01" class="form-control" name="prix" value="${abonnement != null ? abonnement.prix : ''}" required="required">
                </fieldset>

                <!-- Champ Durée -->
                <fieldset class="form-group">
                    <label>Durée</label>
                    <input type="number" class="form-control" name="duree" value="${abonnement != null ? abonnement.duree : ''}" required="required">
                </fieldset>

                <!-- Champ Unité de durée -->
                <fieldset class="form-group">
                    <label>Unité de durée</label>
                    <select class="form-control" name="uniteDuree" required="required">
                        <c:forEach var="option" items="${uniteDureeOptions}">
                            <option value="${option}" <c:if test="${abonnement != null && abonnement.uniteDuree == option}">selected</c:if>>${option}</option>
                        </c:forEach>
                    </select>
                </fieldset>

                <!-- Bouton d'envoi -->
                <button type="submit" class="btn btn-success">
                    <c:choose>
                        <c:when test="${abonnement != null}">
                            Enregistrer les modifications
                        </c:when>
                        <c:otherwise>
                            Ajouter l'abonnement
                        </c:otherwise>
                    </c:choose>
                </button>

                <!-- Bouton pour réinitialiser le formulaire (si ajout) -->
                <c:if test="${abonnement == null}">
                    <button type="reset" class="btn btn-secondary">Réinitialiser</button>
                </c:if>
            </form>
        </div>
    </div>
</div>

<br>

<jsp:include page="../pagesParametres/footer.jsp" />
