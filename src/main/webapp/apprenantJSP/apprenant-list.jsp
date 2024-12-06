<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<jsp:include page="../pagesParametres/header.jsp" />

<%@ taglib prefix="c" uri="jakarta.tags.core"%>



    <header>
        <nav class="navbar navbar-expand-md navbar-dark" style="background-color: tomato">
        <ul class="navbar-nav">
          <li><a href="index.jsp" class="nav-link">Accueil</a></li>
            <li><a class="navbar-brand"href="<%=request.getContextPath()%>/list" class="nav-link">Apprenants</a></li>
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
            <h3 class="text-center">Liste des Apprenants</h3>
            <hr>
            <div class="container text-left">
                <a href="<%=request.getContextPath()%>/new" class="btn btn-success">Ajouter un Apprenant</a>
            </div>
            <br>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nom</th>
                        <th>niveauLangue</th>
                        <th>langueCible</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="apprenant" items="${listApprenants}">
					    <tr>
					        <td>
					            <c:out value="${apprenant.idApprenant}" />
					        </td>
					        <td>
					            <c:out value="${apprenant.nom}" />
					        </td>
					        <td>
					            <c:out value="${apprenant.niveauLangue}" />
					        </td>
					        <td>
					            <c:out value="${apprenant.langueCible}" />
					        </td>
					        <td>
    <a href="edit?idApprenant=<c:out value='${apprenant.idApprenant}' />" class="btn btn-sm btn-warning">
        <i class="bi bi-pencil-fill"></i> Modifier
    </a>
    &nbsp;
    <a href="delete?idApprenant=<c:out value='${apprenant.idApprenant}' />" class="btn btn-sm btn-danger" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet apprenant ?')">
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

