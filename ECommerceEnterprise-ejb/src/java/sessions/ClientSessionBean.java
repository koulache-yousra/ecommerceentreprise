package sessions;

import entities.Client;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Stateless
public class ClientSessionBean {
    
    @PersistenceContext(unitName = "E_commercePU")
    private EntityManager em;
    
    public Client seConnecter(String email, String motDePasse) {
        try {
            System.out.println("🔍 Recherche client : " + email);
            
            // IMPORTANT : Utiliser les bons noms de colonnes
            Client client = em.createQuery(
                "SELECT c FROM Client c WHERE c.email = :email AND c.motDePasse = :mdp", 
                Client.class)
                .setParameter("email", email)
                .setParameter("mdp", motDePasse)
                .getSingleResult();
            
            System.out.println("✅ Client trouvé : " + client.getPrenom() + " " + client.getNom());
            System.out.println("📧 Email : " + client.getEmail());
            System.out.println("🔐 Mot de passe (BDD) : " + client.getMotDePasse());
            
            return client;
            
        } catch (Exception e) {
            System.err.println("❌ ERREUR connexion : " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    // Pour déboguer : voir tous les clients
    public void afficherTousClients() {
        try {
            java.util.List<Client> clients = em.createQuery(
                "SELECT c FROM Client c", Client.class)
                .getResultList();
            
            System.out.println("=== LISTE CLIENTS BDD ===");
            for (Client c : clients) {
                System.out.println("ID: " + c.getId() + 
                                 " | Nom: " + c.getNom() + 
                                 " | Email: " + c.getEmail() + 
                                 " | MDP: " + c.getMotDePasse());
            }
        } catch (Exception e) {
            System.err.println("Erreur liste clients: " + e.getMessage());
        }
    }
}