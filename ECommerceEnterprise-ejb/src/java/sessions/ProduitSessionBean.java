package sessions;

import entities.Produit;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.math.BigDecimal;
import java.util.List;

@Stateless
public class ProduitSessionBean {
    
    @PersistenceContext(unitName = "E_commercePU")
    private EntityManager em;
    
    // Lister tous les produits
    public List<Produit> listerProduits() {
        try {
            System.out.println("📦 Récupération des produits depuis la BDD...");
            List<Produit> produits = em.createQuery("SELECT p FROM Produit p ORDER BY p.nom", Produit.class)
                    .getResultList();
            
            System.out.println("✅ " + produits.size() + " produits trouvés dans la BDD");
            return produits;
        } catch (Exception e) {
            System.err.println("❌ Erreur listerProduits: " + e.getMessage());
            return List.of(); // Retourne liste vide si erreur
        }
    }
    
    // Trouver par ID
    public Produit trouverParId(Long id) {
        try {
            System.out.println("🔍 Recherche produit ID: " + id);
            Produit produit = em.find(Produit.class, id);
            
            if (produit != null) {
                System.out.println("✅ Produit trouvé: " + produit.getNom());
            } else {
                System.out.println("❌ Produit non trouvé pour ID: " + id);
            }
            
            return produit;
        } catch (Exception e) {
            System.err.println("❌ Erreur trouverParId: " + e.getMessage());
            return null;
        }
    }
    
    // Ajouter produit - CORRIGÉ (erreur de syntaxe)
    public Produit ajouterProduit(String nom, String description, BigDecimal prix, Integer quantite) {
        try {
            // ID est auto-généré par la BDD, donc pas besoin de le passer
            Produit produit = new Produit();
            produit.setNom(nom);
            produit.setDescription(description);
            produit.setPrix(prix);
            produit.setQuantite(quantite);
            
            em.persist(produit);
            System.out.println("✅ Produit ajouté: " + nom + " (ID auto-généré: " + produit.getId() + ")");
            return produit;
        } catch (Exception e) {
            System.err.println("❌ Erreur ajout produit: " + e.getMessage());
            return null;
        }
    }
    
    // Version avec tous les paramètres (optionnel)
    public Produit ajouterProduitComplet(String nom, String description, BigDecimal prix, 
                                         BigDecimal prixPromo, Integer quantite, Long categorieId) {
        try {
            Produit produit = new Produit();
            produit.setNom(nom);
            produit.setDescription(description);
            produit.setPrix(prix);
            produit.setPrixPromo(prixPromo);
            produit.setQuantite(quantite);
            produit.setCategorieId(categorieId);
            
            em.persist(produit);
            System.out.println("✅ Produit complet ajouté: " + nom);
            return produit;
        } catch (Exception e) {
            System.err.println("❌ Erreur ajout produit complet: " + e.getMessage());
            return null;
        }
    }
    
    // Mettre à jour stock
    public boolean mettreAJourStock(Long produitId, Integer nouvelleQuantite) {
        try {
            Produit p = em.find(Produit.class, produitId);
            if (p != null) {
                p.setQuantite(nouvelleQuantite);
                em.merge(p);
                System.out.println("📦 Stock mis à jour - Produit ID " + produitId + 
                                 ": " + nouvelleQuantite + " unités");
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("❌ Erreur mise à jour stock: " + e.getMessage());
            return false;
        }
    }
    
    // Rechercher produits
    public List<Produit> rechercherProduits(String terme) {
        try {
            return em.createQuery(
                "SELECT p FROM Produit p WHERE LOWER(p.nom) LIKE LOWER(:terme) OR " +
                "LOWER(p.description) LIKE LOWER(:terme) ORDER BY p.nom", Produit.class)
                .setParameter("terme", "%" + terme + "%")
                .getResultList();
        } catch (Exception e) {
            System.err.println("❌ Erreur recherche produits: " + e.getMessage());
            return List.of();
        }
    }
    
    // Méthode pour déboguer : afficher tous les produits
    public void afficherTousProduits() {
        try {
            List<Produit> produits = listerProduits();
            
            System.out.println("\n=== LISTE PRODUITS DE LA BDD ===");
            System.out.println("Total: " + produits.size() + " produits");
            System.out.println("=" .repeat(60));
            
            for (Produit p : produits) {
                System.out.println("ID: " + p.getId() + 
                                 " | Nom: " + p.getNom() + 
                                 " | Prix: " + p.getPrix() + " DA" +
                                 " | Stock: " + p.getQuantite() +
                                 " | Catégorie: " + p.getCategorieId());
            }
            
        } catch (Exception e) {
            System.err.println("❌ Erreur afficherTousProduits: " + e.getMessage());
        }
    }
}