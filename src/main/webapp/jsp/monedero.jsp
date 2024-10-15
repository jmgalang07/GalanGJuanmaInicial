<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/resultMonedero.css"/>
        <title>Monedero</title>
    </head>
    <body>
        <div id="contenedor">
            <h1>🪙 Cambio de Monedas y Billetes 💵</h1>
            <%
                // Creo un StringBuilder para acumular los resultados
                StringBuilder resultado = new StringBuilder();

                // Obtengo el precio del producto y el dinero entregado desde los parámetros de la solicitud
                double precioProducto = Double.parseDouble(request.getParameter("precio"));
                double entregado = Double.parseDouble(request.getParameter("numeroEntregado"));

                // Calculo el cambio a devolver
                double cambio = entregado - precioProducto;

                // Utilizo un formateador para mostrar dos decimales
                DecimalFormat df = new DecimalFormat("0.00");

                // Verifico si el dinero entregado es insuficiente
                if (cambio < 0) {
                    resultado.append("<h2>El dinero entregado es insuficiente.</h2>");
                } // Verifico si no hay cambio que devolver
                else if (cambio == 0) {
                    resultado.append("<h2>No hay cambio que devolver.</h2>");
                } // Si hay cambio, calculo y muestro las denominaciones a devolver
                else {
                    resultado.append("<h2>El cambio a devolver es: " + df.format(cambio) + " €</h2>");
                    resultado.append("<div class='monedas-contenedor'>");

                    // Establezco la denominación inicial (500 euros)
                    double denominacion = 500;
                    int dineroRestar;

                    // Mientras haya cambio que devolver
                    while (cambio > 0.009) {
                        // Calculo cuántas denominaciones se pueden devolver
                        dineroRestar = (int) (cambio / denominacion);

                        // Si hay dinero a devolver de esa denominación
                        if (dineroRestar > 0) {
                            // Reduzco el cambio a devolver
                            cambio -= dineroRestar * denominacion;
                            // Redondeo el cambio para evitar errores
                            cambio = Math.round(cambio * 100.0) / 100.0;

                            // Agrego la cantidad de monedas/billetes a los resultados
                            resultado.append("<div class='moneda-billete'>");
                            resultado.append("<span class='cantidad'>" + dineroRestar + "</span>");

                            // Muestro la imagen correspondiente a la denominación
                            if (denominacion >= 2) {
                                resultado.append("<img src='../img/" + (int) denominacion + "euros.jpg' alt='" + denominacion + " €' class='img-monedas'>");
                            } else if (denominacion == 1) {
                                resultado.append("<img src='../img/1euros.jpg' alt='1 €' class='img-monedas'>");
                            } else {
                                resultado.append("<img src='../img/" + ((int) (denominacion * 100)) + "centimos.jpg' alt='" + denominacion + " €' class='img-monedas'>");
                            }
                            resultado.append("</div>");
                        }

                        // Disminuyo la denominación para la siguiente iteración
                        if (denominacion == 500) denominacion = 200;
                        else if (denominacion == 200) denominacion = 100;
                        else if (denominacion == 100) denominacion = 50;
                        else if (denominacion == 50) denominacion = 20;
                        else if (denominacion == 20) denominacion = 10;
                        else if (denominacion == 10) denominacion = 5;
                        else if (denominacion == 5) denominacion = 2;
                        else if (denominacion == 2) denominacion = 1;
                        else if (denominacion == 1) denominacion = 0.50;
                        else if (denominacion == 0.50) denominacion = 0.20;
                        else if (denominacion == 0.20) denominacion = 0.10;
                        else if (denominacion == 0.10) denominacion = 0.05;
                        else if (denominacion == 0.05) denominacion = 0.02;
                        else if (denominacion == 0.02) denominacion = 0.01;
                    }

                    resultado.append("</div>");
                }

                // Finalmente, imprimo el contenido acumulado en el StringBuilder
%>
            <%= resultado.toString()%> 

            <div class="botones">
                <input type="submit" name="enviar" value="Volver al monedero" onClick="location.href = '../html/monedero.html'"/> 
                <input type="button" name="enviar" value="Menú" onClick="location.href = '<%= request.getContextPath()%>'"/>
            </div>
        </div>
    </body>
</html> 