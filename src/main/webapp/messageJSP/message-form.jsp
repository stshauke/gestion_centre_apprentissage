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

<div class="container col-md-5">
    <div class="card">
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/message/${message != null ? 'update' : 'insert'}" method="post">
                <caption>
                    <h2>
                        <c:choose>
                            <c:when test="${message != null}">
                                Modifier un message
                            </c:when>
                            <c:otherwise>
                                Ajouter un message
                            </c:otherwise>
                        </c:choose>
                    </h2>
                </caption>

                <!-- Champ caché pour l'ID de l'abonnement (si modification) -->
                <c:if test="${message != null}">
                    <input type="hidden" name="idMessage" value="${message.idMessage}" />
                </c:if>

                <!-- Si modification, afficher le nom de l'apprenant en lecture seule -->
                <c:if test="${message != null}">
                    <fieldset class="form-group">
                        <label>Apprenant</label>
                        <!-- Lecture seule pour le nom -->
                        <input type="text" class="form-control" value="${nomApprenant}" readonly>
                        <!-- Stocker l'idApprenant dans un champ caché -->
                        <input type="hidden" name="idApprenant" value="${message.idApprenant}">
                    </fieldset>
                </c:if>

                <!-- Si ajout, afficher une liste déroulante -->
                <c:if test="${message == null}">
                    <fieldset class="form-group">
                        <label>Apprenant</label>
                        <select class="form-control" name="idApprenant" required="required">
                            <option value="" disabled selected>Choisissez un apprenant</option>
                            <c:forEach var="apprenant" items="${listApprenants}">
                                <option value="${apprenant.idApprenant}">${apprenant.nom}</option>
                            </c:forEach>
                        </select>
                    </fieldset>
                </c:if>



                <!-- Champ Contenu -->
                <fieldset class="form-group">
                    <label>Contenu</label>
                    <input type="text" value="${message.contenu}" class="form-control" name="contenu" required="required">
                </fieldset>

                <!-- Champ Langue cible -->
                <fieldset class="form-group">
                    <label>Langue cible</label>
                    <input type="text" value="${message.langueCible}" class="form-control" name="langueCible" required="required">
                </fieldset>

                <!-- Champ Date Publication -->
                <fieldset class="form-group">
                    <label>Date de publication</label>
                    <input type="date" value="${message.datePublication}" class="form-control" name="datePublication" required="required">
                </fieldset>

                <button type="submit" class="btn btn-success">Enregistrer</button>

            </form>

        </div>
    </div>
</div>

<jsp:include page="../pagesParametres/footer.jsp" />