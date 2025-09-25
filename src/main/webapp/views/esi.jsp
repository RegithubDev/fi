<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="com.resustainability.reisp.constants.CommonConstants"%>

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
            color: var(--text-color);
            min-height: 100vh;
        }

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
        }
    </style>
</head>
<body>

<div class="container-fluid py-4">
<div class="d-flex justify-content-between align-items-center m-2">
  <div>
    <a href="<%=request.getContextPath()%>/fi-d26827851841284wjvwunfuqwhfbwqr7212hfu" 
       class="btn back-btn">
        <i class="fas fa-arrow-left me-2"></i>Back
    </a>
  </div>
  <div>
    <a href="<%=request.getContextPath()%>/logout" 
       class="btn logout-btn">
        <i class="fas fa-sign-out-alt me-2"></i>Logout
    </a>
  </div>
</div>

    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center p-3 header-bar">
                <h2 class="mb-0"><i class="fas fa-clinic-medical me-3"></i>ESI Contributions Dashboard</h2>
                <button class="btn" data-bs-toggle="modal" data-bs-target="#esiModal">
                    <i class="fas fa-plus me-2"></i>Add ESI Contribution
                </button>
            </div>
        </div>
    </div>

    <!-- Filter Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title mb-3 fw-bold" style="color: var(--primary-gov-blue);"><i class="fas fa-filter me-2"></i>Filter Contributions</h5>
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
            <div class="table-responsive card p-3">
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
                            <c:choose>
                                <c:when test="${sessionScope.ROLE eq 'Admin' or sessionScope.ROLE eq 'SA'}">
                                    <th><i class="fas fa-file-invoice me-2"></i>Status</th>
                                    <th class="text-center"><i class="fas fa-cogs me-2"></i>Actions</th>
                                </c:when>
                                <c:otherwise>
                                <th><i class="fas fa-file-invoice me-2"></i>Attachment</th>
                                    <th><i class="fas fa-gavel me-2"></i>Action</th>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${esiList}" var="esi" varStatus="index">
                            <tr class="table-row">
                                <td data-label="Profit Center">
                                    <div class="fw-bold">${esi.profit_center_code}</div>
                                    <div class="small" style="color: var(--text-muted-color) !important;">${esi.profit_center_name}</div>
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
                                    <td data-label="Due Date">
								  
								   <c:choose>
                                       <c:when test="${not empty esi.upload_file}">

                                           <a href="<%=CommonConstants.SAFETY_FILE_SAVING_PATH_LOC%>esi/${esi.upload_file }" 
											   class="filevalue" 
											   target="_blank">
											   ${esi.upload_file}
											</a>
											
                                        </c:when>
                                       
                                        <c:otherwise>
                                        <i data-feather='slash'>No File</i>
                                        </c:otherwise>
                                    </c:choose>
                                    
									</td>
                                        <td data-label="Action">
                                            <button class="btn btn-sm appeal-btn" 
                                                    data-record-id="${esi.id}" 
                                                    data-url="<%=request.getContextPath()%>/appealRecord">
                                                <i class="fas fa-gavel me-1"></i> Appeal for change
                                            </button>
                                        </td>
                                    </c:otherwise>
                                </c:choose>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Edit Modals -->
<c:forEach items="${esiList}" var="esi" varStatus="index">
    <div class="modal fade" id="esiModal_${index.count}" tabindex="-1" aria-labelledby="esiModalLabel_${index.count}" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content">
                <form id="esiForm_${index.count}" action="<%=request.getContextPath() %>/update-esi" method="post" enctype="multipart/form-data">
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
                                <input type="number" step="0.01" min="0" id="employee_contribution_${index.count}" name="employee_contributions" class="form-control" value="${esi.employee_contribution}" oninput="calculateTotal_edit(${index.count})" required />
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Employer (₹)</label>
                                <input type="number" step="0.01" min="0" id="employer_contribution_${index.count}" name="employer_contributions" class="form-control" value="${esi.employer_contribution}" oninput="calculateTotal_edit(${index.count})" required />
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-bold">Total (₹)</label>
                                <input type="number" id="total_amount_${index.count}" name="total_amounts" value="${esi.total_amount}" class="form-control bg-light" readonly required />
                            </div>
                        </div>

                        <!-- Payment Details -->
                        <h5 class="mt-4"><i class="fas fa-money-check-alt me-2"></i>Payment Details</h5>
                        <div class="row mb-3 g-3">
                            <div class="col-md-4">
                                <label class="form-label">Amount Paid (₹)</label>
                                <input type="number" step="0.01" min="0" id="amount_paid_${index.count}" name="amount_paids" class="form-control" value="${esi.amount_paid}" oninput="calculateDifference_edit(${index.count})" required />
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-bold">Balance (₹)</label>
                                <input type="number" id="difference_${index.count}" name="differences" value="${esi.difference}" class="form-control bg-light" readonly required />
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Challan Number</label>
                                <input type="text" id="challan_no_${index.count}" name="challan_nos" class="form-control" value="${esi.challan_no}" placeholder="Enter challan number" />
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Due Date</label>
                                <input type="date" id="due_date_${index.count}" name="due_dates" class="form-control" value="${esi.due_date}" required />
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Actual Payment Date</label>
                                <input type="date" id="actual_payment_date_${index.count}" name="actual_payment_dates" class="form-control actual-payment-date-input" value="${esi.actual_payment_date}" onchange="calculateDelayDays_edit(${index.count})" required />
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Delay in Days</label>
                                <input type="number" id="delay_days_${index.count}" name="delay_days" class="form-control bg-light" value="${esi.delay_days}" readonly required />
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Employee Count</label>
                                <input type="number" min="0" id="no_of_emp_${index.count}" name="no_of_emps" class="form-control" value="${esi.no_of_emp}" placeholder="e.g., 17" />
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-bold">Status</label>
                                <select name="status" class="form-select">
                                    <option value="Active" ${esi.status == 'Active' ? 'selected' : ''}>Active</option>
                                    <option value="Inactive" ${esi.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                </select>
                            </div>
                        </div>
                        
                        <h5 class="mt-4"><i class="fas fa-file-alt me-2"></i>Additional Details</h5>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Remarks</label>
                                <textarea class="form-control" name="remarks" rows="3" placeholder="Enter remarks here...">${esi.remarks}</textarea>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Upload File</label>
                                <input type="file" class="form-control" name="mediaList">
                                 <c:choose>
                                       <c:when test="${not empty esi.upload_file}">

                                           <a href="<%=CommonConstants.SAFETY_FILE_SAVING_PATH_LOC%>esi/${esi.upload_file }" 
											   class="filevalue" 
											   target="_blank">
											   ${esi.upload_file}
											</a>
											
                                        </c:when>
                                       
                                        <c:otherwise>
                                        </c:otherwise>
                                    </c:choose>
                         <input type="hidden" id="challan_no_edit1_${index.count}" name="upload_file" class="form-control" value="${pt.upload_file}" />
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
            <form id="esiForm" action="<%=request.getContextPath() %>/add-esi" method="post" enctype="multipart/form-data">
                <div class="modal-header">
                    <h5 class="modal-title" id="esiModalLabel">Add New ESI Contribution</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
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
                            <input type="number" step="0.01" min="0" class="form-control" name="employee_contribution" id="employee_contribution" oninput="calculateTotal();" required />
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Employer (₹)</label>
                            <input type="number" step="0.01" min="0" class="form-control" name="employer_contribution" id="employer_contribution" oninput="calculateTotal();" required />
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
                    
                    <h5 class="mt-4"><i class="fas fa-file-alt me-2"></i>Additional Details</h5>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Remarks</label>
                                <textarea class="form-control" name="remarks" rows="3" placeholder="Enter remarks here...">${esi.remarks}</textarea>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Upload File</label>
                                <input type="file" class="form-control" name="mediaList">
                            </div>
                          
                        </div>
                    
                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save ESI Contribution</button>
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
    // Set max date for actual payment date inputs to today
    const today = new Date().toISOString().split('T')[0];
    $('.actual-payment-date-input').attr('max', today);

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
        $('[id^=esiModal_] .select2').each(function() {
            $(this).select2({
                theme: 'bootstrap-5',
                dropdownParent: $(this).closest('.modal')
            });
        });
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
                            if (column === 9) {
                                return $(data).text().trim();
                            }
                            return data;
                        }
                    }
                },
                customizeData: function(d) {
                    d.header[0] = 'Profit Center Code';
                    d.header.splice(1, 0, 'Profit Center Name');
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
            
            const nextMonth = new Date(currentDate.getFullYear(), currentDate.getMonth(), 15);
            const dueDate = nextMonth.toISOString().slice(0, 10);
            $('#due_date').val(dueDate);
        }
    });

   
    $(function() {
    	   window.calculateTotal = function() {
    		   var form = $('#esiForm');
    	        var total = parseNumericInput(form.find('#employee_contribution')) 
    	                  + parseNumericInput(form.find('#employer_contribution')); 
    	        form.find('#total_amount').val(total.toFixed(2)); 
    	        calculateDifference();
    	   }
    	});
    // Edit Modal Calculations
    $(function() {
  	   window.calculateTotal_edit= function(index) {
        var employee = parseNumericInput($('#employee_contribution_' + index));
        var employer = parseNumericInput($('#employer_contribution_' + index));
        var total = employee + employer;
        
        $('#total_amount_' + index).val(total.toFixed(2));
        calculateDifference_edit(index);
    }
    });

    $(function() {
   	   window.calculateDifference_edit = function(index) {
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
   	   
    });

   	   
    $(function() {
   	   window.calculateDelayDays_edit = function(index) {
        var dueDateStr = $('#due_date_' + index).val();
        var actualDateStr = $('#actual_payment_date_' + index).val();
        
        if (dueDateStr && actualDateStr) {
            var diffDays = (new Date(actualDateStr) - new Date(dueDateStr)) / (1000 * 3600 * 24);
            $('#delay_days_' + index).val(Math.max(0, Math.ceil(diffDays)));
        } else {
            $('#delay_days_' + index).val(0);
        }
    }
    });

    // Add Modal Calculations
    function parseNumericInput(selector) { 
        return Math.max(0, parseFloat($(selector).val()) || 0); 
    }
    $(function() {
    	   window.calculateDifference = function() {
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
    	});

   

    $(function() {
 	   window.calculateDelayDays = function() {
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
    });
    $(function() {
  	   window.checkDuplicatePCMY() = function() {
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
    });
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