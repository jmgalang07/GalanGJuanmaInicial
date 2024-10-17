<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/sesiones.css"/>
        <title>Contador de sesiones</title>
    </head>
    <body>
        <div id="contenedor">
            <%
                // Inicializo el contador de sesiones como una variable local
                Integer contador = 0; // Inicializo en 0 siempre

                String action = request.getParameter("enviar"); // Obtengo la acción del formulario

                // Verifico si el checkbox está seleccionado para eliminar la sesión
                String gustos = request.getParameter("gustos");

                // Al pulsar "Recargar"
                if ("Recargar".equals(action)) {
                    // Incremento el contador solo si no se ha solicitado eliminar la sesión
                    if (gustos == null) {
                        contador++; // Incremento el contador
                    }
                }

                // Al pulsar "Eliminar"
                if ("Eliminar".equals(gustos)) {
                    // Aquí no se almacena el contador, simplemente se hace el reinicio
                    contador = 0; // Reinicio el contador a 0
                }
            %>

            <h1>Has visitado la página <%= (contador > 0) ? contador : 0 %> <%= (contador == 1) ? "vez" : "veces" %></h1>

            <form action="sesiones.jsp" method="POST">
                <div class="gustos">
                    <input type="checkbox" value="Eliminar" name="gustos">&nbsp;&nbsp; Eliminar sesión
                </div>
                <div class="botones">
                    <input type="submit" name="enviar" value="Recargar"/> 
                    <input type="button" name="enviar" value="Menú inicial" onClick="location.href = '<%= request.getContextPath()%>'"/> 
                </div>
            </form>
        </div>
    </body>
</html>