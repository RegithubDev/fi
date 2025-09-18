<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Compliance Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/animate.css@4.1.1/animate.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gov-blue: #0d47a1; /* A deep, official blue */
            --secondary-gov-blue: #1565c0;
            --accent-color: #ffc107; /* A contrasting gold/yellow for accents */
            --card-bg: #ffffff;
            --text-color: #212529;
            --text-muted-color: #5a6268;
            --header-bg: #ffffff;
            --body-bg: #eef2f5; /* A very light grey */
            --shadow-color: rgba(0, 0, 0, 0.08);
            --border-color: #dee2e6;
        }

        body {
            font-family: 'Roboto', sans-serif;
            background-color: var(--body-bg);
            color: var(--text-color);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .navbar {
            background-color: var(--header-bg);
            border-bottom: 3px solid var(--primary-gov-blue);
            box-shadow: 0 2px 8px var(--shadow-color);
            padding: 0.75rem 0;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.6rem;
            color: var(--primary-gov-blue) !important;
        }
        .navbar-brand i {
            margin-right: 8px;
        }
.logo-img{
    height: 40px!important;
    filter: brightness(1.2)!important;
}
        .navbar-nav .nav-link {
            color: var(--text-color) !important;
            font-weight: 500;
            margin-left: 1.5rem;
            transition: color 0.2s ease;
            border-bottom: 2px solid transparent;
            padding-bottom: 5px;
        }

        .navbar-nav .nav-link:hover, .dropdown-toggle:hover {
            color: var(--primary-gov-blue) !important;
            border-bottom-color: var(--primary-gov-blue);
        }

        .dropdown-menu {
            border: 1px solid var(--border-color);
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            animation: fadeIn 0.2s ease-out;
        }

        .dropdown-item {
            font-weight: 500;
            padding: 0.6rem 1.2rem;
            transition: background-color 0.2s ease;
        }

        .dropdown-item:hover {
            background-color: var(--body-bg);
            color: var(--primary-gov-blue);
        }

        .dashboard-header {
            padding: 3rem 0;
            text-align: center;
            background-color: #ffffff;
            border-bottom: 1px solid var(--border-color);
        }

        .dashboard-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-gov-blue);
            margin-bottom: 0.5rem;
        }

        .dashboard-subtitle {
            font-size: 1.1rem;
            color: var(--text-muted-color);
            max-width: 700px;
            margin: 0 auto;
        }

        .card-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2.5rem;
            padding: 4rem 0;
        }

        .compliance-card {
            background-color: var(--card-bg);
            border-radius: 8px;
            padding: 2rem;
            text-align: left;
            text-decoration: none;
            color: var(--text-color);
            box-shadow: 0 4px 15px var(--shadow-color);
            transition: all 0.3s ease-in-out;
            border: 1px solid var(--border-color);
            border-left: 5px solid;
        }
        
        .compliance-card.pf { border-left-color: #3498db; }
        .compliance-card.esi { border-left-color: #e74c3c; }
        .compliance-card.pt { border-left-color: #2ecc71; }

        .compliance-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.12);
            border-left-width: 8px;
        }

        .card-header {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }

        .card-icon {
            font-size: 2.5rem;
            margin-right: 1.5rem;
            width: 60px;
            height: 60px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background-color: var(--body-bg);
        }

        .compliance-card.pf .card-icon { color: #3498db; }
        .compliance-card.esi .card-icon { color: #e74c3c; }
        .compliance-card.pt .card-icon { color: #2ecc71; }

        .card-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin: 0;
        }

        .card-subtitle {
            font-size: 0.95rem;
            color: var(--text-muted-color);
            line-height: 1.6;
        }
        
        .btn-logout {
            background-color: var(--primary-gov-blue);
            border: none;
            border-radius: 6px;
            padding: 0.5rem 1.2rem;
            color: white !important;
            font-weight: 500;
            transition: background-color 0.2s ease;
        }

        .btn-logout:hover {
            background-color: var(--secondary-gov-blue);
        }

        footer {
            background-color: var(--primary-gov-blue);
            color: #ffffff;
            padding: 1.5rem 0;
            text-align: center;
            font-size: 0.9rem;
            margin-top: auto;
        }
        
        footer a {
            color: var(--accent-color);
            text-decoration: none;
            font-weight: 500;
        }
        
        footer a:hover {
            text-decoration: underline;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 992px) {
            .dashboard-title { font-size: 2.2rem; }
            .card-container { gap: 1.5rem; }
        }

        @media (max-width: 768px) {
            .dashboard-title { font-size: 2rem; }
            .dashboard-subtitle { font-size: 1rem; }
            .card-container { grid-template-columns: 1fr; padding: 2rem 0; }
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="#"><img src="/reirm/resources/ai/img/Logo-red-1 (1).svg" alt="Logo" class="logo-img"></i> Re FinCompliance</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <c:if test="${sessionScope.ROLE eq 'SA' || sessionScope.ROLE eq 'Admin' }">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="mastersDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Masters
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="mastersDropdown">
                                <li><a class="dropdown-item" href="<%=request.getContextPath()%>/user">Users</a></li>
<!--  <li><a class="dropdown-item" href="<%=request.getContextPath()%>/sbu">SBU</a></li>  -->
                        </ul>
                        </li>
                    </c:if>
                    <li class="nav-item">
                        <a class="btn btn-logout" href="<%=request.getContextPath()%>/logout">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="dashboard-header">
        <div class="container">
            <h1 class="dashboard-title animate__animated animate__fadeInDown">Compliance Services Portal</h1>
            <p class="dashboard-subtitle animate__animated animate__fadeInUp animate__delay-0_2s">Official portal for managing Provident Fund, State Insurance, and Professional Tax compliance.</p>
        </div>
    </div>

    <div class="container">
        <div class="card-container">
            <!-- PF Card -->
            <a href="<%=request.getContextPath()%>/pf" class="compliance-card pf animate__animated animate__fadeInUp animate__delay-0_2s">
                <div class="card-header">
                    <div class="card-icon"><i class="fas fa-piggy-bank"></i></div>
                    <h2 class="card-title">Provident Fund</h2>
                </div>
                <div class="card-subtitle">Access services for PF contributions, view statements, and manage employee accounts.</div>
            </a>
            
            <!-- ESI Card -->
            <a href="<%=request.getContextPath()%>/esi" class="compliance-card esi animate__animated animate__fadeInUp animate__delay-0_4s">
                <div class="card-header">
                    <div class="card-icon"><i class="fas fa-hospital-user"></i></div>
                    <h2 class="card-title">Employees State Insurance</h2>
                </div>
                <div class="card-subtitle">Complete ESI filings, manage employee benefits, and access related insurance services.</div>
            </a>
            
            <!-- PT Card -->
            <a href="<%=request.getContextPath()%>/pt" class="compliance-card pt animate__animated animate__fadeInUp animate__delay-0_6s">
                <div class="card-header">
                    <div class="card-icon"><i class="fas fa-file-invoice-dollar"></i></div>
                    <h2 class="card-title">Professional Tax</h2>
                </div>
                <div class="card-subtitle">Handle all aspects of Professional Tax, including calculations, payments, and filings.</div>
            </a>
            
               <a href="<%=request.getContextPath()%>/inventory" class="compliance-card pt animate__animated animate__fadeInUp animate__delay-0_6s">
                <div class="card-header">
                    <div class="card-icon"><i class="fas fa-file-invoice-dollar"></i></div>
                    <h2 class="card-title">Inventory</h2>
                </div>
                <div class="card-subtitle"></div>
            </a>
            
            
        </div>
    </div>

    <footer>
        <div class="container">
            <p class="mb-0">
                COPYRIGHT &copy; <span id="currentYear"></span> | Powered by 
                <a href="https://resustainability.com/" target="_blank">Re Sustainability Limited</a>.
                All Rights Reserved.
            </p>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            document.getElementById("currentYear").textContent = new Date().getFullYear();
            
            // Use shorter animation delays
            const elements = document.querySelectorAll('.animate__animated');
            elements.forEach(el => {
                const delay = el.style.animationDelay;
                if (delay) {
                    const newDelay = parseFloat(delay.replace('s', '')) / 2 + 's';
                    el.style.animationDelay = newDelay;
                }
            });
        });
    </script>
</body>
</html>
