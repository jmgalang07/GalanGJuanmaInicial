<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/resultNombre.css"/>
        <title>Mi nombre con cookie</title>
    </head>
    <body>
        <div id="contenedor">
            <%
                // Declaro una variable para almacenar la cookie y un booleano para verificar su existencia
                Cookie cookie = null;
                Boolean existe = false;

                // Obtengo todas las cookies del request
                Cookie[] cookiesArray = request.getCookies();
                // Verifico si hay cookies disponibles
                if (cookiesArray != null) {   // Esta comprobación es obligatoria
                    // Recorro el array de cookies para buscar la que me interesa
                    for (int i = 0; i < cookiesArray.length; i++) {
                        if (cookiesArray[i].getName().equals("nombreConCookie")) {
                            // Si encuentro la cookie, la asigno a la variable
                            cookie = cookiesArray[i];
                            break; // Salgo del bucle si la encuentro
                        }
                    }
                }

                // Si no encontré la cookie, la creo con un nombre y un valor
                if (cookie == null) {
                    cookie = new Cookie("nombreConCookie", URLEncoder.encode("Juan Manuel Galán Gómez", "UTF-8"));
                } else {
                    // Si la cookie existe, marco la variable como verdadera
                    existe = Boolean.TRUE;
                }

                // Establezco la duración de la cookie en segundos
                cookie.setMaxAge(10); // Puede ajustar el tiempo según sea necesario
                // Agrego la cookie a la respuesta
                response.addCookie(cookie);

                // Uso StringBuilder para crear el saludo
                StringBuilder persona = new StringBuilder();
                // Si la cookie existe, decodifico su valor y lo uso para el saludo
                if (existe) {
                    persona.append("Hola ").append(URLDecoder.decode(cookie.getValue(), "UTF-8"));
                } else {
                    // Si la cookie no existía, informo que no tengo los datos
                    persona.append("Todavía no tenemos tus datos.");
                }
            %>

            <h1><%=persona.toString()%></h1> <!-- Muestro el saludo en la página -->
            <form action="miNombre.jsp" method="POST"> <!-- Formulario para recargar la página -->
                <div class="botones">
                    <input type="submit" name="enviar" value="Recargar"/> <!-- Botón para recargar -->
                    <br><br>
                    <input type="button" name="enviar" value="Volver al menú" onClick="location.href = '<%= request.getContextPath()%>'"/> <!-- Botón para volver al menú -->
                </div>
            </form>
        </div>
    </body>
</html>