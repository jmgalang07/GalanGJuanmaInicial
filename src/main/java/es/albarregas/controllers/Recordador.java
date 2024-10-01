package es.albarregas.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Juanma
 */
@WebServlet(name = "Recordador", urlPatterns = {"/Recordador"})
public class Recordador extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Verifico si hay un parámetro "error" en la solicitud
        String error = request.getParameter("error");

        try (PrintWriter out = response.getWriter()) {
            out.print("<!DOCTYPE html>");
            out.print("<html>");
            out.print("<head>");
            out.print("<title>Formulario con errores</title>");
            out.print("<link rel='stylesheet' type='text/css' href='./css/form.css'/>");
            out.print("</head>");
            out.print("<body>");

            // Muestro el mensaje de error si el parámetro está presente
            if (error != null && error.equals("true")) {
                out.print("<h3>¡Error! Faltan campos por rellenar correctamente.</h3>");
            }

            out.print("<h1>Formulario con validador y recordador</h1>");
            out.print("<p>¡NOTA! -> Todos los campos son obligatorios</p>");
            out.print("<h3>Formulario por GET</h3>");

            // Vuelvo a mostrar el formulario con los campos completados
            out.print("<form action='Recordador' method='POST'>");

            // Nombre
            String nombre = request.getParameter("nombre");
            out.print("<label><strong>Nombre: </strong></label>");
            // Relleno el campo de nombre con el valor previamente introducido
            out.print("<input type='text' name='nombre' value='" + (nombre != null ? nombre : "") + "'/>");
            out.print("<br><br>");

            // Apellidos
            String apellidos = request.getParameter("apellidos");
            out.print("<label><strong>Apellidos: </strong></label>");
            // Relleno el campo de apellidos con el valor previamente introducido
            out.print("<input type='text' name='apellidos' value='" + (apellidos != null ? apellidos : "") + "'/>");
            out.print("<br><br>");

            // Fecha de nacimiento
            String fechaNacimiento = request.getParameter("fecha_nacimiento");
            out.print("<label><strong>Fecha de nacimiento: </strong></label>");
            // Relleno el campo de fecha con el valor previamente introducido
            out.print("<input type='date' id='fecha' name='fecha_nacimiento' value='" + (fechaNacimiento != null ? fechaNacimiento : "") + "'/>");
            out.print("<br><br>");

            // Domicilio
            String domicilio = request.getParameter("domicilio");
            out.print("<label><strong>Domicilio: </strong></label>");
            // Relleno el campo de domicilio con el valor previamente introducido
            out.print("<input type='text' name='domicilio' value='" + (domicilio != null ? domicilio : "") + "'/>");
            out.print("<br><br>");

            // Botón de enviar
            out.print("<input type='submit' name='primerForm'/>");
            out.print("<br><br>");

            // Enlace que me lleva al menú inicial
            out.print("<a href='.'>Volver al menú</a>");

            out.print("</form>");
            out.print("</body>");
            out.print("</html>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Compruebo si el formulario fue enviado con el input 'primerForm'
        if (request.getParameter("primerForm") == null) {
            // Si no se envió el formulario correctamente, vuelvo a mostrarlo con los datos introducidos
            // Verifico si existe el parámetro "error" en la solicitud
            String error = request.getParameter("error");
            try (PrintWriter out = response.getWriter()) {
                out.print("<!DOCTYPE html>");
                out.print("<html>");
                out.print("<head>");
                out.print("<title>Formulario con errores</title>");
                out.print("<link rel='stylesheet' type='text/css' href='./css/form.css'/>");
                out.print("</head>");
                out.print("<body>");

                // Muestro un mensaje de error si el parámetro está presente
                if (error != null && error.equals("true")) {
                    out.print("<h3>¡Error! Faltan campos por rellenar correctamente.</h3>");
                }

                out.print("<h1>Formulario con validador y recordador</h1>");
                out.print("<p>¡NOTA! -> Todos los campos son obligatorios</p>");
                out.print("<h3>Formulario por POST</h3>");

                // Vuelvo a mostrar el formulario con los campos completados
                out.print("<form action='Recordador' method='POST'>");

                // Nombre
                String nombre = request.getParameter("nombre");
                out.print("<label><strong>Nombre: </strong></label>");
                out.print("<input type='text' name='nombre' value='" + (nombre != null ? nombre : "") + "'/>");
                out.print("<br><br>");

                // Apellidos
                String apellidos = request.getParameter("apellidos");
                out.print("<label><strong>Apellidos: </strong></label>");
                out.print("<input type='text' name='apellidos' value='" + (apellidos != null ? apellidos : "") + "'/>");
                out.print("<br><br>");

                // Fecha de nacimiento
                String fechaNacimiento = request.getParameter("fecha_nacimiento");
                out.print("<label><strong>Fecha de nacimiento: </strong></label>");
                out.print("<input type='date' id='fecha' name='fecha_nacimiento' value='" + (fechaNacimiento != null ? fechaNacimiento : "") + "'/>");
                out.print("<br><br>");

                // Domicilio
                String domicilio = request.getParameter("domicilio");
                out.print("<label><strong>Domicilio: </strong></label>");
                out.print("<input type='text' name='domicilio' value='" + (domicilio != null ? domicilio : "") + "'/>");
                out.print("<br><br>");

                // Botón de enviar
                out.print("<input type='submit' name='primerForm'/>");
                out.print("<br><br>");

                // Enlace que me lleva al menú inicial
                out.print("<a href='.'>Volver al menú</a>");

                out.print("</form>");
                out.print("</body>");
                out.print("</html>");
            }
        } else {
            try (PrintWriter out = response.getWriter()) {
                // Variable para controlar si hay errores en el formulario
                Boolean error = false;
                // Valido los campos recibidos
                Enumeration<String> parametros = request.getParameterNames();

                // Verifico si algún campo requerido está vacío
                while (parametros.hasMoreElements()) {
                    String param = parametros.nextElement();
                    if ((param.equals("nombre") || param.equals("apellidos") || param.equals("fecha_nacimiento") || param.equals("domicilio"))
                            && (request.getParameter(param) == null || request.getParameter(param).isEmpty())) {
                        error = true;
                        break;
                    }
                }

                if (error) {
                    // Si hay un error, muestro una página con mensaje de error y un botón para regresar al formulario
                    out.println("<!DOCTYPE html>");
                    out.println("<html>");
                    out.println("<head>");
                    out.println("<title>Error en el Formulario</title>");
                    out.println("</head>");
                    out.println("<body>");
                    out.println("<h1>¡ERROR! Faltan campos por rellenar</h1>");
                    out.println("<form action='Recordador' method='POST'>");

                    // Aquí los campos se vuelven a enviar como parámetros para que el usuario no pierda los datos
                    String[] campos = {"nombre", "apellidos", "fecha_nacimiento", "domicilio"};
                    for (String campo : campos) {
                        out.println("<input type='hidden' name='" + campo + "' value='" + request.getParameter(campo) + "'/>");
                    }
                    out.println("<input type='submit' value='Volver al formulario'/>");
                    out.println("</form>");
                    out.println("</body>");
                    out.println("</html>");

                } else {
                    // Si no hay errores, muestro los datos del formulario
                    out.println("<!DOCTYPE html>");
                    out.println("<html>");
                    out.println("<head>");
                    out.println("<title>Datos del Formulario</title>");
                    out.print("<link rel='stylesheet' type='text/css' href='./css/respuesta.css'/>");
                    out.println("</head>");
                    out.println("<body>");
                    out.println("<div class='container'>"); // Agrego el contenedor
                    out.println("<h1>Datos del Formulario</h1>");

                    // Muestro los datos ingresados en el formulario
                    Enumeration<String> parametros2 = request.getParameterNames();
                    while (parametros2.hasMoreElements()) {
                        String nombre = parametros2.nextElement();
                        String[] valores = request.getParameterValues(nombre);
                        String concatenados = (valores != null) ? String.join(", ", valores) : "";
                        out.println(nombre.substring(0, 1).toUpperCase() + nombre.substring(1) + ": " + concatenados + "<br>" + "<br>");
                    }
                    // Enlace que me lleva al menú inicial
                    out.println("<a href='.'>Volver al menú</a>");
                    out.println("</div>");
                    out.println("</body>");
                    out.println("</html>");
                }
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
