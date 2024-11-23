<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
</head>
<body>
    <center>
        <h1>An Error Occurred</h1>
        <h2>Error Message: <%= exception.getMessage() %></h2>
        <p>Type: <%= exception.getClass().getName() %></p>
    </center>
</body>
</html>
