package sessions;

import entities.Commande;
import entities.Paiement;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.math.BigDecimal;

@Stateless
public class PaiementSessionBean {
    
    @PersistenceContext(unitName = "E_commercePU")
    private EntityManager em;
    
    // Effectuer paiement - CORRIGÉ (type Double → BigDecimal)
    public Paiement effectuerPaiement(Long commandeId, BigDecimal montant, 
                                     String numeroCarte, String banque) {
        try {
            Commande commande = em.find(Commande.class, commandeId);
            if (commande == null) {
                System.err.println("❌ Commande non trouvée ID: " + commandeId);
                return null;
            }
            
            // Vérifier montant - CORRIGÉ (compareTo avec BigDecimal)
            BigDecimal totalCommande = commande.getTotal();
            if (montant.compareTo(totalCommande) != 0) {
                System.err.println("❌ Montant incorrect: attendu " + totalCommande + ", reçu " + montant);
                return null;
            }
            
            // Simuler appel service bancaire
            boolean paiementValide = simulerAppelBanque(numeroCarte, montant);
            
            // Créer paiement - CORRIGÉ (BigDecimal au lieu de Double)
            Paiement paiement = new Paiement();
            paiement.setCommande(commande);
            paiement.setMontant(montant);
            paiement.setNumeroCarte(masquerNumeroCarte(numeroCarte));
            paiement.setBanque(banque);
            paiement.setStatut(paiementValide ? "PAYE" : "ECHEC");
            
            if (paiementValide) {
                commande.setStatut("VALIDEE");
                em.merge(commande);
                System.out.println("✅ Commande validée ID: " + commandeId);
            } else {
                commande.setStatut("ECHEC_PAIEMENT");
                em.merge(commande);
                System.out.println("❌ Échec paiement commande ID: " + commandeId);
            }
            
            em.persist(paiement);
            System.out.println("✅ Paiement enregistré ID: " + paiement.getId() + 
                             " - Montant: " + montant + " DA");
            
            return paiement;
            
        } catch (Exception e) {
            System.err.println("❌ Erreur paiement: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    // Trouver paiement par commande
    public Paiement trouverParCommande(Long commandeId) {
        try {
            return em.createQuery(
                "SELECT p FROM Paiement p WHERE p.commande.id = :commandeId", 
                Paiement.class)
                .setParameter("commandeId", commandeId)
                .getSingleResult();
        } catch (Exception e) {
            System.err.println("❌ Aucun paiement trouvé pour commande ID: " + commandeId);
            return null;
        }
    }
    
    // Méthodes privées - CORRIGÉ (BigDecimal au lieu de Double)
    private boolean simulerAppelBanque(String numeroCarte, BigDecimal montant) {
        // Simulation - Dans la réalité, on appelle le service web banque
        System.out.println("🏦 Appel service bancaire:");
        System.out.println("  • Carte: " + masquerNumeroCarte(numeroCarte));
        System.out.println("  • Montant: " + montant + " DA");
        
        // Simuler une vérification simple
        if (numeroCarte == null || numeroCarte.length() < 16) {
            System.out.println("  ❌ Carte invalide (16 chiffres requis)");
            return false;
        }
        
        if (montant == null || montant.compareTo(BigDecimal.ZERO) <= 0) {
            System.out.println("  ❌ Montant invalide (doit être > 0)");
            return false;
        }
        
        if (montant.compareTo(new BigDecimal("10000")) > 0) {
            System.out.println("  ❌ Montant trop élevé (> 10,000 DA)");
            return false;
        }
        
        System.out.println("  ✅ Paiement simulé avec succès");
        return true;
    }
    
    private String masquerNumeroCarte(String numeroCarte) {
        if (numeroCarte == null || numeroCarte.length() < 4) {
            return "****";
        }
        // Enlever les espaces
        String numeroPropre = numeroCarte.replaceAll("\\s", "");
        if (numeroPropre.length() < 4) {
            return "****";
        }
        return "**** **** **** " + numeroPropre.substring(numeroPropre.length() - 4);
    }
    
    // Méthode supplémentaire pour vérifier si une commande est déjà payée
    public boolean estDejaPayee(Long commandeId) {
        try {
            Paiement paiement = trouverParCommande(commandeId);
            return paiement != null && "PAYE".equals(paiement.getStatut());
        } catch (Exception e) {
            return false;
        }
    }
    
    // Méthode pour annuler un paiement
    public boolean annulerPaiement(Long paiementId) {
        try {
            Paiement paiement = em.find(Paiement.class, paiementId);
            if (paiement != null) {
                paiement.setStatut("ANNULE");
                em.merge(paiement);
                
                // Annuler aussi la commande
                Commande commande = paiement.getCommande();
                if (commande != null) {
                    commande.setStatut("ANNULEE");
                    em.merge(commande);
                }
                
                System.out.println("✅ Paiement annulé ID: " + paiementId);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("❌ Erreur annulation paiement: " + e.getMessage());
            return false;
        }
    }
}