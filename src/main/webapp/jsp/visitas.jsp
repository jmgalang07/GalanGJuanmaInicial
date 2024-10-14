<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/visitas.css"/>
        <title>Contador visitas</title>
    </head>
    <body>
        <div id="contenedor">
            <%
                Cookie cookie = null; // Inicializo la variable para la cookie
                int contador = 0; // Inicializo el contador de visitas
                String action = request.getParameter("enviar"); // Obtengo la acción del formulario

                // Obtengo las cookies existentes
                Cookie[] cookiesArray = request.getCookies();
                if (cookiesArray != null) {
                    for (int i = 0; i < cookiesArray.length; i++) {
                        if (cookiesArray[i].getName().equals("contador")) {
                            // Decodifico el valor de la cookie contador
                            contador = Integer.parseInt(URLDecoder.decode(cookiesArray[i].getValue(), "UTF-8"));
                            cookie = cookiesArray[i]; // Almaceno la cookie del contador
                            break; // Salgo del bucle si encuentro la cookie
                        }
                    }
                }

                // Al pulsar "Eliminar", reinicio el contador
                if (action != null && action.equals("Eliminar")) {
                    contador = 1; // Reinicio el contador a 1
                    cookie = new Cookie("contador", URLEncoder.encode(String.valueOf(contador), "UTF-8")); // Creo una nueva cookie
                    cookie.setMaxAge(3600); // Establezco la caducidad a 3600 segundos
                    response.addCookie(cookie); // Agrego la cookie a la respuesta
                } else {
                    // Si no se elimina, incremento el contador
                    if (cookie == null) {
                        contador = 1; // Si no existe, inicio el contador en 1
                        cookie = new Cookie("contador", URLEncoder.encode(String.valueOf(contador), "UTF-8")); // Creo una nueva cookie
                        cookie.setMaxAge(3600); // Establezco la caducidad a 3600 segundos
                    } else {
                        contador++; // Incremento el contador
                        cookie.setValue(URLEncoder.encode(String.valueOf(contador), "UTF-8")); // Actualizo el valor de la cookie
                    }
                    response.addCookie(cookie); // Agrego la cookie a la respuesta
                }
            %>

            <h1>Has visitado la página <%= contador%> <%= (contador == 1) ? "vez" : "veces"%></h1>

            <% if (contador == 1) {%>
            <h2>Información de la cookie</h2>
            <h3>Caducidad: <%= cookie.getMaxAge()%> segundos</h3>
            <h4>Nombre: <%= cookie.getName()%></h4>
            <h5>Segura: <%= cookie.getSecure()%></h5>
            <h6>Versión: <%= cookie.getVersion()%></h6>
            <% }%>

            <form action="visitas.jsp" method="POST">
                <div class="botones">
                    <input type="submit" name="enviar" value="Recargar"/> 
                    <br><br>
                    <input type="submit" name="enviar" value="Eliminar"/> 
                    <br><br>
                    <input type="button" name="enviar" value="Menú inicial" onClick="location.href = '<%= request.getContextPath()%>'"/> 
                </div>
            </form>
        </div>
    </body>
</html>