<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Paiement Réussi - E-commerce UMBB</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
               background: linear-gradient(135deg, #f8f9fa, #e8f4fc); 
               min-height: 100vh; display: flex; align-items: center; }
        
        .success-container { max-width: 600px; margin: 0 auto; text-align: center; 
                            padding: 3rem; background: white; border-radius: 20px; 
                            box-shadow: 0 20px 40px rgba(0,0,0,0.1); }
        
        .success-icon { font-size: 5rem; color: #27ae60; margin-bottom: 2rem; 
                       animation: bounce 1s infinite alternate; }
        
        @keyframes bounce {
            from { transform: translateY(0); }
            to { transform: translateY(-20px); }
        }
        
        h1 { color: #27ae60; margin-bottom: 1rem; }
        .subtitle { color: #666; margin-bottom: 2rem; font-size: 1.2rem; }
        
        .details { background: #f8f9fa; padding: 1.5rem; border-radius: 10px; 
                  text-align: left; margin: 2rem 0; }
        .detail-row { display: flex; justify-content: space-between; margin: 0.5rem 0; }
        
        .btn { display: inline-block; padding: 1rem 2rem; margin: 0.5rem; 
              text-decoration: none; border-radius: 5px; font-weight: bold; 
              transition: all 0.3s; }
        .btn-primary { background: #27ae60; color: white; }
        .btn-primary:hover { background: #219653; transform: translateY(-2px); }
        .btn-secondary { background: #3498db; color: white; }
        .btn-secondary:hover { background: #2980b9; }
        
        .confirmation-number { background: #2c3e50; color: white; padding: 1rem; 
                              border-radius: 5px; font-family: monospace; 
                              font-size: 1.2rem; margin: 2rem 0; }
        
        .whats-next { margin-top: 3rem; padding-top: 2rem; border-top: 2px solid #eee; }
        .next-step { display: flex; align-items: center; gap: 1rem; margin: 1rem 0; 
                    text-align: left; }
        .next-step i { font-size: 1.5rem; color: #3498db; }
    </style>
</head>
<body>
    <div class="success-container">
        <div class="success-icon">✅</div>
        
        <h1>Paiement Réussi !</h1>
        <p class="subtitle">Votre commande a été confirmée et sera traitée rapidement.</p>
        
        <div class="confirmation-number">
            N° de confirmation: TX<%= System.currentTimeMillis() %>
        </div>
        
        <div class="details">
            <h3>Détails de la transaction</h3>
            <div class="detail-row">
                <span>Date:</span>
                <span><%= new java.util.Date() %></span>
            </div>
            <div class="detail-row">
                <span>Statut:</span>
                <span style="color: #27ae60; font-weight: bold;">✅ PAYÉ</span>
            </div>
            <div class="detail-row">
                <span>Méthode:</span>
                <span>Carte bancaire</span>
            </div>
            <div class="detail-row">
                <span>Montant:</span>
                <span style="font-weight: bold;">${param.total != null ? param.total : "0.00"} DA</span>
            </div>
        </div>
        
        <div class="whats-next">
            <h3>Prochaines étapes</h3>
            <div class="next-step">
                <span>📧</span>
                <div>
                    <strong>Email de confirmation</strong>
                    <p>Vous recevrez un email avec les détails de votre commande</p>
                </div>
            </div>
            <div class="next-step">
                <span>📦</span>
                <div>
                    <strong>Préparation de commande</strong>
                    <p>Votre commande sera préparée sous 24-48 heures</p>
                </div>
            </div>
            <div class="next-step">
                <span>🚚</span>
                <div>
                    <strong>Livraison</strong>
                    <p>Vous serez notifié lors de l'expédition</p>
                </div>
            </div>
        </div>
        
        <div style="margin-top: 3rem;">
            <a href="shopping.jsp" class="btn btn-primary">🛒 Continuer mes achats</a>
            <a href="index.html" class="btn btn-secondary">🏠 Retour à l'accueil</a>
        </div>
        
        <p style="margin-top: 2rem; color: #666; font-size: 0.9rem;">
            Merci de votre confiance ! Pour toute question, contactez-nous à support@ecommerce-umbb.dz
        </p>
    </div>
</body>
</html>