package entities;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "clients")  // CHANGÉ : "clients" (avec 's') pas "Client"
public class Client implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "client_id")  // CHANGÉ
    private Long id;
    
    @Column(name = "nom")
    private String nom;
    
    @Column(name = "prenom")
    private String prenom;
    
    @Column(name = "email", unique = true, nullable = false)
    private String email;
    
    @Column(name = "mot_de_passe")  // CHANGÉ
    private String motDePasse;
    
    @Column(name = "telephone")
    private String telephone;
    
    @Column(name = "adresse")
    private String adresse;
    
    @Column(name = "role")
    private String role;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "date_inscription")
    private Date dateInscription;
    
    // Constructeurs
    public Client() {
        this.dateInscription = new Date();
    }
    
    // Getters et Setters (ALT + INSERT pour générer)
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    
    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getMotDePasse() { return motDePasse; }
    public void setMotDePasse(String motDePasse) { this.motDePasse = motDePasse; }
    
    public String getTelephone() { return telephone; }
    public void setTelephone(String telephone) { this.telephone = telephone; }
    
    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }
    
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    
    public Date getDateInscription() { return dateInscription; }
    public void setDateInscription(Date dateInscription) { this.dateInscription = dateInscription; }
}