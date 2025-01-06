<%-- 
    Document   : complete-profil
    Created on : 29 déc. 2024, 17:10:00
    Author     : snekh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Compléter votre Profil</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #ffe976;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
        }

        .profile-container {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 100%;
            max-width: 400px;
        }

        .btn-primary {
            background-color: #fd7e14;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <h2 class="text-center mb-4">Compléter votre Profil</h2>
        <form action="${pageContext.request.contextPath}/profil" method="post">
            <div class="mb-3">
                <label for="name" class="form-label">Nom</label>
                <input type="text" class="form-control" id="name" name="name" placeholder="Entrez votre nom" required>
            </div>
            <div class="mb-3">
                <label for="languageLevel" class="form-label">Niveau de langue</label>
                <input type="text" class="form-control" id="languageLevel" name="languageLevel" placeholder="Entrez votre niveau de langue" required>
            </div>
            <div class="mb-3">
                <label for="targetLanguage" class="form-label">Langue cible</label>
                <input type="text" class="form-control" id="targetLanguage" name="targetLanguage" placeholder="Entrez votre langue cible" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Enregistrer</button>
        </form>

        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger mt-3 text-center">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>

    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
