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
                // Inicializo el contador de sesiones desde la cookie
                Cookie[] cookiesArray = request.getCookies(); // Obtengo todas las cookies
                Integer contador = 0; // Inicializo el contador en 0 por defecto

                // Verifico si hay cookies existentes
                if (cookiesArray != null) { // Compruebo que haya cookies
                    for (Cookie c : cookiesArray) { // Itero a través de las cookies
                        if (c.getName().equals("contador")) { // Si encuentro la cookie del contador
                            // Decodifico el valor de la cookie y lo convierto a entero
                            contador = Integer.parseInt(URLDecoder.decode(c.getValue(), "UTF-8"));
                        }
                    }
                }

                // Obtengo la acción del formulario
                String action = request.getParameter("enviar");

                // Verifico si el checkbox está seleccionado para eliminar la sesión
                String gustos = request.getParameter("gustos");

                // Al pulsar "Recargar"
                if ("Recargar".equals(action)) {
                    // Incremento el contador solo si no se ha solicitado eliminar la sesión
                    if (gustos == null) {
                        contador++; // Aumento el contador
                    }
                }

                // Al pulsar "Eliminar"
                if ("Eliminar".equals(gustos)) {
                    // Aquí reinicio el contador y no almaceno el valor en la cookie
                    contador = 0; // Reinicio el contador a 0
                }

                // Creo o actualizo la cookie del contador
                // Almaceno el contador en una cookie
                Cookie contadorCookie = new Cookie("contador", URLEncoder.encode(contador.toString(), "UTF-8"));
                contadorCookie.setMaxAge(3600); // Establezco la caducidad de la cookie a 1 hora
                response.addCookie(contadorCookie); // Agrego la cookie a la respuesta
            %>

            <h1>Has visitado la página <%= (contador > 0) ? contador : 0%> <%= (contador == 1) ? "vez" : "veces"%></h1>

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