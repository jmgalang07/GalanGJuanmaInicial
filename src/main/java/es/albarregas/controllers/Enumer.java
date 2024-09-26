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
@WebServlet(name = "Enumer", urlPatterns = {"/Enumer"})
public class Enumer extends HttpServlet {

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
