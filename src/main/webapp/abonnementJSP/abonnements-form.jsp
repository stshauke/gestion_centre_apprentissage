<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../pagesParametres/header.jsp" />

<header>
    <nav class="navbar navbar-expand-md navbar-dark" style="background-color: tomato">
        <div>
            <a href="index.jsp" class="navbar-brand">Accueil</a>
        </div>
        <ul class="navbar-nav">
           <li><a href="<%=request.getContextPath()%>/list" class="nav-link">Apprenants</a></li>
            <li><a href="<%=request.getContextPath()%>/cours/list-cours" class="nav-link">Cours</a></li>
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
            <form action="${pageContext.request.contextPath}/abonnements/${abonnements != null ? 'update' : 'insert'}" method="post">
                <caption>
                    <h2>
                        <c:choose>
                            <c:when test="${abonnements != null}">
                                Modifier un abonnement
                            </c:when>
                            <c:otherwise>
                                Ajouter un abonnement
                            </c:otherwise>
                        </c:choose>
                    </h2>
                </caption>

                <!-- Champ caché pour l'ID de l'abonnement (si modification) -->
                <c:if test="${abonnements != null}">
                    <input type="hidden" name="idAbonnement" value="${abonnements.idAbonnement}" />
                </c:if>

                <!-- Champ Apprenant -->
                <fieldset class="form-group">
                    <label>Apprenant</label> 
                    <select class="form-control" name="idApprenant" required="required">
                        <option value="" disabled selected>Choisissez un apprenant</option>
                        <!-- Boucle pour afficher les apprenants dans la liste déroulante -->
                        <c:forEach var="apprenant" items="${listApprenants}">
                            <option value="${apprenant.idApprenant}">${apprenant.nom}</option>
                        </c:forEach>
                    </select>
                </fieldset>

                <!-- Champ Date Début -->
                <fieldset class="form-group">
                    <label>Date Début</label> 
                    <input type="text" value="${abonnements.dateDebut}" class="form-control" name="dateDebut" required="required">
                </fieldset>

                <!-- Champ Date Fin -->
                <fieldset class="form-group">
                    <label>Date Fin</label> 
                    <input type="text" value="${abonnements.dateFin}" class="form-control" name="dateFin" required="required">
                </fieldset>

                <!-- Bouton d'envoi -->
                <button type="submit" class="btn btn-success">Enregistrer</button>
            </form>

        </div>
    </div>
</div>

<jsp:include page="../pagesParametres/footer.jsp" />