<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.Cookie"%>
<%
    // Primero recibo la acción que el usuario ha seleccionado desde el formulario
    String accion = request.getParameter("crear") != null ? "crear" :
                    request.getParameter("visualizar") != null ? "visualizar" :
                    request.getParameter("modificar") != null ? "modificar" :
                    request.getParameter("eliminar") != null ? "eliminar" : null;

    // Recibo el nombre y el valor de la cookie desde los campos del formulario
    String nombre = request.getParameter("nombre");
    String valor = request.getParameter("valor");

    // Verifica si el nombre es nulo o vacío solo para la acción de creación
    if ("crear".equals(accion) && (nombre == null || nombre.trim().isEmpty())) {
        response.sendRedirect("menuCookie.jsp?mensaje=El nombre de la cookie no puede estar vacio.");
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

    // Verifico cuál es la acción que el usuario seleccionó
    if ("crear".equals(accion)) {
        if (cookieExists) {
            // Si la cookie ya existe, no permito crear otra
            response.sendRedirect("menuCookie.jsp?mensaje=La cookie ya existe. No se puede crear una nueva.");
        } else {
            // Creo la cookie y la añado a la respuesta
            Cookie cookie = new Cookie(nombre, valor);
            cookie.setMaxAge(3600); // Duración de la cookie
            response.addCookie(cookie); // Añado la cookie a la respuesta para que se guarde en el navegador
            response.sendRedirect("menuCookie.jsp?mensaje=La cookie ( " + nombre + " ) tiene un valor de ( " + valor + " )");
        }
    } else if ("visualizar".equals(accion)) {
        // Obtengo todas las cookies almacenadas en el navegador
        StringBuilder resultado = new StringBuilder();
        if (cookies != null) {
            for (Cookie c : cookies) {
                resultado.append("La cookie '").append(c.getName())
                         .append("' tiene el valor: '").append(c.getValue())
                         .append("'<br>");
            }
            request.setAttribute("resultado", resultado.toString());
        } else {
            request.setAttribute("resultado", "No hay cookies almacenadas.");
        }
        response.sendRedirect("menuCookie.jsp?mensaje=Cookies visualizadas con exito");
    } else if ("modificar".equals(accion)) {
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
            response.sendRedirect("menuCookie.jsp?mensaje=La cookie ( " + nombre + " ) modificada exitosamente a ( " + valor + " )");
        } else {
            response.sendRedirect("menuCookie.jsp?mensaje=La cookie no existe. No se puede modificar.");
        }
    } else if ("eliminar".equals(accion)) {
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
            response.sendRedirect("menuCookie.jsp?mensaje=La cookie ( " + nombre + " ) con valor ( " + valor + " ) se ha eliminado.");
        } else {
            response.sendRedirect("menuCookie.jsp?mensaje=La cookie no existe. No se puede eliminar.");
        }
    }
%>