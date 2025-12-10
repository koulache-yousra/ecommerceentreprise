package servlets;

import sessions.ClientSessionBean;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    
    @EJB
    private ClientSessionBean clientSessionBean;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Simulation - Dans la réalité, on appelle l'EJB
        System.out.println("Nouvel inscrit: " + nom + " " + prenom + " (" + email + ")");
        
        // Créer session
        HttpSession session = request.getSession();
        session.setAttribute("clientEmail", email);
        session.setAttribute("clientNom", nom + " " + prenom);
        
        // Rediriger vers shopping
        response.sendRedirect("shopping.jsp");
    }
}