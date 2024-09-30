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
@WebServlet(name = "Vali_Intermedio", urlPatterns = {"/Vali_Intermedio"})
public class Vali_Intermedio extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Verificar si existe el parámetro "error" en la solicitud
        String error = request.getParameter("error");

        try (PrintWriter out = response.getWriter()) {

            out.print("<!DOCTYPE html>");
            out.print("<html>");
            out.print("<head>");
            out.print("<title>Formulario con errores</title>");
            out.print("<link rel='stylesheet' type='text/css' href='./css/form.css'/>");
            out.print("</head>");
            out.print("<body>");

            // Mostrar el mensaje de error si el parámetro está presente
            if (error != null && error.equals("true")) {
                out.print("<h3>¡Error! Faltan campos por rellenar correctamente.</h3>");
            }

            out.print("<h1>Formulario con validador intermedio</h1>");
            out.print("<p>¡NOTA! -> El nombre, los apellidos y la fecha de nacimiento son obligatorios</p>");

            // Vuelvo a mostrar el formulario con los campos completados
            out.print("<form action='Vali_Intermedio' method='POST'>");

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

            // Aficiones
            out.print("<label>Aficiones: </label><br><br>");
            out.print("<input type='checkbox' value='Musica' name='gustos'" + (request.getParameter("gustos") != null && request.getParameter("gustos").contains("Musica") ? " checked" : "") + "/>&nbsp;&nbsp; M&uacute;sica &nbsp;");
            out.print("<input type='checkbox' value='Viajes' name='gustos'" + (request.getParameter("gustos") != null && request.getParameter("gustos").contains("Viajes") ? " checked" : "") + "/>&nbsp;&nbsp; Viajes &nbsp;");
            out.print("<input type='checkbox' value='Juegos' name='gustos'" + (request.getParameter("gustos") != null && request.getParameter("gustos").contains("Juegos") ? " checked" : "") + "/>&nbsp;&nbsp; Juegos &nbsp;");
            out.print("<input type='checkbox' value='Deportes' name='gustos'" + (request.getParameter("gustos") != null && request.getParameter("gustos").contains("Deportes") ? " checked" : "") + "/>&nbsp;&nbsp; Deportes &nbsp;");
            out.print("<br>");

            // Sistema operativo
            String sistemaOperativo = request.getParameter("sistema_operativo");
            out.print("<label>Sistema operativo: </label>");
            out.print("<select name='sistema_operativo' id='lt1'>");
            out.print("<option value='0'" + (sistemaOperativo == null || sistemaOperativo.equals("0") ? " selected" : "") + " disabled>Elige uno...</option>");
            out.print("<option value='Windows'" + ("Windows".equals(sistemaOperativo) ? " selected" : "") + ">Windows</option>");
            out.print("<option value='Linux'" + ("Linux".equals(sistemaOperativo) ? " selected" : "") + ">Linux</option>");
            out.print("<option value='Mac'" + ("Mac".equals(sistemaOperativo) ? " selected" : "") + ">Mac</option>");
            out.print("<option value='Ubuntu'" + ("Ubuntu".equals(sistemaOperativo) ? " selected" : "") + ">Ubuntu</option>");
            out.print("</select>");
            out.print("<br><br>");

            // Género
            String sexo = request.getParameter("sexo");
            out.print("<label>Género: </label><br>");
            out.print("<input type='radio' value='Mujer' name='sexo'" + ("Mujer".equals(sexo) ? " checked" : "") + "/>&nbsp;&nbsp; Mujer<br>");
            out.print("<input type='radio' value='Hombre' name='sexo'" + ("Hombre".equals(sexo) ? " checked" : "") + "/>&nbsp;&nbsp; Hombre<br>");
            out.print("<input type='radio' value='Otro' name='sexo'" + ("Otro".equals(sexo) ? " checked" : "") + "/>&nbsp;&nbsp; Otro<br>");
            out.print("<br>");

            // Botón de enviar
            out.print("<input type='submit' name='enviar'/>");

            out.print("</form>");
            out.print("</body>");
            out.print("</html>");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Inicio variable para controlar errores
            Boolean error = false;
            // Obtengo los parámetros del formulario
            Enumeration<String> parametros = request.getParameterNames();
            // Recorro todos los parámetros y valido si hay errores
            while (parametros.hasMoreElements() && !error) {
                String nombre = parametros.nextElement();

                // Convierto la primera letra en mayúscula
                String nombreCapitalizado = nombre.substring(0, 1).toUpperCase() + nombre.substring(1);

                // Obtengo todos los valores del parámetro
                String[] valores = request.getParameterValues(nombre);

                // Verifico si algún campo type text está vacío
                if ((nombre.equals("nombre") || nombre.equals("apellidos") || nombre.equals("fecha_nacimiento"))
                        && (valores == null || valores[0].isEmpty())) {
                    error = true;
                    break;
                }
            }

            // Si se detecta un error, muestro un mensaje de error.
            if (error) {
                StringBuilder formulario = new StringBuilder();
                formulario.append("<!DOCTYPE html>");
                formulario.append("<html>");
                formulario.append("<head>");
                formulario.append("<title>Formulario con errores</title>");
                formulario.append("</head>");
                formulario.append("<body>");
                formulario.append("<h1>¡ERROR! Rellena los campos correctamente</h1>");
                formulario.append("<form action='Vali_Intermedio' method='GET'>");
                formulario.append("<input type='submit' name='enviar'/>");
                formulario.append("</form>");
                formulario.append("</body>");
                formulario.append("</html>");

                out.println(formulario.toString());
            } else {
                // Si no hay errores, se muestran los datos del formulario
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
                out.println("<a href='.'>Volver al menú</a>");
                out.println("</div>");
                out.println("</body>");
                out.println("</html>");
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
