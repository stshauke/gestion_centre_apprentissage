<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../pagesParametres/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header>
    <nav class="navbar navbar-expand-md navbar-dark" style="background-color: tomato">
        <ul class="navbar-nav">
          <li><a href="index.jsp" class="nav-link">Accueil</a></li>
            <li><a href="<%=request.getContextPath()%>/list" class="nav-link">Apprenants</a></li>
            <li><a href="<%=request.getContextPath()%>/cours/list-cours" class="nav-link">Cours</a></li>
            <li><a  class="navbar-brand" href="<%=request.getContextPath()%>/salles/list-salle" class="nav-link">Salles</a></li>
            <li><a href="<%=request.getContextPath()%>/abonnements/list-abonnements" class="nav-link">Abonnements</a></li>
            <li><a href="<%=request.getContextPath()%>/message/list-message" class="nav-link">Message</a></li>         
        </ul>
    </nav>
</header>
<br>
<div class="container col-md-5">
    <div class="card">
        <div class="card-body">
            <!-- Formulaire pour ajouter ou modifier un apprenant -->
            <form action="${pageContext.request.contextPath}/salles/${salle != null ? 'update' : 'insert'}" method="post">
            
    <caption>
        <h2>
            <c:choose>
                <c:when test="${salle != null}">
                    Modifier une Salle
                </c:when>
                <c:otherwise>
                    Ajouter une salle
                </c:otherwise>
            </c:choose>
        </h2>
    </caption>

    <!-- Champ caché pour l'ID de la salle (si modification) -->
    <c:if test="${salle != null}">
        <input type="hidden" name="idSalle" value="${salle.idSalle}" />
    </c:if>

    <!-- Champ Nom -->
    <fieldset class="form-group">
        <label>Nom</label> 
        <input type="text" value="${salle.nomSalle}" class="form-control" name="nomSalle" required="required">
    </fieldset>

    <!-- Champ Equipements -->
    <fieldset class="form-group">
        <label>Equipements</label> 
        <input type="text" value="${salle.equipements}" class="form-control" name="equipements" required="required">
    </fieldset>

    <!-- Bouton d'envoi -->
    <button type="submit" class="btn btn-success">Enregistrer</button>
</form>

        </div>
    </div>
</div>
<jsp:include page="../pagesParametres/footer.jsp" />

