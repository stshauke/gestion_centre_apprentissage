<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<jsp:include page="../pagesParametres/header.jsp" />

<header>
    <nav class="navbar navbar-expand-md navbar-dark" style="background-color: tomato">
        <ul class="navbar-nav">
          <li><a href="index.jsp" class="nav-link">Accueil</a></li>
            <li><a href="<%=request.getContextPath()%>/list" class="nav-link">Apprenants</a></li>
            <li><a href="<%=request.getContextPath()%>/cours/list-cours" class="nav-link">Cours</a></li>
            <li><a href="<%=request.getContextPath()%>/salles/list-salle" class="nav-link">Salles</a></li>
            <li><a  href="<%=request.getContextPath()%>/abonnements/list-abonnements" class="nav-link">Abonnements</a></li>
            <li><a class="navbar-brand" href="<%=request.getContextPath()%>/message/list-message" class="nav-link">Message</a></li>         
        </ul>
    </nav>
</header>
<br>

<div class="row">
    <div class="container">
        <h3 class="text-center">Liste des messages</h3>
        <hr>
        <div class="container text-left">
            <a href="<%=request.getContextPath()%>/message/new" class="btn btn-success">Ajouter un message</a>
        </div>
        <br>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nom apprenant</th>
                    <th>Contenu</th>
                    <th>langue_cible</th>
                    <th>datePublication</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="message" items="${listMessage}" varStatus="status">
    <tr>
        <td><c:out value="${message.idMessage}" /></td>
        <td>
            <!-- Afficher le nom correspondant à l'index -->
            <c:out value="${nomsApprenants[status.index]}" />
        </td>
        <td><c:out value="${message.contenu}" /></td>
        <td><c:out value="${message.langueCible}" /></td>
        <td><c:out value="${message.datePublication}" /></td>
        <td>
            <a href="<%=request.getContextPath()%>/message/edit?idMessage=<c:out value='${message.idMessage}' />" class="btn btn-sm btn-warning">
                <i class="bi bi-pencil-fill"></i> Modifier
            </a>
            &nbsp;
            <a href="<%=request.getContextPath()%>/message/delete?idMessage=<c:out value='${message.idMessage}' />" class="btn btn-sm btn-danger"
               onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce message ?')">
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