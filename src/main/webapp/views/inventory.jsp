<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <title>Inventory Contributions Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- CSS Libraries -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.2/css/buttons.bootstrap5.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css" />
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

        #inventoryTable thead th {
            background-color: var(--primary-gov-blue) !important;
            color: #ffffff !important;
            font-weight: 500;
        }
        #inventoryTable tbody tr:hover {
            background-color: #e3f2fd !important;
        }
        .dataTables_wrapper .form-control, .dataTables_wrapper .form-select {
            border-radius: 6px;
        }
        .dataTables_paginate .page-item.active .page-link {
            background-color: var(--primary-gov-blue);
            border-color: var(--primary-gov-blue);
        }

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
            z-index: 1060;
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

        .modal-body .row {
            margin-bottom: 1rem;
        }
        .modal-body .form-label {
            font-size: 0.9rem;
            color: var(--text-color);
        }
        .modal-body .form-control,
        .modal-body .form-select,
        .modal-body textarea {
            border-radius: 6px;
            border-color: var(--border-color);
            padding: 0.5rem 0.75rem;
        }
        .modal-body .form-control:focus,
        .modal-body .form-select:focus,
        .modal-body textarea:focus {
            border-color: var(--primary-gov-blue);
            box-shadow: 0 0 5px rgba(13, 71, 161, 0.3);
        }
        .modal-body h5 {
            color: var(--primary-gov-blue);
            font-weight: 700;
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 0.5rem;
            margin-bottom: 1.5rem;
        }
        .modal-body .col-md-6,
        .modal-body .col-md-4,
        .modal-body .col-md-12 {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        .modal-body .bg-light {
            background-color: #f8f9fa;
            color: var(--text-color);
        }
        .modal-footer {
            border-top: 1px solid var(--border-color);
            padding: 1rem;
        }
        .modal-footer .btn {
            min-width: 100px;
        }
        .modal-body textarea {
            resize: vertical;
            min-height: 100px;
        }
        .modal-body .form-control-file {
            padding: 0.5rem;
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
                <h2 class="mb-0"><i class="fas fa-clinic-medical me-3"></i>Inventory Dashboard</h2>
                <button class="btn add-inventory-btn" id="add-inventory-btn">
                    <i class="fas fa-plus me-2"></i>Add Inventory Contribution
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
                <table id="inventoryTable" class="table table-hover align-middle" style="width:100%;">
                    <thead>
                        <tr>
                            <th><i class="fas fa-briefcase me-2"></i>Entity Code</th>
                            <th><i class="fas fa-building me-2"></i>Entity Name</th>
                            <th><i class="fas fa-user-tie me-2"></i>Profit Center Code</th>
                            <th><i class="fas fa-building me-2"></i>Profit Center Name</th>
                            <th><i class="fas fa-calculator me-2"></i>SBU</th>
                            <th><i class="fas fa-calendar-alt me-2"></i>Month</th>
                            <th><i class="fas fa-balance-scale me-2"></i>Book Value</th>
                            <th><i class="fas fa-clock me-2"></i>Reported Value</th>
                            <th><i class="fas fa-check-circle me-2"></i>(TB) Adjustment GL</th>
                            <th><i class="fas fa-hourglass-half me-2"></i>(TB) System GL</th>
                            <th><i class="fas fa-file-invoice me-2"></i>Variance</th>
                            <th><i class="fas fa-file-invoice me-2"></i>Remarks</th>
                            <c:choose>
                                <c:when test="${sessionScope.ROLE eq 'Admin' or sessionScope.ROLE eq 'SA'}">
                                    <th><i class="fas fa-file-invoice me-2"></i>Status</th>
                                    <th class="text-center"><i class="fas fa-cogs me-2"></i>Actions</th>
                                </c:when>
                                <c:otherwise>
                                    <th><i class="fas fa-gavel me-2"></i>Action</th>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${inventoryList}" var="inventory" varStatus="index">
                            <tr class="table-row">
                                <td>
                                    <div class="fw-bold">${inventory.entity_code}</div>
                               <!--       <div class="small" style="color: var(--text-muted-color) !important;">${inventory.entity_name}</div>  -->
                                </td>
                                <td>${inventory.entity_name}</td>
                                <td>
                                    <div class="fw-bold">${inventory.profit_center_code}</div>
                                </td>
                                <td>${inventory.profit_center_name}</td>
                                <td>${inventory.sbu}</td>
                                <td>${inventory.month_year}</td>
                                <td class="text-success">₹${inventory.book_value}</td>
                                <td class="text-danger">₹${inventory.reported_value}</td>
                                <td>${inventory.tb_adjustment_gl}</td>
                                <td>${inventory.tb_system_gl}</td>
                                <td>${inventory.varience}</td>
                                <td>${inventory.remarks}</td>
                                <c:choose>
                                    <c:when test="${sessionScope.ROLE eq 'Admin' or sessionScope.ROLE eq 'SA'}">
                                        <td>
                                            <span class="status-badge ${inventory.status == 'Active' ? 'active' : 'inactive'}">
                                                <span class="status-text">${inventory.status}</span>
                                            </span>
                                        </td>
                                        <td class="text-center">
                                            <div class="d-flex justify-content-center">
                                                <button class="btn btn-sm btn-outline-primary me-1 edit-trigger" data-index="${index.count}">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>
                                            <button class="btn btn-sm appeal-btn" 
                                                    data-record-id="${inventory.id}" 
                                                    data-index="${index.count}"
                                                    data-url="<%=request.getContextPath()%>/appealRecord">
                                                <i class="fas fa-gavel me-1"></i> Appeal
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

<!-- Edit Inventory Modal -->
<!-- Edit Inventory Modal -->
<c:forEach items="${inventoryList}" var="inventory" varStatus="index">
    <div class="modal fade" id="inventoryModal_${index.count}" tabindex="-1" aria-labelledby="inventoryModalLabel_${index.count}" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content">
                <form id="inventoryForm_${index.count}" action="<%=request.getContextPath() %>/inventory/update" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="modal-header">
                        <h5 class="modal-title" id="inventoryModalLabel_${index.count}">Update Inventory Contribution</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="id" value="${inventory.id}" />
                        <h5><i class="fas fa-info-circle me-2"></i>Core Information</h5>
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label for="entityCodeSelect_${index.count}" class="form-label fw-bold">Entity Code</label>
                                <select class="form-select select2" id="entityCodeSelect_${index.count}" name="entity_code" ${sessionScope.ROLE != 'Admin' && sessionScope.ROLE != 'SA' ? 'disabled' : ''} required>
                                    <option value="">-- Search Entity Code --</option>
                                    <c:forEach items="${eList}" var="entity">
                                        <option value="${entity.entity_code}" data-entity-name="${entity.entity_name}" ${entity.entity_code == inventory.entity_code ? 'selected' : ''}>${entity.entity_code} - ${entity.entity_name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <c:choose>
                                <c:when test="${sessionScope.ROLE eq 'Admin' or sessionScope.ROLE eq 'SA'}">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Profit Center</label>
                                        <select class="form-select select2" name="profit_center_code" required>
                                            <option value="">-- Search Profit Center --</option>
                                            <c:forEach items="${profitCenterList}" var="pc">
                                                <option value="${pc.profit_center_code}" ${pc.profit_center_code == inventory.profit_center_code ? 'selected' : ''}>${pc.profit_center_code} - ${pc.profit_center_name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </c:when>
                                <c:when test="${sessionScope.ROLE eq 'Management'}">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Profit Center</label>
                                        <select class="form-select select2" name="profit_center_code" ${sessionScope.ROLE != 'Admin' && sessionScope.ROLE != 'SA' ? 'disabled' : ''} required>
                                            <option value="">-- Search Profit Center --</option>
                                            <c:set var="pcList" value="${fn:split(sessionScope.PC, ',')}" />
                                            <c:forEach items="${profitCenterList}" var="pc">
                                                <c:forEach var="allowedPC" items="${pcList}">
                                                    <c:if test="${pc.profit_center_code == fn:trim(allowedPC)}">
                                                        <option value="${pc.profit_center_code}" ${pc.profit_center_code == inventory.profit_center_code ? 'selected' : ''}>${pc.profit_center_code} - ${pc.profit_center_name}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Profit Center</label>
                                        <p class="form-control-plaintext bg-light p-2 rounded">${inventory.profit_center_code} - ${inventory.profit_center_name}</p>
                                        <input type="hidden" name="profit_center_code" value="${inventory.profit_center_code}" />
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Month-Year</label>
                                <input type="month" class="form-control" name="month_year" value="${inventory.month_year}" ${sessionScope.ROLE != 'Admin' && sessionScope.ROLE != 'SA' ? 'readonly' : ''} required>
                            </div>
                            
                              <!-- Add Status Field -->
                            <div class="col-md-6">
                                <label for="status_${index.count}" class="form-label fw-bold">Status</label>
                                <select class="form-select" id="status_${index.count}" name="status" ${sessionScope.ROLE != 'Admin' && sessionScope.ROLE != 'SA' ? 'disabled' : ''} required>
                                    <option value="Active" ${inventory.status == 'Active' ? 'selected' : ''}>Active</option>
                                    <option value="Inactive" ${inventory.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                </select>
                            </div>
                        </div>
                        <h5 class="mt-4"><i class="fas fa-calculator me-2"></i>Financial Details</h5>
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label class="form-label">As per TB with Adjustment GL (₹)</label>
                                <input type="number" step="0.01" min="0" class="form-control" name="tb_adjustment_gl" value="${inventory.tb_adjustment_gl}" ${sessionScope.ROLE != 'Admin' && sessionScope.ROLE != 'SA' ? 'readonly' : ''} oninput="calculateVariance_edit(${index.count})" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">As per TB with System GL (₹)</label>
                                <input type="number" step="0.01" min="0" class="form-control" name="tb_system_gl" value="${inventory.tb_system_gl}" ${sessionScope.ROLE != 'Admin' && sessionScope.ROLE != 'SA' ? 'readonly' : ''} oninput="calculateVariance_edit(${index.count})" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Book Value (₹)</label>
                                <input type="number" step="0.01" min="0" class="form-control bg-light" name="book_value" value="${inventory.book_value}" ${sessionScope.ROLE != 'Admin' && sessionScope.ROLE != 'SA' ? 'readonly' : ''} readonly required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Reported Value (₹)</label>
                                <input type="number" step="0.01" min="0" class="form-control" name="reported_value" value="${inventory.reported_value}" oninput="calculateVariance_edit(${index.count})" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Variance (₹)</label>
                                <input type="number" step="0.01" min="0" class="form-control bg-light" name="varience" value="${inventory.varience}" ${sessionScope.ROLE != 'Admin' && sessionScope.ROLE != 'SA' ? 'readonly' : ''} readonly required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">SBU</label>
                                <input type="text" class="form-control" name="sbu" value="${inventory.sbu}" ${sessionScope.ROLE != 'Admin' && sessionScope.ROLE != 'SA' ? 'readonly' : ''} required>
                            </div>
                        </div>
                        <h5 class="mt-4"><i class="fas fa-file-alt me-2"></i>Additional Details</h5>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Remarks</label>
                                <textarea class="form-control" name="remarks" rows="3" placeholder="Enter remarks here...">${inventory.remarks}</textarea>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Upload File</label>
                                <input type="file" class="form-control" name="uploadFile">
                            </div>
                          
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Update Inventory Contribution</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</c:forEach>

<!-- Add Modal -->
<div class="modal fade" id="inventoryModal" tabindex="-1" aria-labelledby="inventoryModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content">
            <form id="inventoryForm" action="<%=request.getContextPath() %>/inventory/add" method="post" enctype="multipart/form-data">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <div class="modal-header">
                    <h5 class="modal-title" id="inventoryModalLabel">Add New Inventory Contribution</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h5><i class="fas fa-info-circle me-2"></i>Core Information</h5>
                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label for="entityCodeSelect" class="form-label fw-bold">Entity Code</label>
                            <select class="form-select select2" id="entityCodeSelect" name="entity_code" required>
                                <option value="">-- Search Entity --</option>
                                <c:choose>
                                    <c:when test="${sessionScope.ROLE eq 'Admin' or sessionScope.ROLE eq 'SA' or sessionScope.ROLE eq 'User'}">
                                        <c:forEach items="${eList}" var="entity">
                                            <option value="${entity.entity_code}" data-entity-name="${entity.entity_name}">${entity.entity_code} - ${entity.entity_name}</option>
                                        </c:forEach>
                                    </c:when>
                                    <c:when test="${sessionScope.ROLE eq 'Management'}">
                                        <c:set var="allowedEntities" value="${fn:split(sessionScope.entity, ',')}" />
                                        <c:forEach items="${entityList}" var="entity">
                                            <c:if test="${fn:contains(',' + sessionScope.entity + ',', ',' + entity.entity_code + ',')}">
                                                <option value="${entity.entity_code}" data-entity-name="${entity.entity_name}">${entity.entity_code} - ${entity.entity_name}</option>
                                            </c:if>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="defaultEntity" value="${fn:trim(sessionScope.Entity)}" />
                                        <c:forEach items="${eList}" var="entity">
                                            <c:if test="${entity.entity_code eq defaultEntity}">
                                                <option value="${entity.entity_code}" data-entity-name="${entity.entity_name}" selected>${entity.entity_code} - ${entity.entity_name}</option>
                                            </c:if>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="profitCenterSelect" class="form-label fw-bold">Profit Center</label>
                            <c:choose>
                                <c:when test="${sessionScope.ROLE eq 'Admin' or sessionScope.ROLE eq 'SA' or sessionScope.ROLE eq 'User'}">
                                    <select class="form-select select2" id="profitCenterSelect" name="profit_center_code" required>
                                        <option value="">-- Search Profit Center --</option>
                                        <c:forEach items="${profitCenterList}" var="pc">
                                            <option value="${pc.profit_center_code}">${pc.profit_center_code} - ${pc.profit_center_name}</option>
                                        </c:forEach>
                                    </select>
                                </c:when>
                                <c:when test="${sessionScope.ROLE eq 'Management'}">
                                    <select class="form-select select2" id="profitCenterSelect" name="profit_center_code" required>
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
                                </c:when>
                                <c:otherwise>
                                    <select class="form-select select2" id="profitCenterSelect" name="profit_center_code" required>
                                        <option value="">-- Search Profit Center --</option>
                                        <c:forEach items="${profitCenterList}" var="pc">
                                            <c:if test="${pc.profit_center_code eq sessionScope.PC}">
                                                <option value="${pc.profit_center_code}" selected>${pc.profit_center_code} - ${pc.profit_center_name}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="col-md-6">
                            <label for="month" class="form-label fw-bold">Month-Year</label>
                            <input type="month" class="form-control" id="month" name="month_year" required>
                        </div>
                        <!-- Add Status Field -->
                        <div class="col-md-6">
                            <label for="status" class="form-label fw-bold">Status</label>
                            <select class="form-select" id="status" name="status" required>
                                <option value="Active" selected>Active</option>
                                <option value="Inactive">Inactive</option>
                            </select>
                        </div>
                    </div>
                    <h5 class="mt-4"><i class="fas fa-calculator me-2"></i>Financial Details</h5>
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label for="tbAdjustmentGL" class="form-label">As per TB with Adjustment GL (₹)</label>
                            <input type="number" step="0.01" min="0" class="form-control" id="tbAdjustmentGL" name="tb_adjustment_gl" oninput="calculateVariance()" required>
                        </div>
                        <div class="col-md-4">
                            <label for="tbSystemGL" class="form-label">As per TB with System GL (₹)</label>
                            <input type="number" step="0.01" min="0" class="form-control" id="tbSystemGL" name="tb_system_gl" oninput="calculateVariance()" required>
                        </div>
                        <div class="col-md-4">
                            <label for="bookValue" class="form-label">Book Value (₹)</label>
                            <input type="number" step="0.01" min="0" class="form-control bg-light" id="bookValue" name="book_value" readonly required>
                        </div>
                        <div class="col-md-4">
                            <label for="reportedValue" class="form-label">Reported Value (₹)</label>
                            <input type="number" step="0.01" min="0" class="form-control" id="reportedValue" name="reported_value" oninput="calculateVariance()" required>
                        </div>
                        <div class="col-md-4">
                            <label for="variance" class="form-label">Variance (₹)</label>
                            <input type="number" step="0.01" min="0" class="form-control bg-light" id="variance" name="varience" readonly required>
                        </div>
                        <div class="col-md-4">
                            <label for="sbu" class="form-label">SBU</label>
                            <input type="text" class="form-control" id="sbu" name="sbu" required>
                        </div>
                    </div>
                    <h5 class="mt-4"><i class="fas fa-file-alt me-2"></i>Additional Details</h5>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="remarks" class="form-label">Remarks</label>
                            <textarea class="form-control" id="remarks" name="remarks" rows="3" placeholder="Enter remarks here..."></textarea>
                        </div>
                        <div class="col-md-6">
                            <label for="uploadFile" class="form-label">Upload File</label>
                            <input type="file" class="form-control" id="uploadFile" name="mediaList">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save Inventory Contribution</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
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
    // Debugging: Log when script starts
    console.log('Document ready, initializing components...');

    // Initialize Bootstrap modals
    try {
        var addModalInstance = new bootstrap.Modal(document.getElementById('inventoryModal'), {
            backdrop: 'static',
            keyboard: false
        });
        console.log('Add modal initialized successfully');
    } catch (error) {
        console.error('Error initializing add modal:', error);
        Swal.fire({
            icon: 'error',
            title: 'Initialization Error',
            text: 'Failed to initialize the add modal. Check console for details.'
        });
    }

    // Add button click handler
    $('#add-inventory-btn').on('click', function (e) {
        e.preventDefault();
        e.stopPropagation();
        console.log('Add button clicked');
        try {
            $('#inventoryForm')[0].reset();
            $('#inventoryModalLabel').text('Add New Inventory Contribution');
            const currentDate = new Date();
            const currentMonth = currentDate.toISOString().slice(0, 7);
            $('#month').val(currentMonth);
            $('#entityCodeSelect').val('').trigger('change');
            $('#entityName').val('');
            if ('${sessionScope.ROLE}' !== 'User' && '${sessionScope.ROLE}' !== 'Management') {
                $('#profitCenterSelect').val('').trigger('change');
            }
            addModalInstance.show();
            console.log('Add modal shown');
        } catch (error) {
            console.error('Error opening add modal:', error);
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Unable to open the add modal. Check console for details.'
            });
        }
    });

    // Edit button logic for Admin/SA
    $(document).on('click', '.edit-trigger', function (e) {
        e.preventDefault();
        e.stopPropagation();
        var index = $(this).data('index');
        console.log('Edit button clicked for index:', index);
        try {
            var editModal = new bootstrap.Modal(document.getElementById('inventoryModal_' + index), {
                backdrop: 'static',
                keyboard: false
            });
            // Trigger change event to populate entity name in edit modal
            $('#entityCodeSelect_' + index).trigger('change');
            editModal.show();
            console.log('Edit modal shown for index:', index);
        } catch (error) {
            console.error('Error opening edit modal for index ' + index + ':', error);
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Unable to open the edit modal for index ' + index + '. Check console for details.'
            });
        }
    });

    // Initialize Select2
    function initSelect2() {
        try {
            // Initialize Select2 for filter dropdowns
            $('#profitCenterFilter, #monthYearFilter').select2({
                theme: 'bootstrap-5',
                allowClear: true,
                placeholder: function() { return $(this).data('placeholder') || '-- Search --'; }
            });
            // Initialize Select2 for Add Modal
            $('#inventoryModal .select2').select2({
                theme: 'bootstrap-5',
                dropdownParent: $('#inventoryModal'),
                allowClear: true,
                placeholder: function() { return $(this).data('placeholder') || '-- Search --'; }
            });
            // Initialize Select2 for Edit Modals
            $('[id^=inventoryModal_]').each(function() {
                $(this).find('.select2').select2({
                    theme: 'bootstrap-5',
                    dropdownParent: $(this),
                    allowClear: true,
                    placeholder: function() { return $(this).data('placeholder') || '-- Search --'; }
                });
            });
            console.log('Select2 initialized');
        } catch (error) {
            console.error('Error initializing Select2:', error);
            Swal.fire({
                icon: 'error',
                title: 'Select2 Error',
                text: 'Failed to initialize Select2 dropdowns. Check console for details.'
            });
        }
    }

    // Initialize DataTable
    try {
        var table = $('#inventoryTable').DataTable({
            responsive: true,
            lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
            language: { search: "", searchPlaceholder: "Search..." },
            dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
                 "<'row'<'col-sm-12'tr>>" +
                 "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
            buttons: [
                {
                    extend: 'excelHtml5',
                    text: '<i class="fas fa-file-excel me-1"></i>Export',
                    className: 'btn btn-success btn-sm',
                    exportOptions: {
                        columns: ':not(:last-child)',
                        format: {
                            body: function (data, row, column, node) {
                                return $(node).text().trim();
                            }
                        }
                    }
                }
            ],
            initComplete: function(settings, json) {
                this.api().buttons().container().appendTo('#buttons');
                initSelect2();
                populateFilters(this.api());
                console.log('DataTable initialized');
            },
            drawCallback: function() {
                // Reinitialize Select2 only for modal dropdowns to avoid resetting filters
                $('[id^=inventoryModal_]').each(function() {
                    $(this).find('.select2').select2({
                        theme: 'bootstrap-5',
                        dropdownParent: $(this),
                        allowClear: true,
                        placeholder: function() { return $(this).data('placeholder') || '-- Search --'; }
                    });
                });
                $('#inventoryModal .select2').select2({
                    theme: 'bootstrap-5',
                    dropdownParent: $('#inventoryModal'),
                    allowClear: true,
                    placeholder: function() { return $(this).data('placeholder') || '-- Search --'; }
                });
                console.log('DataTable draw complete, Select2 reinitialized for modals');
            }
        });
    } catch (error) {
        console.error('Error initializing DataTable:', error);
        Swal.fire({
            icon: 'error',
            title: 'DataTable Error',
            text: 'Failed to initialize DataTable. Check console for details.'
        });
    }

 // Appeal button logic
    $(document).on('click', '.appeal-btn', function (e) {
        e.preventDefault();
        e.stopPropagation();
        var recordId = $(this).data('record-id');
        var index = $(this).data('index');
        var appealUrl = $(this).data('url');
        console.log('Appeal button clicked for index:', index, 'recordId:', recordId);

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
                try {
                    // Instead of opening the edit modal, show success message
                    Swal.fire({
                        icon: 'success',
                        title: 'Successfully Appealed',
                        text: 'Your appeal has been submitted to the Admin.',
                        timer: 2000,
                        showConfirmButton: false
                    });
                    console.log('Appeal submitted for recordId:', recordId);

                    // Optional: Add AJAX call to notify backend
                    $.ajax({
                        url: appealUrl,
                        type: 'POST',
                        data: { id: recordId },
                        success: function(response) {
                            console.log('Appeal logged successfully:', response);
                        },
                        error: function(xhr, status, error) {
                            console.error('Error logging appeal:', error);
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'Failed to submit appeal. Please try again.'
                            });
                        }
                    });
                } catch (error) {
                    console.error('Error processing appeal for index ' + index + ':', error);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Unable to process the appeal. Check console for details.'
                    });
                }
            }
        });
    });
    // Filter Logic
    $('#profitCenterFilter, #monthYearFilter').on('change', function () {
        var pcVal = $('#profitCenterFilter').val();
        var myVal = $('#monthYearFilter').val();
        console.log('Filter changed - Profit Center:', pcVal, 'Month-Year:', myVal);

        table.column(2).search(pcVal ? '^' + $.fn.dataTable.util.escapeRegex(pcVal) + '$' : '', true, false);
        table.column(5).search(myVal ? '^' + $.fn.dataTable.util.escapeRegex(myVal) + '$' : '', true, false);

        table.draw();
    });

    $('#clearFilters').on('click', function () {
        console.log('Clear filters clicked');
        $('#profitCenterFilter').val('').trigger('change');
        $('#monthYearFilter').val('').trigger('change');
        table.search('').columns().search('').draw();
        console.log('Filters cleared and table redrawn');
    });

    function populateFilters(api) {
        console.log('Populating filters...');
        var currentPC = $('#profitCenterFilter').val();
        var currentMY = $('#monthYearFilter').val();

        // Destroy existing Select2 instances to prevent duplicates
        $('#profitCenterFilter').select2('destroy');
        $('#monthYearFilter').select2('destroy');

        // Populate profit center filter from DataTable column 2 (Profit Center Code) and column 3 (Profit Center Name)
        var pcSelect = $('#profitCenterFilter');
        pcSelect.empty().append('<option value=""></option>');
        var uniquePCs = {};

        // Use rows().data() to get unique profit center codes and their names, extracting plain text to avoid HTML artifacts
        api.rows({ search: 'applied' }).every(function () {
            var data = this.data();
            var pcCode = data[2] ? $(data[2]).text().trim() : '';  // Parse HTML to get clean code text
            var pcName = data[3] ? data[3].trim() : '';
            if (pcCode && !uniquePCs[pcCode]) {
                var displayText = pcCode + ' - ' + pcName;
                uniquePCs[pcCode] = true;
                pcSelect.append('<option value="' + pcCode + '">' + displayText + '</option>');
            }
        });
        console.log('Profit Centers populated from DataTable:', Object.keys(uniquePCs).length);

        // Populate month-year filter from DataTable
        var mySelect = $('#monthYearFilter');
        mySelect.empty().append('<option value=""></option>');
        var uniqueMYs = {};
        api.column(5, { search: 'applied' }).data().each(function (data) {
            var my = data.trim();
            if (my && !uniqueMYs[my]) {
                uniqueMYs[my] = true;
                mySelect.append('<option value="' + my + '">' + my + '</option>');
            }
        });
        console.log('Month-Years populated:', Object.keys(uniqueMYs).length);

        // Restore selected values
        pcSelect.val(currentPC);
        mySelect.val(currentMY);

        // Reinitialize Select2 for filters
        $('#profitCenterFilter').select2({
            theme: 'bootstrap-5',
            allowClear: true,
            placeholder: $('#profitCenterFilter').data('placeholder') || '-- Select Profit Center --'
        });
        $('#monthYearFilter').select2({
            theme: 'bootstrap-5',
            allowClear: true,
            placeholder: $('#monthYearFilter').data('placeholder') || '-- Select Period --'
        });

        console.log('Filters populated and Select2 reinitialized');
    }

    // Entity Code Selection Handler for Add Modal
    $('#entityCodeSelect').on('change', function() {
        var selectedOption = $(this).find('option:selected');
        var entityName = selectedOption.data('entity-name') || '';
        $('#entityName').val(entityName);
        console.log('Add Modal - Entity Code selected:', $(this).val(), 'Entity Name:', entityName);
    });

    // Entity Code Selection Handler for Edit Modals
    $('[id^=entityCodeSelect_]').on('change', function() {
        var index = $(this).attr('id').split('_')[1];
        var selectedOption = $(this).find('option:selected');
        var entityName = selectedOption.data('entity-name') || '';
        $('#entityName_' + index).val(entityName);
        console.log('Edit Modal ' + index + ' - Entity Code selected:', $(this).val(), 'Entity Name:', entityName);
    });

    // Calculation functions for Add Modal
    window.calculateVariance = function() {
        try {
            var tbAdjustmentGL = parseNumericInput('#tbAdjustmentGL');
            var tbSystemGL = parseNumericInput('#tbSystemGL');
            var reportedValue = parseNumericInput('#reportedValue');

            var bookValue = tbAdjustmentGL + tbSystemGL;
            $('#bookValue').val(bookValue.toFixed(2));

            var variance = bookValue - reportedValue;
            $('#variance').val(variance.toFixed(2));
            console.log('Variance calculated:', variance);
        } catch (error) {
            console.error('Error in calculateVariance:', error);
        }
    };

    // Calculation functions for Edit Modals
    window.calculateVariance_edit = function(index) {
        try {
            var tbAdjustmentGL = parseNumericInput('#inventoryModal_' + index + ' [name="tb_adjustment_gl"]');
            var tbSystemGL = parseNumericInput('#inventoryModal_' + index + ' [name="tb_system_gl"]');
            var reportedValue = parseNumericInput('#inventoryModal_' + index + ' [name="reported_value"]');

            var bookValue = tbAdjustmentGL + tbSystemGL;
            $('#inventoryModal_' + index + ' [name="book_value"]').val(bookValue.toFixed(2));

            var variance = bookValue - reportedValue;
            $('#inventoryModal_' + index + ' [name="varience"]').val(variance.toFixed(2));
            console.log('Variance calculated for edit modal', index, ':', variance);
        } catch (error) {
            console.error('Error in calculateVariance_edit for index ' + index + ':', error);
        }
    };

    function parseNumericInput(selector) {
        return Math.max(0, parseFloat($(selector).val()) || 0);
    }

    // Removed duplicate check logic
    $('#profitCenterSelect, #month').on('change', function() {
        console.log('Profit Center or Month-Year changed:', $('#profitCenterSelect').val(), $('#month').val());
    });

    function showStrictAlertBox(title, message) {
        $('#strictAlertBox').remove();
        var secondsLeft = 10;
        var alertBoxHtml = '<div id="strictAlertBox" class="strict-alert">' +
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
        $('body').append(alertBoxHtml);
        var countdownInterval = setInterval(function() {
            secondsLeft--;
            $('#strictAlertCountdown').text(secondsLeft);
            if (secondsLeft <= 0) {
                clearInterval(countdownInterval);
                $('#strictAlertBox').fadeOut(500, function() { $(this).remove(); });
            }
        }, 1000);
        $('.strict-alert-close').on('click', function() {
            clearInterval(countdownInterval);
            $('#strictAlertBox').fadeOut(500, function() { $(this).remove(); });
        });
    }
});
</script>
</body>
</html>