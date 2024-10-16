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
 * Servlet que gestiona las peticiones y muestra las cabeceras de la petición
 * HTTP.
 *
 * @author Juanma
 */
@WebServlet(name = "Peticiones", urlPatterns = {"/Peticiones"})
public class Peticiones extends HttpServlet {

    /**
     * Método que maneja las peticiones GET.
     *
     * @param request objeto HttpServletRequest
     * @param response objeto HttpServletResponse
     * @throws ServletException si ocurre un error específico del servlet
     * @throws IOException si ocurre un error de E/S
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Cabeceras de Petición</title>");
            out.print("<link rel='stylesheet' type='text/css' href='./css/peticiones.css'/>");
            out.println("</head>");
            out.println("<body>");
            out.println("<div id='contenedor'>");

            // Mostrar las cabeceras de la petición
            out.println("<h1>Cabeceras de la petición</h1>");
            Enumeration<String> headerNames = request.getHeaderNames();
            out.println("<ul>");
            while (headerNames.hasMoreElements()) {
                String headerName = headerNames.nextElement();
                String headerValue = request.getHeader(headerName);
                out.println("<li><strong>" + headerName + ":</strong> " + headerValue + "</li>");
            }
            out.println("</ul>");

            out.println("<a href='.'>Volver al menú</a>");
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    /**
     * Método que maneja las peticiones POST.
     *
     * @param request objeto HttpServletRequest
     * @param response objeto HttpServletResponse
     * @throws ServletException si ocurre un error específico del servlet
     * @throws IOException si ocurre un error de E/S
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para gestionar y mostrar las cabeceras de peticiones GET.";
    }
}
