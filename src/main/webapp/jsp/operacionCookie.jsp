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
    String action = request.getParameter("enviar");
    
    if ("Crear".equals(action)) {
        if (cookieExists) {
            mensaje.append("La cookie ya existe. No se puede crear una nueva.");
        } else {
            Cookie cookie = new Cookie(nombre, valor);
            cookie.setMaxAge(3600); // Duración de la cookie
            response.addCookie(cookie); 
            mensaje.append("La cookie ( ").append(nombre).append(" ) tiene un valor de ( ").append(valor).append(" ).");
        }
    } else if ("Visualizar".equals(action)) {
        if (cookies != null) {
            for (Cookie c : cookies) {
                mensaje.append("La cookie '").append(c.getName())
                        .append("' tiene el valor: '").append(c.getValue()).append("'<br>");
            }
            mensaje.append("Cookies visualizadas con éxito.");
        } else {
            mensaje.append("No hay cookies almacenadas.");
        }
    } else if ("Modificar".equals(action)) {
        boolean cookieFound = false;
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals(nombre)) {
                    c.setValue(valor);
                    response.addCookie(c);
                    cookieFound = true;
                    break;
                }
            }
        }
        if (cookieFound) {
            mensaje.append("La cookie ( ").append(nombre).append(" ) modificada exitosamente a ( ").append(valor).append(" ).");
        } else {
            mensaje.append("La cookie no existe. No se puede modificar.");
        }
    } else if ("Eliminar".equals(action)) {
        boolean cookieDeleted = false;
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals(nombre)) {
                    c.setMaxAge(0); // Elimino la cookie
                    response.addCookie(c);
                    cookieDeleted = true;
                    break;
                }
            }
        }
        if (cookieDeleted) {
            mensaje.append("La cookie ( ").append(nombre).append(" ) se ha eliminado.");
        } else {
            mensaje.append("La cookie no existe. No se puede eliminar.");
        }
    } else if ("Indice".equals(action)) {
        mensaje.replace(0, mensaje.length(), request.getContextPath());
    }

    // Redirecciono con el mensaje ya construido
    response.sendRedirect(mensaje.toString());
%>
