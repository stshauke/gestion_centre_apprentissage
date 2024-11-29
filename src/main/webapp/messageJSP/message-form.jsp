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
            <li><a href="<%=request.getContextPath()%>/message/list-message" class="nav-link">Message</a></li>
            
        </ul>
    </nav>
</header>
<br>
<div class="container col-md-5">
    <div class="card">
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/message/${message != null ? 'update' : 'insert'}" method="post">
                <caption>
                    <h2>
                        <c:choose>
                            <c:when test="${message != null}">
                                Modifier un message
                            </c:when>
                            <c:otherwise>
                                Ajouter un message
                            </c:otherwise>
                        </c:choose>
                    </h2>
                </caption>
                <!-- Champ caché pour l'ID de la salle (si modification) -->
                <c:if test="${message != null}">
                    <input type="hidden" name="idMessage" value="${message.idMessage}" />
                </c:if>

                <!-- Champ Nom -->
                <fieldset class="form-group">
                    <label>Apprenant</label> 
                    <input type="text" value="${message.idApprenant}" class="form-control" name="idApprenant" 
                           required="required">
                </fieldset>

                <!-- Champ LangueDispensee -->
                <fieldset class="form-group">
                    <label>Contenu</label> 
                    <input type="text" value="${message.contenu}" class="form-control" name="contenu" 
                           required="required">
                </fieldset>
                <!-- Champ DescriptionsCours -->
                <fieldset class="form-group">
                    <label>Langue cible</label> 
                    <input type="text" value="${message.langueCible}" class="form-control" name="langueCible" 
                           required="required" >
                </fieldset>
                 <!-- Champ typeCours -->
                <fieldset class="form-group">
                    <label>Date de publication</label> 
                    <input type="text" value="${message.datePublication}" class="form-control" name="datePublication" 
                           required="required" >
                </fieldset>
                
                </fieldset>
                <!-- Bouton d'envoi -->
                <button type="submit" class="btn btn-success">Enregistrer</button>
            </form>
        </div>
    </div>
</div>
<jsp:include page="../pagesParametres/footer.jsp" />
