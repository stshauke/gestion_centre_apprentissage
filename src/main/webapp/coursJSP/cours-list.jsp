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
        </ul>
    </nav>
</header>
<br>

<div class="row">
    <div class="container">
        <h3 class="text-center">Liste des Cours</h3>
        <hr>
        <div class="container text-left">
            <a href="<%=request.getContextPath()%>/cours/new" class="btn btn-success">Ajouter un cours</a>
        </div>
        <br>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nom du Cours</th>
                    <th>Langue</th>
                    <th>Description</th>
                    <th>Type</th>
                    <th>Salle</th>
                    <th>Tarif</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="cours" items="${listCours}">
                    <tr>
                        <td><c:out value="${cours.idCours}" /></td>
                        <td><c:out value="${cours.nomCours}" /></td>
                        <td><c:out value="${cours.langueDispensee}" /></td>
                        <td><c:out value="${cours.descriptionsCours}" /></td>
                        <td><c:out value="${cours.typeCours}" /></td>
                        <td><c:out value="${cours.idSalle}" /></td>
                        <td><c:out value="${cours.tarifCours}" /></td>
                        <td>
                            <a href="<%=request.getContextPath()%>/cours/edit?idCours=<c:out value='${cours.idCours}' />" class="btn btn-sm btn-warning">
                                <i class="bi bi-pencil-fill"></i> Modifier
                            </a>
                            &nbsp;
                            <a href="<%=request.getContextPath()%>/cours/delete?idCours=<c:out value='${cours.idCours}' />" class="btn btn-sm btn-danger"
                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce cours ?')">
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
