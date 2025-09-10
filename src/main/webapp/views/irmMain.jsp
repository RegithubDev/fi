<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimal-ui">
    <meta name="description" content="Vuexy admin is super flexible, powerful, clean & modern responsive bootstrap 4 admin template with unlimited possibilities.">
    <meta name="keywords" content="admin template, Vuexy admin template, dashboard template, flat admin template, responsive admin template, web app">
    <meta name="author" content="PIXINVENT">
    <title>Dashboard analytics</title>
    <link rel="apple-touch-icon" href="/reirm/resources/images/ico/apple-icon-120.html">
    <link rel="icon" type="image/png" sizes="96x96" href="/reirm/resources/images/protect-favicon.png">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,300;0,400;0,500;0,600;1,400;1,500;1,600" rel="stylesheet">
    <meta name="google-signin-client_id" content="46521935412-0pl18k3a2mq7fs8nrl1853qcie9h5fjb.apps.googleusercontent.com">
    <!-- Vendor CSS -->
    <link rel="stylesheet" type="text/css" href="/reirm/resources/vendors/css/extensions/sweetalert2.min.css"/>
    <link rel="stylesheet" type="text/css" href="/reirm/resources/css/plugins/extensions/ext-component-sweet-alerts.min.css"/>
    <link rel="stylesheet" type="text/css" href="/reirm/resources/vendors/css/vendors.min.css">
    <link rel="stylesheet" type="text/c
    ss" href="/reirm/resources/vendors/css/tables/datatable/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/vendors/css/tables/datatable/responsive.bootstrap5.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/vendors/css/tables/datatable/buttons.bootstrap5.min.css">
    <link rel="stylesheet" type="text/c
    ss" href="/reirm/resources/vendors/css/tables/datatable/rowGroup.bootstrap5.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/vendors/css/pickers/pickadate/pickadate.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/vendors/css/pickers/flatpickr/flatpickr.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/vendors/css/extensions/toastr.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/css/plugins/extensions/ext-component-toastr.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="stylesheet" href="/reirm/resources/css/font-awesome-v.4.7.css"/>
    <!-- Theme CSS -->
    <link rel="stylesheet" type="text/css" href="/reirm/resources/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/css/bootstrap-extended.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/css/colors.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/css/components.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/css/themes/dark-layout.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/css/themes/bordered-layout.min.css">
    <link rel="stylesheet" type="text/c
    ss" href="/reirm/resources/css/themes/semi-dark-layout.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/vendors/css/forms/select/select2.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/css/core/menu/menu-types/horizontal-menu.min.css">
    <link rel="stylesheet" type="text/css" href="/reirm/resources/css/plugins/forms/pickers/form-flat-pickr.min.css">
    <link rel="stylesheet" type="text/c
    ss" href="/reirm/resources/css/plugins/forms/pickers/form-pickadate.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="/reirm/resources/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
<script src="https://cdn.sheetjs.com/xlsx-0.20.0/package/dist/xlsx.full.min.js"></script>
    
    <style>
    .edited-row {
    background-color: #fffde7 !important; /* Light yellow background */
    transition: background-color 0.3s ease;
}
// CSS:
.edited-row {
    background-color: #fffde7 !important; /* Light yellow */
    border-left: 3px solid #ffd600;
}

.recently-edited {
    animation: highlightFade 2s;
}

@keyframes highlightFade {
    0% { background-color: #b3e5fc; }
    100% { background-color: #fffde7; }
}

.editing-row {
    background-color: #e3f2fd !important; /* Light blue background for editing */
}
    .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
    color: var(--bs-nav-tabs-link-active-color)!important;;
    background-color: #ffffff!important;;
    border-color: var(--bs-nav-tabs-link-active-border-color)!important;;
    
    }
    .nav-tabs .nav-link:hover:not(.active) {
    color: black!important;;;
}
 .nav-tabs .nav-link:not(.active) {
    color: black!important;;;
}
       /* Add these new styles */
        .nav-tabs .nav-link {
            border: none;
            color: #6e6b7b !important;;
            font-weight: 500;
            padding: 0.75rem 1.5rem;
            position: relative;
        }
        .nav-tabs .nav-link.active {
            color: #7367f0;
            background-color: #292bbd;
            border-bottom: 2px solid #7367f0;
        }
        .nav-tabs .nav-link:hover:not(.active) {
            color: white;
        }
        .tab-content {
            padding: 1.5rem 0;
        }
        .download-btn {
            background: linear-gradient(135deg, #28C76F 0%, #20a858 100%);
            border: none;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            transition: all 0.3s ease;
        }
        .download-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(40, 199, 111, 0.3);
            color: white;
        }
        .download-btn i {
            margin-right: 0.5rem;
        }
        /* Previous styles remain the same */
    /* Eclipse-shaped badges */
.eclipse-badge {
    display: inline-flex;
    align-items: center;
    padding: 4px 12px;
    border-radius: 50px;
    font-size: 0.8rem;
    font-weight: 500;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}
td:nth-child(10) {
  width: 12rem;
}
td:nth-child(7) {
  background-color: rgba(75, 75, 75, .12);
    color: #4B4B4B !important;
    padding: .3rem .5rem;
    font-size: 85%;
}
/* Status colors */
.status-partial {
    background: linear-gradient(135deg, #FFD700 0%, #FFA500 100%);
    color: #8B4513;
}
.status-p {
    background: linear-gradient(135deg, #4dff00 0%, #26ff00 100%);
    color: #8B4513;
}
.status-halfday {
    background: linear-gradient(135deg, #FFA07A 0%, #FF6347 100%);
    color: #800000;
}

.status-incomplete {
    background: linear-gradient(135deg, #FF9999 0%, #FF6666 100%);
    color: #000000;
}

.status-fullday {
    background: linear-gradient(135deg, #90EE90 0%, #32CD32 100%);
    color: #006400;
}
b[role="presentation"] {
  display: none !important;
}

.status-overtime {
        background: linear-gradient(135deg, #87bac0 0%, #67e09d 100%);
    color: #000000;

}

.status-missing {
    background: linear-gradient(135deg, #D8BFD8 0%, #9932CC 100%);
    color: #4B0082;
}

.status-default {
    background: linear-gradient(135deg, #E6E6FA 0%, #D3D3D3 100%);
    color: #696969;
}

/* Optional hover effect */
.eclipse-badge:hover {
    transform: translateY(-1px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.15);
    transition: all 0.2s ease;
}
    .table:not(.table-dark):not(.table-light) tfoot:not(.table-dark) th, .table:not(.table-dark):not(.table-light) thead:not(.table-dark) th {
    background-color: #211747!important;
}
.scroll-top{
display:none!important;
}
   .status-badge {
    padding: 4px 8px;
    border-radius: 12px;
    font-size: 0.8rem;
    font-weight: 500;
}

.status-present {
    background-color: #d4edda;
    color: #155724;
}

.status-late {
    background-color: #fff3cd;
    color: #856404;
}
   
    /* Enhanced Global Styles */
        :root {
            --primary-color: #7367F0;
            --secondary-color: #82868B;
            --success-color: #28C76F;
            --info-color: #00CFE8;
            --warning-color: #FF9F43;
            --danger-color: #EA5455;
            --light-color: #F8F9FA;
            --dark-color: #4B4B4B;
            --card-shadow: 0 4px 24px 0 rgba(34, 41, 47, 0.1);
            --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
        }

        /* Loading Overlay */
        #loadingOverlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.85);
            z-index: 9999;
            display: none;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            color: white;
        }
        #loadingOverlay .loader-text {
            margin-bottom: 20px;
            font-size: 1.25rem;
            animation: pulse 1.5s infinite;
        }
        #loadingOverlay .countdown {
            font-size: 3rem;
            font-weight: bold;
            background: var(--primary-color);
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 0 20px rgba(115, 103, 240, 0.7);
        }

        /* Filter Section - Enhanced */
        .filter-section {
            background: linear-gradient(135deg, rgba(255,255,255,0.95) 0%, rgba(248,249,250,0.95) 100%);
            padding: 1.5rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
        }
        .filter-section::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI2MDAiIGhlaWdodD0iNjAwIj48ZmlsdGVyIGlkPSJncmFpbiI+PGZlVHVyYnVsZW5jZSB0eXBlPSJmcmFjdGFsTm9pc2UiIGJhc2VGcmVxdWVuY3k9IjAuMDUiIG51bU9jdGF2ZXM9IjUiIHN0aXRjaFRpbGVzPSJzdGl0Y2giLz48ZmVDb2xvck1hdHJpeCB0eXBlPSJzYXR1cmF0ZSIgdmFsdWVzPSIwIi8+PC9maWx0ZXI+PHJlY3QgZmlsdGVyPSJ1cmwoI2dyYWluKSIgb3BhY2l0eT0iMC4wMiIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIvPjwvc3ZnPg==');
            opacity: 0.1;
            pointer-events: none;
        }

        /* Date Inputs */
        .date-input-wrapper {
            position: relative;
        }
        .date-input-wrapper .form-control {
            padding-left: 2.5rem;
            height: 46px;
            border-radius: 8px;
            border: 1px solid rgba(0,0,0,0.1);
            background: rgba(255,255,255,0.8);
            transition: var(--transition);
        }
        .no-ot-tag {
    display: inline-block;
    background: #e9ecef;
    color: #495057;
    padding: 3px 8px;
    border-radius: 50px;
    font-size: 0.75rem;
    font-weight: 500;
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}
        .date-input-wrapper .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(115, 103, 240, 0.15);
        }
        .date-input-wrapper i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--secondary-color);
            z-index: 2;
        }

        /* Search Button */
        .search-btn {
            width: 46px;
            height: 46px;
            border-radius: 8px;
            background: linear-gradient(135deg, var(--primary-color) 0%, #9E95F5 100%);
            border: none;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition);
            box-shadow: 0 4px 8px rgba(115, 103, 240, 0.3);
        }
        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(115, 103, 240, 0.4);
        }

        /* Select Dropdowns */
        .select-wrapper {
            position: relative;
        }
        .premium-select {
            height: 46px;
            border-radius: 8px;
            border: 1px solid rgba(0,0,0,0.1);
            background: rgba(255,255,255,0.8);
            padding-right: 2.5rem;
            appearance: none;
            transition: var(--transition);
        }
        .premium-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(115, 103, 240, 0.15);
        }
        .select-icons {
            position: absolute;
            right: 0.75rem;
            top: 0;
            height: 100%;
            display: flex;
            align-items: center;
        }
        .clear-select {
            cursor: pointer;
            color: #aaa;
            transition: var(--transition);
            margin-right: 0.5rem;
        }
        .clear-select:hover {
            color: var(--danger-color) !important;
            transform: scale(1.1);
        }
        .dropdown-icon {
            color: var(--secondary-color);
        }

        /* Reset Button */
        .reset-btn {
            height: 46px;
            border-radius: 8px;
            background: rgba(255,255,255,0.9);
            border: 1px solid rgba(0,0,0,0.08);
            color: var(--secondary-color);
            font-weight: 500;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .reset-btn:hover {
            background: white;
            border-color: rgba(0,0,0,0.15);
            color: var(--dark-color);
        }

        /* Cards Section */
        .stats-card {
            border: none;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
            height: 100%;
        }
        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(34, 41, 47, 0.2);
        }
        .stats-card .card-header {
            background: white;
            border-bottom: none;
            padding: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .stats-card .card-title {
            font-size: 1rem;
            color: var(--secondary-color);
            margin-bottom: 0.5rem;
        }
        .stats-card h2 {
            font-size: 1.75rem;
            margin-bottom: 0;
            font-weight: 600;
        }
        .avatar {
            width: 42px;
            height: 42px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }
        .avatar-content i {
            font-size: 1.5rem;
        }

        /* DataTable */
        .dataTables_wrapper .dataTable {
            border-radius: 12px;
            overflow: hidden;
        }
        .dataTables_wrapper .dataTable thead th {
            background: var(--primary-color);
            color: white;
            font-weight: 600;
            padding: 1rem;
            border-bottom: none;
        }
        .dataTables_wrapper .dataTable tbody tr {
            transition: var(--transition);
        }
        .dataTables_wrapper .dataTable tbody tr:hover {
            background-color: rgba(115, 103, 240, 0.05) !important;
        }
        .dataTables_wrapper .dataTable tbody td {
            padding: 0.75rem 1rem;
            vertical-align: middle;
            border-top: 1px solid rgba(0,0,0,0.05);
        }
        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 500;
            display: inline-block;
        }
        .status-present {
            background-color: var(--success-color);
            color: white;
        }
        .status-absent {
            background-color: var(--danger-color);
            color: white;
        }
        .status-late {
            background-color: var(--warning-color);
            color: white;
        }

        /* Animations */
        @keyframes pulse {
            0% { opacity: 0.6; }
            50% { opacity: 1; }
            100% { opacity: 0.6; }
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-fadein {
            animation: fadeIn 0.5s ease-out forwards;
        }

        /* Responsive Adjustments */
        @media (max-width: 992px) {
            .filter-section .row > div:not(:last-child) {
                margin-bottom: 1rem;
            }
            .stats-card {
                margin-bottom: 1rem;
            }
        }
        @media (max-width: 768px) {
            .filter-section {
                padding: 1rem;
            }
            .date-range-row {
                flex-direction: column;
            }
            .date-range-row > div {
                margin-bottom: 0.75rem;
            }
            .date-range-row > div:last-child {
                margin-bottom: 0;
            }
        }
        @media (max-width: 576px) {
            .stats-card .card-header {
                flex-direction: column;
                align-items: flex-start;
            }
            .stats-card .avatar {
                margin-top: 0.75rem;
                align-self: flex-end;
            }
        }
        .history-collapse {
    max-height: 300px;
    overflow-y: auto;
    border: 1px solid rgba(0,0,0,0.1);
    border-radius: 8px;
    padding: 10px;
    background: rgba(255,255,255,0.95);
}
.history-table th, .history-table td {
    font-size: 0.85rem;
    padding: 0.5rem;
}
.details-control {
    cursor: pointer;
    width: 30px;
}
@media print {
    body * { visibility: hidden; }
    #payslipModal, #payslipModal * { visibility: visible; }
    #payslipModal { position: absolute; left: 0; top: 0; width: 100%; }
    .modal-header, .modal-footer { display: none; }
    .payslip-container { border: none; box-shadow: none; }
}
    </style>
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
</head>
<body class="horizontal-layout horizontal-menu navbar-floating footer-static" data-open="hover" data-menu="horizontal-menu" data-col="">
    <!-- Header and Menu -->
    <jsp:include page="../views/layout/header.jsp"></jsp:include>
    <jsp:include page="../views/layout/userActivityCheck.jsp"></jsp:include>
    <div class="horizontal-menu-wrapper">
        <jsp:include page="../views/layout/menu.jsp"></jsp:include>
    </div>
    
    <!-- Content -->
   <div class="app-content content">
        <div class="content-overlay"></div>
        <div class="header-navbar-shadow"></div>
        <div class="content-wrapper container-xxl p-0">
            <div class="content-body">
                <section id="dashboard-ecommerce">
                    <!-- Loading Overlay -->
                    <div id="loadingOverlay">
                        <div class="loader-text">Downloading Data...</div>
                        <div class="countdown">5</div>
                    </div>
                    
                    <!-- Filter Section -->
                    <div class="filter-section animate-fadein">
                        <div class="row align-items-center g-3">
                            <!-- Date Range + Search -->
                           <div class="col-12 col-md-4">
    <div class="d-flex flex-column">
        <div class="d-flex align-items-center mb-2">
            <label class="small text-muted mb-0 me-2 fw-medium">From Date</label>
            <div class="date-input-wrapper flex-grow-1">
                <i class="far fa-calendar-alt"></i>
                <input type="text" class="form-control flatpickr" id="from_date" placeholder="DD/MM/YYYY">
            </div>
        </div>
        <div class="d-flex align-items-center">
            <label class="small text-muted mb-0 me-2 fw-medium">To Date</label>
            <div class="d-flex flex-grow-1">
                <div class="date-input-wrapper flex-grow-1">
                    <i class="far fa-calendar-alt"></i>
                    <input type="text" class="form-control flatpickr" id="to_date" placeholder="DD/MM/YYYY">
                </div>
                <button class="search-btn ms-2" onclick="loadInitialData()">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
        <!-- Notification message added here -->
        <div class="mt-2 small text-muted">
            <i class="fas fa-info-circle me-1"></i> Please select date range and click search to view data
        </div>
        
        <!-- Add Request Button -->
<div class="mt-3">
  <button class="btn btn-primary w-100" data-bs-toggle="modal" data-bs-target="#newRequestModal">
    <i class="fas fa-plus me-1"></i> Add Request
  </button>
</div>

    </div>
</div>
                  
                  <!-- New Add Request Modal -->
<div class="modal fade" id="newRequestModal" tabindex="-1" aria-labelledby="newRequestModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
    
      <div class="modal-header">
        <h5 class="modal-title" id="newRequestModalLabel">New Request</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <div class="modal-body">
        <div class="row mb-3">
          <div class="col-md-4">
            <label>Employee Name</label>
            <input type="text" class="form-control" id="new-emp-name" name="employee_name">
          </div>
          <div class="col-md-4">
            <label>Employee Code</label>
            <input type="text" class="form-control" id="new-emp-code" name="emp_code">
          </div>
          <div class="col-md-4">
            <label>Department</label>
            <input type="text" class="form-control" id="new-department" name="department">
          </div>
        </div>
        
        <div class="row mb-3">
          <div class="col-md-4">
            <label>Work Date</label>
            <input type="date" class="form-control" id="new-work-date" name="work_date">
          </div>
          <div class="col-md-4">
            <label>Punch In Time</label>
            <input type="datetime-local" class="form-control" id="new-punch-in" name="punch_in">
          </div>
          <div class="col-md-4">
            <label>Punch Out Time</label>
            <input type="datetime-local" class="form-control" id="new-punch-out" name="punch_out">
          </div>
        </div>

        <div class="row mb-3">
          <div class="col-md-6">
            <label>Total Duration</label>
            <input type="text" class="form-control" id="new-total-duration" name="total_duration">
          </div>
          <div class="col-md-6">
            <label>Overtime</label>
            <input type="text" class="form-control" id="new-ot" name="overtime">
          </div>
        </div>

        <div class="mb-3">
          <label>Reason</label>
          <textarea class="form-control" id="new-reason" name="reason" rows="2"></textarea>
        </div>
      </div>
      
      <div class="modal-footer">
        <button class="btn btn-success" id="new-request-submit">Submit</button>
        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
      </div>

    </div>
  </div>
</div>
                            
                            <!-- Premium Dropdowns -->
                            <div class="col-12 col-md-5">
                                <div class="card border-0 p-2" style="background: rgba(255,255,255,0.7); border-radius: 10px;">
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="small text-muted mb-1 fw-medium">Employee</label>
                                            <div class="select-wrapper">
                                                <select class="form-select premium-select" id="empFilter">
                                                    <option value="">All Employees</option>
                                                </select>
                                                <div class="select-icons">
                                                    <span class="clear-select d-none me-1">
                                                        <i class="fas fa-times-circle"></i>
                                                    </span>
                                                    <span class="dropdown-icon">
                                                        <i class="fas fa-chevron-down"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="small text-muted mb-1 fw-medium">Area</label>
                                            <div class="select-wrapper">
                                                <select class="form-select premium-select" id="areaFilter">
                                                    <option value="">All Areas</option>
                                                </select>
                                                <div class="select-icons">
                                                    <span class="clear-select d-none me-1">
                                                        <i class="fas fa-times-circle"></i>
                                                    </span>
                                                    <span class="dropdown-icon">
                                                        <i class="fas fa-chevron-down"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Reset Button -->
                            <div class="col-12 col-md-3">
                                <button class="reset-btn w-100" onclick="clearFilters()">
                                    <i class="fas fa-sync-alt me-2"></i> Reset Filters
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Stats Cards -->
                    <!-- <div class="row match-height animate-fadein">
                        <div class="col-lg-3 col-sm-6 col-12">
                            <div class="card stats-card">
                                <div class="card-header">
                                    <div>
                                        <h2 class="text-primary" id="totalEmployees">0</h2>
                                        <h3 class="card-title">Total Employees</h3>
                                    </div>
                                    <div class="avatar bg-light-primary">
                                        <div class="avatar-content">
                                            <i class="fas fa-users text-primary"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6 col-12">
                            <div class="card stats-card">
                                <div class="card-header">
                                    <div>
                                        <h2 class="text-success" id="avgHours">0</h2>
                                        <h3 class="card-title">Avg. Hours</h3>
                                    </div>
                                    <div class="avatar bg-light-success">
                                        <div class="avatar-content">
                                            <i class="fas fa-clock text-success"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6 col-12">
                            <div class="card stats-card">
                                <div class="card-header">
                                    <div>
                                        <h2 class="text-info" id="presentCount">0</h2>
                                        <h3 class="card-title">Present Today</h3>
                                    </div>
                                    <div class="avatar bg-light-info">
                                        <div class="avatar-content">
                                            <i class="fas fa-check-circle text-info"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6 col-12">
                            <div class="card stats-card">
                                <div class="card-header">
                                    <div>
                                        <h2 class="text-warning" id="overtimeCount">0</h2>
                                        <h3 class="card-title">Overtime</h3>
                                    </div>
                                    <div class="avatar bg-light-warning">
                                        <div class="avatar-content">
                                            <i class="fas fa-user-clock text-warning"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> -->
                    
                    <!-- DataTable Section -->
             <div class="card animate-fadein">
     <ul class="nav nav-tabs" id="attendanceTabs" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="summary-tab" data-bs-toggle="tab" href="#summary" role="tab" aria-controls="summary" aria-selected="true">Summary</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="missed-tab" data-bs-toggle="tab" href="#missed" role="tab" aria-controls="missed" aria-selected="false">Missed Outs</a>
                        </li>
                    </ul>
                    
                    <!-- Tab Content -->
                    <div class="tab-content" id="attendanceTabContent">
                        <!-- Summary Tab (existing content) -->
                        <div class="tab-pane fade show active" id="summary" role="tabpanel" aria-labelledby="summary-tab">
                            <div class="card animate-fadein">
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table" id="employeeTable">
                <thead>
                    <tr>
                        <th></th> <!-- Expand/Collapse -->
                        <th>Emp Code</th>
                        <th>Employee Name</th>
                         <th>Role</th>
                        <th>Area</th>
                        <th>Total Hours</th>
                        <th>Overtime Hours</th>
                        <th>Action</th>
                    </tr>
               </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Missed Outs Tab -->
                        <div class="tab-pane fade" id="missed" role="tabpanel" aria-labelledby="missed-tab">
                            <div class="card">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h4 class="card-title">Missed Punch Outs</h4>
                                 <button class="download-btn" data-bs-toggle="modal" data-bs-target="#bulkRegularizeModal">
								    <i class="fas fa-file-excel"></i> Bulk Regularize
								</button>
                                    <button class="download-btn" onclick="downloadMissedOuts()">
                                        <i class="fas fa-file-excel"></i> Export to Excel
                                    </button>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table" id="missedTable">
                                            <thead>
                                                <tr>
                                                    <th>Emp Code</th>
                                                    <th>Employee Name</th>
                                                    <th>Position</th>
                                                    <th>Area</th>
                                                    <th>Work Date</th>
                                                    <th>Day Start</th>
                                                    <th>Day End</th>
                                                    <th>Holiday</th>
                                                    <th>Holiday</th>
                                                    <th>Status</th>
                                                    <th>Regularisation</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </div>
    <!-- Modal -->
<div class="modal fade" id="bulkRegularizeModal" tabindex="-1" aria-labelledby="bulkRegularizeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content shadow-lg">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="bulkRegularizeModalLabel">Bulk Regularization Upload</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body">
        <div class="mb-3 text-center">
          <p>📥 Download the Excel template, fill the data and upload it back.</p>
          <button class="btn btn-outline-primary" onclick="downloadMissedOuts()">
            <i class="fas fa-download"></i> Download Template
          </button>
        </div>

       <form id="bulkUploadForm" enctype="multipart/form-data">
          <div class="mb-3">
            <label for="uploadExcel" class="form-label">Upload Filled Excel <span class="text-danger">*</span></label>
            <input class="form-control" type="file" id="uploadExcel" name="uploadExcel" accept=".xlsx,.xls" required>
          </div>
        </form>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="submit" form="bulkUploadForm" class="btn btn-success">Submit</button>
      </div>
    </div>
  </div>
</div>
    <!-- Payslip Modal -->
<!-- Update the payslip modal HTML -->
<div class="modal fade" id="payslipModal" tabindex="-1" aria-labelledby="payslipModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="payslipModalLabel">Employee Hours Calculation</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="payslip-container" style="font-family: Arial, sans-serif; padding: 20px;">
                    <div class="payslip-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                        <div>
                            <h4>Re Sustainability Limited</h4>
                            <p style="font-size: 0.9rem; color: #666;">123 Business Park, Hyderabad, India</p>
                        </div>
                        <img src="https://appmint.resustainability.com/reirm/resources/ai/img/Logo-red-1%20(1).svg" alt="Company Logo" style="max-height: 50px;">
                    </div>
                    <hr>
                    <div class="payslip-details" style="margin-bottom: 20px;">
                        <table style="width: 100%; border-collapse: collapse;">
                            <tr>
                                <td style="padding: 8px; font-weight: bold;">Employee Name:</td>
                                <td style="padding: 8px;" id="payslipEmpName"></td>
                            </tr>
                            <tr>
                                <td style="padding: 8px; font-weight: bold;">Employee Code:</td>
                                <td style="padding: 8px;" id="payslipEmpCode"></td>
                            </tr>
                            <tr>
                                <td style="padding: 8px; font-weight: bold;">Area:</td>
                                <td style="padding: 8px;" id="payslipArea"></td>
                            </tr>
                            <tr>
                                <td style="padding: 8px; font-weight: bold;">Period:</td>
                                <td style="padding: 8px;" id="payslipPeriod"></td>
                            </tr>
                        </table>
                    </div>
                    <div class="payslip-summary">
                        <table style="width: 100%; border-collapse: collapse; border: 1px solid #ddd;">
                            <thead>
                                <tr style="background-color: #f8f9fa;">
                                    <th style="padding: 10px; text-align: left; border-bottom: 1px solid #ddd;">Description</th>
                                    <th style="padding: 10px; text-align: right; border-bottom: 1px solid #ddd;">Hours</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="padding: 10px; border-bottom: 1px solid #ddd;">Total Hours Worked</td>
                                    <td style="padding: 10px; text-align: right; border-bottom: 1px solid #ddd;" id="payslipTotalHours"></td>
                                </tr>
                                <tr>
                                    <td style="padding: 10px;">Overtime Hours</td>
                                    <td style="padding: 10px; text-align: right;" id="payslipOTHours"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <p style="font-size: 0.8rem; color: #666; margin-top: 20px;">Note: This payslip is for informational purposes only.</p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="window.print()">Print Hours Calculation</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="regulariseModal" tabindex="-1" aria-labelledby="regulariseModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
  <div class="modal-header">
    <h5 class="modal-title">Regularise Missed Punch</h5>
    <div class="ms-auto">
      <select id="request-type" class="form-select">
        <option value="missed-punch">Missed Punch</option>
        <option value="leave">Leave Request</option>
      </select>
    </div>
    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
  </div>
  
  <!-- Missed Punch Content -->
  <div id="missed-punch-content">
    <div class="modal-body">
      <div class="row mb-3">
        <div class="col-md-4">
          <label>Employee</label>
          <input type="text" id="reg-emp-name" class="form-control"  disabled>
          <input type="hidden" id="reg-emp-code" class="form-control" name="emp_codee" disabled>
           <input type="hidden" id="reg-emp-namee" class="form-control" name="employee_namee" disabled>
        </div>
        <div class="col-md-4">
          <label>Area</label>
          <input type="text" id="reg-department" class="form-control" name="area_namee" disabled>
        </div>
        <div class="col-md-4">
          <label>Work Date</label>
          <input type="text" id="reg-work-date" class="form-control" name="work_datee" disabled>
        </div>
      </div>
      <div class="row mb-3">
        <div class="col-md-4">
          <label>Punch in Time*</label>
          <input type="datetime-local" id="reg-punch-time-in" class="form-control" name="day_startt" required>
        </div>
        <div class="col-md-4">
          <label>Punch State*</label>
          <select id="reg-punch-state" class="form-select" name="checkIn">
            <option value="0">Check In</option>
            <option value="1">Check Out</option>
          </select>
        </div>
        <div class="col-md-4">
          <label>Punch out Time*</label>
          <input type="datetime-local" id="reg-punch-time-out" class="form-control" name="day_endd" required>
        </div>
        <div class="col-md-4">
          <label>Punch State*</label>
          <select id="reg-punch-state" class="form-select" name="checkOut">
            <option value="1">Check Out</option>
            <option value="0">Check In</option>
          </select>
        </div>
        <div class="row mb-3">
          <div class="col-md-4">
            <label>Total Duration</label>
            <input type="text" id="reg-total-duration" class="form-control" name="total_working_hourss" disabled>
          </div>
          <div class="col-md-4">
            <label>Overtime</label>
            <input type="text" id="reg-ot-duration" class="form-control" name="overtime_hourss" disabled>
          </div>
        </div>
        
        <div class="col-md-4">
          <label>Apply Reason</label>
          <textarea id="reg-reason" class="form-control" rows="1" name="regularise_reason"></textarea>
        </div>
      </div>
    </div>
    <div class="modal-footer">
      <button id="reg-confirm-btn" class="btn btn-success">Confirm</button>
      <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
    </div>
  </div>
  
  <!-- Leave Request Content (initially hidden) -->
  <div id="leave-request-content" style="display: none;">
    <div class="modal-body">
      <div class="row mb-3">
        <div class="col-md-4">
          <label>Employee</label>
          <input type="text" id="leave-emp-name" name="emp_code" class="form-control" disabled>
        </div>
        <div class="col-md-4">
          <label>Department</label>
          <input type="text" id="leave-department"  name="area_name" class="form-control" disabled>
        </div>
        <div class="col-md-4">
          <label>Leave Type*</label>
          <select id="leave-type" class="form-select" name="is_leave" required>
            <option value="">Select Leave Type</option>
            <option value="SL">Sick Leave (SL)</option>
            <option value="CAL">Casual Leave (CAL)</option>
            <option value="ML">Maternity Leave (ML)</option>
            <option value="COL">Compassionate Leave (COL)</option>
            <option value="AL">Annual Leave (AL)</option>
            <option value="BT">Business Trip (BT)</option>
          </select>
        </div>
      </div>
      <div class="row mb-3">
        <div class="col-md-12">
          <label>Select Leave Dates*</label>
          <div id="leave-calendar" class="mt-2"></div>
        </div>
      </div>
      <div class="row mb-3">
        <div class="col-md-12">
          <label>Leave Reason*</label>
          <textarea id="leave-reason" class="form-control" name="leave_reason" rows="3" required></textarea>
        </div>
      </div>
    </div>
    <div class="modal-footer">
      <button id="leave-confirm-btn" class="btn btn-success">Submit Leave Request</button>
      <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
    </div>
  </div>
</div>
  </div>
</div>

    <!-- Footer -->
    <footer class="footer footer-static footer-light">
        <p class="clearfix mb-0">
            <span class="float-md-start d-block d-md-inline-block mt-25">COPYRIGHT © <span id="currentYear"></span> | Powered by
                <a class="ms-25" href="https://resustainability.com/" target="_blank">Re Sustainability Limited</a>
                <span class="d-none d-sm-inline-block">. All Rights Reserved.</span>
            </span>
        </p>
    </footer>
    
   <!--  <button class="btn btn-primary btn-icon scroll-top" type="button"><i data-feather="arrow-up"></i></button> -->
    <!-- Vendor JS -->

    <script src="/reirm/resources/vendors/js/vendors.min.js"></script>
    <script src="/reirm/resources/vendors/js/ui/jquery.sticky.js"></script>
    <script src="/reirm/resources/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="/reirm/resources/vendors/js/charts/apexcharts.min.js"></script>
    <script src="/reirm/resources/vendors/js/extensions/toastr.min.js"></script>
    <script src="/reirm/resources/vendors/js/extensions/moment.min.js"></script>
    <script src="/reirm/resources/vendors/js/tables/datatable/jquery.dataTables.min.js"></script>
    <script src="/reirm/resources/vendors/js/tables/datatable/datatables.buttons.min.js"></script>
    <script src="/reirm/resources/vendors/js/tables/datatable/dataTables.bootstrap5.min.js"></script>
    <script src="/reirm/resources/vendors/js/tables/datatable/dataTables.responsive.min.js"></script>
    <script src="/reirm/resources/vendors/js/tables/datatable/responsive.bootstrap5.js"></script>
    <script src="/reirm/resources/js/materialize-v.1.0.min.js"></script>
    <script src="/reirm/resources/js/jquery-validation-1.19.1.min.js"></script>
    <script src="/reirm/resources/js/jquery.dataTables-v.1.10.min.js"></script>
    <script src="/reirm/resources/js/datetime-moment-v1.10.12.js"></script>
    <script src="/reirm/resources/js/dataTables.material.min.js"></script>
    <script src="/reirm/resources/js/moment-v2.8.4.min.js"></script>
    <script src="/reirm/resources/js/core/app-menu.min.js"></script>
    <script src="/reirm/resources/js/core/app.min.js"></script>
    <script src="/reirm/resources/js/scripts/customizer.min.js"></script>
    <script src="/reirm/resources/js/scripts/forms/form-select2.min.js"></script>
    <script src="/reirm/resources/js/scripts/pages/modal-add-new-cc.min.js"></script>
    <script src="/reirm/resources/js/scripts/pages/page-pricing.min.js"></script>
    <script src="/reirm/resources/js/scripts/pages/modal-add-new-address.min.js"></script>
    <script src="/reirm/resources/js/scripts/pages/modal-create-app.min.js"></script>
    <script src="/reirm/resources/js/scripts/pages/modal-two-factor-auth.min.js"></script>
    <script src="/reirm/resources/js/scripts/pages/modal-edit-user.min.js"></script>
    <script src="/reirm/resources/js/scripts/pages/modal-share-project.min.js"></script>
    <script src="/reirm/resources/js/scripts/pages/dashboard-analytics.min.js"></script>
    <script src="/reirm/resources/js/scripts/pages/app-invoice-list.min.js"></script>
    <script src="/reirm/resources/vendors/js/pickers/pickadate/picker.js"></script>
    <script src="/reirm/resources/vendors/js/pickers/pickadate/picker.date.js"></script>
    <script src="/reirm/resources/vendors/js/pickers/pickadate/picker.time.js"></script>
    <script src="/reirm/resources/vendors/js/pickers/pickadate/legacy.js"></script>
    <script src="/reirm/resources/vendors/js/pickers/flatpickr/flatpickr.min.js"></script>
    <script src="/reirm/resources/js/scripts/forms/pickers/form-pickers.min.js"></script>
    <script src="/reirm/resources/js/scripts/extensions/ext-component-blockui.js"></script>
    <!-- Bootstrap CSS -->

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script src="/reirm/resources/js/scripts/pages/dashboard-ecommerce.min.js"></script>
    <form action="<%=request.getContextPath() %>/logout" name="logoutForm" id="logoutForm" method="post">
        <input type="hidden" name="email" id="email"/>
    </form>
   <script>
// Global variables to store all data and DataTable instance
// Global variables to store all data and DataTable instance
 let allAttendanceData = [];
    let dataTable = null;
    let missedTable = null;
    let allMissedData = [];
    $(document).ready(function() {
        // Get today's date
        var today = new Date();
        // Get the 25th of the previous month
        var fromDate = new Date(today.getFullYear(), today.getMonth() - 1, 26);
        // Get the 25th of the current month
        var toDate = new Date(today.getFullYear(), today.getMonth(), 25);

        // Initialize flatpickr
        flatpickr('#from_date', {
            dateFormat: 'Y-m-d',
            defaultDate: fromDate
        });

        flatpickr('#to_date', {
            dateFormat: 'Y-m-d',
            defaultDate: toDate
        });

        // Initialize Select2
        $('#empFilter').select2({
            placeholder: 'Select Employee',
            allowClear: true,
            width: '100%',
            dropdownAutoWidth: true
        });

        $('#areaFilter').select2({
            placeholder: 'Select Area',
            allowClear: true,
            width: '100%',
            dropdownAutoWidth: true
        });

        // Load initial data
        loadInitialData();
        $('#attendanceTabs a').on('click', function(e) {
            e.preventDefault();
            $(this).tab('show');
            
            // Load missed data when the tab is shown
            if ($(this).attr('id') === 'missed-tab' && allMissedData.length === 0) {
                loadMissedOutsData();
            }
        });
        // Set up event listeners for filters
        $('#empFilter, #areaFilter').on('change', applyFilters);
        $('#from_date, #to_date').on('change', applyFilters);
        $('#searchBtn').on('click', loadInitialData);
    });
 // Add this function to filter missed punches from your existing data
    function filterMissedPunches(data) {
        return data.filter(item => {
            // Check for "Missing Punch" status or other conditions that indicate a missed punch
            return item.attendance_status === 'Missing Punch' ; 
            //	|| (item.day_start_time === item.day_end_time) ||
                //   (item.total_seconds <= 3600 && item.work_date !== new Date().toISOString().split('T')[0]);
        });
    }

    // Modify the loadMissedOutsData function to use existing data
    function loadMissedOutsData() {
        if (!allAttendanceData || allAttendanceData.length === 0) {
            toastr.warning('Please load attendance data first', 'No Data');
            $('#attendanceTabs a[href="#summary"]').tab('show');
            return;
        }

        $('#loadingOverlay').show();
        
        try {
        	   const startDate = $('#from_date').val();
               const endDate = $('#to_date').val();

               let filteredData = allAttendanceData;

               if (startDate && endDate) {
                   const start = new Date(startDate);
                   const end = new Date(endDate);
                   filteredData = allAttendanceData.filter(item => {
                       const date = new Date(item.work_date);
                       return date >= start && date <= end;
                   });
               }

            // Filter the existing allAttendanceData for missed punches
            const missedData = filterMissedPunches(allAttendanceData);
            
            if (missedData.length === 0) {
                toastr.info('No missed punch outs found in the current data set.', 'No Data');
            } else {
                allMissedData = missedData;
                initializeMissedTable(allMissedData);
            }
        } catch (error) {
            toastr.error('Failed to process missed punch data.', 'Error');
            console.error('Error processing missed punches:', error);
        } finally {
            $('#loadingOverlay').hide();
        }
    }

    function downloadMissedOuts() {
        if (!allMissedData || allMissedData.length === 0) {
            toastr.warning('No missed punch data available to download', 'Warning');
            return;
        }

        $('#loadingOverlay').show();

        try {
            const ws_data = [
                ["All Rights Reserved for Re Sustainability Ltd."],
                [
                    "Employee Code", "Employee Name", "Position", "Area", "Work Date", "Day Start", "Day End", "Status",
                    "Total Hours (Auto-calculated from Check-in and Check-out)",
                    "Minutes",
                    "Work Hours (Capped at 8 hours)",
                    "OT Hours (Extra time beyond 8 hrs)",
                    "OT Minutes"
                ]
            ];

            allMissedData.forEach((item, index) => {
                const rowIndex = index + 3; // +3 for title and header

                const parseAndFormatDate = (str) => {
                    if (!str) return '';
                    const match = str.match(/^([A-Za-z]+)\s+(\d{1,2})\s*-\s*(\d{2}:\d{2}:\d{2})$/);
                    if (!match) return '';
                    const [_, monthStr, day, time] = match;
                    const monthMap = {
                        Jan: 0, Feb: 1, Mar: 2, Apr: 3, May: 4, Jun: 5,
                        Jul: 6, Aug: 7, Sep: 8, Oct: 9, Nov: 10, Dec: 11
                    };
                    const monthIndex = monthMap[monthStr.slice(0, 3)];
                    if (monthIndex === undefined) return '';
                    const now = new Date();
                    const year = now.getFullYear();
                    const date = new Date(year, monthIndex, parseInt(day), ...time.split(':').map(Number));
                    if (isNaN(date)) return '';
                    const dd = date.getDate().toString().padStart(2, '0');
                    const mm = (date.getMonth() + 1).toString().padStart(2, '0');
                    const yyyy = date.getFullYear();
                    const hh = date.getHours().toString().padStart(2, '0');
                    const min = date.getMinutes().toString().padStart(2, '0');
                    return dd + '-' + mm + '-' + yyyy + ' ' + hh + ':' + min;
                };

                ws_data.push([
                    item.emp_code,
                    item.employee_name,
                    item.position_name,
                    item.area_name,
                    item.work_date ? new Date(item.work_date) : '',
                    parseAndFormatDate(item.day_start),
                    parseAndFormatDate(item.day_end),
                    item.attendance_status || '',
                    { f: 'IF(G' + rowIndex + '="", "", TEXT((G' + rowIndex + '-F' + rowIndex + '), "hh:mm"))' },
                    { f: 'IF(I' + rowIndex + '="", "", HOUR(I' + rowIndex + ')*60 + MINUTE(I' + rowIndex + '))' },
                    { f: 'IF(I' + rowIndex + '="", "", IF((HOUR(I' + rowIndex + ')+MINUTE(I' + rowIndex + ')/60)>9, 9, (HOUR(I' + rowIndex + ')+MINUTE(I' + rowIndex + ')/60)))' },
                    { f: 'IF(I' + rowIndex + '="", "", (HOUR(I' + rowIndex + ')+MINUTE(I' + rowIndex + ')/60) - K' + rowIndex + ')' },
                    { f: 'IF(L' + rowIndex + '="", "", ROUND(L' + rowIndex + '*60, 0))' }
                ]);
            });
         // 1. Create worksheet
            const ws = XLSX.utils.aoa_to_sheet(ws_data);

            // 2. Set column widths
            ws['!cols'] = ws_data[1].map(() => ({ wch: 30 }));

            // 3. Merge A1:M1 for title
            ws['!merges'] = [{ s: { r: 0, c: 0 }, e: { r: 0, c: 12 } }];

            // 4. Apply styles row by row
            const range = XLSX.utils.decode_range(ws['!ref']);
            for (let R = range.s.r; R <= range.e.r; ++R) {
              for (let C = range.s.c; C <= range.e.c; ++C) {
                const cellAddress = XLSX.utils.encode_cell({ r: R, c: C });
                const cell = ws[cellAddress];
                if (!cell) continue;

                if (R === 0) {
                  // Title row
                  cell.s = {
                    font: { bold: true, sz: 16, color: { rgb: "000000" } },
                    alignment: { horizontal: "center", vertical: "center" }
                  };
                } else if (R === 1) {
                  // Header row
                	cell.s = {
                			  font: { bold: true, color: { rgb: "FFFFFF" } },
                			  fill: { fgColor: { rgb: "4A90E2" } },
                			  alignment: { horizontal: "center", vertical: "center" },
                			  border: {
                			    top: { style: "thin", color: { rgb: "000000" } },
                			    bottom: { style: "thin", color: { rgb: "000000" } },
                			    left: { style: "thin", color: { rgb: "000000" } },
                			    right: { style: "thin", color: { rgb: "000000" } }
                			  }
                			};

                } else {
                  // Data rows
                  const isTextColumn = [0, 1, 2, 3, 7].includes(C); // Text columns
                  cell.s = {
                    alignment: { horizontal: isTextColumn ? "left" : "center", vertical: "center" }
                  };
                }
              }
            }

            // 5. Create and write workbook
            const wb = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(wb, ws, "Missed Punches");

            XLSX.writeFile(wb, "missed_punch_outs.xlsx", {
            	  bookType: "xlsx",
            	  bookSST: true,
            	  type: "binary"
            	});


            toastr.success('Missed punch outs exported successfully', 'Success');
        } catch (error) {
            toastr.error('Failed to export missed punch data', 'Error');
            console.error('Error exporting missed punches:', error);
        } finally {
            $('#loadingOverlay').hide();
        }
    }


    // Update your existing initializeMissedTable function to handle the data format
  function initializeMissedTable(data) {
    // Destroy existing table if it exists
    if (missedTable) {
        missedTable.destroy();
    }

    missedTable = $('#missedTable').DataTable({
        data: data,
        columns: [
            { data: 'emp_code' },
            { data: 'employee_name' },
            { data: 'position_name' },
            { data: 'area_name' },
            { 
                data: 'work_date',
                render: function(data) {
                    return data ? new Date(data).toLocaleDateString() : 'N/A';
                }
            },
            { data: 'day_start' },
            { data: 'day_end' },
            { 
                data: 'is_holiday',
                render: function(data) {
                    return data === '1' || data === 1 ? 'Yes' : 'No';
                }
            },
            { data: 'holiday_reason' },
            { 
                data: 'attendance_status',
                render: function(data) {
                    return '<span class="eclipse-badge status-missing">' + 
                           '<i class="fas fa-exclamation-circle me-1"></i>' + (data || 'Missing Punch') + '</span>';
                }
            },
            {
                data: null,
                render: function (data, type, row) {
                    return '<button class="btn btn-sm btn-primary regularise-btn" data-emp=\'' + JSON.stringify(row) + '\'>Regularise</button>';
                },
                orderable: false
            }
        ],
        responsive: true,
        pageLength: 10,
        dom: '<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-6"f>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
        language: {
            paginate: {
                previous: '<i class="fas fa-chevron-left"></i>',
                next: '<i class="fas fa-chevron-right"></i>'
            }
        }
    });

}

    $('#missedTable tbody').on('click', '.regularise-btn', function () {
        const emp = $(this).data('emp');
		console.log(emp);
        $('#reg-emp-name').val(emp.employee_name+' ('+emp.emp_code+')');
        $('#reg-department').val(emp.area_name);
        $('#reg-work-date').val(emp.work_date);
        $('#reg-total-duration').val('');
        $('#reg-ot-duration').val('');

        // Parse day_start and day_end into datetime-local format
        const parseToDatetimeLocal = (str) => {
            try {
                const date = new Date('2025 ' + str); // ensure year prefix for proper parsing
                return date.toISOString().slice(0, 16); // format: YYYY-MM-DDTHH:mm
            } catch {
                return '';
            }
        };
		
        const inTime = convertToDatetimeLocal(emp.day_start);
        const outTime = convertToDatetimeLocal(emp.day_end);

        $('#reg-punch-time-in').val(inTime);
        $('#reg-punch-time-out').val(outTime); 
        if (inTime != '' && outTime != '') { 
            const diffMs = new Date(outTime) -  new Date(inTime);
            const diffMins = Math.floor(diffMs / 60000);
            const hours = Math.floor(diffMins / 60);
            const minutes = diffMins % 60;

            $('#reg-total-duration').val(hours+'h '+minutes+'m');

            if (hours > 8) {
                const otHours = hours - 8;
                const otMinutes = minutes;
                $('#reg-ot-duration').val(otHours+'h '+otMinutes+'m');
            } else  if (minutes > 0) {
                $('#reg-ot-duration').val('0h '+minutes+'m');
            } else {
                $('#reg-ot-duration').val('0h 0m');
            }
        } else {
            $('#reg-total-duration').val('');
            $('#reg-ot-duration').val('');
        }
        // Trigger change to auto-calculate hours/OT
        $('#reg-punch-time-in').trigger('change');
        $('#reg-punch-time-out').trigger('change');

        $('#reg-reason').val('');
      //  $('#reg-total-duration').val('');
       // $('#reg-ot-duration').val('');

        const modal = new bootstrap.Modal(document.getElementById('regulariseModal'));
        modal.show();
        $('#reg-confirm-btn').data('emp-data', emp);
    });
    function convertToDatetimeLocal(raw) {
        if (!raw || !raw.includes(' - ')) return '';

        const [monthDay, time] = raw.split(' - ');

        // Use regex to extract month and day
        const match = monthDay.match(/^([A-Za-z]+)\s*(\d{1,2})$/);
        if (!match) return '';

        const [, month, day] = match;
        const monthIndex = new Date(`${month} 1, 2025`).getMonth() + 1;
        const formattedMonth = monthIndex.toString().padStart(2, '0');
        const formattedDay = day.toString().padStart(2, '0');
        const formattedTime = time?.slice(0, 5) || '00:00';

        return `2025-${formattedMonth}-${formattedDay}T${formattedTime}`;
    }


    // Calculate duration on punch time input change
    $('#reg-punch-time-in, #reg-punch-time-out').on('change', function () {
        const inTime = new Date($('#reg-punch-time-in').val());
        const outTime = new Date($('#reg-punch-time-out').val());

        if (!isNaN(inTime) && !isNaN(outTime) && outTime > inTime) {
            const diffMs = outTime - inTime;
            const diffMins = Math.floor(diffMs / 60000);
            const hours = Math.floor(diffMins / 60);
            const minutes = diffMins % 60;

            $('#reg-total-duration').val(hours+'h '+minutes+'m');

            if (hours > 8) {
                const otHours = hours - 8;
                const otMinutes = minutes;
                $('#reg-ot-duration').val(otHours+'h '+otMinutes+'m');
            } else {
                $('#reg-ot-duration').val('0h 0m');
            }
        } else {
            $('#reg-total-duration').val('');
            $('#reg-ot-duration').val('');
        }
    });

    $('#reg-confirm-btn').on('click', function () {
        const emp = $(this).data('emp-data');
        const payload = {
            emp_code: emp.emp_code,
            punch_in: $('#reg-punch-time-in').val(),
            punch_out: $('#reg-punch-time-out').val(),
            punch_state: $('#reg-punch-state').val(),
            reason: $('#reg-reason').val(),
            work_date: emp.work_date
        };

        console.log('Posting payload:', payload); // Debug

        $.ajax({
            url: '${pageContext.request.contextPath}/api/regularisePunch',
            method: 'POST',
            data: JSON.stringify(payload),
            contentType: 'application/json',
            success: function (res) {
                alert('Punch regularised successfully');
                $('#regulariseModal').modal('hide');
            },
            error: function (err) {
                alert('Error in regularising punch');
            }
        });
    });


    function loadInitialData() {
        $('#loadingOverlay').show();

        $.ajax({
            url: '${pageContext.request.contextPath}/ajax/getEmployeeAttendance',
            type: 'GET',
            dataType: 'json',
            data: {
                from_date: $('#from_date').val(),
                to_date: $('#to_date').val(),
                emp_code: '',
                area_name: ''
            },
            success: function(response) {
                $('#loadingOverlay').hide();

                if (response && Array.isArray(response) && response.length > 0) {
                    allAttendanceData = response;
                    initializeDataTable(allAttendanceData);
                    populateEmployeeFilter(allAttendanceData);
                    populateAreaFilter(allAttendanceData);
                } else {
                    toastr.error('No data found for the selected filters.', 'No Data');
                }
            },
            error: function(xhr, status, error) {
                $('#loadingOverlay').hide();
                let errorMsg = 'Failed to load data. ';
                
                if (xhr.status === 0) {
                    errorMsg += 'Network connection error.';
                } else if (xhr.status === 404) {
                    errorMsg += 'Requested URL not found.';
                } else if (xhr.status === 500) {
                    errorMsg += 'Internal Server Error.';
                } else if (error === 'parsererror') {
                    errorMsg += 'Failed to parse JSON response.';
                } else if (error === 'timeout') {
                    errorMsg += 'Request timed out.';
                } else {
                    errorMsg += 'Unknown error occurred.';
                }
                
                console.error('AJAX Error:', errorMsg, xhr);
                toastr.error(errorMsg, 'Error');
            }
        });
    }
    function formatHistoryTable(empCode) {
        return '<div class="collapse history-collapse" id="history-' + empCode.replace(/[^a-zA-Z0-9]/g, '') + '">' +
               '<table class="table table-bordered table-sm history-table" id="history-table-' + empCode.replace(/[^a-zA-Z0-9]/g, '') + '" style="width: 100%;">' +
               '<thead><tr>' +
               '<th>Work Date</th>' +
               '<th>Day Start</th>' +
               '<th>Day End</th>' +
               '<th>Work Hours</th>' +
               '<th>OT Hours</th>' +
               '<th>Shift</th>' +
               '<th>Status</th>' +
               '<th>Action</th>' + // Added for edit functionality
               '</tr></thead></table></div>';
    }

    function initializeDataTable(data) {
        // Filter data by date range
        var fromDate = $('#from_date').val();
        var toDate = $('#to_date').val();
        let filteredData = data;

        if (fromDate || toDate) {
            filteredData = data.filter(item => {
                var workDate = new Date(item.work_date);
                var from = fromDate ? new Date(fromDate) : null;
                var to = toDate ? new Date(toDate) : null;
                if (from && to) {
                    return workDate >= from && workDate <= to;
                } else if (from) {
                    return workDate >= from;
                } else if (to) {
                    return workDate <= to;
                }
                return true;
            });
        }

        // Aggregate data by emp_code
        var aggregatedData = [];
        var empMap = new Map();

        filteredData.forEach(item => {
            var empCode = item.emp_code;
            if (!empMap.has(empCode)) {
                empMap.set(empCode, {
                    emp_code: empCode,
                    employee_name: item.employee_name,
                    position_name: item.position_name,
                    area_name: item.area_name,
                    work_minutes_total: 0,
                    overtime_minutes_total: 0
                });
            }

            const emp = empMap.get(empCode);

            if (item.total_working_hours && item.total_working_hours !== '00:00:00') {
                const [hh, mm] = item.total_working_hours.split(':').map(Number);
                const totalMinutes = hh * 60 + mm;

                // Add all work minutes (including minutes)
                emp.work_minutes_total += totalMinutes;

                // Round down totalMinutes to full hours
                const fullHourMinutes = Math.floor(totalMinutes / 60) * 60;

                // Holiday logic: full hours only as OT
                if (item.is_holiday == 1) {
                    emp.overtime_minutes_total += fullHourMinutes;
                } else if (totalMinutes > 480) {
                    // Only count full-hour portion of OT
                    const otMinutes = totalMinutes - 480;
                    const otFullHourMinutes = Math.floor(otMinutes / 60) * 60;
                    emp.overtime_minutes_total += otFullHourMinutes;
                }
            }


        });

        empMap.forEach(emp => {
            emp.work_hours = Math.floor(emp.work_minutes_total / 60);
            emp.work_minutes = emp.work_minutes_total % 60;

            if (emp.is_holiday == 1) {
                // On holiday, treat full working time as OT
                emp.overtime_hours = Math.floor(emp.work_minutes_total / 60);
                emp.overtime_minutes = emp.work_minutes_total % 60;
            } else {
                emp.overtime_hours = Math.floor(emp.overtime_minutes_total / 60);
                emp.overtime_minutes = emp.overtime_minutes_total % 60;
            }

            aggregatedData.push(emp);
        });



        // Destroy existing DataTable if it exists
        if (dataTable) {
            dataTable.destroy();
        }

        dataTable = $('#employeeTable').DataTable({
            data: aggregatedData,
            columns: [
                {
                    className: 'details-control',
                    orderable: false,
                    data: null,
                    defaultContent: '<i class="fas fa-plus-circle text-primary"></i>',
                    width: '30px'
                },
                { data: 'emp_code' },
                { data: 'employee_name' },
                { data: 'position_name' },
                { data: 'area_name' },
                {
                    data: null,
                    render: function(data, type, row) {
                        var hours = row.work_hours || 0;
                        var minutes = row.work_minutes || 0;
                        let result = '<span><i class="fas fa-clock text-primary me-1"></i>' + hours + ' Hr';
                        if (minutes > 0) result += ' ' + minutes + ' Min' + (minutes > 1 ? 's' : '');
                        result += '</span>';
                        return result;
                    }
                },
                {
                    data: null,
                    render: function(data, type, row) {
                        var hours = row.overtime_hours || 0;
                        var minutes = row.overtime_minutes || 0;
                        if (hours === 0 && minutes === 0) {
                            return '<span class="text-muted no-ot-tag">No OT</span>';
                        }
                        let result = '<span class="text-success"><i class="fas fa-clock me-1"></i>';
                        if (hours > 0) result += hours + ' Hr' + (hours > 1 ? 's' : '');
                        if (hours > 0 && minutes > 0) result += ' ';
                        if (minutes > 0) result += minutes + ' Min' + (minutes > 1 ? 's' : '');
                        result += '</span>';
                        return result;
                    }
                },
                {
                    data: null,
                    render: function(data, type, row) {
                        return '<button class="btn btn-sm btn-primary" onclick="openPayslipModal(\'' + row.emp_code + '\', \'' + row.employee_name + '\', \'' + row.area_name + '\')">Print Hours </button>';
                    }
                }
            ],
            responsive: true,
            autoWidth: false,
            order: [[1, 'asc']],
            pageLength: 10,
            dom: '<"d-flex justify-content-between align-items-center mx-0 row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-6"f>>t<"d-flex justify-content-between mx-0 row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>',
            language: {
                paginate: {
                    previous: '<i class="fas fa-chevron-left"></i>',
                    next: '<i class="fas fa-chevron-right"></i>'
                }
            }
        });

        // Delegated event handler for details-control
        $('#employeeTable tbody').off('click', 'td.details-control').on('click', 'td.details-control', function() {
            var tr = $(this).closest('tr');
            var row = dataTable.row(tr);
            var empCode = row.data().emp_code;

            if (row.child.isShown()) {
                row.child.hide();
                tr.find('.details-control i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
            } else {
                row.child(formatHistoryTable(empCode)).show();
                tr.find('.details-control i').removeClass('fa-plus-circle').addClass('fa-minus-circle');

                // Filter historical data
                var fromDate = $('#from_date').val();
                var toDate = $('#to_date').val();
                let historyData = allAttendanceData.filter(item => item.emp_code === empCode);

                if (fromDate || toDate) {
                    historyData = historyData.filter(item => {
                        var workDate = new Date(item.work_date);
                        var from = fromDate ? new Date(fromDate) : null;
                        var to = toDate ? new Date(toDate) : null;
                        if (from && to) {
                            return workDate >= from && workDate <= to;
                        } else if (from) {
                            return workDate >= from;
                        } else if (to) {
                            return workDate <= to;
                        }
                        return true;
                    });
                }
             // Sort historyData by actual date ascending
                historyData.sort((a, b) => new Date(b.work_date) - new Date(a.work_date));

                // Initialize history DataTable
               $('#history-table-' + empCode.replace(/[^a-zA-Z0-9]/g, '')).DataTable({
    data: historyData,
    columns: [
        { 
            data: 'work_date',
            render: function(data, type, row, meta) {
                if (type === 'display' && !row.editing) {
                    return data;
                }
                return '<input type="date" class="form-control edit-field" value="' + data + '">';
            }
        },
        { 
            data: 'day_start',
            render: function(data, type, row, meta) {
                if (type === 'display' && !row.editing) {
                    return data;
                }
                return '<input type="time" class="form-control edit-field" value="' + data + '">';
            }
        },
        { 
            data: 'day_end',
            render: function(data, type, row, meta) {
                if (type === 'display' && !row.editing) {
                    return data || '-';
                }
                return '<input type="time" class="form-control edit-field" value="' + (data || '') + '">';
            }
        },
        {
            data: 'total_working_hours',
            title: 'Work Hours',
            render: function(data, type, row) {
                if (row.editing) {
                    if (row.day_start && row.day_end) {
                        if (row.day_start === row.day_end) return 'Punch In/Out Same — 0 Hr';

                        var workingHours = calculateWorkingHours(row.day_start, row.day_end);
                        var [hh, mm] = workingHours.split(':').map(Number);
                        var totalMinutes = hh * 60 + mm;

                        var code = '';
                        if (row.is_holiday == 1) {
                            code = ' (' + row.holiday_reason + ') ';
                        }

                        var hours = Math.floor(totalMinutes / 60);
                        var minutes = totalMinutes % 60;
                        let result = code + hours + ' Hr';
                        if (minutes > 0) result += ' ' + minutes + ' Min' + (minutes > 1 ? 's' : '');
                        return result;
                    }
                    return 'Enter times to calculate';
                }

                if (!data || data === '00:00:00' || row.day_start === row.day_end)
                    return 'Punch Out PENDING';

                var [hh, mm] = data.split(':').map(Number);
                var totalMinutes = hh * 60 + mm;
                var workMinutes = totalMinutes;

                var code = '';
                if (row.is_holiday == 1) {
                    code = ' ('+row.holiday_reason+') ';
                }

                var hours = Math.floor(workMinutes / 60);
                var minutes = workMinutes % 60;
                let result = code + hours + ' Hr';
                if (minutes > 0) result += ' ' + minutes + ' Min' + (minutes > 1 ? 's' : '');
                return result;
            }
        }
,
        {
            data: null,
            title: 'OT Hours',
            render: function(data, type, row) {
                if (row.editing) {
                    if (row.day_start && row.day_end) {
                        if (row.day_start === row.day_end) return '<span class="no-ot-tag">No OT</span>';

                        var workingHours = calculateWorkingHours(row.day_start, row.day_end);
                        var [hh, mm] = workingHours.split(':').map(Number);
                        var totalMinutes = hh * 60 + mm;

                       /*  if (row.is_holiday == 1) {
                            var code = ' (' + row.holiday_reason + ')';
                            let result = hh + ' Hr';
                            if (mm > 0) result += ' ' + mm + ' Min' + (mm > 1 ? 's' : '');
                            return result + code;
                        } */

                        var otMinutes = totalMinutes > 480 ? totalMinutes - 480 : 0;
                        if (otMinutes === 0) return '<span class="no-ot-tag">No OT</span>';

                        var hours = Math.floor(otMinutes / 60);
                        var minutes = otMinutes % 60;

                        let result = '';
                        if (hours > 0) result += hours + ' Hr' + (hours > 1 ? 's' : '');
                        if (hours > 0 && minutes > 0) result += ' ';
                        if (minutes > 0) result += minutes + ' Min' + (minutes > 1 ? 's' : '');

                        return result;
                    }
                    return 'Enter times to calculate';
                }

                if (row.day_start === row.day_end || !row.total_working_hours || row.total_working_hours === '00:00:00') {
                    return '<span class="no-ot-tag">No OT</span>';
                }

            /*     if (row.is_holiday == 1) {
                    var code = ' (' + row.holiday_reason + ')';
                    var [hh, mm] = row.total_working_hours.split(':').map(Number);
                    let result = hh + ' Hr';
                    if (mm > 0) result += ' ' + mm + ' Min' + (mm > 1 ? 's' : '');
                    return result + code;
                } */

                var [hh, mm] = row.total_working_hours.split(':').map(Number);
                var totalMinutes = hh * 60 + mm;
                var otMinutes = totalMinutes > 480 ? totalMinutes - 480 : 0;

                if (otMinutes === 0) return '<span class="no-ot-tag">No OT</span>';

                var hours = Math.floor(otMinutes / 60);
                var minutes = otMinutes % 60;

                let result = '';
                if (hours > 0) result += hours + ' Hr' + (hours > 1 ? 's' : '');
                if (hours > 0 && minutes > 0) result += ' ';
                if (minutes > 0) result += minutes + ' Min' + (minutes > 1 ? 's' : '');

                return result;
            }
        }
,
        { 
            data: 'shift_type',
            render: function(data, type, row) {
                if (type === 'display' && !row.editing) {
                    return data;
                }
                return '<select class="form-control edit-field">' +
                    '<option value="General"' + (data === 'General' ? ' selected' : '') + '>General</option>' +
                    '<option value="Shift A"' + (data === 'Shift A' ? ' selected' : '') + '>Shift A</option>' +
                    '<option value="Shift B"' + (data === 'Shift B' ? ' selected' : '') + '>Shift B</option>' +
                    '<option value="Shift C"' + (data === 'Shift C' ? ' selected' : '') + '>Shift C</option>' +
                    '</select>';
            }
        },
        {
            data: 'attendance_status',
            render: function(data, type, row) {
                if (row.editing) return 'Will be updated';
                
                let className = '';
                let icon = '';
                switch (data) {
                    case 'Partial Day':
                        className = 'status-partial';
                        icon = '<i class="fas fa-clock me-1"></i>';
                        break;
                    case 'Present':
                        className = 'status-p';
                        icon = '<i class="fas fa-clock me-1"></i>';
                        break;
                    case 'Half Day':
                        className = 'status-halfday';
                        icon = '<i class="fas fa-adjust me-1"></i>';
                        break;
                    case 'Incomplete Shift':
                        className = 'status-incomplete';
                        icon = '<i class="fas fa-exclamation-circle me-1"></i>';
                        break;
                    case 'Full Day (No OT)':
                        className = 'status-fullday';
                        icon = '<i class="fas fa-check-circle me-1"></i>';
                        break;
                    case 'Full Day with OT':
                        className = 'status-overtime';
                        icon = '<i class="fas fa-business-time me-1"></i>';
                        break;
                    case 'Missing Punch':
                        className = 'status-missing';
                        icon = '<i class="fas fa-question-circle me-1"></i>';
                        break;
                    default:
                        className = 'status-default';
                        icon = '<i class="fas fa-info-circle me-1"></i>';
                }
                return '<span class="eclipse-badge ' + className + '">' + icon + ' ' + data + '</span>';
            }
        },
        {
            data: null,
            render: function(data, type, row) {
                if (row.editing) {
                    return '<button class="btn btn-sm btn-success update-row me-1">Update</button>' +
                           '<button class="btn btn-sm btn-secondary cancel-edit">Cancel</button>';
                }
                return '<button class="btn btn-sm btn-primary edit-row">Edit</button>';
            }
        }
    ],
    pageLength: 5,
    searching: false,
    ordering: false,
    createdRow: function(row, data, dataIndex) {
        if (data.editing) {
            $(row).addClass('editing-row');
        }
        if (data.isEdited) {
            $(row).addClass('edited-row');
            // Optional: Add edit icon
            $(row).find('td:first').prepend('<i class="fas fa-edit me-2" title="Edited"></i>');
        }
    }
});
            // Add event listeners for time changes during editing
               $('#history-table-' + empCode.replace(/[^a-zA-Z0-9]/g, '')).on('change', '.edit-field', function() {
                   var table = $(this).closest('table').DataTable();
                   var row = $(this).closest('tr');
                   var rowData = table.row(row).data();
                   
                   // Update the row data with the new value
                   var field = $(this).closest('td').index();
                   switch (field) {
                       case 0: // Work Date
                           rowData.work_date = $(this).val();
                           break;
                       case 1: // Day Start
                           rowData.day_start = $(this).val();
                           break;
                       case 2: // Day End
                           rowData.day_end = $(this).val();
                           break;
                       case 5: // Shift
                           rowData.shift_type = $(this).val();
                           break;
                   }
                   
                   // Re-render the row to update calculations
                   table.row(row).invalidate().draw(false);
               });

               // Enhanced calculateWorkingHours function
               function calculateWorkingHours(startTime, endTime) {
                   if (!startTime || !endTime) return '00:00:00';
                   
                   // Parse times (format: HH:MM or HH:MM:SS)
                   const startParts = startTime.split(':').map(Number);
                   const endParts = endTime.split(':').map(Number);
                   
                   const startDate = new Date(0, 0, 0, startParts[0], startParts[1], startParts[2] || 0);
                   const endDate = new Date(0, 0, 0, endParts[0], endParts[1], endParts[2] || 0);
                   
                   // Handle overnight shifts (end time is next day)
                   if (endDate <= startDate) {
                       endDate.setDate(endDate.getDate() + 1);
                   }
                   
                   const diffMs = endDate - startDate;
                   const diffHrs = Math.floor(diffMs / 3600000); // hours
                   const diffMins = Math.floor((diffMs % 3600000) / 60000); // minutes
                   
                   // Format as HH:MM:00
                   return String(diffHrs).padStart(2, '0') + ':' + String(diffMins).padStart(2, '0') + ':00';


               }
               
               
               $('#history-table-' + empCode.replace(/[^a-zA-Z0-9]/g, '')).on('click', '.edit-row', function() {
                   var table = $(this).closest('table').DataTable();
                   var row = $(this).closest('tr');
                   var rowData = table.row(row).data();
                   
                   // Set editing flag
                   rowData.editing = true;
                   
                   // Redraw the row
                   table.row(row).invalidate().draw(false);
                   
                   // Add editing class to row
                   $(row).addClass('editing-row');
               });

               $('#history-table-' + empCode.replace(/[^a-zA-Z0-9]/g, '')).on('click', '.update-row', function() {
                   var table = $(this).closest('table').DataTable();
                   var row = $(this).closest('tr');
                   var rowData = table.row(row).data();
                   
                   // Get updated values from inputs
                   rowData.work_date = row.find('input[type="date"]').val();
                   rowData.day_start = row.find('input[type="time"]').eq(0).val();
                   rowData.day_end = row.find('input[type="time"]').eq(1).val();
                   rowData.shift_type = row.find('select').val();
                   
                   // Calculate new total working hours if both start and end times are available
                   if (rowData.day_start && rowData.day_end) {
                       // You might want to add your time calculation logic here
                       // For now, we'll just set a placeholder
                       rowData.total_working_hours = calculateWorkingHours(rowData.day_start, rowData.day_end);
                   }
                   
                   // Update attendance status based on new values
                   rowData.attendance_status = determineAttendanceStatus(rowData);
                   
                   // Clear editing flag
                    rowData.isEdited = true;
    				rowData.lastEdited = new Date(); // Track edit timestamp
    				 $(row).addClass('recently-edited');
    				    setTimeout(() => {
    				        $(row).removeClass('recently-edited');
    				    }, 2000);
                   // Prepare data for AJAX request
                   var updateData = {
                       id: rowData.id, // assuming there's an id field
                       work_date: rowData.work_date,
                       day_start: rowData.day_start,
                       day_end: rowData.day_end,
                       shift_type: rowData.shift_type
                   };
                   
                   // Send AJAX request to update the record
                   $.ajax({
                       url: '/api/update-attendance', // Update with your actual endpoint
                       method: 'POST',
                       data: updateData,
                       success: function(response) {
                           if (response.success) {
                               // Update the row data with any server-side changes
                               if (response.data) {
                                   Object.assign(rowData, response.data);
                               }
                               
                               // Redraw the row
                               table.row(row).invalidate().draw(false);
                               
                               // Show success message
                               toastr.success('Record updated successfully');
                           } else {
                               toastr.error(response.message || 'Error updating record');
                           }
                       },
                       error: function() {
                           toastr.error('Error updating record');
                       }
                   });
                   table.row(row).invalidate().draw(false);
               });

               $('#history-table-' + empCode.replace(/[^a-zA-Z0-9]/g, '')).on('click', '.cancel-edit', function() {
                   var table = $(this).closest('table').DataTable();
                   var row = $(this).closest('tr');
                   var rowData = table.row(row).data();
                   
                   // Clear editing flag
                   rowData.editing = false;
                   
                   // Redraw the row
                   table.row(row).invalidate().draw(false);
               });

                $('#history-' + empCode.replace(/[^a-zA-Z0-9]/g, '')).collapse('show');
            }
        });
    }
    
    // Helper function to calculate working hours (simplified example)
    function calculateWorkingHours(startTime, endTime) {
        // Implement your actual time calculation logic here
        // This is just a placeholder
        return '08:00:00';
    }

    // Helper function to determine attendance status (simplified example)
    function determineAttendanceStatus(rowData) {
        // Implement your actual logic to determine status based on times
        // This is just a placeholder
        if (rowData.day_start && rowData.day_end) {
            return 'Present';
        }
        return 'Missing Punch';
    }
    function openPayslipModal(empCode, empName, areaName) {
        let empData = allAttendanceData.filter(item => item.emp_code === empCode);

        if (empData.length === 0) {
            toastr.error('No data available for this employee.', 'No Data');
            return;
        }

        var fromDate = $('#from_date').val();
        var toDate = $('#to_date').val();
        if (fromDate || toDate) {
            empData = empData.filter(item => {
                var workDate = new Date(item.work_date);
                var from = fromDate ? new Date(fromDate) : null;
                var to = toDate ? new Date(toDate) : null;
                if (from && to) {
                    return workDate >= from && workDate <= to;
                } else if (from) {
                    return workDate >= from;
                } else if (to) {
                    return workDate <= to;
                }
                return true;
            });
        }

        let periodStart, periodEnd;
        var options = { year: 'numeric', month: 'long', day: 'numeric' };

        if (fromDate && toDate) {
            periodStart = new Date(fromDate).toLocaleDateString('en-US', options);
            periodEnd = new Date(toDate).toLocaleDateString('en-US', options);
        } else {
            var firstWorkDate = empData[0].work_date;
            var date = new Date(firstWorkDate);
            var year = date.getFullYear();
            let month = date.getMonth();
            if (date.getDate() < 25) {
                month = month - 1;
                if (month < 0) {
                    month = 11;
                    year--;
                }
            }
            periodStart = new Date(year, month, 25).toLocaleDateString('en-US', options);
            periodEnd = new Date(year, month + 1, 25).toLocaleDateString('en-US', options);
        }

        let workHours = 0;
        let workMinutes = 0;
        let totalOTHrs = 0;
        let totalOTMin = 0;

        empData.forEach(item => {
            if (item.total_working_hours && item.total_working_hours !== '00:00:00') {
                var [hh, mm] = item.total_working_hours.split(':').map(Number);
                var totalMinutes = hh * 60 + mm;
              //  var workMinutes = Math.min(totalMinutes, 8 * 60); // Cap at 8 hours/day
                var workMinutes = totalMinutes;
                var otMinutes = totalMinutes > 480 ? totalMinutes - 480 : 0;

                workHours += Math.floor(workMinutes / 60);
                workMinutes += workMinutes % 60;
                totalOTHrs += Math.floor(otMinutes / 60);
                totalOTMin += otMinutes % 60;
            }
        });

        workHours += Math.floor(workMinutes / 60);
        workMinutes = workMinutes % 60;
        totalOTHrs += Math.floor(totalOTMin / 60);
        totalOTMin = totalOTMin % 60;

        $('#payslipEmpCode').text(empCode);
        $('#payslipEmpName').text(empName);
        $('#payslipArea').text(areaName);
        $('#payslipPeriod').text(periodStart + ' to ' + periodEnd);
        $('#payslipTotalHours').text(workHours + ' Hrs' + (workMinutes > 0 ? ' ' + workMinutes + ' Mins' : ''));
        let otText = '';
        if (totalOTHrs > 0) otText += totalOTHrs + ' Hr' + (totalOTHrs > 1 ? 's' : '');
        if (totalOTHrs > 0 && totalOTMin > 0) otText += ' ';
        if (totalOTMin > 0) otText += totalOTMin + ' Min' + (totalOTMin > 1 ? 's' : '');
        $('#payslipOTHours').text(otText || 'No OT');

        $('#payslipModal').modal('show');
    }

    function applyFilters() {
        if (!dataTable || allAttendanceData.length === 0) return;

        var empCode = $('#empFilter').val().trim();
        var areaName = $('#areaFilter').val().trim();
        var fromDate = $('#from_date').val();
        var toDate = $('#to_date').val();

        // If date is selected, rebuild table with filtered date data
        if (fromDate || toDate) {
            initializeDataTable(allAttendanceData);
        }

        // Clear existing filters
        dataTable.columns().search('');

        // Apply emp code filter
        if (empCode) {
        	console.log(dataTable.column(1).header().innerText); // Should print "Employee Code" or whatever your table header says

            dataTable.column(1).search(empCode, false, false); // Column 1 is emp_code
        }

        // Apply area name filter
        if (areaName) {
            dataTable.column(4).search(areaName, false, false); // Column 4 is area_name
        }

        dataTable.draw(); // Apply all filters
    }


    function getFilteredData() {
        if (!dataTable) return [];

        var filteredData = dataTable.rows({ search: 'applied' }).data().toArray();

        if (filteredData.length === 0 ||
            ($('#empFilter').val() === '' &&
             $('#areaFilter').val() === '' &&
             $('#from_date').val() === '' &&
             $('#to_date').val() === '')) {
            return allAttendanceData;
        }

        return filteredData;
    }

    function populateEmployeeFilter(data) {
        allEmployees = [...new Map(data.map(item =>
            [item.emp_code, { emp_code: item.emp_code, employee_name: item.employee_name }]
        )).values()];

        var $empFilter = $('#empFilter');
        $empFilter.empty().append('<option value="">All Employees</option>');

        allEmployees.sort((a, b) => a.employee_name.localeCompare(b.employee_name));

        allEmployees.forEach(emp => {
            $empFilter.append('<option value="' + emp.emp_code + '">' + emp.employee_name + ' (' + emp.emp_code + ')</option>');
        });

        $empFilter.select2({
            placeholder: 'Select Employee',
            allowClear: true,
            width: '100%'
        });
    }

    function populateAreaFilter(data) {
        allAreas = [...new Set(data.map(item => item.area_name).filter(Boolean))];

        var $areaFilter = $('#areaFilter');
        $areaFilter.empty().append('<option value="">All Areas</option>');

        allAreas.sort((a, b) => a.localeCompare(b));

        allAreas.forEach(area => {
            $areaFilter.append('<option value="' + area + '">' + area + '</option>');
        });

        $areaFilter.select2({
            placeholder: 'Select Area',
            allowClear: true,
            width: '100%'
        });
    }

    function clearFilters() {
        $('#from_date').val('');
        $('#to_date').val('');
        $('#empFilter').val('').trigger('change');
        $('#areaFilter').val('').trigger('change');

        if (dataTable) {
            dataTable.columns().search('').draw();
            initializeDataTable(allAttendanceData);
        }
    }

    $('.select2-sandwich').select2({
        width: '100%',
        minimumResultsForSearch: 5,
        placeholder: $(this).data('placeholder')
    });

    $('.flatpickr').flatpickr({
        dateFormat: 'Y-m-d',
        allowInput: true
    });

    document.querySelectorAll('.premium-select').forEach(select => {
        var wrapper = select.closest('.select-wrapper');
        var clearBtn = wrapper.querySelector('.clear-select');

        select.addEventListener('change', function() {
            clearBtn.classList.toggle('d-none', this.value === '');
        });

        clearBtn.addEventListener('click', function() {
            select.value = '';
            select.dispatchEvent(new Event('change'));
            this.classList.add('d-none');
        });
    });
    $(document).ready(function() {
    	  // Initialize calendar
    	  $('#leave-calendar').datepicker({
    	    multidate: true,
    	    format: 'yyyy-mm-dd',
    	    todayHighlight: true
    	  });
    	  
    	  // Toggle between missed punch and leave request
    	  $('#request-type').change(function() {
    	    if ($(this).val() === 'leave') {
    	      $('#missed-punch-content').hide();
    	      $('#leave-request-content').show();
    	      
    	      // Copy employee info to leave form
    	      $('#leave-emp-name').val($('#reg-emp-name').val());
    	      $('#leave-department').val($('#reg-department').val());
    	    } else {
    	      $('#missed-punch-content').show();
    	      $('#leave-request-content').hide();
    	    }
    	  });
    	  
    	  // Handle leave submission
    	  $('#leave-confirm-btn').click(function() {
    	    const selectedDates = $('#leave-calendar').datepicker('getDates');
    	    const reason = $('#leave-reason').val();
    	    const leaveType = $('#leave-type').val();
    	    
    	    if (!leaveType) {
    	      alert('Please select a leave type');
    	      return;
    	    }
    	    
    	    if (selectedDates.length === 0) {
    	      alert('Please select at least one date for leave');
    	      return;
    	    }
    	    
    	    if (!reason) {
    	      alert('Please provide a reason for leave');
    	      return;
    	    }
    	    
    	    // Format dates as strings
    	    const formattedDates = selectedDates.map(date => {
    	      return date.toISOString().split('T')[0];
    	    });
    	    
    	    // Prepare data for API
    	    const leaveData = {
    	      employeeId: $('#reg-emp-name').data('employee-id'), // assuming you store ID in data attribute
    	      employeeName: $('#reg-emp-name').val(),
    	      department: $('#reg-department').val(),
    	      leaveType: leaveType,
    	      leaveTypeName: $('#leave-type option:selected').text().split('(')[0].trim(),
    	      dates: formattedDates,
    	      reason: reason,
    	      requestDate: new Date().toISOString().split('T')[0],
    	      status: 'Pending' // default status
    	    };
    	    
    	    // Call API to submit leave request
    	    $.ajax({
    	      url: '/api/leave-requests',
    	      method: 'POST',
    	      contentType: 'application/json',
    	      data: JSON.stringify(leaveData),
    	      success: function(response) {
    	        alert('Leave request submitted successfully');
    	        $('.btn-close').click(); // Close modal
    	        // You might want to refresh some part of your UI here
    	      },
    	      error: function(xhr, status, error) {
    	        alert('Error submitting leave request: ' + error);
    	      }
    	    });
    	  });
    	});
    	  
    	document.getElementById('bulkUploadForm').addEventListener('submit', function(e) {
    	    e.preventDefault();

    	    const fileInput = document.getElementById('uploadExcel');
    	    if (!fileInput.files.length) {
    	        alert("Please select an Excel file.");
    	        return;
    	    }

    	    const formData = new FormData();
    	    formData.append("file", fileInput.files[0]);

    	    fetch('/att/upload-excel', {
    	        method: 'POST',
    	        body: formData
    	    })
    	    .then(response => {
    	        if (response.ok) {
    	            alert("File uploaded and processed successfully!");
    	            document.getElementById('bulkUploadForm').reset();
    	        } else {
    	            alert("Error processing file.");
    	        }
    	    })
    	    .catch(err => {
    	        console.error("Upload failed", err);
    	        alert("An error occurred.");
    	    });
    	});
    	
    	 document.getElementById("new-punch-in").addEventListener("change", calculateDuration);
    	  document.getElementById("new-punch-out").addEventListener("change", calculateDuration);

    	  function calculateDuration() {
    	    const inTime = new Date(document.getElementById("new-punch-in").value);
    	    const outTime = new Date(document.getElementById("new-punch-out").value);

    	    if (!isNaN(inTime) && !isNaN(outTime) && outTime > inTime) {
    	      const diffMs = outTime - inTime;
    	      const hours = Math.floor(diffMs / (1000 * 60 * 60));
    	      const minutes = Math.floor((diffMs % (1000 * 60 * 60)) / (1000 * 60));
    	      document.getElementById("new-total-duration").value = `${hours}h ${minutes}m`;
    	    } else {
    	      document.getElementById("new-total-duration").value = "";
    	    }
    	  }
</script>
    <script async>
        var link = document.createElement('link');
        link.href = 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/atelier-cave-light.min.css';
        link.rel = 'stylesheet';
        document.getElementsByTagName('head')[0].appendChild(link);
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js"></script>
    <script async>hljs.initHighlightingOnLoad();</script>
</body>
</html>