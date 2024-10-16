<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.Cookie"%>
<%
    // Recibo el nombre y el valor de la cookie desde los campos del formulario
    String nombre = request.getParameter("nombre");
    String valor = request.getParameter("valor");

    // Para crear el mensaje
    StringBuilder mensaje = new StringBuilder("menuCookie.jsp?mensaje=");

    // Verifica si el nombre es nulo o vacío solo para la acción de creación
    if (request.getParameter("enviar").equals("Crear") && (nombre == null || nombre.trim().isEmpty())) {
        mensaje.append("El nombre de la cookie no puede estar vacío.");
        response.sendRedirect(mensaje.toString());
        return; // Termina la ejecución
    }

    // Verifico si ya existe una cookie
    boolean cookieExists = false;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if (c.getName().equals(nombre)) {
                cookieExists = true;
                break;
            }
        }
    }

    // Verifico la acción del usuario con el parámetro "enviar"
    if (request.getParameter("enviar").equals("Crear")) {
        if (cookieExists) {
            // Si la cookie ya existe, no permito crear otra
            mensaje.append("La cookie ya existe. No se puede crear una nueva.");
        } else {
            // Creo la cookie y la añado a la respuesta
            Cookie cookie = new Cookie(nombre, valor);
            cookie.setMaxAge(3600); // Duración de la cookie
            response.addCookie(cookie); // Añado la cookie a la respuesta para que se guarde en el navegador
            mensaje.append("La cookie ( ").append(nombre).append(" ) tiene un valor de ( ").append(valor).append(" )");
        }
    } else if (request.getParameter("enviar").equals("Visualizar")) {
        // Obtengo todas las cookies almacenadas en el navegador
        StringBuilder resultado = new StringBuilder();
        if (cookies != null) {
            for (Cookie c : cookies) {
                resultado.append("La cookie '").append(c.getName())
                         .append("' tiene el valor: '").append(c.getValue())
                         .append("'<br>");
            }
            request.setAttribute("resultado", resultado.toString());
            mensaje.append("Cookies visualizadas con éxito.");
        } else {
            mensaje.append("No hay cookies almacenadas.");
        }
    } else if (request.getParameter("enviar").equals("Modificar")) {
        boolean cookieFound = false;
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals(nombre)) {
                    c.setValue(valor);
                    response.addCookie(c); // Vuelvo a añadir la cookie modificada
                    cookieFound = true;
                    break;
                }
            }
        }
        if (cookieFound) {
            mensaje.append("La cookie ( ").append(nombre).append(" ) modificada exitosamente a ( ").append(valor).append(" )");
        } else {
            mensaje.append("La cookie no existe. No se puede modificar.");
        }
    } else if (request.getParameter("enviar").equals("Eliminar")) {
        boolean cookieDeleted = false;
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals(nombre)) {
                    c.setMaxAge(0); // Elimino la cookie
                    response.addCookie(c); // Añado la cookie eliminada a la respuesta
                    cookieDeleted = true;
                    break;
                }
            }
        }
        if (cookieDeleted) {
            mensaje.append("La cookie ( ").append(nombre).append(" ) con valor ( ").append(valor).append(" ) se ha eliminado.");
        } else {
            mensaje.append("La cookie no existe. No se puede eliminar.");
        }
    } else if (request.getParameter("enviar").equals("Indice")) {
        // Reemplazo el contenido de mensaje con el contexto de la aplicación
        mensaje.replace(0, mensaje.length(), request.getContextPath());
    }

    // Realizo el redireccionamiento con el mensaje ya construido
    response.sendRedirect(mensaje.toString());
%>