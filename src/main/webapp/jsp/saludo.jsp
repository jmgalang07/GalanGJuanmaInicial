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
            StringBuilder mensaje = new StringBuilder("Buen");
            int hora = LocalTime.now().getHour();
            String genero = (request.getParameter("sexo").equals("Hombre")) ? " señor " : " señora ";
            if (hora >= 7 & hora < 12) {
                mensaje.append("os días");
            } else if (hora >= 12 & hora < 8) {
                mensaje.append("as tardes");
            } else {
                mensaje.append("as noches");
            }
            mensaje.append(genero).append(request.getParameter("nombre"));
        %>
        <h2><%=mensaje.toString()%></h2>
        <p><a href="<%=request.getContextPath()%>">Menú</a></p>
    </body>
</html>