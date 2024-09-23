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
@WebServlet(name = "Datos", urlPatterns = {"/Datos"})
public class Datos extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Datos</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Datos at " + request.getContextPath() + "</h1>");
            Enumeration<String> parametros = request.getParameterNames();  //getParametersName devuelve el valor
            while(parametros.hasMoreElements()){
                String nombre = parametros.nextElement();
                String[] valores = request.getParameterValues(nombre); // Obtener todos los valores del parámetro
                if (valores != null) {
                    // Si hay múltiples valores, unirlos con comas
                    String concatenados = String.join(", ", valores);
                    out.println("<p>El valor del parámetro " + nombre + " es " + concatenados + "</p>");
                } else {
                    // Mostrar el valor único
                    out.println("<p>El valor del parámetro " + nombre + " es " + request.getParameter(nombre) + "</p>");
                } 
            }
            
            out.println("<a href='.'>Volver al menú" + "</a>");
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
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}