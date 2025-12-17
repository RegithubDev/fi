<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Compliance Dashboard</title>

    <!-- CDNs -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">

    <style>
        :root {
            --primary: #0d47a1;
            --primary-light: #1565c0;
            --accent: #ffc107;
            --bg: #f5f9ff;
            --card-bg: rgba(255, 255, 255, 0.85);
            --shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
            --border: rgba(0, 0, 0, 0.1);
        }

        * { box-sizing: border-box; }
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #e3f2fd 0%, #fff3cd 100%);
            color: #212529;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
        }

        /* Navbar */
        .navbar {
           background: rgba(13, 110, 253, 0.25);
    border-bottom: 3px solid #f8f9fa;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            animation: slideDown 0.6s ease-out;
        }
        .navbar-brand img { height: 38px; }
        .nav-link {
            font-weight: 500;
            color: #333 !important;
            position: relative;
            transition: color .2s;
            opacity: 0;
            animation: fadeInUp 0.5s ease forwards;
            animation-delay: calc(0.1s * var(--i));
        }
        .nav-link:hover { color: var(--primary) !important; }
        .nav-link::after {
            content: '';
            position: absolute;
            width: 0; height: 2px;
            bottom: -6px; left: 50%;
            background: var(--primary);
            transition: all .3s;
            transform: translateX(-50%);
        }
        .nav-link:hover::after { width: 70%; }

        /* Hero */
        .hero {
            text-align: center;
            padding: 4rem 1rem;
            background: rgba(255,255,255,0.9);
        }
        .hero h1 {
            font-size: 2.8rem;
            font-weight: 700;
            color: var(--primary);
            animation: bounceInDown 1s ease;
        }
        .hero p {
            max-width: 720px;
            margin: 1rem auto;
            color: #555;
            animation: fadeInUp 1s ease 0.4s both;
        }

        /* Cards Grid - 4 Cards in One Row */
        .card-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 4 equal columns */
            gap: 2rem;
            padding: 3rem 1rem;
        }

        /* Mobile: Horizontal Scroll */
        @media (max-width: 992px) {
            .card-grid {
                grid-template-columns: none;
                grid-auto-flow: column;
                grid-auto-columns: 80%; /* Each card takes 80% width */
                overflow-x: auto;
                scroll-snap-type: x mandatory;
                padding: 2rem 1rem;
                gap: 1.5rem;
            }
            .compliance-card {
                scroll-snap-align: start;
                min-width: 280px;
            }
            .hero h1 { font-size: 2.2rem; }
        }

        .compliance-card {
            background: var(--card-bg);
            backdrop-filter: blur(12px);
            border-radius: 16px;
            padding: 1.8rem;
            box-shadow: var(--shadow);
            border: 1px solid var(--border);
            transition: all .3s ease;
            text-decoration: none;
            color: inherit;
            position: relative;
            overflow: hidden;
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUpScale 0.7s ease forwards;
            animation-delay: calc(0.15s * var(--i));
        }
        .compliance-card::before {
            content: '';
            position: absolute;
            left: 0; top: 0; bottom: 0;
            width: 6px;
            background: var(--color, var(--primary));
            transition: width .4s ease;
        }
        .compliance-card:hover {
            transform: translateY(-12px) scale(1.02);
            box-shadow: 0 25px 50px rgba(0,0,0,0.15);
        }
        .compliance-card:hover::before {
            width: 100%;
            opacity: 0.2;
        }

        .card-icon {
            width: 60px; height: 60px;
            border-radius: 50%;
            background: rgba(13,71,161,0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            color: var(--color, var(--primary));
            margin-right: 1rem;
            transition: transform 0.3s ease;
        }
        .compliance-card:hover .card-icon {
            transform: rotate(12deg) scale(1.1);
        }

        .card-title {
            font-size: 0.9rem;
            font-weight: 600;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .card-subtitle {
            margin-top: .75rem;
            font-size: .95rem;
            color: #666;
            line-height: 1.5;
        }

        .cta-badge {
            background: var(--accent);
            color: #000;
            font-weight: 600;
            font-size: .85rem;
            padding: .35rem .75rem;
            border-radius: 50px;
            display: inline-flex;
            align-items: center;
            gap: .4rem;
            transition: all .2s;
            animation: pulse 2s infinite;
        }
        .cta-badge:hover {
            transform: scale(1.15);
            animation: bounce 0.6s;
        }

        footer {
           background: #e9ecef;
    color: #0a58ca;
            text-align: center;
            padding: 1.5rem;
            margin-top: auto;
            font-size: .9rem;
            animation: fadeInUp 0.8s ease 0.6s both;
        }
        footer a { color: var(--accent); text-decoration: none; }
        footer a:hover { text-decoration: underline; }

        @keyframes slideDown {
            from { transform: translateY(-100%); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeInUpScale {
            from { opacity: 0; transform: translateY(40px) scale(0.95); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
    </style>
    <style>
        /* blinking cursor */
        .typing::after {
            content: '|';
            animation: blink 1s step-end infinite;
            color: var(--primary);
        }
        @keyframes blink {
            50% { opacity: 0; }
        }
    </style>
    
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand animate__animated animate__fadeInDown" href="#">
            <img src="/reirm/resources/ai/img/Logo-red-1 (1).svg" alt="Logo">
            Re FinCompliance
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav ms-auto align-items-center">
                <c:if test="${sessionScope.ROLE eq 'SA' || sessionScope.ROLE eq 'Admin'}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" style="--i:1;">Masters</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="<%=request.getContextPath()%>/user">Users</a></li>
                            <li><a class="dropdown-item" href="<%=request.getContextPath()%>/mo">Inventory (Missed)</a></li>
                            <li><a class="dropdown-item" href="<%=request.getContextPath()%>/pc">PC</a></li>
                        </ul>
                    </li>
                </c:if>
                <!--  <li class="nav-item ms-3">
                    <a class="btn btn-outline-danger btn-sm" href="<%=request.getContextPath()%>/logout" style="--i:2;margin-left: 54rem !important;">Logout</a>
                </li> -->
                
                <li class="nav-item ms-auto"> <!-- ms-auto pushes it to the far right -->
    <a class="btn btn-outline-danger btn-sm px-3 d-flex align-items-center gap-1" 
       href="<%=request.getContextPath()%>/logout" 
       style="--i:2;margin-left: 2rem !important;">
        <i class="fas fa-sign-out-alt"></i>
        <span>Logout</span>
    </a>
</li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero -->
<section class="hero">
    <div class="container">
        <h1>Compliance Services Portal</h1>
        <p id="typingText" class="typing"></p>
    </div>
</section>

<!-- Cards - 4 in One Row -->
<div class="container">
    <div class="card-grid">

        <!-- PF -->
        <a href="<%=request.getContextPath()%>/pf" class="compliance-card" style="--color:#3498db; --i:1;">
            <div class="d-flex align-items-center mb-3">
                <div class="card-icon"><i class="fas fa-piggy-bank"></i></div>
                <h2 class="card-title">Provident Fund</h2>
            </div>
            <p class="card-subtitle">Manage PF contributions, view statements, and employee accounts.</p>
        </a>

        <!-- ESI -->
        <a href="<%=request.getContextPath()%>/esi" class="compliance-card" style="--color:#e74c3c; --i:2;">
            <div class="d-flex align-items-center mb-3">
                <div class="card-icon"><i class="fas fa-hospital-user"></i></div>
                <h2 class="card-title">Employees State Insurance</h2>
            </div>
            <p class="card-subtitle">File ESI returns, manage benefits and insurance services.</p>
        </a>

        <!-- PT -->
        <a href="<%=request.getContextPath()%>/pt" class="compliance-card" style="--color:#2ecc71; --i:3;">
            <div class="d-flex align-items-center mb-3">
                <div class="card-icon"><i class="fas fa-file-invoice-dollar"></i></div>
                <h2 class="card-title">Professional Tax</h2>
            </div>
            <p class="card-subtitle">Calculate, pay, and file Professional Tax seamlessly.</p>
        </a>

        <!-- Inventory -->
        <a href="<%=request.getContextPath()%>/inventory" class="compliance-card" style="--color:#9c27b0; --i:4;">
            <div class="d-flex align-items-center mb-3">
                <div class="card-icon"><i class="fas fa-boxes-stacked"></i></div>
                <h2 class="card-title">
                    Inventory
                  <!--    <span class="cta-badge"><i class="fas fa-arrow-right"></i> Go</span> -->
                </h2>
            </div>
            <p class="card-subtitle">
                Track raw materials, WIP, finished goods, and MRO stock in real time.
            </p>
        </a>
        
        
          <!-- FAR -->
        <a href="<%=request.getContextPath()%>/far" class="compliance-card" style="--color:#9c27b0; --i:4;">
            <div class="d-flex align-items-center mb-3">
                <div class="card-icon"><i class="fas fa-boxes-stacked"></i></div>
                <h2 class="card-title">
                    FAR
                  <!--    <span class="cta-badge"><i class="fas fa-arrow-right"></i> Go</span> -->
                </h2>
            </div>
            <p class="card-subtitle">
                Track FAR
            </p>
        </a>
        

    </div>
</div>

<!-- Footer -->
<footer>
    <div class="container">
        COPYRIGHT &copy; <span id="year"></span> | Powered by
        <a href="https://resustainability.com/" target="_blank">Re Sustainability Limited</a>.
        All Rights Reserved.
    </div>
</footer>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('year').textContent = new Date().getFullYear();

    // Re-trigger animations on scroll
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.animationPlayState = 'running';
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.compliance-card').forEach(card => observer.observe(card));
</script>

<script>
        // The final text (HTML entities are decoded automatically)
        const fullText = `Official portal for managing Provident Fund, State Insurance, Professional Tax & Inventory.`;

        const el = document.getElementById('typingText');
        let i = 0;

        function type() {
            if (i < fullText.length) {
                el.innerHTML += fullText.charAt(i);
                i++;
                setTimeout(type, 45);               // speed – smaller = faster
            } else {
                el.classList.remove('typing');      // optional: stop blinking cursor
            }
        }

        // start typing when the page loads
        window.addEventListener('load', () => {
            setTimeout(type, 600);                  // tiny delay so the hero animation finishes first
        });
    </script>

</body>
</html>