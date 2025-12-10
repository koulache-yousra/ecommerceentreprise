<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Récupérer les paramètres
    String produitId = request.getParameter("produitId");
    String produitNom = request.getParameter("produitNom");
    String produitPrix = request.getParameter("produitPrix");
    String quantite = request.getParameter("quantite");
    String nomClient = request.getParameter("nom");
    String email = request.getParameter("email");
    
    if (produitId == null) {
        response.sendRedirect("shopping.jsp");
        return;
    }
    
    // Calculer le total
    double prix = Double.parseDouble(produitPrix);
    int qte = Integer.parseInt(quantite != null ? quantite : "1");
    double total = prix * qte;
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Paiement Sécurisé - E-commerce UMBB</title>
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
        .step.completed .step-number { background: #27ae60; }
        .step.active .step-number { background: #e74c3c; }
        .step-label { font-size: 0.9rem; color: #666; }
        
        .payment-container { display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; 
                            margin-top: 2rem; }
        @media (max-width: 768px) { .payment-container { grid-template-columns: 1fr; } }
        
        .order-summary-card, .payment-form-card { 
            background: white; padding: 2rem; border-radius: 10px; 
            box-shadow: 0 5px 15px rgba(0,0,0,0.1); 
        }
        
        .payment-form-card { background: linear-gradient(135deg, #2c3e50, #34495e); color: white; }
        
        .summary-item { display: flex; justify-content: space-between; margin: 1rem 0; }
        .total { border-top: 2px solid #3498db; padding-top: 1rem; margin-top: 1rem; 
                font-size: 1.3rem; font-weight: bold; }
        
        .security-info { background: #e8f4fc; padding: 1rem; border-radius: 5px; 
                        margin: 1rem 0; display: flex; align-items: center; gap: 10px; }
        
        .form-group { margin-bottom: 1.5rem; }
        label { display: block; margin-bottom: 0.5rem; font-weight: 500; }
        .payment-form-card label { color: #ecf0f1; }
        input { width: 100%; padding: 0.8rem; border: 1px solid #ddd; border-radius: 5px; 
               font-size: 1rem; }
        .payment-form-card input { background: rgba(255,255,255,0.1); color: white; 
                                  border-color: #7f8c8d; }
        input:focus { outline: none; border-color: #3498db; }
        .payment-form-card input:focus { border-color: #1abc9c; }
        
        .card-icons { display: flex; gap: 10px; margin: 1rem 0; font-size: 2rem; }
        
        .btn { display: inline-block; padding: 1rem 2rem; background: #27ae60; color: white; 
              text-decoration: none; border-radius: 5px; font-weight: bold; border: none; 
              cursor: pointer; font-size: 1rem; transition: background 0.3s; width: 100%; 
              text-align: center; }
        .btn:hover { background: #219653; }
        .btn-back { background: #95a5a6; }
        .btn-back:hover { background: #7f8c8d; }
        
        .actions { display: flex; gap: 1rem; margin-top: 2rem; }
        
        .payment-methods { display: flex; gap: 1rem; margin: 1rem 0; }
        .method { flex: 1; text-align: center; padding: 1rem; border: 2px solid #ddd; 
                 border-radius: 5px; cursor: pointer; }
        .method.active { border-color: #27ae60; background: rgba(39, 174, 96, 0.1); }
        
        .cvv-info { display: flex; align-items: center; gap: 10px; margin-top: 0.5rem; 
                   font-size: 0.9rem; color: #7f8c8d; }
    </style>
</head>
<body>
    <div class="header">
        <h1>💳 Paiement Sécurisé</h1>
        <p>Finalisez votre achat en toute sécurité</p>
    </div>
    
    <div class="container">
        <div class="order-steps">
            <div class="step completed">
                <div class="step-number">✓</div>
                <div class="step-label">Commande</div>
            </div>
            <div class="step active">
                <div class="step-number">2</div>
                <div class="step-label">Paiement</div>
            </div>
            <div class="step">
                <div class="step-number">3</div>
                <div class="step-label">Confirmation</div>
            </div>
        </div>
        
        <div class="security-info">
            <span style="color: #27ae60; font-size: 1.5rem;">🔒</span>
            <div>
                <strong>Paiement 100% sécurisé</strong>
                <p style="margin: 0; font-size: 0.9rem;">Vos informations bancaires sont cryptées et protégées</p>
            </div>
        </div>
        
        <div class="payment-container">
            <div class="order-summary-card">
                <h3>Récapitulatif de commande</h3>
                <div class="summary-item">
                    <span>Produit:</span>
                    <span><strong><%= produitNom %></strong></span>
                </div>
                <div class="summary-item">
                    <span>Quantité:</span>
                    <span><strong><%= quantite %></strong></span>
                </div>
                <div class="summary-item">
                    <span>Prix unitaire:</span>
                    <span><strong><%= String.format("%.2f", prix) %> DA</strong></span>
                </div>
                <div class="summary-item total">
                    <span>Total à payer:</span>
                    <span style="color: #27ae60; font-size: 1.5em;">
                        <strong><%= String.format("%.2f", total) %> DA</strong>
                    </span>
                </div>
                
                <div style="margin-top: 2rem; padding-top: 1rem; border-top: 1px solid #eee;">
                    <h4>Informations client</h4>
                    <p><strong>Nom:</strong> <%= nomClient != null ? nomClient : "Non spécifié" %></p>
                    <p><strong>Email:</strong> <%= email != null ? email : "Non spécifié" %></p>
                </div>
            </div>
            
            <div class="payment-form-card">
                <h3>Informations de paiement</h3>
                
                <form id="paymentForm" action="PaiementServlet" method="post">
                    <input type="hidden" name="produitId" value="<%= produitId %>">
                    <input type="hidden" name="total" value="<%= total %>">
                    <input type="hidden" name="quantite" value="<%= quantite %>">
                    
                    <div class="payment-methods">
                        <div class="method active" onclick="selectMethod('carte')">
                            <div style="font-size: 2rem;">💳</div>
                            <div>Carte bancaire</div>
                        </div>
                        <div class="method" onclick="selectMethod('paypal')">
                            <div style="font-size: 2rem;">🇵</div>
                            <div>PayPal</div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="nomCarte">Nom sur la carte *</label>
                        <input type="text" id="nomCarte" name="nomCarte" required 
                               placeholder="MOHAMED BENZIANE">
                    </div>
                    
                    <div class="form-group">
                        <label for="numeroCarte">Numéro de carte *</label>
                        <input type="text" id="numeroCarte" name="numeroCarte" required 
                               placeholder="1234 5678 9012 3456" maxlength="19"
                               oninput="formatCardNumber(this)">
                    </div>
                    
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                        <div class="form-group">
                            <label for="dateExp">Expiration (MM/AA) *</label>
                            <input type="text" id="dateExp" name="dateExp" required 
                                   placeholder="12/25" maxlength="5"
                                   oninput="formatExpiryDate(this)">
                        </div>
                        <div class="form-group">
                            <label for="cvv">CVV *</label>
                            <input type="password" id="cvv" name="cvv" required 
                                   placeholder="123" maxlength="4">
                            <div class="cvv-info">
                                <span>🔍</span>
                                <span>3 ou 4 chiffres au dos de la carte</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card-icons">
                        <span>🔵</span>
                        <span>💳</span>
                        <span>🏦</span>
                        <span>💲</span>
                    </div>
                    
                    <div class="actions">
                        <a href="commander.jsp?id=<%= produitId %>&nom=<%= produitNom %>&prix=<%= produitPrix %>" 
                           class="btn btn-back">← Modifier la commande</a>
                        <button type="submit" class="btn" onclick="processPayment(event)">
                            Payer <%= String.format("%.2f", total) %> DA →
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script>
        function selectMethod(method) {
            document.querySelectorAll('.method').forEach(el => el.classList.remove('active'));
            event.target.closest('.method').classList.add('active');
        }
        
        function formatCardNumber(input) {
            let value = input.value.replace(/\D/g, '');
            let formatted = '';
            for (let i = 0; i < value.length; i++) {
                if (i > 0 && i % 4 === 0) formatted += ' ';
                formatted += value[i];
            }
            input.value = formatted.substring(0, 19);
        }
        
        function formatExpiryDate(input) {
            let value = input.value.replace(/\D/g, '');
            if (value.length >= 2) {
                value = value.substring(0, 2) + '/' + value.substring(2, 4);
            }
            input.value = value.substring(0, 5);
        }
        
        function processPayment(e) {
            e.preventDefault();
            
            // Validation simple
            const numeroCarte = document.getElementById('numeroCarte').value.replace(/\s/g, '');
            const dateExp = document.getElementById('dateExp').value;
            const cvv = document.getElementById('cvv').value;
            
            if (numeroCarte.length < 16) {
                alert('Numéro de carte invalide (16 chiffres requis)');
                return;
            }
            
            if (!/^\d{2}\/\d{2}$/.test(dateExp)) {
                alert('Format de date invalide (MM/AA requis)');
                return;
            }
            
            if (cvv.length < 3) {
                alert('CVV invalide (3 ou 4 chiffres requis)');
                return;
            }
            
            // Simulation de traitement
            document.getElementById('paymentForm').submit();
        }
    </script>
</body>
</html>