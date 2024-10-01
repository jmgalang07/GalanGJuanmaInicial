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
@WebServlet(name = "Validador", urlPatterns = {"/Validador"})
public class Validador extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Formulario</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>¡¡ERROR!! No se puede acceder al controlador sin pasar por el formulario.</h1>");
            out.println("<a href='.'>Volver al menú</a>");
            out.println("</form>");
            out.println("</body>");
            out.println("</html>");
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
                //String nombreCapitalizado = nombre.substring(0, 1).toUpperCase() + nombre.substring(1);

                // Obtengo todos los valores del parámetro
                String[] valores = request.getParameterValues(nombre);

                // Verifico si algún campo type text está vacío
                if ((nombre.equals("nombre") || nombre.equals("apellidos") || nombre.equals("fecha_nacimiento"))
                        && (valores == null || valores[0].isEmpty())) {
                    error = true;
                    break;
                }
            }

            // Si se detecta un error, muestro el formulario con un mensaje de error y con el formulario de nuevo.
            if (error) {
                StringBuilder formulario = new StringBuilder();
                formulario.append("<!DOCTYPE html>");
                formulario.append("<html>");
                formulario.append("<head>");
                formulario.append("<title>Formulario con errores</title>");
                formulario.append("<link rel='stylesheet' type='text/css' href='./css/formValidador.css'/>");
                formulario.append("</head>");
                formulario.append("<body>");
                formulario.append("<h1>¡ERROR! Rellena los campos correctamente</h1>");

                formulario.append("<p>¡NOTA! -> El nombre, los apellidos y la fecha de nacimiento son obligatorios</P>");

                // Vuelvo a mostrar el formulario con los campos completados
                formulario.append("<form action='Validador' method='POST'>");

                // Nombre
                String nombre = request.getParameter("nombre");
                formulario.append("<label><strong>Nombre: </strong></label>");
                formulario.append("<input type='text' name='nombre' value='").append(nombre != null ? nombre : "").append("'/>");
                formulario.append("<br><br>");

                // Apellidos
                String apellidos = request.getParameter("apellidos");
                formulario.append("<label><strong>Apellidos: </strong></label>");
                formulario.append("<input type='text' name='apellidos' value='").append(apellidos != null ? apellidos : "").append("'/>");
                formulario.append("<br><br>");

                // Fecha de nacimiento
                String fechaNacimiento = request.getParameter("fecha_nacimiento");
                formulario.append("<label><strong>Fecha de nacimiento: </strong></label>");
                formulario.append("<input type='date' id='fecha' name='fecha_nacimiento' value='").append(fechaNacimiento != null ? fechaNacimiento : "").append("'/>");
                formulario.append("<br><br>");

                // Aficiones
                formulario.append("<label>Aficiones: </label><br><br>");
                formulario.append("<input type='checkbox' value='Musica' name='gustos'").append(request.getParameter("gustos") != null && request.getParameter("gustos").contains("Musica") ? " checked" : "").append("/>&nbsp;&nbsp; M&uacute;sica &nbsp;");
                formulario.append("<input type='checkbox' value='Viajes' name='gustos'").append(request.getParameter("gustos") != null && request.getParameter("gustos").contains("Viajes") ? " checked" : "").append("/>&nbsp;&nbsp; Viajes &nbsp;");
                formulario.append("<input type='checkbox' value='Juegos' name='gustos'").append(request.getParameter("gustos") != null && request.getParameter("gustos").contains("Juegos") ? " checked" : "").append("/>&nbsp;&nbsp; Juegos &nbsp;");
                formulario.append("<input type='checkbox' value='Deportes' name='gustos'").append(request.getParameter("gustos") != null && request.getParameter("gustos").contains("Deportes") ? " checked" : "").append("/>&nbsp;&nbsp; Deportes &nbsp;");
                formulario.append("<br>");

                // Sistema operativo
                String sistemaOperativo = request.getParameter("sistema_operativo");
                formulario.append("<label>Sistema operativo: </label>");
                formulario.append("<select name='sistema_operativo' id='lt1'>");
                formulario.append("<option value='0'").append(sistemaOperativo == null || sistemaOperativo.equals("0") ? " selected" : "").append(" disabled>Elige uno...</option>");
                formulario.append("<option value='Windows'").append("Windows".equals(sistemaOperativo) ? " selected" : "").append(">Windows</option>");
                formulario.append("<option value='Linux'").append("Linux".equals(sistemaOperativo) ? " selected" : "").append(">Linux</option>");
                formulario.append("<option value='Mac'").append("Mac".equals(sistemaOperativo) ? " selected" : "").append(">Mac</option>");
                formulario.append("<option value='Ubuntu'").append("Ubuntu".equals(sistemaOperativo) ? " selected" : "").append(">Ubuntu</option>");
                formulario.append("</select>");
                formulario.append("<br><br>");

                // Género
                String sexo = request.getParameter("sexo");
                formulario.append("<label>Género: </label><br>");
                formulario.append("<input type='radio' value='Mujer' name='sexo'").append("Mujer".equals(sexo) ? " checked" : "").append("/>&nbsp;&nbsp; Mujer<br>");
                formulario.append("<input type='radio' value='Hombre' name='sexo'").append("Hombre".equals(sexo) ? " checked" : "").append("/>&nbsp;&nbsp; Hombre<br>");
                formulario.append("<input type='radio' value='Otro' name='sexo'").append("Otro".equals(sexo) ? " checked" : "").append("/>&nbsp;&nbsp; Otro<br>");
                formulario.append("<br>");

                // Botón de enviar
                formulario.append("<input type='submit' name='enviar'/>");
                formulario.append("<br><br>");
                
                // Enlace que me lleva al menú inicial
                formulario.append("<a href='.'>Volver al menú</a>");

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
