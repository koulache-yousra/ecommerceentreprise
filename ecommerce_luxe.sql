

CREATE DATABASE ecommerce_luxe;
USE ecommerce_luxe;

-- Table Clients améliorée
CREATE TABLE clients (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL,
    telephone VARCHAR(20),
    adresse TEXT,
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    role ENUM('CLIENT', 'ADMIN') DEFAULT 'CLIENT',
    avatar_url VARCHAR(255) DEFAULT '/images/avatars/default.png'
);

-- Table Catégories
CREATE TABLE categories (
    categorie_id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    description TEXT,
    icone VARCHAR(50)
);

-- Table Produits améliorée
CREATE TABLE produits (
    produit_id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    description TEXT,
    prix DECIMAL(10,2) NOT NULL,
    prix_promo DECIMAL(10,2),
    quantite INT NOT NULL DEFAULT 0,
    categorie_id INT,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_featured BOOLEAN DEFAULT FALSE,
    rating DECIMAL(3,2) DEFAULT 0.0,
    FOREIGN KEY (categorie_id) REFERENCES categories(categorie_id)
);

-- Table Panier (Nouveau !)
CREATE TABLE panier (
    panier_id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT NOT NULL,
    produit_id INT NOT NULL,
    quantite INT NOT NULL DEFAULT 1,
    date_ajout TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE CASCADE,
    FOREIGN KEY (produit_id) REFERENCES produits(produit_id) ON DELETE CASCADE,
    UNIQUE KEY unique_panier (client_id, produit_id)
);

-- Table Commandes améliorée
CREATE TABLE commandes (
    commande_id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT NOT NULL,
    date_commande TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    statut ENUM('PANIER', 'EN_ATTENTE', 'VALIDEE', 'EXPEDIEE', 'LIVREE', 'ANNULEE') DEFAULT 'EN_ATTENTE',
    total DECIMAL(10,2) NOT NULL,
    adresse_livraison TEXT,
    notes TEXT,
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

-- Table Détails Commande
CREATE TABLE details_commande (
    detail_id INT PRIMARY KEY AUTO_INCREMENT,
    commande_id INT NOT NULL,
    produit_id INT NOT NULL,
    quantite INT NOT NULL,
    prix_unitaire DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (commande_id) REFERENCES commandes(commande_id) ON DELETE CASCADE,
    FOREIGN KEY (produit_id) REFERENCES produits(produit_id)
);

-- Table Paiements
CREATE TABLE paiements (
    paiement_id INT PRIMARY KEY AUTO_INCREMENT,
    commande_id INT UNIQUE NOT NULL,
    montant DECIMAL(10,2) NOT NULL,
    methode ENUM('CARTE', 'PAYPAL', 'VIREMENT') DEFAULT 'CARTE',
    statut ENUM('EN_ATTENTE', 'PAYE', 'ECHEC', 'REMBOURSE') DEFAULT 'EN_ATTENTE',
    date_paiement TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    transaction_id VARCHAR(100),
    FOREIGN KEY (commande_id) REFERENCES commandes(commande_id)
);

-- Insertion de données de test
INSERT INTO categories (nom, description, icone) VALUES
('Électronique', 'Ordinateurs, smartphones, tablettes', '💻'),
('Mode', 'Vêtements, chaussures, accessoires', '👕'),
('Maison', 'Meubles, décoration, électroménager', '🏠'),
('Beauté', 'Cosmétiques, parfums, soins', '💄'),
('Sport', 'Équipements sportifs, vêtements', '⚽');

INSERT INTO produits (nom, description, prix, prix_promo, quantite, categorie_id, image_url, is_featured, rating) VALUES
('MacBook Pro 16" M3', 'Ordinateur portable Apple avec puce M3, 16GB RAM, 1TB SSD', 2499.99, 2299.99, 15, 1, '/images/products/macbook.jpg', TRUE, 4.8),
('iPhone 15 Pro Max', 'Smartphone Apple 256GB, écran 6.7", caméra 48MP', 1299.99, NULL, 30, 1, '/images/products/iphone.jpg', TRUE, 4.9),
('Samsung Galaxy S24', 'Smartphone Android 128GB, écran AMOLED 6.2"', 899.99, 849.99, 25, 1, '/images/products/samsung.jpg', TRUE, 4.7),
('Casque Sony WH-1000XM5', 'Casque sans fil avec réduction de bruit active', 349.99, 329.99, 40, 1, '/images/products/sony.jpg', FALSE, 4.6),
('Montre Apple Watch Series 9', 'Montre connectée GPS + Cellular, 45mm', 499.99, 469.99, 20, 1, '/images/products/apple-watch.jpg', TRUE, 4.5),
('T-shirt Premium Coton', 'T-shirt 100% coton biologique, coupe slim', 49.99, 39.99, 100, 2, '/images/products/tshirt.jpg', FALSE, 4.3),
('Chaussures Running Nike', 'Chaussures de course légères, amorti Air Max', 129.99, NULL, 50, 5, '/images/products/nike.jpg', TRUE, 4.4);

-- Clients de test (mot de passe = "password123" hashé)
INSERT INTO clients (nom, prenom, email, mot_de_passe, telephone, adresse, role) VALUES
('Benziane', 'Ahmed', 'ahmed@email.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MrqK3.7Z7.6YJ.9Q7J.1V2B6a8b9c0d', '0550123456', '123 Rue des Fleurs, Alger', 'CLIENT'),
('Martin', 'Sophie', 'sophie@email.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MrqK3.7Z7.6YJ.9Q7J.1V2B6a8b9c0d', '0550654321', '456 Avenue de la République, Oran', 'CLIENT'),
('Admin', 'System', 'admin@ecommerce.dz', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MrqK3.7Z7.6YJ.9Q7J.1V2B6a8b9c0d', '0550000000', '789 Boulevard des Martyrs, Alger', 'ADMIN');

-- Panier de test
INSERT INTO panier (client_id, produit_id, quantite) VALUES
(1, 2, 1),
(1, 4, 2),
(2, 1, 1);

