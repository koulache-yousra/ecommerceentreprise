<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Connexion - E-commerce UMBB</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
               background: linear-gradient(135deg, #f8f9fa, #e8f4fc); 
               min-height: 100vh; display: flex; align-items: center; }
        
        .login-container { max-width: 400px; margin: 0 auto; padding: 2rem; 
                          background: white; border-radius: 15px; 
                          box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        
        .logo { text-align: center; margin-bottom: 2rem; }
        .logo h1 { color: #2c3e50; display: flex; align-items: center; 
                  justify-content: center; gap: 10px; }
        
        .tabs { display: flex; margin-bottom: 2rem; border-bottom: 2px solid #eee; }
        .tab { flex: 1; text-align: center; padding: 1rem; cursor: pointer; 
              border-bottom: 3px solid transparent; }
        .tab.active { border-bottom-color: #3498db; color: #3498db; font-weight: bold; }
        
        .form-container { display: none; }
        .form-container.active { display: block; animation: fadeIn 0.5s; }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .form-group { margin-bottom: 1.5rem; }
        label { display: block; margin-bottom: 0.5rem; color: #2c3e50; font-weight: 500; }
        input { width: 100%; padding: 0.8rem; border: 1px solid #ddd; 
               border-radius: 5px; font-size: 1rem; }
        input:focus { outline: none; border-color: #3498db; }
        
        .btn { width: 100%; padding: 1rem; background: #27ae60; color: white; 
              border: none; border-radius: 5px; font-weight: bold; 
              cursor: pointer; font-size: 1rem; transition: background 0.3s; }
        .btn:hover { background: #219653; }
        
        .forgot-password { text-align: right; margin: 1rem 0; }
        .forgot-password a { color: #3498db; text-decoration: none; }
        
        .demo-info { background: #e8f4fc; padding: 1rem; border-radius: 5px; 
                    margin: 2rem 0; font-size: 0.9rem; }
        
        .nav-links { text-align: center; margin-top: 2rem; }
        .nav-links a { color: #3498db; text-decoration: none; }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo">
            <h1>🔐 E-commerce UMBB</h1>
            <p>Connectez-vous à votre compte</p>
        </div>
        
        <div class="tabs">
            <div class="tab active" onclick="showTab('login')">Connexion</div>
            <div class="tab" onclick="showTab('register')">Inscription</div>
        </div>
        
        <!-- Formulaire Connexion -->
        <div id="loginForm" class="form-container active">
            <form action="LoginServlet" method="post">
                <div class="form-group">
                    <label for="loginEmail">Adresse email</label>
                    <input type="email" id="loginEmail" name="email" required 
                           placeholder="votre.email@example.com">
                </div>
                
                <div class="form-group">
                    <label for="loginPassword">Mot de passe</label>
                    <input type="password" id="loginPassword" name="password" required 
                           placeholder="Votre mot de passe">
                </div>
                
                <div class="forgot-password">
                    <a href="#">Mot de passe oublié ?</a>
                </div>
                
                <button type="submit" class="btn">Se connecter</button>
            </form>
        </div>
        
        <!-- Formulaire Inscription -->
        <div id="registerForm" class="form-container">
            <form action="RegisterServlet" method="post">
                <div class="form-group">
                    <label for="regNom">Nom</label>
                    <input type="text" id="regNom" name="nom" required 
                           placeholder="Votre nom">
                </div>
                
                <div class="form-group">
                    <label for="regPrenom">Prénom</label>
                    <input type="text" id="regPrenom" name="prenom" required 
                           placeholder="Votre prénom">
                </div>
                
                <div class="form-group">
                    <label for="regEmail">Adresse email</label>
                    <input type="email" id="regEmail" name="email" required 
                           placeholder="votre.email@example.com">
                </div>
                
                <div class="form-group">
                    <label for="regPassword">Mot de passe</label>
                    <input type="password" id="regPassword" name="password" required 
                           placeholder="Créez un mot de passe sécurisé">
                </div>
                
                <div class="form-group">
                    <label for="regConfirmPassword">Confirmer le mot de passe</label>
                    <input type="password" id="regConfirmPassword" name="confirmPassword" required 
                           placeholder="Retapez votre mot de passe">
                </div>
                
                <button type="submit" class="btn">S'inscrire</button>
            </form>
        </div>
        
        <div class="demo-info">
            <p><strong>💡 Pour la démonstration :</strong></p>
            <p>Email: <code>client@example.com</code></p>
            <p>Mot de passe: <code>password123</code></p>
        </div>
        
        <div class="nav-links">
            <a href="index.html">← Retour à l'accueil</a> | 
            <a href="shopping.jsp">Continuer sans compte →</a>
        </div>
    </div>
    
    <script>
        function showTab(tabName) {
            // Mettre à jour les tabs
            document.querySelectorAll('.tab').forEach(tab => {
                tab.classList.remove('active');
            });
            event.target.classList.add('active');
            
            // Afficher le formulaire correspondant
            document.getElementById('loginForm').classList.remove('active');
            document.getElementById('registerForm').classList.remove('active');
            document.getElementById(tabName + 'Form').classList.add('active');
        }
        
        // Validation inscription
        document.querySelector('#registerForm form').addEventListener('submit', function(e) {
            const password = document.getElementById('regPassword').value;
            const confirmPassword = document.getElementById('regConfirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Les mots de passe ne correspondent pas !');
            }
        });
    </script>
</body>
</html>