<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                double precioProducto = Double.parseDouble(request.getParameter("precio"));
                double entregado = Double.parseDouble(request.getParameter("numeroEntregado"));
                double cambio = entregado - precioProducto;

                if (cambio < 0) {
                    out.println("<h2>El dinero entregado es insuficiente.</h2>");
                } else if (cambio == 0) {
                    out.println("<h2>No hay cambio que devolver.</h2>");
                } else {
                    out.println("<h2>El cambio a devolver es: " + cambio + " €</h2>");
                    out.println("<div class='monedas-contenedor'>");

                    double empezar = 500;
                    int dineroRestar;

                    while (cambio > 0.009) {
                        dineroRestar = (int)(cambio / empezar); 
                        if (dineroRestar > 0) {
                            cambio -= dineroRestar * empezar; 
                            cambio = Math.round(cambio * 100.0) / 100.0; // Redondeo para evitar errores

                            out.println("<div class='moneda-billete'>");
                            out.println("<span class='cantidad'>" + dineroRestar + "</span>");

                            //Muestro la imagen
                            if (empezar >= 2) {
                                out.println("<img src='../img/" + (int)empezar + "euros.jpg' alt='" + empezar + " €' class='img-monedas'>");
                            } else if (empezar == 1) {
                                out.println("<img src='../img/1euros.jpg' alt='1 €' class='img-monedas'>");
                            } else {
                                out.println("<img src='../img/" + ((int)(empezar * 100)) + "centimos.jpg' alt='" + empezar + " €' class='img-monedas'>");
                            }

                            out.println("</div>");
                        }

                        // Disminuir la denominación para la siguiente iteración
                        if (empezar == 500) empezar = 200;
                        else if (empezar == 200) empezar = 100;
                        else if (empezar == 100) empezar = 50;
                        else if (empezar == 50) empezar = 20;
                        else if (empezar == 20) empezar = 10;
                        else if (empezar == 10) empezar = 5;
                        else if (empezar == 5) empezar = 2;
                        else if (empezar == 2) empezar = 1;
                        else if (empezar == 1) empezar = 0.50;
                        else if (empezar == 0.50) empezar = 0.20;
                        else if (empezar == 0.20) empezar = 0.10;
                        else if (empezar == 0.10) empezar = 0.05;
                        else if (empezar == 0.05) empezar = 0.02;
                        else if (empezar == 0.02) empezar = 0.01;
                    }
                    out.println("</div>");
                }
            %>
            <a href="../html/monedero.html">Volver al monedero</a>
            <p><a href="<%= request.getContextPath()%>">Menú</a></p>
        </div>
    </body>
</html>