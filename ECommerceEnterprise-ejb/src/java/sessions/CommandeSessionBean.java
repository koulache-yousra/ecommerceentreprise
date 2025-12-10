package sessions;

import entities.Client;
import entities.Commande;
import entities.Produit;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class CommandeSessionBean {
    
    @PersistenceContext(unitName = "E_commercePU")
    private EntityManager em;
    
    // Créer commande
    public Commande creerCommande(Long clientId, Long produitId, Integer quantite) {
        try {
            Client client = em.find(Client.class, clientId);
            Produit produit = em.find(Produit.class, produitId);
            
            if (client == null || produit == null || produit.getQuantite() < quantite) {
                return null;
            }
            
            // Mettre à jour stock
            produit.setQuantite(produit.getQuantite() - quantite);
            em.merge(produit);
            
            // Créer commande
            Commande commande = new Commande(client, produit, quantite);
            em.persist(commande);
            
            return commande;
        } catch (Exception e) {
            System.err.println("Erreur création commande: " + e.getMessage());
            return null;
        }
    }
    
    // Lister commandes d'un client
    public List<Commande> listerCommandesClient(Long clientId) {
        return em.createQuery(
            "SELECT c FROM Commande c WHERE c.client.id = :clientId ORDER BY c.dateCommande DESC", 
            Commande.class)
            .setParameter("clientId", clientId)
            .getResultList();
    }
    
    // Trouver commande par ID
    public Commande trouverCommande(Long id) {
        return em.find(Commande.class, id);
    }
    
    // Mettre à jour statut
    public boolean mettreAJourStatut(Long commandeId, String nouveauStatut) {
        try {
            Commande c = em.find(Commande.class, commandeId);
            if (c != null) {
                c.setStatut(nouveauStatut);
                em.merge(c);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("Erreur mise à jour statut: " + e.getMessage());
            return false;
        }
    }
}