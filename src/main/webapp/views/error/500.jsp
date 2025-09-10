<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie9"><![endif]-->
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Access Denied</title>
    <link rel="icon" type="image/png" sizes="96x96" href="<c:url value="/resources/images/protect-favicon.png"/>" >
    <link rel="stylesheet" href="<c:url value="/resources/css/materialize-v.1.0.min.css" />" >
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #e74c3c;
            --accent-color: #3498db;
            --light-color: #ecf0f1;
            --dark-color: #2c3e50;
        }
        
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f7fa;
            color: var(--dark-color);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        
        .nav-wrapper {
            padding: 0 20px;
        }
        
        .error-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .error-card {
            max-width: 500px;
            width: 100%;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        
        .error-card:hover {
            transform: translateY(-5px);
        }
        
        .error-header {
            background-color: var(--secondary-color);
            color: white;
            padding: 20px;
            text-align: center;
        }
        
        .error-icon {
            font-size: 5rem;
            margin-bottom: 20px;
            animation: pulse 1.5s infinite;
        }
        
        .error-content {
            padding: 30px;
            text-align: center;
            background-color: white;
        }
        
        .error-title {
            font-size: 2rem;
            margin-bottom: 15px;
            color: var(--secondary-color);
            font-weight: 500;
        }
        
        .error-message {
            font-size: 1.1rem;
            margin-bottom: 25px;
            color: #555;
        }
        
        .btn-home {
            background-color: var(--primary-color);
            color: white;
            padding: 10px 25px;
            border-radius: 4px;
            text-transform: uppercase;
            font-weight: 500;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }
        
        .btn-home:hover {
            background-color: #1a252f;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .footer-container {
            background-color: var(--primary-color);
            color: white;
            padding: 20px 0;
            text-align: center;
        }
        
        .footer-img {
            height: 40px;
            vertical-align: middle;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }
        
        .shake {
            animation: shake 0.8s cubic-bezier(.36,.07,.19,.97) both;
        }
    </style>
</head>

<body>

    <!-- Header -->
    <nav>
        <div class="nav-wrapper blue darken-3">
           
        </div>
    </nav>

    <!-- Main Content -->
    <div class="error-container">
        <div class="error-card">
            <div class="error-header">
                <i class="material-icons error-icon">block</i>
            </div>
            <div class="error-content">
                <h1 class="error-title">ACCESS DENIED</h1>
                <p class="error-message">
                    You don't have permission to access this page. 
                    Please contact your administrator if you believe this is an error.
                </p>
                <a href="<%=request.getContextPath()%>/fi-d26827851841284wjvwunfuqwhfbwqr7212hfu" class="btn-home waves-effect waves-light">
                    <i class="material-icons left">home</i> Return to Home
                </a>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer-container">
        <div class="container">
            <img src="/reirm/resources/assets/fi.gif" class="footer-img" alt="footer image">
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Add shake animation to the card on page load
            const card = document.querySelector('.error-card');
            card.classList.add('shake');
            
            // Remove the class after animation completes to allow re-animation if needed
            setTimeout(() => {
                card.classList.remove('shake');
            }, 1000);
        });
    </script>

</body>
</html>