package entities;

import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "Paiement")
public class Paiement implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @OneToOne
    @JoinColumn(name = "commande_id", nullable = false, unique = true)
    private Commande commande;
    
    @Column(nullable = false)
    private Double montant;
    
    @Temporal(TemporalType.TIMESTAMP)
    private Date datePaiement;
    
    private String statut; // "EN_ATTENTE", "PAYE", "ECHEC", "REMBOURSE"
    
    private String numeroTransaction;
    private String methodePaiement; // "CARTE", "PAYPAL", "VIREMENT"
    
    private String numeroCarte; // Masqué en base: "**** **** **** 1234"
    private String banque;
    
    // Constructeurs
    public Paiement() {
        this.datePaiement = new Date();
        this.statut = "EN_ATTENTE";
        this.methodePaiement = "CARTE";
    }
    
    public Paiement(Commande commande, Double montant) {
        this();
        this.commande = commande;
        this.montant = montant;
        this.numeroTransaction = "TX" + System.currentTimeMillis();
    }
    
    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public Commande getCommande() { return commande; }
    public void setCommande(Commande commande) { this.commande = commande; }
    
    public Double getMontant() { return montant; }
    public void setMontant(Double montant) { this.montant = montant; }
    
    public Date getDatePaiement() { return datePaiement; }
    public void setDatePaiement(Date datePaiement) { this.datePaiement = datePaiement; }
    
    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }
    
    public String getNumeroTransaction() { return numeroTransaction; }
    public void setNumeroTransaction(String numeroTransaction) { this.numeroTransaction = numeroTransaction; }
    
    public String getMethodePaiement() { return methodePaiement; }
    public void setMethodePaiement(String methodePaiement) { this.methodePaiement = methodePaiement; }
    
    public String getNumeroCarte() { return numeroCarte; }
    public void setNumeroCarte(String numeroCarte) { this.numeroCarte = numeroCarte; }
    
    public String getBanque() { return banque; }
    public void setBanque(String banque) { this.banque = banque; }
    
    @Override
    public String toString() {
        return "Paiement{" + "id=" + id + ", montant=" + montant + 
               ", statut=" + statut + ", transaction=" + numeroTransaction + '}';
    }

    public void setMontant(BigDecimal montant) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}