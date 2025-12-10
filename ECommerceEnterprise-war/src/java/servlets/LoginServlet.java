package servlets;

import sessions.ClientSessionBean;
import entities.Client;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    
    @EJB
    private ClientSessionBean clientSessionBean;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Pour déboguer : afficher tous les clients
        clientSessionBean.afficherTousClients();
        response.sendRedirect("index.jsp");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        System.out.println("\n=== TENTATIVE CONNEXION ===");
        System.out.println("📧 Email reçu : " + email);
        System.out.println("🔐 MDP reçu : " + password);
        
        try {
            // Afficher tous les clients avant connexion (pour déboguer)
            clientSessionBean.afficherTousClients();
            
            Client client = clientSessionBean.seConnecter(email, password);
            
            if (client != null) {
                System.out.println("🎉 CONNEXION RÉUSSIE !");
                
                HttpSession session = request.getSession();
                session.setAttribute("client", client);
                session.setAttribute("clientId", client.getId());
                session.setAttribute("clientNom", client.getNom());
                session.setAttribute("clientPrenom", client.getPrenom());
                session.setAttribute("clientEmail", client.getEmail());
                session.setAttribute("clientRole", client.getRole());
                
                response.sendRedirect("dashboard.jsp");
                
            } else {
                System.out.println("❌ ÉCHEC CONNEXION : identifiants incorrects");
                response.sendRedirect("index.jsp?error=1");
            }
            
        } catch (Exception e) {
            System.err.println("💥 ERREUR FATALE LoginServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=2");
        }
    }
}