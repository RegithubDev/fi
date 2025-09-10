<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <title>ESI Contributions Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- CSS Libraries -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.2/css/buttons.bootstrap5.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css" />
<<<<<<< HEAD
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gov-blue: #0d47a1;
            --secondary-gov-blue: #1565c0;
            --accent-color: #ffc107;
            --card-bg: #ffffff;
            --text-color: #212529;
            --text-muted-color: #5a6268;
            --header-bg: #ffffff;
            --body-bg: #eef2f5;
            --shadow-color: rgba(0, 0, 0, 0.08);
            --border-color: #dee2e6;
            --success-color: #198754;
            --danger-color: #dc3545;
            --warning-color: #ffc107;
        }

        body {
            background-color: var(--body-bg);
            font-family: 'Roboto', sans-serif;
=======
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        :root {
            --bg-color: #f4f7f6;
            --primary-color: #4F7C82; /* Teal Green */
            --secondary-color: #0B2E33; /* Dark Teal */
            --accent-color: #B8E3E9; /* Light Blue */
            --card-bg: rgba(255, 255, 255, 0.9);
            --text-color: #333;
            --header-text-color: #FFFFFF;
            --shadow-color: rgba(0, 0, 0, 0.1);
            --border-color: #dee2e6;
            --muted-color: #93B1B5; /* Desaturated Blue/Gray */
        }
          /* Base Status Badge Styling */
  .status-badge {
    position: relative;
    display: inline-flex;
    align-items: center;
    padding: 6px 12px;
    border-radius: 16px;
    font-size: 12px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    overflow: hidden;
    transition: all 0.3s ease;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    transform-style: preserve-3d;
    perspective: 100px;
  }

  /* Active Status Styling */
  .status-badge.active {
    background: linear-gradient(135deg, #28a745 0%, #5cb85c 100%);
    color: white;
    border: 1px solid #218838;
  }

  /* Inactive Status Styling */
  .status-badge.inactive {
    background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
    color: white;
    border: 1px solid #bd2130;
  }

  /* Pending/Other Status Styling (optional) */
  .status-badge:not(.active):not(.inactive) {
    background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%);
    color: #212529;
    border: 1px solid #d39e00;
  }

  /* Status Text */
  .status-text {
    position: relative;
    z-index: 2;
    display: flex;
    align-items: center;
  }

  /* Pulse Animation (for Active status) */
  .status-pulse {
    position: absolute;
    width: 100%;
    height: 100%;
    background: inherit;
    border-radius: inherit;
    z-index: 1;
    opacity: 0;
    animation: none;
  }

  .active .status-pulse {
    animation: pulse 2s infinite;
  }

  @keyframes pulse {
    0% {
      transform: scale(1);
      opacity: 0.8;
    }
    70% {
      transform: scale(1.4);
      opacity: 0;
    }
    100% {
      transform: scale(1);
      opacity: 0;
    }
  }

  /* Glow Effect */
  .status-glow {
    position: absolute;
    top: -10px;
    left: -10px;
    right: -10px;
    bottom: -10px;
    background: inherit;
    filter: blur(8px);
    z-index: 0;
    opacity: 0;
    transition: opacity 0.3s ease;
  }

  .status-badge:hover .status-glow {
    opacity: 0.3;
  }

  /* 3D Lift Effect on Hover */
  .status-badge:hover {
    transform: translateY(-2px) translateZ(10px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
  }

  /* Icon Integration (optional) */
  .status-text::before {
    content: "";
    display: inline-block;
    width: 8px;
    height: 8px;
    border-radius: 50%;
    margin-right: 6px;
    background: white;
    box-shadow: 0 0 5px rgba(255,255,255,0.8);
  }

  .inactive .status-text::before {
    background: #ffcccc;
  }

  /* Bounce Animation for Status Change (optional) */
  @keyframes bounceIn {
    0% { transform: scale(0.8); opacity: 0; }
    50% { transform: scale(1.1); }
    100% { transform: scale(1); opacity: 1; }
  }

  .status-badge {
    animation: bounceIn 0.5s ease-out;
  }
          /* Base styling */
  .btn {
    position: relative;
    overflow: hidden;
    border: none;
    border-radius: 12px;
    padding: 12px 24px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 1px;
    transition: all 0.5s cubic-bezier(0.65, 0, 0.35, 1);
    transform-style: preserve-3d;
    perspective: 500px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
  }
  
  .btn-content {
    position: relative;
    z-index: 2;
    display: flex;
    align-items: center;
    transition: all 0.4s;
  }
  
  .btn-background {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(45deg, #343a40, #495057);
    border-radius: 10px;
    z-index: 1;
    transition: all 0.5s cubic-bezier(0.65, 0, 0.35, 1);
    transform: translateZ(-10px);
  }
  
  /* Back button specific */
  .back-btn {
    background: linear-gradient(45deg, #343a40, #495057);
    color: white;
  }
  
  .back-btn .btn-background {
    background: linear-gradient(45deg, #495057, #343a40);
  }
  
  /* Logout button specific */
  .logout-btn {
    background: linear-gradient(45deg, #dc3545, #c82333);
    color: white;
  }
  
  .logout-btn .btn-background {
    background: linear-gradient(45deg, #c82333, #dc3545);
  }
  
  /* Hover effects */
  .btn:hover {
    transform: translateY(-3px) scale(1.02);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
  }
  
  .btn:hover .btn-background {
    transform: translateZ(0);
    opacity: 0.9;
  }
  
  .btn:hover .btn-content {
    transform: translateX(5px);
  }
  
  .back-btn:hover .btn-content {
    transform: translateX(-5px);
  }
  
  /* Active/press effect */
  .btn:active {
    transform: translateY(1px) scale(0.98);
    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.3);
  }
  
  /* Pulse animation */
  @keyframes pulse {
    0% { box-shadow: 0 0 0 0 rgba(220, 53, 69, 0.7); }
    70% { box-shadow: 0 0 0 10px rgba(220, 53, 69, 0); }
    100% { box-shadow: 0 0 0 0 rgba(220, 53, 69, 0); }
  }
  
  .logout-btn {
    animation: pulse 2s infinite;
  }
  
  /* Floating animation */
  @keyframes float {
    0% { transform: translateY(0px); }
    50% { transform: translateY(-5px); }
    100% { transform: translateY(0px); }
  }
  
  .back-btn {
    animation: float 3s ease-in-out infinite;
  }
        .strict-alert {
    position: fixed;
    top: 20%;
    left: 50%;
    transform: translateX(-50%);
    background: #fff8f8;
    color: #a00;
    border: 2px solid #a00;
    border-radius: 10px;
    padding: 20px;
    z-index: 9999;
    font-weight: bold;
    max-width: 500px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.15);
    animation: alertPulse 2s infinite;
}

.strict-alert-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
    padding-bottom: 10px;
    border-bottom: 1px solid #ffcccc;
}

.strict-alert-header h5 {
    margin: 0;
    color: #a00;
    font-weight: bold;
}

.strict-alert-close {
    background: none;
    border: none;
    font-size: 24px;
    color: #a00;
    cursor: pointer;
    padding: 0 5px;
    line-height: 1;
}

.strict-alert-body {
    margin-bottom: 15px;
    line-height: 1.6;
}

.strict-alert-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 15px;
    padding-top: 10px;
    border-top: 1px solid #ffcccc;
}

.strict-alert-timer {
    color: #666;
    font-size: 0.9em;
}

.strict-alert-edit {
    margin-left: 10px;
}

@keyframes alertPulse {
    0% { box-shadow: 0 0 0 0 rgba(255,0,0,0.4); }
    70% { box-shadow: 0 0 0 10px rgba(255,0,0,0); }
    100% { box-shadow: 0 0 0 0 rgba(255,0,0,0); }
}
#duplicateAlert {
    box-shadow: 0 0 10px rgba(255, 0, 0, 0.3);
}

        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap');

        body {
            background-color: var(--bg-color);
            font-family: 'Poppins', sans-serif;
>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4
            color: var(--text-color);
            min-height: 100vh;
        }

<<<<<<< HEAD
        /* Card & Layout */
        .card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 8px;
            box-shadow: 0 4px 15px 0 var(--shadow-color);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .card:hover {
            box-shadow: 0 8px 25px 0 rgba(0, 0, 0, 0.12);
            transform: translateY(-3px);
        }

        /* Header */
        .header-bar {
            background: var(--primary-gov-blue);
            color: #ffffff;
            border-radius: 8px;
        }
        .header-bar h2 {
            font-weight: 500;
        }
        .header-bar .btn {
            background-color: var(--accent-color);
            color: var(--primary-gov-blue);
            font-weight: 700;
            border: none;
        }
        .header-bar .btn:hover {
            background-color: #ffca2c;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        /* Buttons */
        .btn {
            border-radius: 6px;
            font-weight: 500;
            transition: all 0.2s ease-in-out;
        }
        .btn-primary {
            background-color: var(--secondary-gov-blue);
            border-color: var(--secondary-gov-blue);
        }
        .btn-primary:hover {
            background-color: var(--primary-gov-blue);
            border-color: var(--primary-gov-blue);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .appeal-btn {
            background-color: var(--danger-color);
            border-color: var(--danger-color);
            color: white;
        }
        .appeal-btn:hover {
            background-color: #b02a37;
            border-color: #b02a37;
        }
        .back-btn {
            background-color: transparent;
            border: 1px solid var(--text-muted-color);
            color: var(--text-muted-color);
        }
        .back-btn:hover {
            background-color: var(--text-muted-color);
            color: white;
        }
        .logout-btn {
            background-color: transparent;
            border: 1px solid var(--danger-color);
            color: var(--danger-color);
        }
        .logout-btn:hover {
            background-color: var(--danger-color);
            color: white;
        }
        
        /* DataTable Styling */
        #esiTable thead th {
            background-color: var(--primary-gov-blue) !important;
            color: #ffffff !important;
            font-weight: 500;
        }
        #esiTable tbody tr:hover {
            background-color: #e3f2fd !important; /* Light blue hover */
        }
        .dataTables_wrapper .form-control, .dataTables_wrapper .form-select {
            border-radius: 6px;
        }
        .dataTables_paginate .page-item.active .page-link {
            background-color: var(--primary-gov-blue);
            border-color: var(--primary-gov-blue);
        }

        /* Status Badge */
        .status-badge {
            display: inline-flex;
            align-items: center;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: white;
        }
        .status-badge.active {
            background-color: var(--success-color);
        }
        .status-badge.inactive {
            background-color: var(--text-muted-color);
        }
        .status-badge .status-text::before {
            content: "";
            display: inline-block;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            margin-right: 6px;
            background: white;
        }

        /* Strict Alert Box */
        .strict-alert {
            position: fixed;
            top: 20px;
            right: 20px;
            background: #fff3f3;
            color: #721c24;
            border: 1px solid #f5c6cb;
            border-left: 5px solid var(--danger-color);
            border-radius: 8px;
            padding: 1rem;
            z-index: 1060; /* Higher than modals */
            max-width: 400px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
            animation: slideInRight 0.3s ease-out;
        }
        .strict-alert-header h5 {
            margin: 0;
            color: #721c24;
            font-weight: 700;
        }
        .strict-alert-close {
            background: none; border: none; font-size: 24px;
            color: #721c24; cursor: pointer; opacity: 0.7;
        }
        .strict-alert-close:hover { opacity: 1; }
        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        /* Select2 & Modals */
        .select2-container--bootstrap-5 .select2-selection {
            border-radius: 6px;
        }
        .select2-container--bootstrap-5 .select2-dropdown {
            border-radius: 6px;
        }
        .select2-results__option--highlighted {
            background-color: var(--primary-gov-blue) !important;
        }
        .modal-content {
            border-radius: 8px;
            border: none;
        }
        .modal-header {
            background-color: var(--primary-gov-blue);
            color: white;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
        }
        .modal-body h5 {
            color: var(--primary-gov-blue);
            font-weight: 700;
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 0.5rem;
            margin-bottom: 1rem;
        }
        .swal2-popup {
            border-radius: 8px !important;
        }
        .swal2-confirm {
            background-color: var(--primary-gov-blue) !important;
=======
        .card-3d {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid var(--border-color);
            border-radius: 15px;
            box-shadow: 0 4px 20px 0 var(--shadow-color);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card-3d:hover {
            box-shadow: 0 10px 30px 0 rgba(0, 0, 0, 0.15);
            transform: translateY(-5px);
        }

        .header-bar {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--header-text-color);
            text-shadow: 0 1px 2px rgba(0,0,0,0.2);
        }

        .btn-primary {
            background: var(--primary-color);
            border-color: var(--primary-color);
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background: var(--secondary-color);
            border-color: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

      #esiTable thead th {
		    background-color: #2d747e !important;
		    color: var(--header-text-color) !important;
		}

        #esiTable tbody tr {
            border-bottom: 1px solid #f0f0f0;
            transition: all 0.2s ease-in-out;
        }
        #esiTable tbody tr:last-child {
            border-bottom: none;
        }
        #esiTable tbody tr:hover {
            background-color: var(--accent-color) !important;
            transform: scale(1.01);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            z-index: 10;
        }
        .dataTables_wrapper .dataTables_length, .dataTables_wrapper .dataTables_filter, .dataTables_wrapper .dataTables_info, .dataTables_wrapper .dataTables_paginate .page-link {
            color: var(--text-color) !important;
        }
        .dataTables_wrapper .dataTables_filter input {
            background-color: #fff;
            border: 1px solid var(--border-color);
            color: var(--text-color);
        }
        
        .select2-container--bootstrap-5 .select2-selection {
            background: #fff;
            border: 1px solid var(--border-color);
        }
        .select2-container--bootstrap-5 .select2-selection--single .select2-selection__rendered {
            color: var(--text-color);
        }
        .select2-dropdown {
            background: #fff;
            border: 1px solid var(--border-color);
        }
        .select2-results__option--highlighted {
            background-color: var(--primary-color) !important;
            color: white !important;
        }
        
        .swal2-popup {
            border-radius: 15px !important;
        }
        .swal2-title { 
            color: var(--secondary-color) !important; 
>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4
        }
    </style>
</head>
<body>

<div class="container-fluid py-4">
<div class="d-flex justify-content-between align-items-center m-2">
  <div>
    <a href="<%=request.getContextPath()%>/fi-d26827851841284wjvwunfuqwhfbwqr7212hfu" 
<<<<<<< HEAD
       class="btn back-btn">
        <i class="fas fa-arrow-left me-2"></i>Back
=======
       class="btn btn-dark waves-effect waves-float waves-light back-btn">
      <span class="btn-content">
        <i class="fas fa-arrow-left me-2"></i>Back
      </span>
      <span class="btn-background"></span>
>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4
    </a>
  </div>
  <div>
    <a href="<%=request.getContextPath()%>/logout" 
<<<<<<< HEAD
       class="btn logout-btn">
        <i class="fas fa-sign-out-alt me-2"></i>Logout
=======
       class="btn btn-dark waves-effect waves-float waves-light logout-btn">
      <span class="btn-content">
        <i class="fas fa-sign-out-alt me-2"></i>Logout
      </span>
      <span class="btn-background"></span>
>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4
    </a>
  </div>
</div>

    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
<<<<<<< HEAD
            <div class="d-flex justify-content-between align-items-center p-3 header-bar">
                <h2 class="mb-0"><i class="fas fa-clinic-medical me-3"></i>ESI Contributions Dashboard</h2>
                <button class="btn" data-bs-toggle="modal" data-bs-target="#esiModal">
=======
            <div class="d-flex justify-content-between align-items-center p-3 rounded-3 header-bar card-3d">
                <h2 class="mb-0"><i class="fas fa-clinic-medical me-3"></i>ESI Contributions Dashboard</h2>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#esiModal">
>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4
                    <i class="fas fa-plus me-2"></i>Add ESI Contribution
                </button>
            </div>
        </div>
    </div>

<<<<<<< HEAD
    <!-- Filter Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title mb-3 fw-bold" style="color: var(--primary-gov-blue);"><i class="fas fa-filter me-2"></i>Filter Contributions</h5>
=======
		
    <!-- Filter Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card card-3d">
                <div class="card-body">
                    <h5 class="card-title mb-3 fw-bold" style="color: var(--primary-color);"><i class="fas fa-filter me-2"></i>Filter Contributions</h5>
>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4
                    <div class="row g-3 align-items-end">
                        <div class="col-md-4">
                            <label for="profitCenterFilter" class="form-label fw-bold">Profit Center</label>
                            <select class="form-select select2" id="profitCenterFilter" data-placeholder="Select a Profit Center">
                                <option value=""></option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="monthYearFilter" class="form-label fw-bold">Month-Year</label>
                            <select class="form-select select2" id="monthYearFilter" data-placeholder="Select a Period">
                                <option value=""></option>
                            </select>
                        </div>
                        <div class="col-md-4 d-flex align-items-end"> 
                            <button class="btn btn-outline-secondary me-2" type="button" id="clearFilters">
                                <i class="fas fa-times me-2"></i>Clear
                            </button>
<<<<<<< HEAD
=======
                            <!-- Buttons container will be moved here by datatables -->
>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4
                            <div id="buttons" class="d-inline-flex"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Table -->
    <div class="row">
        <div class="col-12">
<<<<<<< HEAD
            <div class="table-responsive card p-3">
=======
            <div class="table-responsive card-3d p-3">
>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4
                <table id="esiTable" class="table table-hover align-middle" style="width:100%;">
                    <thead>
                        <tr>
                            <th><i class="fas fa-briefcase me-2"></i>Profit Center</th>
                            <th><i class="fas fa-calendar-alt me-2"></i>Period</th>
                            <th class="text-end"><i class="fas fa-user-tie me-2"></i>Employee</th>
                            <th class="text-end"><i class="fas fa-building me-2"></i>Employer</th>
                            <th class="text-end"><i class="fas fa-calculator me-2"></i>Total</th>
                            <th class="text-end"><i class="fas fa-money-bill-wave me-2"></i>Paid</th>
                            <th class="text-end"><i class="fas fa-balance-scale me-2"></i>Balance</th>
                            <th><i class="fas fa-clock me-2"></i>Due Date</th>
                            <th><i class="fas fa-check-circle me-2"></i>Paid Date</th>
                            <th><i class="fas fa-hourglass-half me-2"></i>Days Diff</th>
                            <th><i class="fas fa-file-invoice me-2"></i>Challan No</th>
<<<<<<< HEAD
                            <c:choose>
                                <c:when test="${sessionScope.ROLE eq 'Admin' or sessionScope.ROLE eq 'SA'}">
                                    <th><i class="fas fa-file-invoice me-2"></i>Status</th>
                                    <th class="text-center"><i class="fas fa-cogs me-2"></i>Actions</th>
                                </c:when>
                                <c:otherwise>
                                    <th><i class="fas fa-gavel me-2"></i>Action</th>
                                </c:otherwise>
                            </c:choose>
=======
                             <c:choose>
                              <c:when test="${sessionScope.ROLE eq 'Admin' or sessionScope.ROLE eq 'SA'}">
                               <th><i class="fas fa-file-invoice me-2"></i>Status</th>
 							   <th class="text-center"><i class="fas fa-cogs me-2"></i>Actions</th>
                              </c:when>
                              <c:otherwise></c:otherwise>
                             </c:choose>
                           
>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${esiList}" var="esi" varStatus="index">
                            <tr class="table-row">
                                <td data-label="Profit Center">
                                    <div class="fw-bold">${esi.profit_center_code}</div>
<<<<<<< HEAD
                                    <div class="small" style="color: var(--text-muted-color) !important;">${esi.profit_center_name}</div>
=======
                                    <div class="small" style="color: var(--muted-color) !important;">${esi.profit_center_name}</div>
>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4
                                </td>
                                <td data-label="Period" class="fw-bold">${esi.month_year}</td>
                                <td data-label="Employee" class="text-end">₹${esi.employee_contribution}</td>
                                <td data-label="Employer" class="text-end">₹${esi.employer_contribution}</td>
                                <td data-label="Total" class="text-end fw-bold">₹${esi.employee_contribution + esi.employer_contribution}</td>
                                <td data-label="Paid" class="text-end text-success">₹${esi.amount_paid}</td>
                                <td data-label="Balance" class="text-end text-danger">₹${(esi.employee_contribution + esi.employer_contribution) - esi.amount_paid}</td>
                                <td data-label="Due Date">${esi.due_date}</td>
                                <td data-label="Paid Date">${not empty esi.actual_payment_date ? esi.actual_payment_date : '-'}</td>
                                <td data-label="Days Diff">
                                    <c:choose>
                                        <c:when test="${not empty esi.actual_payment_date && esi.delay_days > 0}">
                                            <span class="badge bg-danger">${esi.delay_days} days</span>
                                        </c:when>
                                        <c:when test="${not empty esi.actual_payment_date}">
                                            <span class="badge bg-success">${esi.delay_days} days</span>
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td data-label="Challan No">${esi.challan_no}</td>
<<<<<<< HEAD
                                <c:choose>
                                    <c:when test="${sessionScope.ROLE eq 'Admin' or sessionScope.ROLE eq 'SA'}">
                                        <td data-label="Status">
                                            <span class="status-badge ${esi.status == 'Active' ? 'active' : 'inactive'}">
                                                <span class="status-text">${esi.status}</span>
                                            </span>
                                        </td>
                                        <td class="text-center" data-label="Actions">
                                            <div class="d-flex justify-content-center">
                                                <button class="btn btn-sm btn-outline-primary me-1 btn-action" data-bs-toggle="modal" data-bs-target="#esiModal_${index.count}">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </c:when>
                                    <c:otherwise>
                                        <td data-label="Action">
                                            <button class="btn btn-sm appeal-btn" 
                                                    data-record-id="${esi.id}" 
                                                    data-url="<%=request.getContextPath()%>/appealRecord">
                                                <i class="fas fa-gavel me-1"></i> Appeal
                                            </button>
                                        </td>
                                    </c:otherwise>
                                </c:choose>
=======
                                 <c:choose>
                                  <c:when test="${sessionScope.ROLE eq 'Admin' or sessionScope.ROLE eq 'SA'}">
                                      <td data-label="Status">
                                          <span class="status-badge ${esi.status == 'Active' ? 'active' : 'inactive'}">
                                            <span class="status-text">${esi.status}</span>
                                            <span class="status-pulse"></span>
                                            <span class="status-glow"></span>
                                          </span>
                                      </td>
                                      <td class="text-center" data-label="Actions">
                                        <div class="d-flex justify-content-center">
                                            <button class="btn btn-sm btn-outline-primary me-1 btn-action" data-bs-toggle="modal" data-bs-target="#esiModal${index.count }">
                                                 <i class="fas fa-edit"></i>
                                            </button>
                                        </div>
                                      </td>
                                  </c:when>
                                  <c:otherwise></c:otherwise>
                                 </c:choose>
>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<<<<<<< HEAD
<!-- Edit Modals -->
<c:forEach items="${esiList}" var="esi" varStatus="index">
    <div class="modal fade" id="esiModal_${index.count}" tabindex="-1" aria-labelledby="esiModalLabel_${index.count}" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content">
                <form id="esiForm_${index.count}" action="<%=request.getContextPath() %>/update-esi" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title" id="esiModalLabel_${index.count}">Update ESI Contribution</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="id" value="${esi.id}" />
                        
                        <!-- Core Info -->
                        <h5><i class="fas fa-info-circle me-2"></i>Core Information</h5>
                        <div class="row mb-4 g-3">
                            <c:choose>
                                <c:when test="${sessionScope.ROLE eq 'Admin' or sessionScope.ROLE eq 'SA'}">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Profit Center</label>
                                        <select class="form-select select2" name="profit_center_code" id="profitCenterSelect_${index.count}" required>
                                            <option value="">-- Search Profit Center --</option>
                                            <c:forEach items="${profitCenterList}" var="pc">
                                                <option value="${pc.profit_center_code}" ${pc.profit_center_code == esi.profit_center_code ? 'selected' : ''}>${pc.profit_center_code} - ${pc.profit_center_name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </c:when>
                                <c:when test="${sessionScope.ROLE eq 'Management'}">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Profit Center</label>
                                        <select class="form-select select2" name="profit_center_code" id="profitCenterSelect_${index.count}" required>
                                            <option value="">-- Search Profit Center --</option>
                                            <c:set var="pcList" value="${fn:split(sessionScope.PC, ',')}" />
                                            <c:forEach items="${profitCenterList}" var="pc">
                                                <c:forEach var="allowedPC" items="${pcList}">
                                                    <c:if test="${pc.profit_center_code == fn:trim(allowedPC)}">
                                                        <option value="${pc.profit_center_code}" ${pc.profit_center_code == esi.profit_center_code ? 'selected' : ''}>${pc.profit_center_code} - ${pc.profit_center_name}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Profit Center</label>
                                        <p class="form-control-plaintext bg-light p-2 rounded">${esi.profit_center_code} - ${esi.profit_center_name}</p>
                                        <input type="hidden" name="profit_center_code" value="${esi.profit_center_code}" />
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Month-Year</label>
                                <p class="form-control-plaintext bg-light p-2 rounded">${esi.month_year}</p>
                                <input type="hidden" name="month_year" value="${esi.month_year}" />
                            </div>
                        </div>

                        <!-- Contribution Details -->
                        <h5><i class="fas fa-calculator me-2"></i>Contribution Details</h5>
                        <div class="row mb-3 g-3">
                            <div class="col-md-4">
                                <label class="form-label">Employee (₹)</label>
                                <input type="number" step="0.01" min="0" id="employee_contribution_${index.count}" name="employee_contribution" class="form-control" value="${esi.employee_contribution}" oninput="calculateTotal_edit(${index.count})" required />
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Employer (₹)</label>
                                <input type="number" step="0.01" min="0" id="employer_contribution_${index.count}" name="employer_contribution" class="form-control" value="${esi.employer_contribution}" oninput="calculateTotal_edit(${index.count})" required />
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-bold">Total (₹)</label>
                                <input type="number" id="total_amount_${index.count}" name="total_amount" value="${esi.total_amount}" class="form-control bg-light" readonly required />
                            </div>
                        </div>

                        <!-- Payment Details -->
                        <h5 class="mt-4"><i class="fas fa-money-check-alt me-2"></i>Payment Details</h5>
                        <div class="row mb-3 g-3">
                            <div class="col-md-4">
                                <label class="form-label">Amount Paid (₹)</label>
                                <input type="number" step="0.01" min="0" id="amount_paid_${index.count}" name="amount_paid" class="form-control" value="${esi.amount_paid}" oninput="calculateDifference_edit(${index.count})" required />
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-bold">Balance (₹)</label>
                                <input type="number" id="difference_${index.count}" name="difference" value="${esi.difference}" class="form-control bg-light" readonly required />
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Challan Number</label>
                                <input type="text" id="challan_no_${index.count}" name="challan_no" class="form-control" value="${esi.challan_no}" placeholder="Enter challan number" />
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Due Date</label>
                                <input type="date" id="due_date_${index.count}" name="due_date" class="form-control" value="${esi.due_date}" required />
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Actual Payment Date</label>
                                <input type="date" id="actual_payment_date_${index.count}" name="actual_payment_date" class="form-control actual-payment-date-input" value="${esi.actual_payment_date}" onchange="calculateDelayDays_edit(${index.count})" required />
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Delay in Days</label>
                                <input type="number" id="delay_days_${index.count}" name="delay_days" class="form-control bg-light" value="${esi.delay_days}" readonly required />
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Employee Count</label>
                                <input type="number" min="0" id="no_of_emp_${index.count}" name="no_of_emp" class="form-control" value="${esi.no_of_emp}" placeholder="e.g., 17" />
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-bold">Status</label>
                                <select name="status" class="form-select">
                                    <option value="Active" ${esi.status == 'Active' ? 'selected' : ''}>Active</option>
                                    <option value="Inactive" ${esi.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Update ESI Contribution</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</c:forEach>

<!-- Add Modal -->
<div class="modal fade" id="esiModal" tabindex="-1" aria-labelledby="esiModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content">
            <form id="esiForm" action="<%=request.getContextPath() %>/add-esi" method="post">
                <div class="modal-header">
=======
<!-- MODALS -->
<c:forEach items="${esiList}" var="esi" varStatus="index">
  <div class="modal fade" id="esiModal${index.count}" tabindex="-1" aria-labelledby="esiModalLabel${index.count}" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered">
      <div class="modal-content">
            <form id="esiForm${index.count }" action="<%=request.getContextPath() %>/update-esi" method="post">
                <div class="modal-header header-bar" style="border-top-left-radius: 15px; border-top-right-radius: 15px;">
                    <h5 class="modal-title" id="esiModalLabel">Update ESI Contribution</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <input type="hidden" id="esi_id" name="id" value="${esi.id}" />
					<div class="row mb-3">
					    <div class="col-md-6">
					        <div class="form-group">
					            <label for="profitCenterSelect">Profit Center</label>
					            <select id="profitCenterSelect${index.count}" name="profit_centers" class="form-control">
					                <option value="">- Search Profit Center -</option>
					                <c:forEach items="${profitCenterList}" var="pc">
					                    <option value="${pc.profit_center_code}" ${esi.profit_center_code == pc.profit_center_code ? 'selected' : ''}>
					                        ${pc.profit_center_code} - ${pc.profit_center_name}
					                    </option>
					                </c:forEach>
					            </select>
					        </div>
					    </div>
					    <div class="col-md-6">
					        <div class="form-group">
					            <label for="monthYear">Month-Year</label>
					            <input type="month" id="monthYear${index.count}" name="month_years" class="form-control" value="${esi.month_year}" />
					        </div>
					    </div>
					</div>
					<div class="row mb-3 bg-light p-3 rounded-3">
					    <div class="col-md-3">
					        <div class="form-group">
					            <label>Employee (₹)</label>
					            <div class="input-group input-group-sm">
					                <span class="input-group-text">₹</span>
					                <input type="number" step="0.01" id="employee_contribution${index.count}" name="employee_contributions" 
					                       class="form-control form-control-sm" value="${esi.employee_contribution}" 
					                       oninput="calculateTotal1(${index.count})" required />
					            </div>
					        </div>
					    </div>
					    <div class="col-md-3">
					        <div class="form-group">
					            <label>Employer (₹)</label>
					            <div class="input-group input-group-sm">
					                <span class="input-group-text">₹</span>
					                <input type="number" step="0.01" id="employer_contribution${index.count}" name="employer_contributions" 
					                       class="form-control form-control-sm" value="${esi.employer_contribution}" 
					                       oninput="calculateTotal1(${index.count})" required />
					            </div>
					        </div>
					    </div>
					    <div class="col-md-2">
					        <div class="form-group">
					            <label>Total (₹)</label>
					            <div class="input-group input-group-sm">
					                <span class="input-group-text">₹</span>
					                <input type="number" id="total_amount${index.count}" name="total_amounts"  value="${esi.total_amount}"
					                       class="form-control form-control-sm bg-white" readonly required />
					            </div>
					        </div>
					    </div>
					    <div class="col-md-2">
					        <div class="form-group">
					            <label>Amount Paid (₹)</label>
					            <div class="input-group input-group-sm">
					                <span class="input-group-text">₹</span>
					                <input type="number" step="0.01" id="amount_paid${index.count}" name="amount_paids" 
					                       class="form-control form-control-sm" value="${esi.amount_paid}" 
					                       oninput="calculateDifference1(${index.count})" required />
					            </div>
					        </div>
					    </div>
					    <div class="col-md-2">
					        <div class="form-group">
					            <label>Balance (₹)</label>
					            <div class="input-group input-group-sm">
					                <span class="input-group-text">₹</span>
					                <input type="number" id="difference${index.count}" name="differences" value="${esi.difference}" 
					                       class="form-control form-control-sm bg-white" readonly required />
					            </div>
					        </div>
					    </div>
					</div>
					<div class="row mb-3">
					    <div class="col-md-4">
					        <div class="form-group">
					            <label for="due_date${index.count}" class="form-label fw-bold">Due Date</label>
					            <input type="date" id="due_date${index.count}" name="due_dates" class="form-control" 
					                   value="${esi.due_date}" required />
					        </div>
					    </div>
					    <div class="col-md-4">
					        <div class="form-group">
					            <label for="actual_payment_date${index.count}" class="form-label fw-bold">Actual Payment Date</label>
					            <input type="date" id="actual_payment_date${index.count}" name="actual_payment_dates" 
					                   class="form-control" value="${esi.actual_payment_date}" 
					                   onchange="calculateDelayDays1(${index.count})" required />
					        </div>
					    </div>
					    <div class="col-md-4">
					        <div class="form-group">
					            <label for="delay_days${index.count}" class="form-label fw-bold">Delay in Days</label>
					            <input type="number" id="delay_days${index.count}" name="delay_dayss" 
					                   class="form-control bg-light" value="${esi.delay_days}" readonly required />
					        </div>
					    </div>
					</div>
					<div class="row mb-3">
					    <div class="col-md-4">
					        <div class="form-group">
					            <label for="challan_no">Challan Number</label>
					            <input type="text" id="challan_no${index.count}" name="challan_nos" class="form-control" value="${esi.challan_no}" placeholder="Enter challan number" />
					        </div>
					    </div>
					    <div class="col-md-4">
					        <div class="form-group">
					            <label for="no_of_emp">Count of Employees</label>
					            <input type="text" id="no_of_emp${index.count}" name="no_of_emps" class="form-control" value="${esi.no_of_emp}" placeholder="Enter no of emp count. ie., 17" />
					        </div>
					    </div>
					    <div class="col-md-4">
					        <div class="form-group">
					            <label for="status">Status</label>
					 			<select id="status${index.count}" name="status" class="form-control">
					                <option value="">- Status -</option>
					                    <option value="Active" ${esi.status == 'Active' ? 'selected' : ''}> Active</option>
					                    <option value="Inactive" ${esi.status == 'Inactive' ? 'selected' : ''}> Inactive</option>
					            </select>
                            </div>
					    </div>
					</div>
                </div>
                <div class="modal-footer" style="border-bottom-left-radius: 15px; border-bottom-right-radius: 15px;">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary" id="submitBtn${index.count}" >Update ESI Contribution</button>
                </div>
            </form>
        </div>
    </div>
</div>
</c:forEach>
<div class="modal fade" id="esiModal" tabindex="-1" aria-labelledby="esiModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content" style="background: #fff; border-radius: 15px;">
            <form id="esiForm" action="<%=request.getContextPath() %>/add-esi" method="post">
                <div class="modal-header header-bar" style="border-top-left-radius: 15px; border-top-right-radius: 15px;">
>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4
                    <h5 class="modal-title" id="esiModalLabel">Add New ESI Contribution</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
<<<<<<< HEAD
                    <!-- Core Info -->
                    <h5><i class="fas fa-info-circle me-2"></i>Core Information</h5>
                    <div class="row mb-3 g-3">
                        <c:choose>
                            <c:when test="${sessionScope.ROLE eq 'Admin' or sessionScope.ROLE eq 'SA'}">
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Profit Center</label>
                                    <select class="form-select select2" name="profit_center_code" id="profitCenterSelect" required>
                                        <option value="">-- Search Profit Center --</option>
                                        <c:forEach items="${profitCenterList}" var="pc">
                                            <option value="${pc.profit_center_code}">${pc.profit_center_code} - ${pc.profit_center_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </c:when>
                            <c:when test="${sessionScope.ROLE eq 'Management'}">
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Profit Center</label>
                                    <select class="form-select select2" name="profit_center_code" id="profitCenterSelect" required>
                                        <option value="">-- Search Profit Center --</option>
                                        <c:set var="pcList" value="${fn:split(sessionScope.PC, ',')}" />
                                        <c:forEach items="${profitCenterList}" var="pc">
                                            <c:forEach var="allowedPC" items="${pcList}">
                                                <c:if test="${pc.profit_center_code == fn:trim(allowedPC)}">
                                                    <option value="${pc.profit_center_code}">${pc.profit_center_code} - ${pc.profit_center_name}</option>
                                                </c:if>
                                            </c:forEach>
                                        </c:forEach>
                                    </select>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Profit Center</label>
                                    <p class="form-control-plaintext bg-light p-2 rounded">${sessionScope.PCN}</p>
                                    <input type="hidden" class="form-control" id="profitCenterSelect" name="profit_center_code" value="${sessionScope.PC}"/>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Month-Year</label>
                            <input type="month" class="form-control" name="month_year" id="monthYear" required>
                        </div>
                    </div>

                    <!-- Contribution Details -->
                    <h5 class="mt-4"><i class="fas fa-calculator me-2"></i>Contribution Details</h5>
                    <div class="row mb-3 g-3">
                        <div class="col-md-4">
                            <label class="form-label">Employee (₹)</label>
                            <input type="number" step="0.01" min="0" class="form-control" name="employee_contribution" id="employee_contribution" oninput="calculateTotal()" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Employer (₹)</label>
                            <input type="number" step="0.01" min="0" class="form-control" name="employer_contribution" id="employer_contribution" oninput="calculateTotal()" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold">Total (₹)</label>
                            <input type="number" class="form-control bg-light" name="total_amount" id="total_amount" readonly required>
                        </div>
                    </div>

                    <!-- Payment Details -->
                    <h5 class="mt-4"><i class="fas fa-money-check-alt me-2"></i>Payment Details</h5>
                    <div class="row mb-3 g-3">
                        <div class="col-md-4">
                            <label class="form-label">Amount Paid (₹)</label>
                            <input type="number" step="0.01" min="0" class="form-control" name="amount_paid" id="amount_paid" oninput="calculateDifference()" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold">Balance (₹)</label>
                            <input type="number" class="form-control bg-light" name="difference" id="difference" readonly required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Due Date</label>
                            <input type="date" class="form-control" name="due_date" id="due_date" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Actual Payment Date</label>
                            <input type="date" class="form-control actual-payment-date-input" name="actual_payment_date" id="actual_payment_date" onchange="calculateDelayDays()" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Delay in Days</label>
                            <input type="number" class="form-control bg-light" name="delay_days" id="delay_days" readonly value="0" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Challan Number</label>
                            <input type="text" class="form-control" name="challan_no" id="challan_no" placeholder="Enter challan number" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Employee Count</label>
                            <input type="number" min="0" class="form-control" name="no_of_emp" id="no_of_emp" placeholder="e.g., 17" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save ESI Contribution</button>
=======
                    <div class="row mb-3">
                      <c:choose>
                           <c:when test="${sessionScope.ROLE eq 'Admin' or sessionScope.ROLE eq 'SA'}">
           						<div class="col-md-6"><label class="form-label fw-bold">Profit Center</label><select class="form-select select2" name="profit_center_code" id="profitCenterSelect" required><option value="">-- Search Profit Center --</option><c:forEach items="${profitCenterList}" var="pc"><option value="${pc.profit_center_code}">${pc.profit_center_code} - ${pc.profit_center_name}</option></c:forEach></select></div>
                           </c:when>
                           <c:otherwise>
                           <div class="col-md-6"><label class="form-label fw-bold">Profit Center</label>
                           		<h5 class="brand-text mb-0 text-primary text-center"> ${sessionScope.PCN}</h5>
	                           	<input type="hidden" class="form-control" id="profitCenterSelect" name="profit_center_code" value="${sessionScope.PC}"/>
                           	</div>
                           </c:otherwise>
                       </c:choose>
                        <div class="col-md-6"><label class="form-label fw-bold">Month-Year</label><input type="month" class="form-control" name="month_year" id="monthYear" required></div>
                    </div>
                    <div class="row mb-3 bg-light p-3 rounded-3">
                         <div class="col-md-3"><label class="form-label">Employee (₹)</label><div class="input-group input-group-sm"><span class="input-group-text">₹</span><input type="number" step="0.01" class="form-control form-control-sm" id="employee_contribution" name="employee_contribution" oninput="calculateTotal()" required></div></div>
                         <div class="col-md-3"><label class="form-label">Employer (₹)</label><div class="input-group input-group-sm"><span class="input-group-text">₹</span><input type="number" step="0.01" class="form-control form-control-sm" id="employer_contribution" name="employer_contribution" oninput="calculateTotal()" required></div></div>
                         <div class="col-md-2"><label class="form-label">Total (₹)</label><div class="input-group input-group-sm"><span class="input-group-text">₹</span><input type="number" class="form-control form-control-sm bg-white" id="total_amount" name="total_amount" readonly required></div></div>
                         <div class="col-md-2"><label class="form-label">Amount Paid (₹)</label><div class="input-group input-group-sm"><span class="input-group-text">₹</span><input type="number" step="0.01" class="form-control form-control-sm" id="amount_paid" name="amount_paid" oninput="calculateDifference()" required></div></div>
                         <div class="col-md-2"><label class="form-label">Balance (₹)</label><div class="input-group input-group-sm"><span class="input-group-text">₹</span><input type="number" class="form-control form-control-sm bg-white" id="difference" name="difference" readonly required></div></div>
                    </div>
                    <div class="row mb-3">
                         <div class="col-md-4"><label class="form-label fw-bold">Due Date</label><input type="date" class="form-control" id="due_date" name="due_date" required></div>
                         <div class="col-md-4"><label class="form-label fw-bold">Actual Payment Date</label><input type="date" class="form-control" name="actual_payment_date" id="actual_payment_date" onchange="calculateDelayDays()" required></div>
                         <div class="col-md-4"><label class="form-label fw-bold">Delay in Days</label><input type="number" class="form-control bg-light" name="delay_days" id="delay_days" readonly value="0" required></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6"><label class="form-label fw-bold">Challan Number</label><input type="text" class="form-control" name="challan_no" id="challan_no" placeholder="Enter challan number" required></div>
                        <div class="col-md-6"><label class="form-label fw-bold">Count of Employees this month.</label><input type="text" class="form-control" name="no_of_emp" id="no_of_emp" placeholder="Enter no of emp count. ie,. 17" required></div>
                    </div>
                </div>
                <div class="modal-footer" style="border-bottom-left-radius: 15px; border-bottom-right-radius: 15px;">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary" id="submitBtn">Save ESI Contribution</button>
>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4
                </div>
            </form>
        </div>
    </div>
</div>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.bootstrap5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.print.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<script>
$(document).ready(function () {
<<<<<<< HEAD
    // Set max date for actual payment date inputs to today
    const today = new Date().toISOString().split('T')[0];
    $('.actual-payment-date-input').attr('max', today);

=======
>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4
    // Initialize Select2
    function initSelect2() {
        $('#profitCenterFilter, #monthYearFilter').select2({ 
            theme: 'bootstrap-5',
            allowClear: true,
            placeholder: $(this).data('placeholder')
        });
        $('#esiModal .select2').select2({
            theme: 'bootstrap-5',
            dropdownParent: $('#esiModal')
        });
<<<<<<< HEAD
        $('[id^=esiModal_] .select2').each(function() {
            $(this).select2({
                theme: 'bootstrap-5',
                dropdownParent: $(this).closest('.modal')
            });
        });
=======
>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4
    }

    // Initialize DataTable
    var table = $('#esiTable').DataTable({
        "responsive": true,
        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
        "language": { "search": "", "searchPlaceholder": "Search..." },
        "dom": "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
               "<'row'<'col-sm-12'tr>>" +
               "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
        "buttons": [
            { 
                extend: 'excelHtml5', 
                text: '<i class="fas fa-file-excel me-1"></i>Export', 
                className: 'btn btn-success btn-sm',
                exportOptions: {
                    columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                    format: {
                        body: function ( data, row, column, node ) {
                            if (column === 0) {
                                return $(node).find('.fw-bold').text() + ' ' + $(node).find('.small').text();
                            }
<<<<<<< HEAD
                            if (column === 9) {
=======
                            if (column === 9) { // Days Diff column
>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4
                                return $(data).text().trim();
                            }
                            return data;
                        }
                    }
                },
                customizeData: function(d) {
                    d.header[0] = 'Profit Center Code';
                    d.header.splice(1, 0, 'Profit Center Name');
<<<<<<< HEAD
=======

>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4
                    for (var i = 0; i < d.body.length; i++) {
                        var profitCenterCell = d.body[i][0];
                        if (profitCenterCell) {
                            var parts = profitCenterCell.trim().split(/\s+/);
                            var code = parts.shift() || '';
                            var name = parts.join(' ') || '';
                            d.body[i][0] = code;
                            d.body[i].splice(1, 0, name);
                        }
                    }
                }
            }
        ],
        "initComplete": function(settings, json) {
            this.api().buttons().container().appendTo('#buttons');
            initSelect2();
            populateFilters(this.api());
        }
    });

<<<<<<< HEAD
    // Appeal Button Logic
    $('.appeal-btn').on('click', function() {
        const recordId = $(this).data('record-id');
        const appealUrl = $(this).data('url');
        
        Swal.fire({
            title: 'Appeal Request',
            text: 'Do you want to appeal this record to Admin for changes?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Yes, Appeal',
            cancelButtonText: 'Cancel'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = appealUrl + '?id=' + recordId;
            }
        });
    });

    // Filter Logic
=======
    // --- FILTER LOGIC ---
>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4
    $('#profitCenterFilter, #monthYearFilter').on('change', function () {
        var pcVal = $('#profitCenterFilter').val();
        var myVal = $('#monthYearFilter').val();
        
        table.column(0).search(pcVal ? '^' + $.fn.dataTable.util.escapeRegex(pcVal) : '', true, false);
        table.column(1).search(myVal ? '^' + $.fn.dataTable.util.escapeRegex(myVal) + '$' : '', true, false);
        
        table.draw();
    });

    table.on('draw.dt', function() {
        populateFilters(table);
    });

    $('#clearFilters').on('click', function () {
        $('#profitCenterFilter, #monthYearFilter').val(null).trigger('change');
    });
<<<<<<< HEAD

    function populateFilters(api) {
        var currentPC = $('#profitCenterFilter').val();
        var currentMY = $('#monthYearFilter').val();

        populateSelect(api, 0, '#profitCenterFilter', currentPC, function(cell) {
            var code = $(cell).find('.fw-bold').text().trim();
            var name = $(cell).find('.small').text().trim();
            if (code) return { code: code, text: code + ' ' + name };
            return null;
        });

        populateSelect(api, 1, '#monthYearFilter', currentMY, function(cell) {
            var data = $(cell).text().trim();
            if(data) return { code: data, text: data };
            return null;
        }, (a, b) => b.text.localeCompare(a.text));
    }

    function populateSelect(api, columnIndex, selectId, currentValue, dataExtractor, sortFn) {
        var select = $(selectId);
        var uniqueItems = new Map();

        api.column(columnIndex, { search: 'applied' }).nodes().each(function (cell) {
            var item = dataExtractor(cell);
            if (item && item.code && !uniqueItems.has(item.code)) {
                uniqueItems.set(item.code, item.text);
            }
        });

        select.find('option:not([value=""])').remove();
        
        var itemsArray = Array.from(uniqueItems, ([code, text]) => ({ code, text }));
        
        if (sortFn) {
            itemsArray.sort(sortFn);
        } else {
            itemsArray.sort((a, b) => a.text.localeCompare(b.text));
        }

        itemsArray.forEach(item => {
            select.append($('<option>', { value: item.code, text: item.text }));
        });

        select.val(currentValue);
    }

    // Modal and Calculation Logic
    $('#esiModal').on('show.bs.modal', function (e) {
        if (!$(e.relatedTarget).hasClass('edit-trigger')) {
            $('#esiForm')[0].reset();
            $('#esiModalLabel').text('Add New ESI Contribution');
            if('${sessionScope.ROLE}' !== 'User' && '${sessionScope.ROLE}' !== 'Management'){
                $('#profitCenterSelect').val(null).trigger('change');
            }
            const currentDate = new Date();
            const currentMonth = currentDate.toISOString().slice(0, 7);
            $('#monthYear').val(currentMonth);
            
            const nextMonth = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 15);
            const dueDate = nextMonth.toISOString().slice(0, 10);
            $('#due_date').val(dueDate);
        }
    });

    // Edit Modal Calculations
    function calculateTotal_edit(index) {
        var employee = parseNumericInput($('#employee_contribution_' + index));
        var employer = parseNumericInput($('#employer_contribution_' + index));
        var total = employee + employer;
        
        $('#total_amount_' + index).val(total.toFixed(2));
        calculateDifference_edit(index);
    }

    function calculateDifference_edit(index) {
        var total = parseNumericInput($('#total_amount_' + index));
        var paidInput = $('#amount_paid_' + index);
        var paid = parseNumericInput(paidInput);
        
        if (paid > total) {
            paidInput.val(total.toFixed(2));
            paid = total;
        }

        var difference = total - paid;
        $('#difference_' + index).val(difference.toFixed(2));
    }

    function calculateDelayDays_edit(index) {
        var dueDateStr = $('#due_date_' + index).val();
        var actualDateStr = $('#actual_payment_date_' + index).val();
        
        if (dueDateStr && actualDateStr) {
            var diffDays = (new Date(actualDateStr) - new Date(dueDateStr)) / (1000 * 3600 * 24);
            $('#delay_days_' + index).val(Math.max(0, Math.ceil(diffDays)));
        } else {
            $('#delay_days_' + index).val(0);
        }
    }

    // Add Modal Calculations
    function parseNumericInput(selector) { 
        return Math.max(0, parseFloat($(selector).val()) || 0); 
    }

    function calculateTotal() { 
        var form = $('#esiForm');
        var total = parseNumericInput(form.find('#employee_contribution')) + parseNumericInput(form.find('#employer_contribution')); 
        form.find('#total_amount').val(total.toFixed(2)); 
        calculateDifference(); 
    }

    function calculateDifference() { 
        var form = $('#esiForm');
        var total = parseNumericInput(form.find('#total_amount'));
        var paidInput = form.find('#amount_paid');
        var paid = parseNumericInput(paidInput);

        if (paid > total) {
            paidInput.val(total.toFixed(2));
            paid = total;
        }

        var difference = total - paid;
        form.find('#difference').val(difference.toFixed(2)); 
    }

    function calculateDelayDays() { 
        var form = $('#esiForm');
        var dueDateStr = form.find('#due_date').val(); 
        var actualDateStr = form.find('#actual_payment_date').val(); 
        if (dueDateStr && actualDateStr) { 
            var diffDays = (new Date(actualDateStr) - new Date(dueDateStr)) / (1000 * 3600 * 24); 
            form.find('#delay_days').val(Math.max(0, Math.ceil(diffDays))); 
        } else { 
            form.find('#delay_days').val(0); 
        } 
    }

    function checkDuplicatePCMY() {
        var pcVal = $('#profitCenterSelect').val() ? $('#profitCenterSelect').val().trim() : '';
        var myVal = $('#monthYear').val() ? $('#monthYear').val().trim() : '';

        if (pcVal && myVal) {
            var isDuplicate = false;
            var rowPcName = '';

            $('#esiTable').DataTable().rows().data().each(function (rowData) {
                var htmlContent = $('<div>' + rowData[0] + '</div>');
                var rowPc = htmlContent.find('.fw-bold').text().trim();
                rowPcName = htmlContent.find('.small').text().trim();
                var rowMy = rowData[1] ? rowData[1].trim() : '';
                var statusHtml = rowData[11] ? rowData[11].trim() : '';
                var status = $(statusHtml).text().trim();

                if (rowPc === pcVal && rowMy === myVal && status === 'Active') {
                    isDuplicate = true;
                    return false; // Stop loop
                }
            });

            if (isDuplicate) {
                $('#monthYear').val('');
                showStrictAlertBox(
                    "Duplicate Entry Detected",
                    `Data for <strong>${rowPcName}</strong> in <strong>${myVal}</strong> with "Active" status already exists. Duplicate entries are not allowed.`
                );
            }
        }
    }

    function showStrictAlertBox(title, message) {
        $('#strictAlertBox').remove();
        var secondsLeft = 10;

        var alertBoxHtml =
            '<div id="strictAlertBox" class="strict-alert">' +
                '<div class="strict-alert-header">' +
                    '<h5>' + title + '</h5>' +
                    '<button type="button" class="strict-alert-close">&times;</button>' +
                '</div>' +
                '<div class="strict-alert-body">' +
                    '<p>' + message + '</p>' +
                    '<div class="strict-alert-footer text-muted small">' +
                        'Auto-closing in <span id="strictAlertCountdown">' + secondsLeft + '</span>s' +
                    '</div>' +
                '</div>' +
            '</div>';

        var $alertBox = $(alertBoxHtml);

        $('body').append($alertBox);

        var countdownInterval = setInterval(function() {
            secondsLeft--;
            $('#strictAlertCountdown').text(secondsLeft);
            if (secondsLeft <= 0) {
                clearInterval(countdownInterval);
                $alertBox.fadeOut(500, function() { $(this).remove(); });
            }
        }, 1000);

        $alertBox.find('.strict-alert-close').on('click', function() {
            clearInterval(countdownInterval);
            $alertBox.fadeOut(500, function() { $(this).remove(); });
        });
    }

    $('#profitCenterSelect, #monthYear').on('change', checkDuplicatePCMY);
});
</script>
</body>
</html>
=======
});

function populateFilters(api) {
    var currentPC = $('#profitCenterFilter').val();
    var currentMY = $('#monthYearFilter').val();

    populateSelect(api, 0, '#profitCenterFilter', currentPC, function(cell) {
        var code = $(cell).find('.fw-bold').text().trim();
        var name = $(cell).find('.small').text().trim();
        if (code) {
             return { code: code, text: code + ' ' + name };
        }
        return null;
    });

    populateSelect(api, 1, '#monthYearFilter', currentMY, function(cell) {
        var data = $(cell).text().trim();
        if(data) {
            return { code: data, text: data };
        }
        return null;
    }, function(a, b) { return b.text.localeCompare(a.text); });
}

function populateSelect(api, columnIndex, selectId, currentValue, dataExtractor, sortFn) {
    var select = $(selectId);
    var uniqueItems = new Map();

    api.column(columnIndex, { search: 'applied' }).nodes().each(function (cell) {
        var item = dataExtractor(cell);
        if (item && item.code && !uniqueItems.has(item.code)) {
            uniqueItems.set(item.code, item.text);
        }
    });

    select.find('option:not([value=""])').remove();
    
    var itemsArray = Array.from(uniqueItems, function([code, text]) { return { code: code, text: text }; });
    
    if (sortFn) {
        itemsArray.sort(sortFn);
    } else {
        itemsArray.sort(function(a, b) { return a.text.localeCompare(b.text); });
    }

    itemsArray.forEach(function(item) {
        select.append($('<option>', { value: item.code, text: item.text }));
    });

    select.val(currentValue);
}

// --- MODAL AND CALCULATION LOGIC ---
$('#esiModal').on('show.bs.modal', function (e) {
    if (!$(e.relatedTarget).hasClass('edit-trigger')) {
        $('#esiForm')[0].reset();
        $('#esi_id').val('');
        $('#esiModalLabel').text('Add New ESI Contribution');
        if('${sessionScope.ROLE}' != 'User'){
            $('#profitCenterSelect').val(null).trigger('change');
        }
        const currentDate = new Date();
        const currentMonth = currentDate.toISOString().slice(0, 7);
        $('#monthYear').val(currentMonth);
        var pcVal = '${sessionScope.PC}';
        var mVal = $('#monthYear').val().trim();
        checkDuplicatePCMY1(pcVal,mVal);
        const nextMonth = new Date(currentDate.getFullYear(), currentDate.getMonth(), 16);
        const dueDate = nextMonth.toISOString().slice(0, 10);
        $('#due_date').val(dueDate);
    }
});

function calculateTotal1(index) {
    var employee = parseNumericInput('#employee_contribution' + index);
    var employer = parseNumericInput('#employer_contribution' + index);
    var total = employee + employer;
    
    $('#total_amount' + index).val(total.toFixed(2));
    calculateDifference1(index);
}

function calculateDifference1(index) {
    var total = parseNumericInput('#total_amount' + index);
    var paid = parseNumericInput('#amount_paid' + index);
    var difference = total - paid;
    
    $('#difference' + index).val(difference.toFixed(2));
}

function calculateDelayDays1(index) {
    var dueDateStr = $('#due_date' + index).val();
    var actualDateStr = $('#actual_payment_date' + index).val();
    
    if (dueDateStr && actualDateStr) {
        var dueDate = new Date(dueDateStr);
        var actualDate = new Date(actualDateStr);
        
        if (!isNaN(dueDate) && !isNaN(actualDate)) {
            var timeDiff = actualDate.getTime() - dueDate.getTime();
            var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
            
            $('#delay_days' + index).val(Math.max(0, diffDays));
        } else {
            $('#delay_days' + index).val(0);
        }
    } else {
        $('#delay_days' + index).val(0);
    }
}

function parseNumericInput(selector) { var val = $(selector).val().toString().replace(/,/g, '').trim(); return parseFloat(val) || 0; }
function calculateTotal() { var total = parseNumericInput('#employee_contribution') + parseNumericInput('#employer_contribution'); $('#total_amount').val(total.toFixed(2)); calculateDifference(); }
function calculateDifference() { var difference = parseNumericInput('#total_amount') - parseNumericInput('#amount_paid'); $('#difference').val(difference.toFixed(2)); }
function calculateDelayDays() { var dueDateStr = $('#due_date').val(); var actualDateStr = $('#actual_payment_date').val(); if (dueDateStr && actualDateStr) { var dueDate = new Date(dueDateStr); var actualDate = new Date(actualDateStr); if (!isNaN(dueDate) && !isNaN(actualDate)) { var timeDiff = actualDate.getTime() - dueDate.getTime(); var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24)); $('#delay_days').val(diffDays > 0 ? diffDays : 0); } else { $('#delay_days').val(0); } } else { $('#delay_days').val(0); } }

function confirmDelete(id) { Swal.fire({ title: 'Are you sure?', text: "You won't be able to revert this!", icon: 'warning', showCancelButton: true, confirmButtonColor: '#d33', cancelButtonColor: '#3085d6', confirmButtonText: 'Yes, delete it!' }).then(function(result) { if (result.isConfirmed) { Swal.fire('Deleted!','The ESI contribution has been deleted.','success'); } }); }

function checkDuplicatePCMY() {
    var pcVal = $('#profitCenterSelect').val().trim();
    var myVal = $('#monthYear').val().trim();
    var rowPcName = $('#profitCenterSelect').val().trim();
    if (pcVal !== '' && myVal !== '') {
        var isDuplicate = false;
        var existingId = null;

        $('#esiTable').DataTable().rows().every(function() {
            var rowData = this.data();
            var htmlContent = $('<div>' + rowData[0] + '</div>');

            var rowPc = htmlContent.find('.fw-bold').text().trim();
            rowPcName = htmlContent.find('.small').text().trim();
            var rowMy = rowData[1] ? rowData[1].trim() : '';

            if (rowPc === pcVal && rowMy === myVal) {
                isDuplicate = true;
                existingId = this.id();
                return false;
            }
        });

        if (isDuplicate) {
            $('#monthYear').val('').trigger('change');
            showStrictAlertBox(
                "Duplicate Entry Detected", 
                "❌ Data already exists for:<br><br>" +
                "<strong>Profit Center:</strong> " + rowPcName + "<br>" +
                "<strong>Month-Year:</strong> " + myVal + "<br><br>" +
                "⚠️ <strong>Strict Policy:</strong> Duplicate entries are not allowed.<br>" +
                "To modify existing data, please contact Admin.",
                existingId
            );
        }
    }
}
function checkDuplicatePCMY1(pcVal,myVal) {
    var rowPcName = $('#profitCenterSelect').val().trim();
    if (pcVal !== '' && myVal !== '') {
        var isDuplicate = false;
        var existingId = null;

        $('#esiTable').DataTable().rows().every(function() {
            var rowData = this.data();
            var htmlContent = $('<div>' + rowData[0] + '</div>');

            var rowPc = htmlContent.find('.fw-bold').text().trim();
            rowPcName = htmlContent.find('.small').text().trim();
            var rowMy = rowData[1] ? rowData[1].trim() : '';

            if (rowPc === pcVal && rowMy === myVal) {
                isDuplicate = true;
                existingId = this.id();
                return false; 
            }
        });

        if (isDuplicate) {
            $('#monthYear').val('').trigger('change');
            showStrictAlertBox(
                "Duplicate Entry Detected", 
                "❌ Data already exists for:<br><br>" +
                "<strong>Profit Center:</strong> " + rowPcName + "<br>" +
                "<strong>Month-Year:</strong> " + myVal + "<br><br>" +
                "⚠️ <strong>Strict Policy:</strong> Duplicate entries are not allowed.<br>" +
                "To modify existing data, please contact Admin.",
                existingId
            );
        }
    }
}
function showStrictAlertBox(title, message, existingId) {
    $('#strictAlertBox').remove();
    var secondsLeft = 10;
    var alertBox = $(
        '<div id="strictAlertBox" class="strict-alert">' +
            '<div class="strict-alert-header">' +
                '<h5>' + title + '</h5>' +
                '<button class="strict-alert-close">&times;</button>' +
            '</div>' +
            '<div class="strict-alert-body">' +
                message +
                '<div class="strict-alert-footer">' +
                    '<div class="strict-alert-timer">' +
                        'Auto-closing in <span id="strictAlertCountdown">' + secondsLeft + '</span> seconds' +
                    '</div>' +
                '</div>' +
            '</div>' +
        '</div>'
    );

    $('body').append(alertBox);

    var countdownInterval = setInterval(function() {
        secondsLeft--;
        $('#strictAlertCountdown').text(secondsLeft);
        
        if (secondsLeft <= 0) {
            clearInterval(countdownInterval);
            alertBox.fadeOut(500, function() {
                $(this).remove();
            });
        }
    }, 1000);

    alertBox.find('.strict-alert-close').on('click', function() {
        clearInterval(countdownInterval);
        alertBox.fadeOut(500, function() {
            $(this).remove();
        });
    });
}

$('#profitCenterSelect, #monthYear').on('change', checkDuplicatePCMY);

</script>
</body>
</html>
>>>>>>> 0be22774be56f74f236fbb15502732a798d923a4
