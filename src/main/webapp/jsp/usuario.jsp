<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/usuario.css"/>
        <title>Contador visitas</title>
    </head>
    <body>
        <div id="contenedor">
            <h1>Proceso de identificación</h1>
            <%
                // Inicializo variables para manejar las cookies y el contador
                Cookie cookie = null; // Declaro una variable cookie
                int contador = 0; // Inicializo el contador a 0
                String action = request.getParameter("enviar"); // Obtengo el parámetro de acción del formulario
                String usuarioGuardado = ""; // Inicializo la variable para el usuario guardado
                String usuarioFormulario = request.getParameter("usuario"); // Obtengo el usuario ingresado en el formulario
                String guardarUsuario = request.getParameter("recordarUsuario"); // Obtengo el valor del checkbox para recordar el usuario

                // Verifico si el formulario ha sido enviado
                boolean formularioEnviado = (action != null && action.equals("Enviar")); // Compruebo si la acción es "Enviar"

                // Obtengo las cookies existentes para recuperar el contador y el usuario guardado
                Cookie[] cookiesArray = request.getCookies(); // Obtengo todas las cookies
                if (cookiesArray != null) { // Verifico que haya cookies
                    for (Cookie c : cookiesArray) { // Itero a través de las cookies
                        if (c.getName().equals("contador")) { // Si la cookie es del contador
                            // Decodifico el valor de la cookie contador
                            contador = Integer.parseInt(URLDecoder.decode(c.getValue(), "UTF-8")); // Decodifico y convierto a entero
                            cookie = c; // Almaceno la cookie del contador
                        }
                        if (cookie.getName().equals("usuario")) { // Si la cookie es del usuario
                            // Decodifico el valor de la cookie usuario
                            usuarioGuardado = URLDecoder.decode(c.getValue(), "UTF-8"); // Decodifico el usuario guardado
                        }
                    }
                }

                // Si el checkbox está marcado, guardo el usuario en la cookie
                if (guardarUsuario != null && guardarUsuario.equals("on")) { // Verifico si el checkbox está activado
                    if (usuarioFormulario != null && !usuarioFormulario.trim().isEmpty()) { // Verifico que el usuario no esté vacío
                        // Creo una nueva cookie para el usuario
                        Cookie usuarioCookie = new Cookie("usuario", URLEncoder.encode(usuarioFormulario, "UTF-8")); // Codifico el usuario
                        usuarioCookie.setMaxAge(3600); // Establezco la caducidad a 1 hora
                        response.addCookie(usuarioCookie); // Agrego la cookie a la respuesta
                        // Actualizo el valor del usuario guardado
                        usuarioGuardado = usuarioFormulario; // Actualizo el usuario guardado
                    }
                }

                // Creo o actualizo la cookie del contador
                cookie = new Cookie("contador", URLEncoder.encode("1", "UTF-8")); // Reinicio el contador a 1
                cookie.setMaxAge(10); // Establezco la caducidad a 10 segundos
                response.addCookie(cookie); // Agrego la cookie del contador a la respuesta
%>

            <form action="usuario.jsp" method="POST">
                <label>Usuario: </label>
                <input type="text" name="usuario" value="<%= usuarioGuardado%>"/>  

                <br><br>

                <label>Contraseña: </label>
                <input type="password" name="contrasenia"/>

                <br><br>

                <!-- El checkbox solo se desactiva después de que se guarde el usuario, no al cargar por primera vez -->
                <input type="checkbox" name="recordarUsuario" 
                       <%= (formularioEnviado && !usuarioGuardado.isEmpty() ? "checked disabled" : "")%> />&nbsp;&nbsp; Recordar usuario

                <div class="botones">
                    <input type="submit" name="enviar" value="Enviar"/> 
                    <br><br>
                    <input type="button" name="enviar" value="Inicio" onClick="location.href = '<%= request.getContextPath()%>'"/> 
                </div>
            </form>
        </div>
    </body>
</html>