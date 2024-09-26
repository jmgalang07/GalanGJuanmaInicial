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
            out.println("<h1>Entrada de datos con VALIDADOR (Validador)</h1>");
            out.println("<form action='Enumer' method='POST'>");  // El formulario apunta al controlador 'Enumer'

            out.println("<label>Nombre: </label>");
            out.println("<input type='text' name='nombre'/>");
            out.println("<br><br>");

            out.println("<label>Apellidos: </label>");
            out.println("<input type='text' name='apellidos'/>");
            out.println("<br><br>");

            out.println("<label>Fecha de nacimiento: </label>");
            out.println("<input type='date' id='fecha' name='fecha_nacimiento'>");
            out.println("<br><br>");

            out.println("<label>Aficiones: </label><br><br>");
            out.println("<input type='checkbox' value='Musica' name='gustos'/>&nbsp;&nbsp; M&uacute;sica");
            out.println("<input type='checkbox' value='Viajes' name='gustos'/>&nbsp;&nbsp; Viajes");
            out.println("<input type='checkbox' value='Juegos' name='gustos'/>&nbsp;&nbsp; Juegos");
            out.println("<input type='checkbox' value='Deportes' name='gustos'/>&nbsp;&nbsp; Deportes");
            out.println("<br><br>");

            out.println("<label>Sistema operativo: </label>");
            out.println("<select name='sistema_operativo' id='lt1'>");
            out.println("<option value='0' selected disabled>Elige uno...</option>");
            out.println("<option value='Windows'>Windows</option>");
            out.println("<option value='Linux'>Linux</option>");
            out.println("<option value='Mac'>Mac</option>");
            out.println("<option value='Ubuntu'>Ubuntu</option>");
            out.println("</select>");
            out.println("<br><br>");

            out.println("<label>G&eacute;nero: </label><br>");
            out.println("<input type='radio' value='Mujer' name='sexo' checked/>&nbsp;&nbsp; Mujer<br>");
            out.println("<input type='radio' value='Hombre' name='sexo'/>&nbsp;&nbsp; Hombre<br>");
            out.println("<input type='radio' value='Otro' name='sexo'/>&nbsp;&nbsp; Otro<br>");
            out.println("<br>");
            
            out.println("input type='submit' name='enviar'");
            out.println("<br><br>");

            out.println("<a href='../'>Volver al menú</a>");
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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Resultado de Parámetros</title>");
            out.println("</head>");
            out.println("<body>");
            Enumeration<String> parametros = request.getParameterNames();  // getParametersName devuelve el valor
            while (parametros.hasMoreElements()) {
                String nombre = parametros.nextElement();

                // Convierto la primera letra en mayúscula
                String nombreCapitalizado = nombre.substring(0, 1).toUpperCase() + nombre.substring(1);

                String[] valores = request.getParameterValues(nombre); // Obtengo todos los valores del parámetro
                if (valores != null) {
                    String concatenados = String.join(", ", valores);
                    out.println(nombreCapitalizado + ": " + concatenados + "<br><br>");
                } else {
                    // Muestro el valor único
                    out.println(nombreCapitalizado + ": " + request.getParameter(nombre) + "<br><br>");
                }
            }
            out.println("</body>");
            out.println("</html>");
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
