package es.albarregas.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet que demuestra el ciclo de vida de un servlet.
 * 
 * @author Juanma
 */
@WebServlet(name = "CicloDeVida", urlPatterns = {"/CicloDeVida"})
public class CicloDeVida extends HttpServlet {

    // Se ejecuta cuando el servlet es inicializado
    @Override
    public void init() throws ServletException {
        System.out.println("Servlet inicializado (init).");
    }

    /**
     * Maneja las solicitudes HTTP <code>GET</code>.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException si ocurre un error específico del servlet
     * @throws IOException si ocurre un error de entrada/salida
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Solicitud GET recibida (doGet).");

        // Configura el tipo de contenido de la respuesta
        response.setContentType("text/html;charset=UTF-8");

        // Escribe la respuesta al cliente
        response.getWriter().println("<html><body>");
        response.getWriter().println("<h1>Este es el ciclo de vida de un servlet.</h1>");
        response.getWriter().println("</body></html>");
    }

    // Se ejecuta cuando el servlet está a punto de ser destruido
    @Override
    public void destroy() {
        System.out.println("Servlet destruido (destroy).");
    }
    
    @Override
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println(" ");
    }
}