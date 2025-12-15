<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.Client" %>
<%
    // Vérifier si déjà connecté
    Client client = (Client) session.getAttribute("client");
    if (client != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion | Online Shop</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --primary-light: #3b82f6;
            --secondary: #10b981;
            --dark: #1e293b;
            --light: #f8fafc;
            --gray: #64748b;
            --light-gray: #e2e8f0;
            --shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            --shadow-hover: 0 8px 20px rgba(37, 99, 235, 0.2);
            --transition: all 0.3s ease;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Montserrat', 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
            color: var(--dark);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
        }
        
        /* Container principal */
        .login-container {
            width: 100%;
            max-width: 480px;
            position: relative;
        }
        
        /* Carte de connexion */
        .login-card {
            background: white;
            border-radius: 16px;
            padding: 3rem 2.5rem;
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
        }
        
        .login-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
        }
        
        /* En-tête */
        .login-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }
        
        .logo-icon {
            font-size: 3rem;
            color: var(--primary);
            margin-bottom: 1rem;
            display: inline-block;
        }
        
        .login-title {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: var(--dark);
            letter-spacing: -0.5px;
        }
        
        .login-subtitle {
            color: var(--gray);
            font-size: 1rem;
            font-weight: 400;
        }
        
        /* Messages d'erreur */
        .error-message {
            background: #fef2f2;
            border: 1px solid #fecaca;
            border-left: 4px solid #ef4444;
            color: #dc2626;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }
        
        .error-message i {
            font-size: 1.2rem;
            margin-top: 2px;
        }
        
        /* Formulaire */
        .login-form {
            margin-bottom: 1.5rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--dark);
            font-weight: 500;
            font-size: 0.95rem;
        }
        
        .form-input {
            width: 100%;
            padding: 1rem;
            background: white;
            border: 2px solid var(--light-gray);
            border-radius: 8px;
            color: var(--dark);
            font-size: 1rem;
            font-family: 'Montserrat', sans-serif;
            transition: var(--transition);
        }
        
        .form-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }
        
        .form-input::placeholder {
            color: #94a3b8;
        }
        
        /* Options */
        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding: 0 0.25rem;
        }
        
        .remember-me {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            color: var(--dark);
            font-size: 0.9rem;
        }
        
        .remember-checkbox {
            width: 16px;
            height: 16px;
            accent-color: var(--primary);
            cursor: pointer;
        }
        
        .forgot-password {
            color: var(--primary);
            text-decoration: none;
            font-size: 0.9rem;
            transition: var(--transition);
        }
        
        .forgot-password:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }
        
        /* Bouton de connexion */
        .login-btn {
            width: 100%;
            padding: 1rem;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            font-family: 'Montserrat', sans-serif;
        }
        
        .login-btn:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }
        
        .login-btn i {
            margin-right: 8px;
        }
        
        /* Ligne séparatrice */
        .separator {
            display: flex;
            align-items: center;
            margin: 2rem 0;
            color: var(--gray);
            font-size: 0.9rem;
        }
        
        .separator::before,
        .separator::after {
            content: '';
            flex: 1;
            height: 1px;
            background: var(--light-gray);
        }
        
        .separator span {
            padding: 0 1rem;
        }
        
        /* Lien d'inscription */
        .register-link {
            text-align: center;
            margin-top: 1.5rem;
        }
        
        .register-text {
            color: var(--gray);
            margin-bottom: 0.75rem;
            font-size: 0.95rem;
        }
        
        .register-btn {
            display: inline-block;
            padding: 0.75rem 2rem;
            background: white;
            color: var(--primary);
            border: 2px solid var(--primary);
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            transition: var(--transition);
        }
        
        .register-btn:hover {
            background: var(--primary);
            color: white;
        }
        
        /* Informations de démonstration */
        .demo-info {
            background: #f8fafc;
            border: 1px solid var(--light-gray);
            border-radius: 10px;
            padding: 1.25rem;
            margin-top: 2rem;
        }
        
        .demo-title {
            color: var(--dark);
            font-weight: 600;
            margin-bottom: 0.75rem;
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .demo-title i {
            color: var(--primary);
        }
        
        .demo-account {
            background: white;
            border-radius: 6px;
            padding: 0.75rem;
            margin-top: 0.5rem;
            border: 1px solid var(--light-gray);
        }
        
        .demo-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem 0;
            border-bottom: 1px solid #f1f5f9;
        }
        
        .demo-item:last-child {
            border-bottom: none;
        }
        
        .demo-label {
            color: var(--gray);
            font-size: 0.85rem;
        }
        
        .demo-value {
            color: var(--dark);
            font-family: monospace;
            font-weight: 500;
            font-size: 0.9rem;
        }
        
        /* Pied de page */
        .login-footer {
            text-align: center;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--light-gray);
            color: var(--gray);
            font-size: 0.85rem;
        }
        
        .login-footer a {
            color: var(--primary);
            text-decoration: none;
            transition: var(--transition);
        }
        
        .login-footer a:hover {
            text-decoration: underline;
        }
        
        /* Effet de chargement */
        .loading {
            display: none;
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 16px;
            z-index: 10;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(4px);
        }
        
        .loading-spinner {
            width: 40px;
            height: 40px;
            border: 3px solid #e2e8f0;
            border-top-color: var(--primary);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-bottom: 1rem;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        /* Notification */
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            background: var(--primary);
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 8px;
            box-shadow: var(--shadow);
            z-index: 1000;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: slideIn 0.3s ease-out;
        }
        
        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        
        @keyframes slideOut {
            from { transform: translateX(0); opacity: 1; }
            to { transform: translateX(100%); opacity: 0; }
        }
        
        /* Responsive */
        @media (max-width: 576px) {
            .login-card {
                padding: 2rem 1.5rem;
            }
            
            .login-title {
                font-size: 1.8rem;
            }
            
            .form-options {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }
            
            .demo-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.25rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-card">
            <!-- Effet de chargement -->
            <div class="loading" id="loading">
                <div class="loading-spinner"></div>
                <p style="color: var(--primary); font-weight: 600;">Connexion en cours...</p>
            </div>
            
            <div class="login-header">
                <div class="logo-icon">
                    <i class="fas fa-shopping-bag"></i>
                </div>
                <h1 class="login-title">Online Shop</h1>
                <p class="login-subtitle">Vos achats en toute simplicité</p>
            </div>
            
            <!-- Messages d'erreur seront affichés dynamiquement -->
            <div id="errorContainer"></div>
            
            <form id="loginForm" class="login-form">
                <div class="form-group">
                    <label for="email" class="form-label">Adresse Email</label>
                    <input type="email" id="email" name="email" class="form-input" 
                           placeholder="exemple@email.com" required>
                </div>
                
                <div class="form-group">
                    <label for="password" class="form-label">Mot de passe</label>
                    <input type="password" id="password" name="password" class="form-input" 
                           placeholder="Votre mot de passe" required>
                </div>
                
                <div class="form-options">
                    <label class="remember-me">
                        <input type="checkbox" name="remember" class="remember-checkbox">
                        <span>Se souvenir de moi</span>
                    </label>
                    
                    <a href="#" class="forgot-password" id="forgotPassword">
                        Mot de passe oublié ?
                    </a>
                </div>
                
                <button type="submit" class="login-btn" id="submitBtn">
                    <i class="fas fa-sign-in-alt"></i> Se connecter
                </button>
            </form>
            
            <div class="separator">
                <span>Première visite ?</span>
            </div>
            
            <div class="register-link">
                <p class="register-text">Créez votre compte gratuitement</p>
                <a href="register.html" class="register-btn">
                    <i class="fas fa-user-plus"></i> Créer un compte
                </a>
            </div>
            
           <!--
            <div class="demo-info">
                <h3 class="demo-title">
                    <i class="fas fa-user-circle"></i> Comptes de démonstration
                </h3>
                <p style="color: var(--gray); font-size: 0.85rem; margin-bottom: 0.75rem;">
                    Utilisez ces identifiants pour tester l'application
                </p>
                
                <div class="demo-account">
                    <div class="demo-item">
                        <span class="demo-label">Email client :</span>
                        <span class="demo-value">ahmed@email.com</span>
                    </div>
                    <div class="demo-item">
                        <span class="demo-label">Mot de passe :</span>
                        <span class="demo-value">password123</span>
                    </div>
                </div>
                
                <div class="demo-account" style="margin-top: 0.75rem;">
                    <div class="demo-item">
                        <span class="demo-label">Email admin :</span>
                        <span class="demo-value">admin@ecommerce.dz</span>
                    </div>
                    <div class="demo-item">
                        <span class="demo-label">Mot de passe :</span>
                        <span class="demo-value">admin123</span>
                    </div>
                </div>
            </div>
            
            <div class="login-footer">
                <p>
                    &copy; 2024 Online Shop. Tous droits réservés.
                    <br>
                    <a href="#">Mentions légales</a> • 
                    <a href="#">Politique de confidentialité</a> • 
                    <a href="#">Conditions d'utilisation</a>
                </p>
            </div>
        </div>
    </div>
    -->
    </body>
</html>
