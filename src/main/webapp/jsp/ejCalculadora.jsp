<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http‐equiv="Content‐Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ejCalculadora.css"/>
        <title>Ejemplo calculadora</title>
    </head>
    <body>
        <div id="contenido"> <!-- Añadido un contenedor para el contenido -->
        <%-- Método para sumar dos números enteros --%>
        <%!
            public int sumar(int param1, int param2) {
                return param1 + param2;
            }
        %>
        <%
            if (request.getParameter("switch") == null) {
        %>
        <form method="post" action="ejCalculadora.jsp" >
            <input type="hidden" name="switch" value="true">
            <table>
                <tr>
                    <td>Primer número:</td>
                    <td><input name="param1"></td>
                </tr>
                <tr>
                    <td>Segundo número:</td>
                    <td><input name="param2"></td>
                </tr>
                <tr>
                    <td><button type="submit" name="operation" value="Sumar">Sumar</button></td>
                </tr>
            </table>
            <p><a href="<%=request.getContextPath()%>">Menú</a></p>
        </form>
        <%
        } else {
            try {
                int param1 = Integer.parseInt(request.getParameter("param1"));
                int param2 = Integer.parseInt(request.getParameter("param2"));
                int result = param1 + param2;
        %>
        <p>El resultado de la suma es: <%= sumar(param1, param2)%></p>
        <%
        } catch (NumberFormatException ex) {
        %>
        <p>Alguno de los números no contenía dígitos válidos...</p>
        <%
            }
        %>
        <p><%= Calendar.getInstance().getTime()%></p>
        <a href="ejCalculadora.jsp">Calculadora</a>
        <a href="<%=request.getContextPath()%>">Menú</a>
        <%
            }
        %>
        </div> <!-- Fin del contenedor -->
    </body>
</html>