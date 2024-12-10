<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../pagesParametres/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header>
    <nav class="navbar navbar-expand-md navbar-dark" style="background-color: tomato">
        <ul class="navbar-nav">
          <li><a href="index.jsp" class="nav-link">Accueil</a></li>
            <li><a href="<%=request.getContextPath()%>/list" class="nav-link">Apprenants</a></li>
            <li><a  class="navbar-brand" href="<%=request.getContextPath()%>/cours/list-cours" class="nav-link">Cours</a></li>
            <li><a href="<%=request.getContextPath()%>/salles/list-salle" class="nav-link">Salles</a></li>
            <li><a href="<%=request.getContextPath()%>/abonnements/list-abonnements" class="nav-link">Abonnements</a></li>
            <li><a href="<%=request.getContextPath()%>/message/list-message" class="nav-link">Message</a></li>         
        </ul>
    </nav>
</header>
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
                    <label>Langue Dispensee</label> 
                    <input type="text" value="${cours.langueDispensee}" class="form-control" name="langueDispensee" 
                           required="required" pattern=".{5,}" title="Au moins 5 caractères">
                </fieldset>
                <!-- Champ DescriptionsCours -->
                <fieldset class="form-group">
                    <label>DescriptionsCours</label> 
                    <input type="text" value="${cours.descriptionsCours}" class="form-control" name="DescriptionsCours" 
                           required="required" pattern=".{5,}" title="Au moins 5 caractères">
                </fieldset>
                 <!-- Champ typeCours -->
                <fieldset class="form-group">
                    <label>Type Cours</label> 
                    <input type="text" value="${cours.typeCours}" class="form-control" name="typeCours" 
                           required="required" pattern=".{5,}" title="Au moins 5 caractères">
                </fieldset>
                 <!-- Champ idSalle -->
                <fieldset class="form-group">
                    <label>idSalle</label> 
                    <input type="text" value="${cours.idSalle}" class="form-control" name="idSalle" 
                           required="required">
                </fieldset>
                <!-- Champ tarifCours -->
                <fieldset class="form-group">
                    <label>tarifCours</label> 
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
