<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Period"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<%=request.getContextPath()%>/css/resultEdad.css" rel="stylesheet"/>
        <title>Edades</title>
    </head>
    <body>
        <div class="container">
            <%
                // Obtengo el nombre desde el formulario
                String nombre = request.getParameter("nombre");

                // Obtengo la fecha actual
                LocalDate fechaActual = LocalDate.now();

                // Obtengo la fecha de nacimiento del formulario
                String fechaNacimientoStr = request.getParameter("fecha_nacimiento");

                if (fechaNacimientoStr != null && !fechaNacimientoStr.isEmpty() && nombre != null && !nombre.isEmpty()) {
                    LocalDate fechaNacimiento = LocalDate.parse(fechaNacimientoStr);

                    // Comparar si la fecha de nacimiento es futura
                    if (fechaNacimiento.isAfter(fechaActual)) {
                        out.println("<p>Hola " + nombre + ", no has nacido todavía.</p>");
                    } else {
                        // Calcular la diferencia entre la fecha actual y la fecha de nacimiento
                        Period periodo = Period.between(fechaNacimiento, fechaActual);
                        long diasExactos = ChronoUnit.DAYS.between(fechaNacimiento, fechaActual);

                        // Función para pluralizar "día", "mes" y "año"
                        String diaStr = (periodo.getDays() == 1) ? "día" : "días";
                        String mesStr = (periodo.getMonths() == 1) ? "mes" : "meses";
                        String yearStr = (periodo.getYears() == 1) ? "año" : "años";

                        // Si tiene exactamente 1 año (sin meses ni días)
                        if (periodo.getYears() == 1 && periodo.getMonths() == 0 && periodo.getDays() == 0) {
                            out.println("<p>Hola " + nombre + ", has nacido hace 1 " + yearStr + ".</p>");
                        } // Si solo tiene días
                        else if (periodo.getYears() == 0 && periodo.getMonths() == 0) {
                            out.println("<p>Hola " + nombre + ", has nacido hace " + diasExactos + " " + diaStr + ".</p>");
                        } // Si solo tiene meses exactos
                        else if (periodo.getYears() == 0 && periodo.getMonths() > 0 && periodo.getDays() == 0) {
                            out.println("<p>Hola " + nombre + ", has nacido hace " + periodo.getMonths() + " " + mesStr + ".</p>");
                        } // Si tiene meses y días (sin años)
                        else if (periodo.getYears() == 0 && periodo.getMonths() > 0 && periodo.getDays() > 0) {
                            out.println("<p>Hola " + nombre + ", has nacido hace " + periodo.getMonths() + " " + mesStr + " y " + periodo.getDays() + " " + diaStr + ".</p>");
                        } //Si tiene años y dias (sin meses)
                        else if (periodo.getYears() > 0 && periodo.getMonths() == 0 && periodo.getDays() > 0) {
                            out.println("<p>Hola " + nombre + ", has nacido hace " + periodo.getYears() + " " + yearStr + " y " + periodo.getDays() + " " + diaStr + ".</p>");
                        } // Si tiene años, meses y días
                        else {
                            out.println("<p>Hola " + nombre + ", has nacido hace " + periodo.getYears() + " " + yearStr + ", "
                                    + periodo.getMonths() + " " + mesStr + " y "
                                    + periodo.getDays() + " " + diaStr + ".</p>");
                        }
                    }
                } else {
                    out.println("<p>Introduce los datos correctamente.</p>");
                }
            %>

            <br><br>
            <a href='../'>Volver al menú</a>
        </div>
    </body>
</html>