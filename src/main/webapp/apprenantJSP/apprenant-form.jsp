<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../pagesParametres/header.jsp" />

<header>
    <nav class="navbar navbar-expand-md navbar-dark" style="background-color: tomato">
        <ul class="navbar-nav">
          <li><a href="index.jsp" class="nav-link">Accueil</a></li>
            <li><a   class="navbar-brand" href="<%=request.getContextPath()%>/list" class="nav-link">Apprenants</a></li>
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
            <!-- Formulaire pour ajouter ou modifier un apprenant -->
            <form action="${apprenant != null ? 'update' : 'insert'}" method="post">
                <caption>
                    <h2>
                        <c:choose>
                            <c:when test="${apprenant != null}">
                                Modifier un Apprenant
                            </c:when>
                            <c:otherwise>
                                Ajouter un Apprenant
                            </c:otherwise>
                        </c:choose>
                    </h2>
                </caption>

                <!-- Champ caché pour l'ID de l'apprenant (si modification) -->
                <c:if test="${apprenant != null}">
                    <input type="hidden" name="idApprenant" value="${apprenant.idApprenant}" />
                </c:if>

                <!-- Champ Nom -->
                <fieldset class="form-group">
                    <label>Nom</label> 
                    <input type="text" value="${apprenant.nom}" class="form-control" name="nom" required="required">
                </fieldset>

                <!-- Champ Prénom -->
                <fieldset class="form-group">
                    <label>Niveau Langue</label> 
                    <input type="text" value="${apprenant.niveauLangue}" class="form-control" name="niveauLangue" required="required">
                </fieldset>

                <!-- Champ Email -->
                <fieldset class="form-group">
                    <label>Langue cible</label> 
                    <input type="text" value="${apprenant.langueCible}" class="form-control" name="langueCible" required="required">
                </fieldset>

                <!-- Bouton d'envoi -->
                <button type="submit" class="btn btn-success">Enregistrer</button>
            </form>
        </div>
    </div>
</div>
<jsp:include page="../pagesParametres/footer.jsp" />

