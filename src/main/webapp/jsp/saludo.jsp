<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.time.LocalTime"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<%=request.getContextPath()%>/css/saludo.css"/>

        <title>Saludo</title>
    </head>
    <body>
        <%
            // Inicializo un StringBuilder para construir el mensaje de saludo
            StringBuilder mensaje = new StringBuilder("Buen");
            // Obtengo la hora actual
            int hora = LocalTime.now().getHour();
            // Determino el género del usuario según el parámetro recibido
            String genero = (request.getParameter("sexo").equals("Hombre")) ? " señor " : " señora ";

            // Según la hora actual, agrego el saludo correspondiente
            if (hora >= 7 & hora < 12) {
                mensaje.append("os días"); // Saludo de la mañana
            } else if (hora >= 12 & hora < 20) {
                mensaje.append("as tardes"); // Saludo de la tarde
            } else {
                mensaje.append("as noches"); // Saludo de la noche
            }
            // Agrego el género y el nombre del usuario al mensaje
            mensaje.append(genero).append(request.getParameter("nombre"));
        %>
        <h2><%=mensaje.toString()%></h2> <!-- Muestro el mensaje de saludo en la página -->
        <p><a href="<%=request.getContextPath()%>">Menú</a></p> <!-- Enlace de retorno al menú -->
    </body>
</html>