package es.albarregas.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * @author Juanma
 */
@WebServlet(name = "EnumYmapa", urlPatterns = {"/EnumYmapa"})
public class EnumYmapa extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet request
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // HTML del formulario
            out.println("<!DOCTYPE html>");
            out.println("<html lang='es'>");
            out.println("<head>");
            out.println("<title>Formulario</title>");
            out.println("<meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Entrada de datos por ENUMERATION y MAPA (EnumYmapa)</h1>");
            out.println("<form action='EnumYmapa' method='POST'>");

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

            out.println("<input type='submit' name='enviar' value='Enumeration'/>");
            out.println("<input type='submit' name='enviar' value='Mapa'/>");
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
     * @param response servlet request
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
            out.println("<title>Servlet Datos</title>");
            out.println("</head>");
            out.println("<body>");

            String enviarFormulario = request.getParameter("enviar");

            // Creo instancias de los servlets Enumer y Mapa
            Enumer enviarEnum = new Enumer();
            Mapa enviarMapa = new Mapa();

            // Dependiendo del botón que fue presionado, se llama a uno de los dos métodos
            if ("Enumeration".equals(enviarFormulario)) {
                out.println("<h1>Entrada de datos por ENUMERATION</h1>");
                enviarEnum.doPost(request, response);
            } else {
                out.println("<h1>Entrada de datos por MAPA</h1>");
                enviarMapa.doPost(request, response);
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