<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Erreur de Paiement - E-commerce UMBB</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
               background: linear-gradient(135deg, #f8f9fa, #ffeaea); 
               min-height: 100vh; display: flex; align-items: center; }
        
        .error-container { max-width: 600px; margin: 0 auto; text-align: center; 
                          padding: 3rem; background: white; border-radius: 20px; 
                          box-shadow: 0 20px 40px rgba(0,0,0,0.1); }
        
        .error-icon { font-size: 5rem; color: #e74c3c; margin-bottom: 2rem; }
        
        h1 { color: #e74c3c; margin-bottom: 1rem; }
        .subtitle { color: #666; margin-bottom: 2rem; font-size: 1.2rem; }
        
        .error-details { background: #fff5f5; padding: 1.5rem; border-radius: 10px; 
                        text-align: left; margin: 2rem 0; border-left: 4px solid #e74c3c; }
        
        .solutions { text-align: left; margin: 2rem 0; }
        .solution { display: flex; align-items: flex-start; gap: 1rem; margin: 1rem 0; }
        .solution-number { background: #3498db; color: white; width: 30px; height: 30px; 
                          border-radius: 50%; display: flex; align-items: center; 
                          justify-content: center; font-weight: bold; }
        
        .btn { display: inline-block; padding: 1rem 2rem; margin: 0.5rem; 
              text-decoration: none; border-radius: 5px; font-weight: bold; 
              transition: all 0.3s; }
        .btn-primary { background: #3498db; color: white; }
        .btn-primary:hover { background: #2980b9; transform: translateY(-2px); }
        .btn-secondary { background: #95a5a6; color: white; }
        .btn-secondary:hover { background: #7f8c8d; }
        
        .contact-info { margin-top: 2rem; padding: 1rem; background: #f8f9fa; 
                       border-radius: 5px; }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">❌</div>
        
        <h1>Erreur de Paiement</h1>
        <p class="subtitle">Nous n'avons pas pu traiter votre paiement.</p>
        
        <div class="error-details">
            <h3>Détails de l'erreur</h3>
            <p><strong>Code erreur:</strong> PAY_ERR_<%= System.currentTimeMillis() %></p>
            <p><strong>Message:</strong> ${param.message != null ? param.message : "Transaction refusée par la banque"}</p>
            <p><strong>Date:</strong> <%= new java.util.Date() %></p>
        </div>
        
        <div class="solutions">
            <h3>Que faire maintenant ?</h3>
            
            <div class="solution">
                <div class="solution-number">1</div>
                <div>
                    <strong>Vérifiez vos informations bancaires</strong>
                    <p>Assurez-vous que le numéro de carte, la date d'expiration et le CVV sont corrects.</p>
                </div>
            </div>
            
            <div class="solution">
                <div class="solution-number">2</div>
                <div>
                    <strong>Vérifiez votre solde</strong>
                    <p>Assurez-vous que votre compte dispose des fonds nécessaires.</p>
                </div>
            </div>
            
            <div class="solution">
                <div class="solution-number">3</div>
                <div>
                    <strong>Essayez une autre carte</strong>
                    <p>Si le problème persiste, utilisez une autre carte de paiement.</p>
                </div>
            </div>
            
            <div class="solution">
                <div class="solution-number">4</div>
                <div>
                    <strong>Contactez votre banque</strong>
                    <p>Votre banque peut avoir bloqué la transaction pour des raisons de sécurité.</p>
                </div>
            </div>
        </div>
        
        <div style="margin-top: 2rem;">
            <a href="E_payement.jsp" class="btn btn-primary">🔄 Réessayer le paiement</a>
            <a href="shopping.jsp" class="btn btn-secondary">← Retour aux produits</a>
        </div>
        
        <div class="contact-info">
            <p><strong>Besoin d'aide ?</strong></p>
            <p>📞 Service client: 0550 12 34 56</p>
            <p>📧 Email: support@ecommerce-umbb.dz</p>
        </div>
    </div>
</body>
</html>