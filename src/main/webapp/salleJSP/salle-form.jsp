<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../pagesParametres/header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<br>

<div class="container col-md-5">
    <div class="card">
        <div class="card-body">
            <!-- Formulaire pour ajouter ou modifier un apprenant -->
            <form action="${pageContext.request.contextPath}/salles/${salle != null ? 'update' : 'insert'}" method="post">
                <caption>
                    <h2>
                        <c:choose>
                            <c:when test="${salle != null}">
                                Modifier une Salle
                            </c:when>
                            <c:otherwise>
                                Ajouter une salle
                            </c:otherwise>
                        </c:choose>
                    </h2>
                </caption>

                <!-- Champ caché pour l'ID de la salle (si modification) -->
                <c:if test="${salle != null}">
                    <input type="hidden" name="idSalle" value="${salle.idSalle}" />
                </c:if>

                <!-- Champ Nom -->
                <fieldset class="form-group">
                    <label>Nom</label> 
                    <input type="text" value="${salle.nomSalle}" class="form-control" name="nomSalle" required="required">
                </fieldset>

                <!-- Champ Equipements -->
                <fieldset class="form-group">
                    <label>Equipements</label> 
                    <input type="text" value="${salle.equipements}" class="form-control" name="equipements" required="required">
                </fieldset>

                <!-- Bouton d'envoi -->
                <button type="submit" class="btn btn-success">Enregistrer</button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../pagesParametres/footer.jsp" />
