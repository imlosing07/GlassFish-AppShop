<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter, java.io.StringWriter" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error detectado</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f8f9fa;
        }

        .error-container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            max-width: 800px;
        }

        .error-title {
            color: #dc3545;
            border-bottom: 2px solid #dc3545;
            padding-bottom: 10px;
        }

        .error-detail {
            margin: 15px 0;
            padding: 15px;
            background-color: #f8f9fa;
            border-left: 4px solid #6c757d;
            border-radius: 4px;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }

        .back-link:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="error-container">
    <h2 class="error-title">⚠️ Se ha producido un error</h2>

    <%-- LÍNEAS CRÍTICAS: Detectar si es un forward normal o un error del servidor --%>
    <%
        // Verificar si es un forward normal (con mensaje personalizado)
        String mensajePersonalizado = (String) request.getAttribute("mensaje");
        boolean esForwardNormal = (mensajePersonalizado != null);

        if (esForwardNormal) {
            // CASO 1: Forward normal desde servlet
    %>
    <div class="error-detail">
        <strong>Mensaje:</strong> <%= mensajePersonalizado %>
    </div>

    <div class="error-detail">
        <strong>Tipo:</strong> Error de validación
    </div>

    <%
        // Verificar si hay usuario logueado para mostrar el botón correcto
        HttpSession sesion = request.getSession(false);
        String usuarioLogueado = (sesion != null) ? (String) sesion.getAttribute("usuario") : null;

        if (usuarioLogueado != null) {
    %>
    <a href="${pageContext.request.contextPath}/index.jsp" class="back-link">🔙 Volver a comprar</a>
    <%
    } else {
    %>
    <a href="${pageContext.request.contextPath}/login.jsp" class="back-link">🔙 Volver al login</a>
    <%
        }
    %>

    <%
    } else {
        // CASO 2: Error real del servidor (500, 404, etc.)
    %>
    // CASO 2: Error real del servidor (500, 404, etc.)
    %>
    <div class="error-detail">
        <strong>Código de Estado:</strong>
        <%= request.getAttribute("jakarta.servlet.error.status_code") != null ? request.getAttribute("jakarta.servlet.error.status_code") : "No disponible" %>
    </div>

    <div class="error-detail">
        <strong>Mensaje:</strong>
        <%= request.getAttribute("jakarta.servlet.error.message") != null ? request.getAttribute("jakarta.servlet.error.message") : "No disponible" %>
    </div>

    <div class="error-detail">
        <strong>URI Solicitada:</strong>
        <%= request.getAttribute("jakarta.servlet.error.request_uri") != null ? request.getAttribute("jakarta.servlet.error.request_uri") : "No disponible" %>
    </div>

    <%
        Throwable throwable = (Throwable) request.getAttribute("jakarta.servlet.error.exception");
        if (throwable != null) {
    %>
    <div class="error-detail">
        <strong>Tipo de Excepción:</strong> <%= throwable.getClass().getName() %>
    </div>

    <div class="error-detail">
        <strong>Detalles de la Excepción:</strong>
        <%= throwable.getMessage() != null ? throwable.getMessage() : "Sin mensaje específico" %>
    </div>
    <%
        }
    %>

    <%
        // Mismo check para errores del servidor
        HttpSession sesion = request.getSession(false);
        String usuarioLogueado = (sesion != null) ? (String) sesion.getAttribute("usuario") : null;
        if (usuarioLogueado != null) {
    %>
    <a href="${pageContext.request.contextPath}/index.jsp" class="back-link">🔙 Volver a comprar</a>
    <%
    } else {
    %>
    <a href="${pageContext.request.contextPath}/index.jsp" class="back-link">🔙 Volver al inicio</a>
    <%
        }
    %>

    <%
        }
    %>

    <div class="error-detail">
        <strong>Fecha y Hora:</strong> <%= new java.util.Date() %>
    </div>
</div>
</body>
</html>