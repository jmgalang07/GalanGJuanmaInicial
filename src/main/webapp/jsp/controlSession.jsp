<%@page import="java.time.LocalDate"%>
<%@page import="es.albarregas.beans.Usuario" %>
<%@page import="java.util.*" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String accion = request.getParameter("action"); // Obtengo la acción a realizar
    StringBuilder mensajes = new StringBuilder(); // Inicializo la variable para mensajes
    String valorBusqueda = request.getParameter("buscar"); // Obtengo el parámetro de búsqueda

    if (accion != null) { // Verifico si se ha recibido una acción
        if ("Buscar".equals(accion)) {
            if (!request.getParameter("buscar").isEmpty()) { // Verifico que el campo de búsqueda no esté vacío
                // Obtengo el atributo de sesión por el nombre ingresado en la búsqueda
                Usuario nuevoUsuario = (Usuario) session.getAttribute(valorBusqueda);
                if (nuevoUsuario == null) { // Si no encuentro el usuario
                    session.setAttribute("crear", true); // Muestro la opción para crear un nuevo usuario
                    session.removeAttribute("nuevoUsuario"); // Elimino el atributo del usuario actual
                } else { // Si el usuario existe
                    session.setAttribute("nuevoUsuario", nuevoUsuario); // Guardo el usuario en la sesión para modificarlo
                    session.setAttribute("crear", false); // Desactivo la opción de crear
                }
                session.setAttribute("nombre", valorBusqueda); // Guardo el nombre del atributo en la sesión
            } else {
                mensajes.append("¡El atributo de sesión está vacío!"); 
            }
        } else if ("Crear".equals(accion)) {
            // Verifico que todos los campos necesarios estén completos
            if (!request.getParameter("nombreUsuario").isEmpty()
                    && !request.getParameter("fechaNacimiento").isEmpty()
                    && !request.getParameter("numHijos").isEmpty()
                    && !request.getParameter("salario").isEmpty()) {

                String nombreUsuario = request.getParameter("nombreUsuario"); // Obtengo el nombre del usuario
                String fechaNacimiento = request.getParameter("fechaNacimiento"); // Obtengo la fecha de nacimiento
                int numHijos = Integer.parseInt(request.getParameter("numHijos")); // Obtengo el número de hijos
                double sueldoUsuario = Double.parseDouble(request.getParameter("salario")); // Obtengo el salario

                // Creo un nuevo usuario
                Usuario nuevoUsuario = new Usuario(nombreUsuario, LocalDate.parse(fechaNacimiento), numHijos, sueldoUsuario);
                session.setAttribute(valorBusqueda, nuevoUsuario); // Guardo el nuevo usuario en la sesión
                session.setAttribute("crear", false); // Desactivo el formulario de creación
                session.removeAttribute("nuevoUsuario"); // Elimino el atributo del usuario actual
                session.setAttribute("nombre", ""); // Limpio el campo de búsqueda
                mensajes.append("Atributo de sesión creado con nombre: '").append(valorBusqueda).append("' del usuario: ").append(nombreUsuario); 
            } else {
                mensajes.append("Todos los campos son obligatorios.");
            }
        } else if ("Modificar".equals(accion)) {
            String nombreUsuario = request.getParameter("nombreUsuario"); // Obtengo el nombre del usuario
            String fechaNacimiento = request.getParameter("fechaNacimiento"); // Obtengo la fecha de nacimiento
            int numHijos = Integer.parseInt(request.getParameter("numHijos")); // Obtengo el número de hijos
            double sueldoUsuario = Double.parseDouble(request.getParameter("salario")); // Obtengo el salario
            String nombre = (String) session.getAttribute("nombre"); // Obtengo el nombre guardado en la sesión

            Usuario nuevoUsuario = (Usuario) session.getAttribute(nombre); // Uso el nombre guardado en la sesión

            if (nuevoUsuario != null) { // Si el usuario existe
                nuevoUsuario.setNombre(nombreUsuario); // Actualizo el nombre
                nuevoUsuario.setFechaNacimiento(LocalDate.parse(fechaNacimiento)); // Actualizo la fecha de nacimiento
                nuevoUsuario.setNumHijos(numHijos); // Actualizo el número de hijos
                nuevoUsuario.setSalario(sueldoUsuario); // Actualizo el salario
                session.setAttribute(nombre, nuevoUsuario); // Actualizo los datos del usuario en la sesión
            }
            mensajes.append("Atributo de sesión con nombre: '").append(valorBusqueda).append("' modificado correctamente."); // Mensaje de éxito
            session.setAttribute("crear", false); // Desactivo el formulario de creación
            session.setAttribute("nombre", ""); // Limpio el campo de búsqueda
            session.removeAttribute("nuevoUsuario"); // Elimino el atributo del usuario actual
        } else if ("Eliminar".equals(accion)) { // Si la acción es "Eliminar"
            session.setAttribute("confirmarEliminar", true); // Confirmo la acción de eliminación
            session.setAttribute("nombre", valorBusqueda);  // Para recordar el nombre buscado
            // Redireccionar para manejar la acción en la otra página
        } else if ("Conforme".equals(accion)) {
            String nombre = (String) session.getAttribute("nombre"); // Obtengo el nombre guardado en la sesión
            session.removeAttribute(nombre); // Elimino el atributo de sesión
            session.removeAttribute("nuevoUsuario"); // Elimino el atributo del usuario actual
            session.removeAttribute("nombre"); // Elimino el atributo del nombre
            session.removeAttribute("confirmarEliminar"); // Elimino la confirmación de eliminación

            mensajes.append("Atributo de sesión con nombre: '").append(valorBusqueda).append("' eliminado correctamente."); 
            session.setAttribute("crear", false); // Desactivo el formulario de creación
        } else if ("No realizar".equals(accion) || "Cancelar".equals(accion)) { // Si la acción es "No realizar" o "Cancelar"
            session.removeAttribute("nuevoUsuario"); // Elimino el atributo del usuario actual
            session.removeAttribute("nombre"); // Elimino el atributo del nombre
            session.removeAttribute("confirmarEliminar"); // Elimino la confirmación de eliminación

            mensajes.append("Operación cancelada por el usuario.");
            session.setAttribute("crear", false); // Desactivo el formulario de creación
        } else if ("Inicio".equals(accion)) {
            session.invalidate(); // Invalido la sesión
            response.sendRedirect("../index.html"); // Redirijo al índice
            return; // Salgo del script
        }
    }

    // Almaceno el mensaje de error en la sesión y redirijo
    if (mensajes.length() > 0) { // Verifico si hay mensajes
        session.setAttribute("errorMessage", mensajes.toString()); // Guardo el mensaje de error en la sesión
    }

    response.sendRedirect("menuSession.jsp"); // Redirijo a la página del menú de sesiones
    return; // Salgo del script
%>