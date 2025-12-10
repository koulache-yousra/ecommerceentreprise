<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Test Connexion BDD</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        .success { color: green; }
        .error { color: red; }
    </style>
</head>
<body>
    <h1>🔧 Test Connexion Base de Données</h1>
    
    <%
        Connection conn = null;
        try {
            // 1. Test connexion directe MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/ecommerce_luxe?useSSL=false", 
                "root", 
                "");
            
            out.println("<p class='success'>✅ Connexion MySQL réussie !</p>");
            
            // 2. Test requête clients
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM clients");
            
            out.println("<h3>👥 Clients dans la base :</h3>");
            out.println("<table border='1'><tr><th>ID</th><th>Nom</th><th>Email</th><th>Mot de passe</th></tr>");
            
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getInt("client_id") + "</td>");
                out.println("<td>" + rs.getString("prenom") + " " + rs.getString("nom") + "</td>");
                out.println("<td>" + rs.getString("email") + "</td>");
                out.println("<td>" + rs.getString("mot_de_passe") + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
            
            // 3. Test comptage produits
            rs = stmt.executeQuery("SELECT COUNT(*) as nb FROM produits");
            if (rs.next()) {
                out.println("<p>📦 Nombre de produits : " + rs.getInt("nb") + "</p>");
            }
            
        } catch (Exception e) {
            out.println("<p class='error'>❌ ERREUR : " + e.getMessage() + "</p>");
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) {}
            }
        }
    %>
    
    <hr>
    <h3>🔗 Tests supplémentaires :</h3>
    <ul>
        <li><a href="http://localhost:8080/E_commerce-war/LoginServlet" target="_blank">
            Test LoginServlet (GET) - Affiche les clients
        </a></li>
        <li><a href="index.jsp" target="_blank">
            Page de connexion
        </a></li>
    </ul>
</body>
</html>