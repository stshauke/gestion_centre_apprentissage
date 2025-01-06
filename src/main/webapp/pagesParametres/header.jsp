<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Récupérer le rôle de l'utilisateur depuis la session
    String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>LinguApp</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
    /* Style pour un footer fixe */
    footer {
      position: fixed;
      bottom: 0;
      left: 0;
      width: 100%;
      background-color: #343a40;
      color: white;
      text-align: center;
      padding: 10px 0;
    }

    /* Ajout de marge en bas pour que le contenu de la page ne soit pas caché derrière le footer */
    body {
      padding-bottom: 50px; /* Ajustez selon la hauteur de votre footer */
    }
    
  </style>
</head>
<body>
<nav class="navbar navbar-expand-lg" style="background-color: #FFF3E0; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);">
  <div class="container">
    <a class="navbar-brand fw-bold" href="index.jsp">LinguApp</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <% if (role == null) { %>
        <script>
            alert("Vous devez être connecté pour accéder à cette page !");
            window.location.href = "${pageContext.request.contextPath}/login.jsp";
        </script>
        <% } %>
        <li class="nav-item"><a class="nav-link" href="index.jsp">Accueil</a></li>
        <% if ("admin".equals(role)) { %>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="adminDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                Administration
              </a>
              <ul class="dropdown-menu" aria-labelledby="adminDropdown">
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/list">Apprenants</a></li>
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/cours/list-cours">Cours</a></li>
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/salles/list-salle">Salles</a></li>
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/abonnements/list-abonnements">Abonnements</a></li>
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/message/list-message">Messages</a></li>
              </ul>
            </li>
        <% } else if ("apprenant".equals(role)) { %>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/cours/list-cours">Cours</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/message/list-message">Messages</a></li>
        <% } %>
        <li class="nav-item">
          <a class="nav-link text-warning fw-bold" href="${pageContext.request.contextPath}/logout">Déconnexion</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
