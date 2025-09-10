<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding = "UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimal-ui">
    <title>IRM - User Creation</title>
    <link rel="icon" type="image/png" sizes="96x96" href="/reirm/resources/images/protect-favicon.png" >
    
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Core CSS -->
    <link rel="stylesheet" type="text/css" href="/reirm/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/vendors/css/forms/select/select2.min.css">

    <!-- Page Specific CSS -->
    <link rel="stylesheet" href="/reirm/resources/vendor/css/pages/page-auth.css">

    <style>
        :root {
            --primary-color: #6a11cb;
            --secondary-color: #2575fc;
            --text-color: #4A4A4A;
            --light-gray: #f2f4f8;
            --white-color: #ffffff;
            --error-color: #ea5455;
            --success-color: #28c76f;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(120deg, var(--light-gray) 0%, #eef2f3 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 1rem;
        }

        .auth-wrapper.auth-basic .auth-inner {
            max-width: 900px;
            width: 100%;
        }

        .card {
            border: none;
            border-radius: 1.5rem;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .auth-left-side {
            background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
            color: var(--white-color);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 3rem;
        }

        .auth-left-side img {
            max-width: 300px;
            margin-top: 2rem;
            animation: float 4s ease-in-out infinite;
        }

        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-15px); }
            100% { transform: translateY(0px); }
        }

        .brand-logo img {
            height: 40px;
        }
        
        .card-body {
            padding: 2.5rem;
        }

        .form-label {
            font-weight: 500;
            color: var(--text-color);
        }

        .form-control, .select2-container--default .select2-selection--single {
            border-radius: 0.5rem;
            border: 1px solid #d8d6de;
            transition: all 0.2s ease;
            height: calc(1.5em + 1rem + 2px);
        }
        .form-control:focus, .select2-container--open .select2-selection--single {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(106, 17, 203, 0.25);
        }

        .btn-primary {
            background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
            border: none;
            border-radius: 0.5rem;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 20px rgba(0, 0, 0, 0.2);
        }

        .required { color: var(--error-color); }
        .my-error-class { color: var(--error-color); font-size: 0.875em; }
        .my-valid-class { color: var(--success-color); }
        
        .divider .divider-text {
            background-color: var(--white-color);
        }
    </style>
</head>
<body class="horizontal-layout horizontal-menu blank-page navbar-floating footer-static">
    <div class="app-content content">
        <div class="content-overlay"></div>
        <div class="header-navbar-shadow"></div>
        <div class="content-wrapper">
            <div class="content-body">
                <div class="auth-wrapper auth-basic px-2">
                    <div class="auth-inner my-2">
                        <div class="card mb-0">
                            <div class="row g-0">
                                <!-- Left Section -->
                                <div class="col-lg-5 d-none d-lg-flex align-items-center p-5 auth-left-side">
                                    <div class="w-100 d-lg-flex align-items-center justify-content-center">
                                        <img src="https://static.vecteezy.com/system/resources/previews/021/179/570/non_2x/fills-in-the-profile-data-form-businessman-fills-in-the-profile-data-form-free-png.png" class="img-fluid" alt="Register V2" />
                                    </div>
                                </div>
                                <!-- /Left Section -->

                                <!-- Right Section -->
                                <div class="col-lg-7">
                                    <div class="card-body">
                                        <a class="brand-logo d-flex align-items-center justify-content-center mb-1">
                                            <img src="https://appmint.resustainability.com/reirm/resources/ai/img/Logo-red-1%20(1).svg" alt="Logo">
                                        </a>
                                        <h2 class="brand-text text-primary text-center fw-bolder">Create Your Account</h2>
                                        <p class="card-text mb-2 text-center">Join our platform to streamline your workflow.</p>

                                        <form id="addUserForm" action="<%=request.getContextPath() %>/add-new-user" method="post" class="row gy-1 pt-75">
                                            <input name="newUser" type="hidden" value="new"/>
                                            <div class="col-12 col-md-6">
                                                <label class="form-label" for="user_id_add">User ID<span class="required"> *</span></label>
                                                <input type="text" id="user_id_add" name="user_id" class="form-control" placeholder="Enter Employee ID" />
                                                <span id="user_id_addError" class="my-error-class"></span>
                                            </div>

                                            <div class="col-12 col-md-6">
                                                <label class="form-label" for="email_add">Email<span class="required"> *</span></label>
                                                <input type="email" id="email_add" name="email_id" class="form-control" placeholder="user@example.com" value="${email}" readonly />
                                                <span id="email_addError" class="my-error-class"></span>
                                            </div>

                                            <div class="col-12">
                                                <label class="form-label" for="select2-base_sbu-container">Profit Center<span class="required"> *</span></label>
                                                <select id="select2-base_sbu-container" name="profit_center_code" class="select2 form-select formSelect" >
                                                    <option value="">Select Profit Center</option>
                                                    <c:forEach items="${profitCenterList}" var="pc">
                                                        <option value="${pc.profit_center_code}" ${pf.profit_center_code == pc.profit_center_code ? 'selected' : ''}>
                                                            ${pc.profit_center_code} - ${pc.profit_center_name}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                                <span id="select2-base_sbu-containerError" class="my-error-class"></span>
                                            </div>
                                            
                                            <div class="col-12 text-center mt-3">
                                                <a class="btn btn-primary w-100" onclick="addUser();">Sign Up</a>
                                            </div>
                                        </form>

                                        <p class="text-center mt-2">
                                            <span>Already have an account?</span>
                                            <a href="<%=request.getContextPath() %>/login">
                                                <span class="fw-bold">Sign in instead</span>
                                            </a>
                                        </p>
                                    </div>
                                </div>
                                <!-- /Right Section -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- BEGIN: Vendor JS-->
    <script src="/reirm/resources/vendors/js/vendors.min.js"></script>
    <script src="/reirm/resources/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="/reirm/resources/js/jquery-validation-1.19.1.min.js"></script>
    <!-- END: Vendor JS-->
    
    <!-- BEGIN: Theme JS-->
    <script src="/reirm/resources/js/core/app.min.js"></script>
    <!-- END: Theme JS-->

    <script>
        $(function () {
            'use strict';
            // Initialize Select2
            $('.select2').each(function () {
                var $this = $(this);
                $this.wrap('<div class="position-relative"></div>');
                $this.select2({
                    dropdownAutoWidth: true,
                    width: '100%',
                    dropdownParent: $this.parent()
                });
            });

            // Form Validation
            var validator = $('#addUserForm').validate({
                errorClass: "my-error-class",
                validClass: "my-valid-class",
                ignore: ":hidden:not(.select2)",
                rules: {
                    "user_id": { required: true },
                    "email_id": { required: true, email: true },
                    "profit_center_code": { required: true }
                },
                messages: {
                    "user_id": { required: 'User ID is required' },
                    "email_id": { required: 'Email is required', email: 'Please enter a valid email' },
                    "profit_center_code": { required: 'Profit Center is required' }
                },
                errorPlacement: function(error, element) {
                    var errorId = element.attr("id") + "Error";
                    $('#' + errorId).html('');
                    error.appendTo('#' + errorId);
                }
            });

            // Re-validate on change
            $('.formSelect, input').on('change', function() {
                if ($(this).val() !== "") {
                    $(this).valid();
                }
            });
        });

        function addUser() {
            if ($('#addUserForm').valid()) {
                document.getElementById("addUserForm").submit();
            }
        }

        function setProjectDD() {
            var base_sbu = $("#select2-base_sbu-container").val();
            if ($.trim(base_sbu) != "") {
                // AJAX call to get projects
            }
        }

        function setDeptDD() {
            var base_sbu = $("#select2-base_sbu-container").val();
            if ($.trim(base_sbu) != "") {
                // AJAX call to get departments
            }
        }
    </script>
</body>
</html>
