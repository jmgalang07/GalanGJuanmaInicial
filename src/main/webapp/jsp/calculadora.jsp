<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/calculadora.css"/>
        <title>Calculadora</title>
    </head>
    <body>
        <div id="contenido">
            <h2>CALCULADORA</h2>
            <%
                // Creo un objeto SimpleDateFormat para formatear la fecha
                SimpleDateFormat fecha = new SimpleDateFormat("EEEE d ' de' MMMM 'de' yyyy");
                // Obtengo la fecha actual y la formateo
                String fechaFormateada = fecha.format(Calendar.getInstance().getTime());
            %>
            <h3><%= fechaFormateada%></h3>

            <%-- Defino métodos para realizar operaciones matemáticas --%>
            <%!
                // Método para sumar dos números
                public int sumar(int param1, int param2) {
                    return param1 + param2;
                }

                // Método para restar dos números
                public int restar(int param1, int param2) {
                    return param1 - param2;
                }

                // Método para multiplicar dos números
                public int multiplicar(int param1, int param2) {
                    return param1 * param2;
                }

                // Método para dividir dos números, con manejo de excepción por división por cero
                public int dividir(int param1, int param2) {
                    if (param2 != 0) {
                        return param1 / param2;
                    } else {
                        throw new ArithmeticException("División por cero");
                    }
                }
            %>

            <%
                // Verifico si el formulario ha sido enviado
                if (request.getParameter("switch") == null) {
            %>
            <!-- Formulario para ingresar los números y seleccionar la operación -->
            <form method="post" action="calculadora.jsp">
                <input type="hidden" name="switch" value="true">
                <table>
                    <tr>
                        <td>Primer número:</td>
                        <td><input name="param1" type="text"></td>
                    </tr>
                    <tr>
                        <td>Segundo número:</td>
                        <td><input name="param2" type="text"></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <!-- Opciones para seleccionar la operación matemática -->
                            <input type="radio" name="operation" value="Sumar" checked> Sumar
                            <input type="radio" name="operation" value="Restar"> Restar
                            <input type="radio" name="operation" value="Multiplicar"> Multiplicar
                            <input type="radio" name="operation" value="Dividir"> Dividir
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <button type="submit">Enviar</button>
                        </td>
                    </tr>
                </table>
            </form>
            <%
            } else {
                // Si el formulario fue enviado, inicializo un StringBuilder para almacenar el resultado
                StringBuilder resultado = new StringBuilder();
                try {
                    // Obtengo los parámetros ingresados por el usuario
                    int param1 = Integer.parseInt(request.getParameter("param1"));
                    int param2 = Integer.parseInt(request.getParameter("param2"));
                    String operation = request.getParameter("operation");
                    int result = 0;

                    // Realizo la operación seleccionada
                    switch (operation) {
                        case "Sumar":
                            result = sumar(param1, param2);
                            resultado.append("<p>El resultado de la suma " + param1 + " + " + param2 + " es = " + result + "</p>");
                            break;
                        case "Restar":
                            result = restar(param1, param2);
                            resultado.append("<p>El resultado de la resta " + param1 + " - " + param2 + " es = " + result + "</p>");
                            break;
                        case "Multiplicar":
                            result = multiplicar(param1, param2);
                            resultado.append("<p>El resultado de la multiplicación " + param1 + " * " + param2 + " es = " + result + "</p>");
                            break;
                        case "Dividir":
                            result = dividir(param1, param2);
                            resultado.append("<p>El resultado de la división " + param1 + " / " + param2 + " es = " + result + "</p>");
                            break;
                        default:
                            resultado.append("<p>Operación no válida.</p>");
                    }
                } catch (NumberFormatException ex) {
                    // Manejo de error si no se introducen números válidos
                    resultado.append("<p>¡ERROR! Introduce un número...</p>");
                } catch (ArithmeticException ex) {
                    // Manejo de error para la división por cero
                    resultado.append("<p>" + ex.getMessage() + "</p>");
                }

            %>
            <!-- Muestra el resultado de la operación -->
            <%= resultado.toString()%>
            <%
                }
            %>
            <div class="botones">
                <!-- Enlaces para navegar al menú y reiniciar la calculadora -->
                <a href="<%=request.getContextPath()%>">Menú</a>
                <a href="calculadora.jsp">Calculadora</a>
            </div>
        </div>
    </body>
</html>