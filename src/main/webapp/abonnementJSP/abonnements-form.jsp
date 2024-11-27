<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                                Modifier un cours
                            </c:when>
                            <c:otherwise>
                                Ajouter un cours
                            </c:otherwise>
                        </c:choose>
                    </h2>
                </caption>
                <!-- Champ caché pour l'ID de la salle (si modification) -->
                <c:if test="${abonnements != null}">
                    <input type="hidden" name="idAbonnement" value="${abonnements.idAbonnement}" />
                </c:if>

                <!-- Champ Nom -->
                <fieldset class="form-group">
                    <label>Apprenant</label> 
                    <input type="text" value="${abonnements.idApprenant}" class="form-control" name="idApprenant" 
                           required="required">
                </fieldset>

                <!-- Champ LangueDispensee -->
                <fieldset class="form-group">
                    <label>Date Début</label> 
                    <input type="text" value="${abonnements.dateDebut}" class="form-control" name="dateDebut" 
                           required="required" >
                </fieldset>
                <!-- Champ DescriptionsCours -->
                <fieldset class="form-group">
                    <label>Date fin</label> 
                    <input type="text" value="${abonnements.dateFin}" class="form-control" name="dateFin" 
                           required="required">
                </fieldset>
                
                <!-- Bouton d'envoi -->
                <button type="submit" class="btn btn-success">Enregistrer</button>
            </form>
        </div>
    </div>
</div>
<jsp:include page="../pagesParametres/footer.jsp" />
