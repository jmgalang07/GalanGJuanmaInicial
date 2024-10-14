<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ejCalculadora.css"/>
        <title>Ejemplo calculadora</title>
    </head>
    <body>
        <div id="contenido"> <!-- Añadido un contenedor para el contenido -->

            <%-- Método para sumar dos números enteros --%>
            <%!
                // Defino el método para sumar dos enteros y devolver el resultado
                public int sumar(int param1, int param2) {
                    return param1 + param2;
                }
            %>

            <%
                // Verifico si el formulario ha sido enviado
                if (request.getParameter("switch") == null) {
            %>
            <form method="post" action="ejCalculadora.jsp">
                <input type="hidden" name="switch" value="true"> <!-- Esta entrada oculta indica que el formulario ha sido enviado -->
                <table>
                    <tr>
                        <td>Primer número:</td>
                        <td><input name="param1"></td> <!-- Campo para el primer número -->
                    </tr>
                    <tr>
                        <td>Segundo número:</td>
                        <td><input name="param2"></td> <!-- Campo para el segundo número -->
                    </tr>
                    <tr>
                        <td><button type="submit" name="operation" value="Sumar">Sumar</button></td> <!-- Botón para enviar el formulario -->
                    </tr>
                </table>
                <p><a href="<%=request.getContextPath()%>">Menú</a></p> <!-- Enlace para volver al menú -->
            </form>
            <%
            } else { // Si el formulario ha sido enviado
                try {
                    // Obtengo y convierto los parámetros a enteros
                    int param1 = Integer.parseInt(request.getParameter("param1"));
                    int param2 = Integer.parseInt(request.getParameter("param2"));
                    // Realizo la suma usando el método definido anteriormente
                    int result = param1 + param2;
            %>
            <p>El resultado de la suma es: <%= sumar(param1, param2)%></p> <!-- Muestro el resultado de la suma -->
            <%
            } catch (NumberFormatException ex) { // Manejo de excepción en caso de que los parámetros no sean válidos
            %>
            <p>Alguno de los números no contenía dígitos válidos...</p> <!-- Mensaje de error si hay un formato incorrecto -->
            <%
                    }
                }
            %>
            <p><%= Calendar.getInstance().getTime()%></p> <!-- Muestro la fecha y hora actual -->
            <a href="ejCalculadora.jsp">Calculadora</a> <!-- Enlace para volver a la calculadora -->
            <a href="<%=request.getContextPath()%>">Menú</a> <!-- Enlace para volver al menú -->
        </div> <!-- Fin del contenedor -->
    </body>
</html>