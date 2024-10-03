<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Locale" %>
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
                SimpleDateFormat fecha = new SimpleDateFormat("dd 'de' MMMM 'de' yyyy", new Locale("es", "ES"));
                String fechaFormateada = fecha.format(Calendar.getInstance().getTime());
            %>
            <h3><%= fechaFormateada%></h3>

            <%-- Métodos para operaciones matemáticas --%>
            <%!
                public int sumar(int param1, int param2) {
                    return param1 + param2;
                }

                public int restar(int param1, int param2) {
                    return param1 - param2;
                }

                public int multiplicar(int param1, int param2) {
                    return param1 * param2;
                }

                public int dividir(int param1, int param2) {
                    if (param2 != 0) {
                        return param1 / param2;
                    } else {
                        throw new ArithmeticException("División por cero");
                    }
                }
            %>

            <%
                if (request.getParameter("switch") == null) {
            %>
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
                            <input type="radio" name="operation" value="Sumar" checked> Sumar
                            <input type="radio" name="operation" value="Restar"> Restar
                            <input type="radio" name="operation" value="Multiplicar"> Multiplicar
                            <input type="radio" name="operation" value="Dividir"> Dividir
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <button type="submit">Calcular</button>
                        </td>
                    </tr>
                </table>
                <p><a href="<%=request.getContextPath()%>">Menú</a></p>
            </form>
            <%
            } else {
                try {
                    int param1 = Integer.parseInt(request.getParameter("param1"));
                    int param2 = Integer.parseInt(request.getParameter("param2"));
                    String operation = request.getParameter("operation");
                    int result = 0;

                    switch (operation) {
                        case "Sumar":
                            result = sumar(param1, param2);
                            out.println("<p>El resultado de la suma " + param1 + " + " + param2 + " es = " + result + "</p>");
                            break;
                        case "Restar":
                            result = restar(param1, param2);
                            out.println("<p>El resultado de la resta " + param1 + " - " + param2 + " es = " + result + "</p>");
                            break;
                        case "Multiplicar":
                            result = multiplicar(param1, param2);
                            out.println("<p>El resultado de la multiplicación " + param1 + " * " + param2 + " es = " + result + "</p>");
                            break;
                        case "Dividir":
                            result = dividir(param1, param2);
                            out.println("<p>El resultado de la división " + param1 + " / " + param2 + " es = " + result + "</p>");
                            break;
                        default:
                            out.println("<p>Operación no válida.</p>");
                    }
                } catch (NumberFormatException ex) {
            %>
            <p>¡ERROR! Introduce un número...</p>
            <%
            } catch (ArithmeticException ex) {
            %>
            <p><%= ex.getMessage()%></p>
            <%
                }
            %>

            <a href="calculadora.jsp">Calculadora</a>
            <a href="<%=request.getContextPath()%>">Menú</a>
            <%
                }
            %>
        </div>
    </body>
</html>