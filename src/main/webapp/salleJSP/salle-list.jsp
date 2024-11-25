<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../pagesParametres/header.jsp" />
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<header>
    <nav class="navbar navbar-expand-md navbar-dark" style="background-color: tomato">
        <div>
            <a href="index.jsp" class="navbar-brand">Accueil</a>
        </div>
        <ul class="navbar-nav">
<li><a href="<%=request.getContextPath()%>/list" class="nav-link">Apprenants</a></li>
            <li><a href="<%=request.getContextPath()%>/cours/list-cours" class="nav-link">Cours</a></li>
            <li><a href="<%=request.getContextPath()%>/salles/list-salle" class="nav-link">Salles</a></li>        </ul>
    </nav>
</header>
<br>

<div class="row">
    <div class="container">
        <h3 class="text-center">Liste des salles</h3>
        <hr>
        <div class="container text-left">
            <a href="<%=request.getContextPath()%>/salles/new" class="btn btn-success">Ajouter une salle</a>
        </div>
        <br>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nom</th>
                    <th>Equipements</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <!-- Utilisation de c:forEach pour itérer sur la liste des salles -->
                <c:forEach var="salle" items="${listSalles}">
                    <tr>
                        <td><c:out value="${salle.idSalle}" /></td>
                        <td><c:out value="${salle.nomSalle}" /></td>
                        <td><c:out value="${salle.equipements}" /></td>
                        <td>
                            <a href="<%=request.getContextPath()%>/salles/edit?idSalle=<c:out value='${salle.idSalle}' />" class="btn btn-sm btn-warning">
    <i class="bi bi-pencil-fill"></i> Modifier
</a>

                            &nbsp;
                            <a href="delete?idSalle=<c:out value='${salle.idSalle}' />" class="btn btn-sm btn-danger" 
                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette salle ?')">
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
