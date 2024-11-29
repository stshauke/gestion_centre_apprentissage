<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
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

<div class="row">
    <div class="container">
        <h3 class="text-center">Liste des Abonnements</h3>
        <hr>
        <div class="container text-left">
            <a href="<%=request.getContextPath()%>/abonnements/new" class="btn btn-success">Ajouter un abonnement</a>
        </div>
        <br>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Apprenant</th>
                <th>Date début</th>
                    <th>Date fin</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="abonnements" items="${listAbonnements}">
                    <tr>
                        <td><c:out value="${abonnements.idAbonnement}" /></td>
                        <td><c:out value="${abonnements.idApprenant}" /></td>
                        <td><c:out value="${abonnements.dateDebut}" /></td>
                        <td><c:out value="${abonnements.dateFin}" /></td>
                        <td>
                            <a href="<%=request.getContextPath()%>/abonnements/edit?idAbonnement=<c:out value='${abonnements.idAbonnement}' />" class="btn btn-sm btn-warning">
                                <i class="bi bi-pencil-fill"></i> Modifier
                            </a>
                            &nbsp;
                            <a href="<%=request.getContextPath()%>//abonnements/delete?idAbonnement=<c:out value='${abonnements.idAbonnement}' />" class="btn btn-sm btn-danger"
                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet abonnement ?')">
                                <i class="bi bi-trash"></i> Supprimer
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<jsp:include page="../pagesParametres/footer.jsp" />
