<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="error.jsp" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
<h2>🔐 Iniciar sesión</h2>
<% if (request.getAttribute("error") != null) { %>
<div style="color: red; background: #ffe6e6; padding: 10px; border-radius: 4px; margin-bottom: 15px;">
    <strong>Error:</strong> <%= request.getAttribute("error") %>
</div>
<% } %>
<form action="LoginServlet" method="post">
    Usuario: <input type="text" name="user"><br>
    Contraseña: <input type="password" name="pass"><br>
    <input type="submit" value="Ingresar">
</form>
</body>
</html>