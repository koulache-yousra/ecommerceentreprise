package entities;

import jakarta.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;

@Entity
@Table(name = "produits")
public class Produit implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "produit_id")
    private Long id;
    
    @Column(name = "nom")
    private String nom;
    
    @Column(name = "description", columnDefinition = "TEXT")
    private String description;
    
    @Column(name = "prix", precision = 10, scale = 2)
    private BigDecimal prix;
    
    @Column(name = "prix_promo", precision = 10, scale = 2)
    private BigDecimal prixPromo;
    
    @Column(name = "quantite")
    private Integer quantite;
    
    @Column(name = "categorie_id")
    private Long categorieId;
    
    @Column(name = "image_url")
    private String imageUrl;
    
    @Column(name = "is_featured")
    private Boolean isFeatured;
    
    @Column(name = "rating", precision = 3, scale = 2)
    private BigDecimal rating;
    
    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public BigDecimal getPrix() { return prix; }
    public void setPrix(BigDecimal prix) { this.prix = prix; }
    
    public BigDecimal getPrixPromo() { return prixPromo; }
    public void setPrixPromo(BigDecimal prixPromo) { this.prixPromo = prixPromo; }
    
    public Integer getQuantite() { return quantite; }
    public void setQuantite(Integer quantite) { this.quantite = quantite; }
    
    public Long getCategorieId() { return categorieId; }
    public void setCategorieId(Long categorieId) { this.categorieId = categorieId; }
    
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    
    public Boolean getIsFeatured() { return isFeatured; }
    public void setIsFeatured(Boolean isFeatured) { this.isFeatured = isFeatured; }
    
    public BigDecimal getRating() { return rating; }
    public void setRating(BigDecimal rating) { this.rating = rating; }
}