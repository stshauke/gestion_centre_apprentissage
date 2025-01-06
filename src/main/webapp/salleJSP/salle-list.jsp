<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../pagesParametres/header.jsp" />

<body style="background-color: #fffceb; font-family: Arial, sans-serif;">
    <div class="container-fluid mt-4">
        <h3 class="text-center text-dark my-4">Liste des Salles</h3>
        <hr>

        <div class="container text-left mb-4">
            <!-- Bouton Ajouter une Salle avec un style moderne -->
            <a href="<%= request.getContextPath() %>/salles/new" 
               class="btn btn-lg" 
               style="background-color: #fd7e14; color: white; border-radius: 30px; font-weight: bold;">
                <i class="bi bi-plus-circle"></i> Ajouter une Salle
            </a>
        </div>

        <div class="table-responsive" style="max-height: 600px; overflow-y: auto; border: 1px solid #ddd; border-radius: 10px;">
            <table class="table table-striped table-hover" style="width: 100%; overflow: hidden; border-collapse: separate; border-spacing: 0;">
                <thead style="background-color: #FFE4B5; border: none;">
                    <tr>
                        <th>ID</th>
                        <th>Nom</th>
                        <th>Équipements</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="salle" items="${listSalles}">
                        <tr style="background-color: #F9F9F9; border-bottom: 1px solid rgba(169, 169, 169, 0.8);">
                            <td><c:out value="${salle.idSalle}" /></td>
                            <td><c:out value="${salle.nomSalle}" /></td>
                            
                            <!-- Colonne Équipements avec un défilement si contenu long -->
                            <td style="max-width: 300px; word-wrap: break-word; white-space: normal; overflow-wrap: break-word;">
                                <div style="max-height: 100px; overflow-y: auto;">
                                    <c:out value="${salle.equipements}" />
                                </div>
                            </td>

                            <td class="d-flex justify-content-start">
                                <!-- Boutons Modifier et Supprimer avec bordures arrondies et couleurs modernes -->
                                <a href="<%= request.getContextPath() %>/salles/edit?idSalle=<c:out value='${salle.idSalle}' />" 
                                   class="btn btn-sm" 
                                   style="background-color: #FF8C00; color: white; border-radius: 25px; margin-right: 10px;">
                                    <i class="bi bi-pencil-fill"></i> Modifier
                                </a>
                                <a href="<%= request.getContextPath() %>/salles/delete?idSalle=<c:out value='${salle.idSalle}' />" 
                                   class="btn btn-sm" 
                                   style="background-color: #FF6347; color: white; border-radius: 25px;" 
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette salle ?')">
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
</body>
