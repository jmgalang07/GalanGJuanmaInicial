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
            out.print("<link rel='stylesheet' type='text/css' href='./css/respuesta.css'/>");
            out.println("</head>");
            out.println("<body>");
            out.println("<div class='container'>"); // Agrego el contenedor

            String enviarFormulario = request.getParameter("enviar");

            // Creo instancias de los servlets Enumer y Mapa
            Enumer enviarEnum = new Enumer();
            Mapa enviarMapa = new Mapa();

            // Dependiendo del botón que se presione, llamo a uno de los dos métodos
            if ("Enumeration".equals(enviarFormulario)) {
                out.println("<h1>Entrada de datos por ENUMERATION</h1>");
                enviarEnum.doPost(request, response);
            } else {
                out.println("<h1>Entrada de datos por MAPA</h1>");
                enviarMapa.doPost(request, response);
            }
            out.println("<a href='.'>Volver al menú</a>");
            out.println("</div>");
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
