<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.NumberFormat, java.util.Locale" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Resultado de la Conversión</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/css/resultDivisas.css"/>
    </head>
    <body>
        <div class="container">
            <h1>Calculadora de divisas</h1>

            <%
                // Comprueba si se han enviado los datos
                String cantidadStr = request.getParameter("numero");
                String divisaOrigen = request.getParameter("moneda");
                String divisaDestino = request.getParameter("monedas");

                // Si los parámetros son nulos o vacíos, muestra el formulario de nuevo
                if (cantidadStr == null || cantidadStr.isEmpty() || divisaOrigen == null || divisaDestino == null) {
            %>
            <p>Error: Debes completar el formulario para realizar la conversión.</p>
            <a href="<%= request.getContextPath()%>/html/divisas.html">Volver al formulario</a>
            <%
                    return; // Detiene la ejecución del JSP
                }

                double cantidad = Double.parseDouble(cantidadStr);

                // Tasas de cambio
                double tasaEurosADolares = 1.10;
                double tasaEurosAYenes = 130.50;
                double tasaEurosALibras = 0.85;

                double tasaDolaresAEuros = 0.91;
                double tasaDolaresAYenes = 118.60;
                double tasaDolaresALibras = 0.77;

                double tasaYenesAEuros = 0.0077;
                double tasaYenesADolares = 0.0084;
                double tasaYenesALibras = 0.0065;

                double tasaLibrasAEuros = 1.18;
                double tasaLibrasADolares = 1.30;
                double tasaLibrasAYenes = 153.20;

                // Variable para el resultado final
                double resultado = 0.0;

                // Formatear los números usando el formato español
                NumberFormat formateador = NumberFormat.getInstance(new Locale("es", "ES"));

                // Lógica para convertir divisas o mantener el valor si son iguales
                if (divisaOrigen.equals(divisaDestino)) {
                    // Si la divisa de origen y destino son iguales, el resultado es la misma cantidad
                    resultado = cantidad;
                } else if (divisaOrigen.equals("EUR")) {
                    if (divisaDestino.equals("USD")) {
                        resultado = cantidad * tasaEurosADolares;
                    } else if (divisaDestino.equals("JPY")) {
                        resultado = cantidad * tasaEurosAYenes;
                    } else if (divisaDestino.equals("GBP")) {
                        resultado = cantidad * tasaEurosALibras;
                    }
                } else if (divisaOrigen.equals("USD")) {
                    if (divisaDestino.equals("EUR")) {
                        resultado = cantidad * tasaDolaresAEuros;
                    } else if (divisaDestino.equals("JPY")) {
                        resultado = cantidad * tasaDolaresAYenes;
                    } else if (divisaDestino.equals("GBP")) {
                        resultado = cantidad * tasaDolaresALibras;
                    }
                } else if (divisaOrigen.equals("JPY")) {
                    if (divisaDestino.equals("EUR")) {
                        resultado = cantidad * tasaYenesAEuros;
                    } else if (divisaDestino.equals("USD")) {
                        resultado = cantidad * tasaYenesADolares;
                    } else if (divisaDestino.equals("GBP")) {
                        resultado = cantidad * tasaYenesALibras;
                    }
                } else if (divisaOrigen.equals("GBP")) {
                    if (divisaDestino.equals("EUR")) {
                        resultado = cantidad * tasaLibrasAEuros;
                    } else if (divisaDestino.equals("USD")) {
                        resultado = cantidad * tasaLibrasADolares;
                    } else if (divisaDestino.equals("JPY")) {
                        resultado = cantidad * tasaLibrasAYenes;
                    }
                }

                // Muestra el resultado
                if (resultado != 0.0) {
            %>
            <p><%= formateador.format(cantidad) %> <%= divisaOrigen %> son <%= formateador.format(resultado) %> <%= divisaDestino %>.</p>
            <%
            } else {
            %>
            <p>No se pudo realizar la conversión. Por favor, revisa las divisas seleccionadas.</p>
            <%
                }
            %>
            <a href="../html/divisas.html">Volver al formulario</a>
            <p><a href="<%= request.getContextPath()%>">Menú</a></p>
        </div>
    </body>
</html>