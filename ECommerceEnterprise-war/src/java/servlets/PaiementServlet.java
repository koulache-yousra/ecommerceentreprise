package servlets;

import sessions.PaiementSessionBean;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/PaiementServlet")
public class PaiementServlet extends HttpServlet {
    
    @EJB
    private PaiementSessionBean paiementSessionBean;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Récupérer les paramètres
        String produitId = request.getParameter("produitId");
        String total = request.getParameter("total");
        String nomCarte = request.getParameter("nomCarte");
        String numeroCarte = request.getParameter("numeroCarte");
        String dateExp = request.getParameter("dateExp");
        String cvv = request.getParameter("cvv");
        
        // Simulation - Dans la réalité, on appelle l'EJB de paiement
        System.out.println("Traitement paiement:");
        System.out.println("- Produit ID: " + produitId);
        System.out.println("- Montant: " + total + " DA");
        System.out.println("- Carte: " + numeroCarte);
        
        // Simuler une vérification
        boolean paiementReussi = simulerPaiement(numeroCarte, total);
        
        // Rediriger vers la page de résultat
        if (paiementReussi) {
            response.sendRedirect("paiement_success.jsp?total=" + total);
        } else {
            response.sendRedirect("paiement_error.jsp?message=Paiement refusé par la banque");
        }
    }
    
    private boolean simulerPaiement(String numeroCarte, String montant) {
        // Simulation simple
        try {
            // Enlever les espaces
            String numero = numeroCarte.replaceAll("\\s", "");
            
            // Vérifier que c'est un numéro valide (simulation)
            if (numero.length() != 16) return false;
            
            // Vérifier Luhn (algorithme de validation des cartes)
            return isValidLuhn(numero);
            
        } catch (Exception e) {
            return false;
        }
    }
    
    // Algorithme de Luhn pour valider les numéros de carte
    private boolean isValidLuhn(String number) {
        int sum = 0;
        boolean alternate = false;
        
        for (int i = number.length() - 1; i >= 0; i--) {
            int n = Integer.parseInt(number.substring(i, i + 1));
            if (alternate) {
                n *= 2;
                if (n > 9) {
                    n = (n % 10) + 1;
                }
            }
            sum += n;
            alternate = !alternate;
        }
        
        return (sum % 10 == 0);
    }
}