<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Récupérer les paramètres
    String produitId = request.getParameter("id");
    String produitNom = request.getParameter("nom");
    String produitPrix = request.getParameter("prix");
    
    if (produitId == null || produitNom == null || produitPrix == null) {
        response.sendRedirect("shopping.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Commander - <%= produitNom %> - E-commerce UMBB</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f8f9fa; }
        
        .header { background: linear-gradient(135deg, #2c3e50, #3498db); color: white; padding: 1.5rem; }
        
        .container { max-width: 800px; margin: 0 auto; padding: 2rem; }
        
        .order-steps { display: flex; justify-content: space-between; margin: 2rem 0; position: relative; }
        .order-steps:before { content: ''; position: absolute; top: 20px; left: 0; right: 0; 
                             height: 2px; background: #ddd; z-index: 1; }
        .step { text-align: center; position: relative; z-index: 2; }
        .step-number { width: 40px; height: 40px; background: #3498db; color: white; 
                      border-radius: 50%; display: flex; align-items: center; 
                      justify-content: center; margin: 0 auto 10px; font-weight: bold; }
        .step.active .step-number { background: #27ae60; }
        .step-label { font-size: 0.9rem; color: #666; }
        
        .form-container { background: white; padding: 2rem; border-radius: 10px; 
                         box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 1.5rem; }
        label { display: block; margin-bottom: 0.5rem; color: #2c3e50; font-weight: 500; }
        input, select, textarea { width: 100%; padding: 0.8rem; border: 1px solid #ddd; 
                                 border-radius: 5px; font-size: 1rem; }
        input:focus, select:focus { outline: none; border-color: #3498db; }
        
        .order-summary { background: #e8f4fc; padding: 1.5rem; border-radius: 10px; margin: 2rem 0; }
        .summary-row { display: flex; justify-content: space-between; margin: 0.5rem 0; }
        .total-row { border-top: 2px solid #3498db; padding-top: 1rem; margin-top: 1rem; 
                    font-size: 1.2rem; font-weight: bold; }
        
        .btn { display: inline-block; padding: 1rem 2rem; background: #27ae60; color: white; 
              text-decoration: none; border-radius: 5px; font-weight: bold; border: none; 
              cursor: pointer; font-size: 1rem; transition: background 0.3s; }
        .btn:hover { background: #219653; }
        .btn-back { background: #95a5a6; }
        .btn-back:hover { background: #7f8c8d; }
        
        .actions { display: flex; justify-content: space-between; margin-top: 2rem; }
    </style>
</head>
<body>
    <div class="header">
        <h1>📝 Commande - <%= produitNom %></h1>
        <p>Remplissez vos informations pour finaliser la commande</p>
    </div>
    
    <div class="container">
        <div class="order-steps">
            <div class="step active">
                <div class="step-number">1</div>
                <div class="step-label">Information</div>
            </div>
            <div class="step">
                <div class="step-number">2</div>
                <div class="step-label">Paiement</div>
            </div>
            <div class="step">
                <div class="step-number">3</div>
                <div class="step-label">Confirmation</div>
            </div>
        </div>
        
        <div class="form-container">
            <form id="orderForm" action="E_payement.jsp" method="post">
                <input type="hidden" name="produitId" value="<%= produitId %>">
                <input type="hidden" name="produitNom" value="<%= produitNom %>">
                <input type="hidden" name="produitPrix" value="<%= produitPrix %>">
                
                <div class="order-summary">
                    <h3>Résumé de la commande</h3>
                    <div class="summary-row">
                        <span>Produit:</span>
                        <span><strong><%= produitNom %></strong></span>
                    </div>
                    <div class="summary-row">
                        <span>Prix unitaire:</span>
                        <span><strong><%= produitPrix %> DA</strong></span>
                    </div>
                    <div class="form-group" style="margin-top: 1rem;">
                        <label for="quantite">Quantité:</label>
                        <select id="quantite" name="quantite" onchange="updateTotal()">
                            <% for(int i = 1; i <= 10; i++) { %>
                                <option value="<%= i %>"><%= i %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="summary-row total-row">
                        <span>Total à payer:</span>
                        <span id="totalAmount"><%= produitPrix %> DA</span>
                    </div>
                </div>
                
                <h3>Informations personnelles</h3>
                <div class="form-group">
                    <label for="nom">Nom complet *</label>
                    <input type="text" id="nom" name="nom" required 
                           placeholder="Ex: Ahmed BENZIANE">
                </div>
                
                <div class="form-group">
                    <label for="email">Adresse email *</label>
                    <input type="email" id="email" name="email" required 
                           placeholder="votre.email@example.com">
                </div>
                
                <div class="form-group">
                    <label for="telephone">Téléphone *</label>
                    <input type="tel" id="telephone" name="telephone" required 
                           placeholder="0550123456">
                </div>
                
                <div class="form-group">
                    <label for="adresse">Adresse de livraison *</label>
                    <textarea id="adresse" name="adresse" rows="3" required 
                              placeholder="Rue, numéro, ville, code postal"></textarea>
                </div>
                
                <div class="actions">
                    <a href="shopping.jsp" class="btn btn-back">← Retour aux produits</a>
                    <button type="submit" class="btn">Procéder au paiement →</button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        function updateTotal() {
            const quantite = document.getElementById('quantite').value;
            const prixUnitaire = <%= produitPrix %>;
            const total = quantite * prixUnitaire;
            document.getElementById('totalAmount').textContent = total.toFixed(2) + ' DA';
        }
        
        // Initialiser le total
        updateTotal();
    </script>
</body>
</html>