<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, entities.Produit" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Catalogue Produits - E-commerce UMBB</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f8f9fa; }
        
        .header { background: linear-gradient(135deg, #2c3e50, #3498db); color: white; padding: 1.5rem; }
        .header h1 { display: flex; align-items: center; gap: 10px; }
        
        .container { max-width: 1200px; margin: 0 auto; padding: 2rem; }
        
        .products-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); 
                        gap: 2rem; margin-top: 2rem; }
        .product-card { background: white; border-radius: 10px; overflow: hidden; 
                       box-shadow: 0 5px 15px rgba(0,0,0,0.1); transition: transform 0.3s; }
        .product-card:hover { transform: translateY(-5px); }
        .product-img { height: 200px; background: #3498db; display: flex; align-items: center; 
                      justify-content: center; color: white; font-size: 3rem; }
        .product-info { padding: 1.5rem; }
        .product-title { font-size: 1.3rem; color: #2c3e50; margin-bottom: 0.5rem; }
        .product-desc { color: #666; margin-bottom: 1rem; font-size: 0.9rem; }
        .product-price { font-size: 1.5rem; color: #27ae60; font-weight: bold; margin-bottom: 1rem; }
        .product-stock { display: inline-block; padding: 0.3rem 0.8rem; background: #e8f4fc; 
                        border-radius: 20px; font-size: 0.9rem; margin-bottom: 1rem; }
        .btn-order { background: #27ae60; color: white; padding: 0.8rem 1.5rem; 
                    text-decoration: none; border-radius: 5px; display: inline-block; 
                    font-weight: bold; transition: background 0.3s; }
        .btn-order:hover { background: #219653; }
        
        .nav-links { display: flex; gap: 1rem; margin-top: 2rem; }
        .nav-btn { padding: 0.8rem 1.5rem; background: #3498db; color: white; 
                  text-decoration: none; border-radius: 5px; }
        
        .empty-state { text-align: center; padding: 3rem; color: #666; }
        .empty-state i { font-size: 4rem; color: #ddd; margin-bottom: 1rem; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🛍️ Catalogue des Produits</h1>
        <p>Commandez en ligne et payez en toute sécurité</p>
    </div>
    
    <div class="container">
        <div class="nav-links">
           
            <a href="index.jsp" class="nav-btn">🔐 Deconnexion</a>
        </div>
        
        <div class="products-grid">
            <!-- Produit 1 -->
            <div class="product-card">
                <div class="product-img">💻</div>
                <div class="product-info">
                    <h3 class="product-title">Laptop Dell XPS 15</h3>
                    <p class="product-desc">Ordinateur portable 15 pouces, 16GB RAM, SSD 512GB, écran 4K</p>
                    <div class="product-price">1299.99 DA</div>
                    <span class="product-stock">📦 En stock: 10 unités</span><br>
                    <a href="commander.jsp?id=1&nom=Laptop Dell XPS 15&prix=1299.99" class="btn-order">
                        🛒 Commander
                    </a>
                </div>
            </div>
            
            <!-- Produit 2 -->
            <div class="product-card">
                <div class="product-img">📱</div>
                <div class="product-info">
                    <h3 class="product-title">Smartphone Samsung S21</h3>
                    <p class="product-desc">Téléphone Android 128GB, 6.2 pouces, triple caméra, 5G</p>
                    <div class="product-price">899.99 DA</div>
                    <span class="product-stock">📦 En stock: 25 unités</span><br>
                    <a href="commander.jsp?id=2&nom=Smartphone Samsung S21&prix=899.99" class="btn-order">
                        🛒 Commander
                    </a>
                </div>
            </div>
            
            <!-- Produit 3 -->
            <div class="product-card">
                <div class="product-img">🎧</div>
                <div class="product-info">
                    <h3 class="product-title">Casque Audio Sony</h3>
                    <p class="product-desc">Casque sans fil avec réduction de bruit active, 30h autonomie</p>
                    <div class="product-price">299.99 DA</div>
                    <span class="product-stock">📦 En stock: 15 unités</span><br>
                    <a href="commander.jsp?id=3&nom=Casque Audio Sony&prix=299.99" class="btn-order">
                        🛒 Commander
                    </a>
                </div>
            </div>
            
            <!-- Produit 4 -->
            <div class="product-card">
                <div class="product-img">⌚</div>
                <div class="product-info">
                    <h3 class="product-title">Smartwatch Apple Watch</h3>
                    <p class="product-desc">Montre connectée GPS, écran OLED, suivi santé et sport</p>
                    <div class="product-price">450.00 DA</div>
                    <span class="product-stock">📦 En stock: 8 unités</span><br>
                    <a href="commander.jsp?id=4&nom=Smartwatch Apple Watch&prix=450.00" class="btn-order">
                        🛒 Commander
                    </a>
                </div>
            </div>
        </div>
        
        
    </div>
</body>
</html>