<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
<br>

<br>
<div class="container col-md-5">
    <div class="card">
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/cours/${cours != null ? 'update' : 'insert'}" method="post">
                <caption>
                    <h2>
                        <c:choose>
                            <c:when test="${cours != null}">
                                Modifier un cours
                            </c:when>
                            <c:otherwise>
                                Ajouter un cours
                            </c:otherwise>
                        </c:choose>
                    </h2>
                </caption>
                <!-- Champ caché pour l'ID de la salle (si modification) -->
                <c:if test="${cours != null}">
                    <input type="hidden" name="idCours" value="${cours.idCours}" />
                </c:if>

                <!-- Champ Nom -->
                <fieldset class="form-group">
                    <label>Nom</label> 
                    <input type="text" value="${cours.nomCours}" class="form-control" name="nomCours" 
                           required="required" pattern=".{3,}" title="Au moins 3 caractères">
                </fieldset>

                <!-- Champ LangueDispensee -->
                <fieldset class="form-group">
                    <label>Langue</label> 
                    <input type="text" value="${cours.langueDispensee}" class="form-control" name="langueDispensee" 
                           required="required" pattern=".{5,}" title="Au moins 5 caractères">
                </fieldset>
                <!-- Champ DescriptionsCours -->
                <fieldset class="form-group">
                    <label>Description</label>
                    <textarea class="form-control" name="descriptionsCours" required="required" 
                              pattern=".{5,}" title="Au moins 5 caractères">${cours.descriptionsCours}</textarea>
                </fieldset>

                 <!-- Champ typeCours -->
                <fieldset class="form-group">
                    <label>Type</label> 
                    <input type="text" value="${cours.typeCours}" class="form-control" name="typeCours" 
                           required="required" pattern=".{5,}" title="Au moins 5 caractères">
                </fieldset>
                 <!-- Champ idSalle -->
                <fieldset class="form-group">
                    <label>Salle</label> 
                    <input type="text" value="${cours.idSalle}" class="form-control" name="idSalle" 
                           required="required">
                </fieldset>
                <!-- Champ tarifCours -->
                <fieldset class="form-group">
                    <label>Tarif</label> 
                    <input type="text" value="${cours.tarifCours}" class="form-control" name="tarifCours" 
                           required="required">
                </fieldset>
                <!-- Bouton d'envoi -->
                <button type="submit" class="btn btn-success">Enregistrer</button>
            </form>
        </div>
    </div>
</div>
<jsp:include page="../pagesParametres/footer.jsp" />
