<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>

<html class="loading" lang="en" data-textdirection="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <script src="https://accounts.google.com/gsi/client" async defer></script>
    <title>Login - RE Sustainability</title>
    <link rel="icon" type="image/png" sizes="96x96" href="https://www.nicepng.com/png/detail/196-1968834_finance-icon-finance-and-accounting-icon.png">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,300;0,400;0,500;0,600;1,400;1,500;1,600" rel="stylesheet">
    
    <!-- BEGIN: Vendor CSS-->
    <link rel="stylesheet" type="text/css" href="/reirm/resources/vendors/css/vendors.min.css">
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="/reirm/resources/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/css/bootstrap-extended.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/css/colors.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/css/components.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/css/themes/dark-layout.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/css/themes/bordered-layout.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/css/themes/semi-dark-layout.min.css">
    <script src="/reirm/resources/js/jQuery-v.3.5.min.js"></script>
    
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    
    <style>
      :root {
    --primary-color: #2c3e50;
    --secondary-color: #3498db;
    --accent-color: #e74c3c;
    --light-color: #ecf0f1;
    --dark-color: #2c3e50;
}

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Montserrat', sans-serif;
    min-height: 100vh;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    overflow-x: hidden;
    overflow-y: auto; /* Allows scrolling if content exceeds viewport */
    margin: 0; /* Remove default margin */
    padding: 0; /* Remove default padding */
}

.auth-container {
    background: white;
    border-radius: 20px;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    width: 90%;
    max-width: 490px;
    display: flex;
    min-height: 600px;
    height: auto; /* Adjust height dynamically */
    max-height: 90vh; /* Prevent exceeding viewport height */
    animation: fadeInUp 0.8s ease;
    margin: 20px 0; /* Add some margin to avoid edge touching */
}

.auth-left {
    flex: 1;
    background: linear-gradient(135deg, var(--primary-color) 0%, var(--dark-color) 100%);
    color: white;
    padding: 40px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    position: relative;
    overflow: hidden;
    min-height: 600px; /* Ensure minimum height matches container */
}

.auth-left::before {
    content: "";
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
    animation: pulse 15s infinite linear;
    z-index: 0; /* Ensure it stays behind content */
}

.auth-right {
    flex: 1;
    padding: 60px 40px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    overflow-y: auto; /* Allow scrolling if content overflows */
    min-height: 600px; /* Match left side */
}

.logo {
    width: 150px;
    margin-bottom: 30px;
    filter: drop-shadow(0 2px 5px rgba(0,0,0,0.2));
}

.welcome-text {
    font-size: 2.2rem;
    font-weight: 600;
    margin-bottom: 10px;
    color: var(--primary-color);
}

.sub-text {
    color: #7f8c8d;
    margin-bottom: 30px;
}

.divider {
    display: flex;
    align-items: center;
    margin: 20px 0;
}

.divider::before, .divider::after {
    content: "";
    flex: 1;
    height: 1px;
    background: #e0e0e0;
}

.divider-text {
    padding: 0 15px;
    color: #95a5a6;
    font-size: 0.9rem;
}

.finance-graphic {
    position: absolute;
    opacity: 0.1;
    z-index: 1; /* Keep behind main content */
}

.graphic-1 {
    top: 20%;
    left: 10%;
    width: 100px;
    animation: float 6s ease-in-out infinite;
}

.graphic-2 {
    bottom: 15%;
    right: 10%;
    width: 120px;
    animation: float 8s ease-in-out infinite;
}

.graphic-3 {
    top: 60%;
    left: 30%;
    width: 80px;
    animation: float 7s ease-in-out infinite reverse;
}

.error-message {
    color: var(--accent-color);
    background: rgba(231, 76, 60, 0.1);
    padding: 10px 15px;
    border-radius: 8px;
    margin-bottom: 20px;
    animation: shake 0.5s ease;
}

.footer-text {
    font-size: 0.8rem;
    color: #95a5a6;
    margin-top: 30px;
    text-align: center;
}

.g_id_signin {
    width: 100% !important;
    margin: 15px 0 !important;
}

/* Keep existing keyframes */
@keyframes float {
    0% { transform: translateY(0px); }
    50% { transform: translateY(-15px); }
    100% { transform: translateY(0px); }
}

@keyframes pulse {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

@keyframes fadeInUp {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

@keyframes shake {
    0%, 100% { transform: translateX(0); }
    20%, 60% { transform: translateX(-5px); }
    40%, 80% { transform: translateX(5px); }
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .auth-container {
        flex-direction: column;
        min-height: auto;
        max-height: 95vh; /* Adjust for smaller screens */
    }
    
    .auth-left {
        padding: 30px 20px;
        text-align: center;
        min-height: 300px; /* Reduced for mobile */
    }
    
    .auth-right {
        padding: 40px 20px;
        min-height: 400px; /* Adjusted for mobile */
    }
    
    .welcome-text {
        font-size: 1.8rem;
    }
    
    .finance-graphic {
        display: none; /* Hide graphics on small screens to avoid clutter */
    }
}
    </style>
</head>

<body class="horizontal-layout horizontal-menu blank-page navbar-floating footer-static" data-open="hover" data-menu="horizontal-menu" data-col="blank-page">
    <div class="auth-container animate__animated animate__fadeIn">
        <div class="auth-left">
            <svg class="finance-graphic graphic-1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="12" y1="1" x2="12" y2="23"></line>
                <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
            </svg>
            
            <svg class="finance-graphic graphic-2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
                <polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline>
                <line x1="12" y1="22.08" x2="12" y2="12"></line>
            </svg>
            
            <svg class="finance-graphic graphic-3" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z"></path>
            </svg>
            
            <div class="text-center" style="position: relative; z-index: 1;">
                <img src="/reirm/resources/images/login_icon.png" alt="Logo" class="logo">
                <h2 class="text-white">Finance System Authentication</h2>
                <p class="text-light">Secure access to your financial Management</p>
            </div>
             <div id="g_id_onload"
                 data-client_id="180023549420-4araucipo8cil4matp902f64cte57md9.apps.googleusercontent.com"
                 data-context="use"
                 data-ux_mode="popup"
                 data-callback="handleCredentialResponse"
                 data-nonce=""
                 data-itp_support="true">
            </div>
            	<!-- 			 <div id="g_id_onload"
									 180023549420-57imk7usicj28m4489imvf0spmk3v7l7.apps.googleusercontent.com
				     data-client_id="180023549420-4araucipo8cil4matp902f64cte57md9.apps.googleusercontent.com"
				     data-context="signin"
				     data-ux_mode="popup"
				     data-callback="handleCredentialResponse"
				     data-nonce=""
				     data-auto_select="true"
				     data-itp_support="true">
				</div>
				
				<div class="g_id_signin justify-content-center mt-1"
				     data-type="standard"
				     data-shape="rectangular"
				     data-theme="outline"
				     data-text="signin_with"
				     data-size="large"
				     data-logo_alignment="left">
				</div> -->
            <div class="g_id_signin" 
                 data-type="standard" 
                 data-shape="rectangular"
                 data-theme="filled_blue"
                 data-text="signin_with"
                 data-size="large"
                 data-logo_alignment="left">
            </div>
            
            <div class="divider">
                <span class="divider-text">OR</span>
            </div>
            
            <p class="text-center text-muted ">Please ensure username should be your Email ID @resustainability.com</p>
            
            <p class="text-center small text-muted ">Incase of any login issue, connect on <a href="mailto:it.helpdesk@resustainability.com" class="text-primary">it.helpdesk@resustainability.com</a></p>
            
            
            <p class="small text-center text-muted">Signing up in this Our Portal confirms your acceptance to ReSL IT Application Usage Policy</p>
            
        </div>
        
    </div>
    
    <form action="<%=request.getContextPath() %>/login" name="loginForm" id="loginForm" method="post">
        <input type="hidden" name="email_id" id="email_id"/>
        <input type="hidden" name="user_name" id="user_name"/>
        <input id="profileImg" name="profileImg" type="hidden" />
        <input id="gToken" name="user_session_id" type="hidden" />
        <input id="device_type" name="device_type" type="hidden" />
    </form>
    
    <!-- BEGIN: Vendor JS-->
    <script src="/reirm/resources/vendors/js/vendors.min.js"></script>
    <!-- BEGIN Vendor JS-->
    <script type="text/javascript" src="css3-mediaqueries.js"></script>
    <!-- BEGIN: Page Vendor JS-->
    <script src="/reirm/resources/vendors/js/ui/jquery.sticky.js"></script>
    <script src="/reirm/resources/vendors/js/forms/validation/jquery.validate.min.js"></script>
    <!-- END: Page Vendor JS-->
    <!-- BEGIN: Theme JS-->
    <script src="/reirm/resources/js/core/app-menu.min.js"></script>
    <script src="/reirm/resources/js/core/app.min.js"></script>
    <!-- END: Theme JS-->
    <script src="/reirm/resources/js/core/app-menu.min.js"></script>
    <script src="/reirm/resources/js/core/app.min.js"></script>
    <script src="/reirm/resources/js/scripts/customizer.min.js"></script>
    <!-- BEGIN: Page JS-->
    <script src="/reirm/resources/js/scripts/pages/auth-login.js"></script>
    <!-- END: Page JS-->

    <script>
    $.getJSON("https://api.ipify.org?format=json",  function(data) { 
        $(".page-loader-2").hide();
        console.log(data.ip); 
    }); 
    
    $(window).on('load',  function(){
        if (feather) {
            feather.replace({ width: 14, height: 14 });
        }
        var ua = navigator.userAgent;
        var checker = {
            iphone: ua.match(/(iPhone|iPod|iPad)/),
            blackberry: ua.match(/BlackBerry/),
            android: ua.match(/Android/),
            Mozilla: ua.match(/Mozilla/),
            Chrome: ua.match(/Chrome/)
        };
        if (checker.android){
            console.log("android")
            $("#device_type").val("mobile");
        }
        else if (checker.iphone){
            $("#device_type").val("mobile");
        }
        else if (checker.blackberry){
            $("#device_type").val("mobile");
        }
        else if (checker.Mozilla){
            $("#device_type").val("desktop");
        }
        else if (checker.Chrome){
            $("#device_type").val("desktop");
        }
        else {
            $("#device_type").val("desktop");
        } 
    })

    function decodeJwtResponse(token) {
        let base64Url = token.split('.')[1]
        let base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
        let jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
            return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
        }).join(''));
        return JSON.parse(jsonPayload)
    }

    let responsePayload;
    
    window.handleCredentialResponse = (response) => {
        responsePayload = decodeJwtResponse(response.credential);
        var idToken = response.credential;
        console.log("ID: " + responsePayload.sub);
        console.log('Full Name: ' + responsePayload.name);
        console.log('Given Name: ' + responsePayload.given_name);
        console.log('Family Name: ' + responsePayload.family_name);
        console.log("Image URL: " + responsePayload.picture);
        console.log("Email: " + responsePayload.email);
        
        if('${success}' == null || '${success}' == ''){
            if('${invalidEmail}' == null || '${invalidEmail}' == ''){
                $("#email_id").val(responsePayload.email);
                $("#user_name").val(responsePayload.name);
                $("#profileImg").val(responsePayload.picture);
                $("#gToken").val(idToken);
                $("#loginForm").submit();
            }else{
                alert(responsePayload.email+" do not have access to login. Please try with registered mail account (or) contact to admin.");
                google.accounts.id.disableAutoSelect();
            }
        }else if('${success}' == 'Successfully logged out'){
            if('${invalidEmail}' == null || '${invalidEmail}' == ''){
                $("#email_id").val(responsePayload.email);
                $("#user_name").val(responsePayload.name);
                $("#profileImg").val(responsePayload.picture);
                $("#gToken").val(idToken);
                $("#loginForm").submit();
            }
        }else{
            google.accounts.id.disableAutoSelect();
        }
    }
    </script>
</body>
</html>