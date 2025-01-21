<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmation d'Achat</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1>Confirmation de l'Achat</h1>

    <!-- Affichage du message de succès -->
    <c:if test="${not empty message}">
        <div class="alert alert-success mt-4">
            <h4 class="alert-heading">${message}</h4>
        </div>
    </c:if>

    <!-- Affichage des erreurs si présent -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger mt-4">
            <h4 class="alert-heading">Erreur</h4>
            <p>${errorMessage}</p>
        </div>
    </c:if>

    <!-- Retour à l'accueil -->
    <a href="index.jsp" class="btn btn-primary mt-4">Retour à l'Accueil</a>
</div>
</body>
</html>
