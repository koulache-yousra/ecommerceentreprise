package entities;

import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "Commande")
public class Commande implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "client_id", nullable = false)
    private Client client;
    
    @ManyToOne
    @JoinColumn(name = "produit_id", nullable = false)
    private Produit produit;
    
    @Column(nullable = false)
    private Integer quantite;
    
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateCommande;
    
    private String statut; // "EN_ATTENTE", "VALIDEE", "ANNULEE", "LIVREE"
    
    // Constructeurs
    public Commande() {
        this.dateCommande = new Date();
        this.statut = "EN_ATTENTE";
    }
    
    public Commande(Client client, Produit produit, Integer quantite) {
        this();
        this.client = client;
        this.produit = produit;
        this.quantite = quantite;
    }
    
    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public Client getClient() { return client; }
    public void setClient(Client client) { this.client = client; }
    
    public Produit getProduit() { return produit; }
    public void setProduit(Produit produit) { this.produit = produit; }
    
    public Integer getQuantite() { return quantite; }
    public void setQuantite(Integer quantite) { this.quantite = quantite; }
    
    public Date getDateCommande() { return dateCommande; }
    public void setDateCommande(Date dateCommande) { this.dateCommande = dateCommande; }
    
    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }
    
    // Méthode utilitaire CORRIGÉE
    public BigDecimal getTotal() {
        if (this.produit != null && this.produit.getPrix() != null && this.quantite != null) {
            return this.produit.getPrix().multiply(new BigDecimal(this.quantite));
        }
        return BigDecimal.ZERO;
    }
    
    @Override
    public String toString() {
        return "Commande{" + 
               "id=" + id + 
               ", client=" + (client != null ? client.getNom() : "null") + 
               ", produit=" + (produit != null ? produit.getNom() : "null") + 
               ", quantite=" + quantite + 
               ", total=" + getTotal() + 
               '}';
    }
}