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
            <form action="${pageContext.request.contextPath}/abonnements/${abonnements != null ? 'update' : 'insert'}" method="post">
                <caption>
                    <h2>
                        <c:choose>
                            <c:when test="${abonnements != null}">
                                Modifier un abonnement
                            </c:when>
                            <c:otherwise>
                                Ajouter un abonnement
                            </c:otherwise>
                        </c:choose>
                    </h2>
                </caption>

                <!-- Champ caché pour l'ID de l'abonnement (si modification) -->
                <c:if test="${abonnements != null}">
                    <input type="hidden" name="idAbonnement" value="${abonnements.idAbonnement}" />
                </c:if>

                <!-- Champ Apprenant -->
                <fieldset class="form-group">
                    <label>Apprenant</label>
                    <select class="form-control" name="idApprenant" required="required" 
                        <c:if test="${abonnements != null}">disabled</c:if>> 
                        <!-- Liste des apprenants -->
                        <c:forEach var="apprenant" items="${listApprenants}">
                            <option value="${apprenant.idApprenant}"
                                <c:if test="${apprenant.idApprenant == abonnements.idApprenant}">selected</c:if>> 
                                ${apprenant.nom}
                            </option>
                        </c:forEach>
                    </select>
                    <c:if test="${abonnements != null}">
                        <!-- Ajouter un champ caché pour l'apprenant, car "disabled" exclut des données POST -->
                        <input type="hidden" name="idApprenant" value="${abonnements.idApprenant}" />
                    </c:if>
                </fieldset>


                <!-- Champ Date Début -->
                <fieldset class="form-group">
                    <label>Date Début</label> 
                    <input type="date" value="${abonnements.dateDebut}" class="form-control" name="dateDebut" required="required">
                </fieldset>

                <!-- Champ Date Fin -->
                <fieldset class="form-group">
                    <label>Date Fin</label> 
                    <input type="date" value="${abonnements.dateFin}" class="form-control" name="dateFin" required="required">
                </fieldset>

                <!-- Bouton d'envoi -->
                <button type="submit" class="btn btn-success">Enregistrer</button>
            </form>

        </div>
    </div>
</div>
<br>

<jsp:include page="../pagesParametres/footer.jsp" />