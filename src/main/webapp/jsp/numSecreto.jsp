<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/numSecreto.css"/>
        <title>Número secreto</title>
    </head>
    <body>
        <div id="contenedor">
            <h1>Juego del número secreto</h1>
            <p>El ordenador "piensa" un número y tenemos que averiguarlo en la menor cantidad de intentos posible</p>
            <%
                Integer numeroSecreto = null; // Declaro la variable para el número secreto
                Integer intentos = 0; // Declaro el contador de intentos
                String mensaje = ""; // Declaro el mensaje que se mostrará al usuario
                List<String> historial = new ArrayList<>(); // Inicializo una lista para el historial de intentos

                // Obtengo los valores del formulario
                String inputNumeroSecreto = request.getParameter("numeroSecreto");
                String inputIntentos = request.getParameter("intentos");
                String inputHistorial = request.getParameter("historial");
                String inputNumero = request.getParameter("numero");

                // Verifico si ya se ha proporcionado un número secreto
                if (inputNumeroSecreto != null) {
                    // Si existe, lo obtengo del formulario
                    numeroSecreto = Integer.parseInt(inputNumeroSecreto);
                    if (inputIntentos != null) {
                        intentos = Integer.parseInt(inputIntentos); // Obtengo el contador de intentos
                    }
                    if (inputHistorial != null) {
                        // Divido el historial en registros y los agrego a la lista
                        String[] registros = inputHistorial.split(",");
                        for (String registro : registros) {
                            historial.add(registro); // Agrego cada registro al historial
                        }
                    }
                } else {
                    // Si no existe, genero un nuevo número secreto aleatorio entre 1 y 100
                    numeroSecreto = (int) (Math.random() * 100) + 1;
                }

                // Proceso el número ingresado por el usuario
                if (inputNumero != null && !inputNumero.isEmpty()) {
                    try {
                        int numeroUsuario = Integer.parseInt(inputNumero); // Convierto el número ingresado a entero
                        intentos++; // Incremento el contador de intentos

                        // Verifico si el número ingresado es el correcto
                        if (numeroUsuario == numeroSecreto) {
                            mensaje = "Acertado"; // Mensaje si el usuario acierta
                            historial.add(numeroUsuario + " - " + mensaje); // Agrego al historial
                        } else if (numeroUsuario > numeroSecreto) {
                            mensaje = "El que he pensado es menor"; // Mensaje si el número es mayor
                            historial.add(numeroUsuario + " - " + mensaje);
                        } else {
                            mensaje = "El que he pensado es mayor"; // Mensaje si el número es menor
                            historial.add(numeroUsuario + " - " + mensaje);
                        }
                    } catch (NumberFormatException e) {
                        // Manejo el error si el número no es válido
                        mensaje = "Por favor, introduce un número válido.";
                    }
                }
            %>

            <form method="POST" action="numSecreto.jsp">
                <input type="hidden" name="numeroSecreto" value="<%= numeroSecreto%>"> <!-- Almaceno el número secreto -->
                <input type="hidden" name="intentos" value="<%= intentos%>"> <!-- Almaceno el contador de intentos -->
                <input type="hidden" name="historial" value="<%= String.join(",", historial)%>"> <!-- Almaceno el historial -->

                <% if (mensaje.equals("Acertado")) {%>
                <button type="submit" name="reiniciar" value="true">Inicio</button> 
                <% } else { %>
                <p>Introduce un número de 1 a 100: <input type="number" name="numero" min="1" max="100" required></p>
                <button type="submit">Comprobar</button>
                <% } %>
            </form>

            <% if (!historial.isEmpty()) { %>
            <table>
                <thead>
                    <tr>
                        <th>Número</th>
                        <th>Mensaje</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (String registro : historial) { %>
                    <%
                        // Verifico que el registro contenga el separador correcto
                        String[] partes = registro.split(" - ");
                        if (partes.length == 2) {%>
                    <tr>
                        <td><%= partes[0]%></td>
                        <td><%= partes[1]%></td>
                    </tr>
                    <% } %>
                    <% } %>
                </tbody>
            </table>
            <% } %>

            <% if (mensaje.equals("Acertado")) {%>
            <p>Conseguido en <%= intentos%> intentos</p> <!-- Muestro los intentos realizados -->
            <% } %>

            <%
                // Reinicio el juego cuando presiono el botón "Reiniciar"
                if ("true".equals(request.getParameter("reiniciar"))) {
                    // Redirijo a la misma página para reiniciar el juego
                    response.sendRedirect("numSecreto.jsp");
                }
            %>
        </div>
    </body>
</html>