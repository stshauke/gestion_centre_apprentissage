<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>

<head>
    <title>Gestion des Apprenants</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" 
          crossorigin="anonymous">
</head>

<body>

    <header>
        <nav class="navbar navbar-expand-md navbar-dark" style="background-color: tomato">
            <div>
                <a href="https://www.example.com" class="navbar-brand">Gestion des Apprenants</a>
            </div>

            <ul class="navbar-nav">
                <li><a href="<%=request.getContextPath()%>/list" class="nav-link">Apprenants</a></li>
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
					            <a href="edit?idApprenant=<c:out value='${apprenant.idApprenant}' />">Modifier</a>
					            &nbsp;&nbsp;&nbsp;&nbsp;
					            <a href="delete?idApprenant=<c:out value='${apprenant.idApprenant}' />">Supprimer</a>
					        </td>
					    </tr>
					</c:forEach>

                </tbody>
            </table>
        </div>
    </div>
</body>

</html>
