<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../pagesParametres/header.jsp" />
<%
    // Récupérer le rôle de l'utilisateur depuis la session
    String role = (String) session.getAttribute("role");
%>

        <% if (role == null) { %>
        <script>
            alert("Vous devez être connecté pour accéder à cette page !");
            window.location.href = "${pageContext.request.contextPath}/login.jsp";
        </script>
        <% } %>
<br>

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
<jsp:include page="../pagesParametres/footer.jsp" />

