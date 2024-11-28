<%@page import="es.albarregas.beans.Usuario"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/menuSession.css"/>
        <title>Gestión de sesiones</title>
    </head>
    <body>
        <div id="contenedor1">
            <div class="titulo"><h1>Control de Sesiones</h1></div>

            <div class="primero">
                <!-- Inicio del formulario que manejará las acciones sobre los atributos de sesión -->
                <form action="controlSession.jsp" method="post">
                    <fieldset>
                        <legend>Atributo de sesión</legend>
                        <label>Nombre</label>
                        <!-- Aquí coloco un campo de búsqueda para encontrar el atributo de sesión -->
                        <%
                            // Obtengo el valor de "nombre" de la sesión.
                            String valorBusqueda = session.getAttribute("nombre") != null ? (String) session.getAttribute("nombre") : "";

                            // Verifico si hay un valor para hacer el campo de solo lectura.
                            boolean inputLectura = valorBusqueda != null && !valorBusqueda.isEmpty();
                        %>
                        <input type="search" name="buscar" id="buscar" placeholder="Ej. Atributo" 
                               value="<%= valorBusqueda%>" 
                               <% if (inputLectura) { %>readonly<% } %>/>

                        <%
                            // Verifico si el atributo 'atributoBloqueado' existe en la sesión y si es verdadero
                            Boolean atributoBloqueado = (Boolean) session.getAttribute("atributoBloqueado");
                            boolean botonDisabled = (atributoBloqueado != null && atributoBloqueado) || inputLectura; // Deshabilitar si está bloqueado o si el input es de solo lectura
                        %>
                        <!-- Botón "Buscar" que se deshabilita si 'atributoBloqueado' es verdadero o si el campo de búsqueda es de solo lectura -->
                        <input type="submit" name="action" value="Buscar" class="btn-buscar" 
                               <% if (botonDisabled) { %>disabled<% } %>/>
                    </fieldset>

                    <%
                        // Obtengo el usuario almacenado en la sesión
                        Usuario nuevoUsuario = (Usuario) session.getAttribute("nuevoUsuario");
                        // Verifico si se debe mostrar el formulario para crear un nuevo usuario
                        Boolean crear = session.getAttribute("crear") != null && (Boolean) session.getAttribute("crear");
                        // Verifico si se ha confirmado la eliminación de un usuario
                        Boolean confirmarEliminar = session.getAttribute("confirmarEliminar") != null && (Boolean) session.getAttribute("confirmarEliminar");
                    %>

                    <% if (crear || nuevoUsuario != null ) {%>
                    <fieldset class="medio">
                        <legend>Datos del atributo de sesión</legend>
                        <label for="nombreUsuario">Nombre</label>
                        <!-- Aquí muestro el campo para ingresar el nombre del usuario -->
                        <input type="text" name="nombreUsuario" id="nombreUsuario" placeholder="Ej. Juan" 
                               value="<%= nuevoUsuario != null ? nuevoUsuario.getNombre() : ""%>"/><br><br>
                        <label for="fechaNacimiento">Fecha de nacimiento</label>
                        <!-- Este campo es para seleccionar la fecha de nacimiento del usuario -->
                        <input type="date" name="fechaNacimiento" id="fechaNacimiento"
                               value="<%= nuevoUsuario != null ? nuevoUsuario.getFechaNacimiento() : ""%>"/><br><br>
                        <label for="numHijos">Número de hijos</label>
                        <!-- Aquí ingreso el número de hijos del usuario -->
                        <input type="number" name="numHijos" id="numHijos" min="0" 
                               value="<%= nuevoUsuario != null ? nuevoUsuario.getNumHijos() : ""%>"/><br><br>
                        <label for="salario">Salario</label>
                        <!-- Este campo permite ingresar el salario del usuario -->
                        <input type="number" name="salario" id="salario" min="0"  step="0.01" 
                               value="<%= nuevoUsuario != null ? nuevoUsuario.getSalario() : ""%>"/><br><br>
                    </fieldset>

                    <fieldset>
                        <legend>Acciones</legend>
                        <% if (confirmarEliminar) {%>
                        <!-- Muestro botones para confirmar o cancelar la eliminación -->
                        <input type="submit" name="action" value="Conforme">
                        <input type="submit" name="action" value="No realizar">
                        <input type="submit" name="action" value="Cancelar">
                        <input type="submit" name="action" value="Inicio"/>
                        <% } else if (crear) {%>
                        <!-- Muestro botones para crear un nuevo usuario -->
                        <input type="submit" name="action" value="Crear">
                        <input type="submit" name="action" value="Cancelar">
                        <input type="submit" name="action" value="Inicio"/>
                        <% } else if (nuevoUsuario != null) {%>
                        <!-- Muestro botones para modificar o eliminar un usuario existente -->
                        <input type="submit" name="action" value="Modificar">
                        <input type="submit" name="action" value="Eliminar">
                        <input type="submit" name="action" value="Cancelar">
                        <input type="submit" name="action" value="Inicio"/>
                        <% } %>
                    </fieldset>

                    <% } else {%>
                    <fieldset>
                        <legend>Acciones</legend>
                        <!-- Si no hay usuarios ni se está creando uno, solo muestro la opción de volver al inicio -->
                        <input type="submit" name="action" value="Inicio"/>
                    </fieldset>
                    <% }%>
                </form>
            </div>
            <!-- Muestro un mensaje de error si existe -->
            <%
                // Obtengo el mensaje de error almacenado en la sesión
                String errorMessage = (String) session.getAttribute("errorMessage");
                if (errorMessage != null) {
                    session.removeAttribute("errorMessage"); // Limpio el mensaje de error después de mostrarlo
%>
            <p style="color: red; font-weight: bold"><%= errorMessage%></p>
            <% }%>
        </div>
    </body>
</html>