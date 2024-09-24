package es.albarregas.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Juanma
 */
@WebServlet(name = "Mapa", urlPatterns = {"/Mapa"})
public class Mapa extends HttpServlet {

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
            out.println("<title>Servlet Datos</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Mapa at " + request.getContextPath() + "</h1>");

            // Obtengo el mapa de parámetros
            Map<String, String[]> parametros = request.getParameterMap();
            
            // Itero sobre el mapa de parámetros
            for (Map.Entry<String, String[]> entry : parametros.entrySet()) {
                String nombre = entry.getKey();
                
                // Convierto la primera letra en mayúscula
                String nombreCapitalizado = nombre.substring(0, 1).toUpperCase() + nombre.substring(1);
                
                String[] valores = entry.getValue();  // Obtengo los valores del parámetro
                if (valores != null) {
                    String concatenados = String.join(", ", valores);
                    out.println(nombreCapitalizado + ": " + concatenados + "<br><br>");
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
    }
}