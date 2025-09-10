<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://accounts.google.com/gsi/client" async defer></script>
    <title>Header</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style type="text/css">
        :root {
            --primary-color: #1e3a8a;
            --secondary-color: #2563eb;
            --accent-color: #60a5fa;
            --light-color: #f1f5f9;
            --dark-color: #0f172a;
            --danger-color: #dc2626;
            --border-radius: 12px;
            --box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            --transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .header-navbar {
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color)) !important;
            box-shadow: var(--box-shadow);
            padding: 1rem 1.5rem;
            position: sticky;
            top: 0;
            z-index: 1030;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            color: #fff !important;
            font-weight: 700;
            font-size: 1.75rem;
            font-family: 'Inter', sans-serif;
            letter-spacing: 0.02em;
            transition: var(--transition);
        }

        .navbar-brand:hover {
            color: var(--accent-color) !important;
        }

        .card-img {
            max-width: 60px;
            border-radius: 8px;
            transition: var(--transition);
        }

        .nav-link {
            color: #fff !important;
            font-weight: 600;
            font-size: 1rem;
            padding: 0.75rem 1.25rem;
            border-radius: var(--border-radius);
            transition: var(--transition);
        }

        .nav-link:hover {
            color: var(--accent-color) !important;
            background: rgba(255, 255, 255, 0.1);
        }

        .user-nav {
            color: #fff;
            text-align: right;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            padding: 0.5rem 1rem;
        }

        .user-name {
            font-size: 1.1rem;
            font-weight: 700;
            letter-spacing: 0.02em;
        }

        .user-status {
            font-size: 0.9rem;
            color: #e2e8f0;
            font-weight: 500;
        }

        .badge {
            background: rgba(255, 255, 255, 0.15);
            color: #fff;
            font-weight: 600;
            padding: 0.5rem 1rem;
            border-radius: 50px;
        }

        .logout-btn {
            background: var(--danger-color);
            color: #fff;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: var(--border-radius);
            font-weight: 600;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .logout-btn:hover {
            background: #b91c1c;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(220, 38, 38, 0.3);
        }

        .logout-btn::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                90deg,
                transparent,
                rgba(255, 255, 255, 0.2),
                transparent
            );
            transition: 0.5s;
        }

        .logout-btn:hover::after {
            left: 100%;
        }

        .navbar-toggler {
            border: none;
            color: #fff;
            padding: 0.5rem;
        }

        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(255, 255, 255, 0.9)' stroke-width='2.5' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
            width: 1.75em;
            height: 1.75em;
        }

        @media (max-width: 767px) {
            .navbar-brand {
                font-size: 1.4rem;
            }

            .card-img {
                max-width: 48px;
            }

            .user-nav {
                text-align: center;
                padding: 1rem;
                align-items: center;
            }

            .navbar-nav {
                padding: 1.5rem;
                background: rgba(0, 0, 0, 0.05);
                border-radius: var(--border-radius);
            }

            .logout-btn {
                width: 100%;
                text-align: center;
                margin-top: 1.5rem;
            }
        }

        .fade-in {
            animation: fadeIn 0.5s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <nav class="header-navbar navbar-expand-lg navbar navbar-fixed align-items-center navbar-shadow navbar-brand-center" data-nav="brand-center">
        <div class="container-fluid">
            <a class="navbar-brand animate__animated animate__fadeIn" href="<%=request.getContextPath()%>/home">
                <img src="/reirm/resources/images/smart_logo.png" alt="Logo" class="card-img">
                <span class="brand-text">Employee Attendance Portal</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent" aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarContent">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <div class="user-nav d-sm-flex d-none animate__animated animate__fadeIn">
                            <span class="user-name">${sessionScope.USER_NAME} | <span class="badge badge-light-secondary">${sessionScope.BASE_ROLE}</span><br>
                            <span>[${sessionScope.BASE_SBU}]</span></span>
                        </div>
                    </li>
                    <li class="nav-item">
                        <span class="avatar"><i class="fas fa-user-circle fa-2x"></i></span>
                    </li>
                    <li class="nav-item">
                        <button class="logout-btn g_id_signout animate__animated animate__fadeIn" id="signout_button">
                            <i class="fas fa-sign-out-alt me-1"></i> 
                        </button>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <form action="<%=request.getContextPath()%>/logout" name="logoutForm" id="logoutForm" method="post">
        <input type="hidden" name="email" id="email"/>
    </form>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(window).on("load", function() {
            if ('${welcome}' !== '') {
                toastr.success("You have successfully logged in. Now you can start to explore!", "👋 Welcome ${sessionScope.USER_NAME}", {
                    closeButton: true,
                    tapToDismiss: false,
                    positionClass: "toast-top-right"
                });
            }
            if ('${NewUser}' !== '') {
                toastr.success("You have been <b>Rewarded with 100 points</b> By Registering into <b>Safety Portal</b>", "Congratulations ${sessionScope.USER_NAME}!", {
                    closeButton: true,
                    tapToDismiss: false,
                    positionClass: "toast-top-right"
                });
            }
            if ('${success}' !== '') {
                toastr.success("${success}", {
                    closeButton: true,
                    tapToDismiss: false,
                    positionClass: "toast-top-right"
                });
            }
            if ('${error}' !== '') {
                toastr.error("${error}", {
                    closeButton: true,
                    tapToDismiss: false,
                    positionClass: "toast-top-right"
                });
            }
        });

        const signoutButton = document.getElementById("signout_button");
        signoutButton.onclick = () => {
            google.accounts.id.disableAutoSelect();
            console.log('User signed out.');
            $("#email").val('');
            $("#logoutForm").submit();
        };
    </script>
</body>
</html>