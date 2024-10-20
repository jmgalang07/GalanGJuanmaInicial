<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.Cookie"%>
<%
    // Recibo el nombre y el valor de la cookie desde los campos del formulario
    String nombre = request.getParameter("nombre");
    String valor = request.getParameter("valor");

    // Creo un StringBuilder para construir el mensaje que enviaré
    StringBuilder mensaje = new StringBuilder("menuCookie.jsp?mensaje=");

    // Verifico si el nombre es nulo o vacío solo para la acción de creación
    if ("Crear".equals(request.getParameter("enviar")) && (nombre == null || nombre.trim().isEmpty())) {
        mensaje.append("El nombre de la cookie no puede estar vacío.");
        response.sendRedirect(mensaje.toString());
        return; // Termino la ejecución aquí si el nombre está vacío
    }

    // Verifico si ya existe una cookie con el nombre dado
    boolean cookieExists = false;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if (c.getName().equals(nombre)) {
                cookieExists = true; // Encuentro la cookie y actualizo la variable
                break;
            }
        }
    }

    // Verifico la acción del usuario con el parámetro "enviar"
    String action = request.getParameter("enviar");

    // Si el usuario quiere crear una nueva cookie
    if ("Crear".equals(action)) {
        if (cookieExists) {
            mensaje.append("La cookie ya existe. No se puede crear una nueva.");
        } else {
            // Creo una nueva cookie
            Cookie cookie = new Cookie(nombre, valor);
            cookie.setMaxAge(3600); // Establezco la duración de la cookie a 1 hora
            response.addCookie(cookie); // Agrego la cookie a la respuesta
            mensaje.append("La cookie ( ").append(nombre).append(" ) tiene un valor de ( ").append(valor).append(" ).");
        }
    } else if ("Visualizar".equals(action)) {
        // Si el usuario quiere visualizar una cookie
        if (cookieExists) {
            for (Cookie c : cookies) {
                if (c.getName().equals(nombre)) {
                    mensaje.append("La cookie '").append(c.getName())
                            .append("' tiene el valor: '").append(c.getValue()).append("'"); // Muestro el valor de la cookie
                    break; // Salgo del bucle una vez que encuentro la cookie
                }
            }
        } else {
            mensaje.append("No se puede visualizar la cookie porque no está creada."); // Mensaje si la cookie no existe
        }
    } else if ("Modificar".equals(action)) {
        boolean cookieFound = false;
        // Si el usuario quiere modificar una cookie
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals(nombre)) {
                    c.setValue(valor); // Modifico el valor de la cookie
                    response.addCookie(c); // Actualizo la cookie en la respuesta
                    cookieFound = true; // Encuentro la cookie
                    break;
                }
            }
        }
        if (cookieFound) {
            mensaje.append("La cookie ( ").append(nombre).append(" ) ha sido modificada exitosamente a ( ").append(valor).append(" ).");
        } else {
            mensaje.append("La cookie no existe. No se puede modificar."); // Mensaje si no existe la cookie
        }
    } else if ("Eliminar".equals(action)) {
        boolean cookieDeleted = false;
        // Si el usuario quiere eliminar una cookie
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals(nombre)) {
                    c.setMaxAge(0); // Elimino la cookie
                    response.addCookie(c); // Actualizo la respuesta
                    cookieDeleted = true; // Encuentro la cookie
                    break;
                }
            }
        }
        if (cookieDeleted) {
            mensaje.append("La cookie ( ").append(nombre).append(" ) se ha eliminado.");
        } else {
            mensaje.append("La cookie no existe. No se puede eliminar."); // Mensaje si no existe la cookie
        }
    } else if ("Indice".equals(action)) {
        mensaje.replace(0, mensaje.length(), request.getContextPath()); // Redirecciono a la página de índice
    }

    // Redirecciono con el mensaje ya construido
    response.sendRedirect(mensaje.toString());
%>