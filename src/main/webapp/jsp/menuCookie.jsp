<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/menuCookie.css"/>
        <title>Menu Cookie</title>
    </head>
    <body>
        <div id="contenedor">
            <h1>Control de Cookies</h1>

            <!-- Este formulario envía los datos a operacionCookie.jsp para procesarlos -->
            <form action="operacionCookie.jsp" method="POST">
                <!-- Campo para ingresar el nombre de la cookie -->
                <label>Nombre de la cookie: </label>
                <input type="text" name="nombre"/>  

                <br><br>

                <!-- Campo para ingresar el valor de la cookie -->
                <label>Valor de la cookie: </label>
                <input type="text" name="valor"/> 

                <br>

                <!-- Botones de acción -->
                <div class="botones">
                    <input type="submit" name="enviar" value="Crear"/> 
                    <input type="submit" name="enviar" value="Visualizar"/> 
                    <input type="submit" name="enviar" value="Modificar"/> 
                    <input type="submit" name="enviar" value="Eliminar"/> 
                    <input type="submit" name="enviar" value="Indice" onClick="location.href = '<%= request.getContextPath()%>'"/>
                </div>

                <!-- Aquí muestro cualquier mensaje que se haya pasado desde operacionCookie.jsp -->
                <%
                    String mensaje = request.getParameter("mensaje");
                    if (mensaje != null) {
                        out.println("<p>" + mensaje + "</p>");
                    }

                    // Muestro el resultado si se visualizan las cookies
                    String resultado = (String) request.getAttribute("resultado");
                    if (resultado != null) {
                        out.println("<div>" + resultado + "</div>");
                    }
                %>
            </form>
        </div>
    </body>
</html>