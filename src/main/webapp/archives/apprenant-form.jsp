<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
</body>

</html>
