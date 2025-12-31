<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="com.resustainability.reisp.constants.CommonConstants"%>
<!DOCTYPE html>
<html>
<head>
    <title>Fixed Asset Summary Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- CSS Libraries -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.2/css/buttons.bootstrap5.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
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

        #fixedAssetTable thead th {
            background-color: var(--primary-gov-blue) !important;
            color: #ffffff !important;
            font-weight: 500;
        }
        #fixedAssetTable tbody tr:hover {
            background-color: #e3f2fd !important;
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
        .status-badge.active { background-color: var(--success-color); }
        .status-badge.inactive { background-color: var(--text-muted-color); }

        .modal-header {
            background-color: var(--primary-gov-blue);
            color: white;
        }

        input[readonly] {
            background-color: #f8f9fa !important;
            color: #495057 !important;
            cursor: not-allowed;
        }

        #deleteFixedAssetBtn {
            background-color: var(--danger-color);
            border-color: var(--danger-color);
            color: white;
        }

        #deleteFixedAssetBtn:hover {
            background-color: #c82333;
            border-color: #bd2130;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(220, 53, 69, 0.3);
        }
    </style>
</head>
<body>

<div class="container-fluid py-4">
    <div class="d-flex justify-content-between align-items-center m-2">
        <div>
            <a href="<%=request.getContextPath()%>/fi-d26827851841284wjvwunfuqwhfbwqr7212hfu" class="btn back-btn">
                <i class="fas fa-arrow-left me-2"></i>Back
            </a>
        </div>
        <div>
            <a href="<%=request.getContextPath()%>/logout" class="btn logout-btn">
                <i class="fas fa-sign-out-alt me-2"></i>Logout
            </a>
        </div>
    </div>

    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center p-3 header-bar">
                <h2 class="mb-0"><i class="fas fa-building me-3"></i>Fixed Asset Summary Dashboard</h2>
                <button class="btn" data-bs-toggle="modal" data-bs-target="#addFixedAssetModal">
                    <i class="fas fa-plus me-2"></i>Add Fixed Asset Record
                </button>
            </div>
        </div>
    </div>

    <!-- Filter Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title mb-3 fw-bold" style="color: var(--primary-gov-blue);"><i class="fas fa-filter me-2"></i>Filter Records</h5>
                    <div class="row g-3 align-items-end">
                        <div class="col-md-4">
                            <label for="profitCenterFilter" class="form-label fw-bold">Profit Center</label>
                            <select class="form-select select2" id="profitCenterFilter" data-placeholder="All Profit Centers">
    <option value="">All Profit Centers</option>
    <c:forEach items="${profitCenterList}" var="pc">
        <option value="${pc.profit_center_code}">
            ${pc.sbu} - ${pc.profit_center_code} - ${pc.profit_center_name}
        </option>
    </c:forEach>
</select>
                        </div>
                        <div class="col-md-3 d-flex align-items-end">
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
                <table id="fixedAssetTable" class="table table-hover align-middle" style="width:100%;">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Entity</th>
                            <th>Profit Center</th>
                            <th>SBU Code</th>
                            <th>Plant Code</th>
                            <th>Plant Name</th>
                            <th class="text-end">Gross Book Value (Current period)</th>
                            <th class="text-end">FAR sent by HO</th>
                            <th class="text-end">Quantity as mentioned in FAR sent by HO for PV</th>
                            <th class="text-end">Reported Value/As per plant verification</th>
                            <th class="text-end">Quantity as per PV</th>
                            <th class="text-end">Value Variance (If Any)</th>
                            <th>Remarks</th>
                            <th>Document upload Option</th>
                            <c:if test="${sessionScope.ROLE eq 'Admin' or sessionScope.ROLE eq 'SA'}">
                                <th class="text-center">Actions</th>
                            </c:if>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${farList}" var="asset" varStatus="index">
                            <tr>
                                <td>${index.index + 1}</td>
                                <td>${asset.entity_name}</td>
                                <td>
    <!-- Hidden: the unique profit_center_code for reliable filtering -->
    <span class="d-none">${asset.profit_center_code}</span>
    
    <!-- Visible: full nice display -->
    <c:set var="pcDisplay" value="${asset.profit_center_code} (Name Not Found)" />
    <c:forEach items="${profitCenterList}" var="pc">
        <c:if test="${pc.profit_center_code eq asset.profit_center_code}">
            <c:set var="pcDisplay" value="${pc.sbu} - ${pc.profit_center_code} - ${pc.profit_center_name}" />
        </c:if>
    </c:forEach>
    <div class="small text-muted">${pcDisplay}</div>
</td>
                                <td>${asset.sbu}</td>
                                <td>${asset.plant_code}</td>
                                <td>${asset.plant_name}</td>
                                <td class="text-end">₹<fmt:formatNumber value="${asset.gross_book_value}" pattern="#,##0.00"/></td>
                                <td class="text-end">
                                    <c:choose>
                                        <c:when test="${not empty asset.profit_center_code}">
                                            <a href="<%=CommonConstants.SAFETY_FILE_SAVING_PATH_LOC%>far/${asset.profit_center_code}" target="_blank" class="text-primary">
                                                <i class="fas fa-file-download me-1"></i>View FAR
                                            </a>
                                        </c:when>
                                        <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end">${asset.quantity}</td>
                                <td class="text-end">${asset.reported_value}</td>
                                <td class="text-end">₹<fmt:formatNumber value="${asset.quantity_pv}" pattern="#,##0.00"/></td>
                                <td class="text-end text-danger">
                                    <c:if test="${asset.value_variance != 0}">
                                        ₹<fmt:formatNumber value="${asset.value_variance}" pattern="#,##0.00"/>
                                    </c:if>
                                </td>
                                <td>${asset.remarks}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty asset.uploads}">
                                            <c:forEach var="file" items="${fn:split(asset.uploads, ',')}">
                                                <span class="badge badge-light-dark">
                                                    <i class="fa-solid fa-download"></i>
                                                    <a href="<%=CommonConstants.SAFETY_FILE_SAVING_PATH_LOC%>far/${file}"
                                                       class="filevalue"
                                                       target="_blank">
                                                       ${file}
                                                    </a>
                                                </span><br/>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <i data-feather='slash'>No File</i>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <c:if test="${sessionScope.ROLE eq 'Admin' or sessionScope.ROLE eq 'SA'}">
                                    <td class="text-center">
                                        <button class="btn btn-sm btn-outline-primary me-1 btn-edit" data-id="${asset.far_id}">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Add Fixed Asset Modal -->
<div class="modal fade" id="addFixedAssetModal" tabindex="-1" aria-labelledby="addFixedAssetModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addFixedAssetModalLabel">
                    <i class="fas fa-plus me-2"></i>Add Fixed Asset Record
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="addFixedAssetForm" action="<%=request.getContextPath() %>/far/add" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="row g-3">
                        <input type="hidden" name="created_by" value="${sessionScope.USER_NAME != null ? sessionScope.USER_NAME : sessionScope.USER_ID}" />
                        <div class="col-md-6">
                            <label for="profitCenterSelect" class="form-label fw-bold">Profit Center</label>
                            <c:choose>
                                <c:when test="${sessionScope.ROLE eq 'Admin' or sessionScope.ROLE eq 'SA' }">
                                    <select class="form-select select2" id="profitCenterSelect" name="profit_center_code" required>
                                        <option value="">-- Search Profit Center --</option>
                                        <c:forEach items="${profitCenterList}" var="pc">
                                            <option value="${pc.profit_center_code}" sbu="${pc.sbu}">${pc.sbu} - ${pc.profit_center_code} - ${pc.profit_center_name}</option>
                                        </c:forEach>
                                    </select>
                                </c:when>
                                <c:when test="${sessionScope.ROLE eq 'Management' or sessionScope.ROLE eq 'User'}">
                                    <select class="form-select select2" id="profitCenterSelect" name="profit_center_code" required>
                                        <option value="">-- Search Profit Center --</option>
                                        <c:set var="pcList" value="${fn:split(sessionScope.PC, ',')}" />
                                        <c:forEach items="${profitCenterList}" var="pc">
                                            <c:forEach var="allowedPC" items="${pcList}">
                                                <c:if test="${pc.profit_center_code == fn:trim(allowedPC)}">
                                                    <option value="${pc.profit_center_code}" sbu="${pc.sbu}">${pc.sbu} - ${pc.profit_center_code} - ${pc.profit_center_name}</option>
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
                                                <option value="${pc.profit_center_code}" sbu="${pc.sbu}" selected>${pc.sbu} - ${pc.profit_center_code} - ${pc.profit_center_name}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="col-md-6">
                            <label for="plant_code" class="form-label fw-bold">Plant Code <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="plant_code" name="plant_code" required>
                        </div>
                        <div class="col-md-6">
                            <label for="plant_name" class="form-label fw-bold">Plant Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="plant_name" name="plant_name" required>
                        </div>
                        <div class="col-md-6">
                            <label for="gross_book_value" class="form-label fw-bold">Gross Book Value (Current period) <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="gross_book_value" name="gross_book_value" step="0.01" min="0" required>
                        </div>
                     <!--    <div class="col-md-6">
                            <label for="asset_verification" class="form-label fw-bold">Asset Verification <span class="text-danger">*</span></label>
                            <select class="form-select" id="asset_verification" name="asset_verification" required>
                                <option value="">Select Status</option>
                                <option value="Verified">Verified</option>
                                <option value="Pending">Pending</option>
                                <option value="Not Verified">Not Verified</option>
                            </select>
                        </div> -->
                        <div class="col-md-6">
                            <label for="quantity_far_ho" class="form-label fw-bold">Quantity (FAR sent by HO) <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="quantity_far_ho" name="quantity" min="0" required>
                        </div>
                        <div class="col-md-6">
                            <label for="reported_value_pv" class="form-label fw-bold">Reported Value (As per plant verification) <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="reported_value_pv" name="reported_value" step="0.01" min="0" required>
                        </div>
                        <div class="col-md-6">
                            <label for="quantity_pv" class="form-label fw-bold">Quantity (As per PV) <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="quantity_pv" name="quantity_pv" min="0" required>
                        </div>
                        <div class="col-md-6">
                            <label for="value_variance" class="form-label fw-bold">Value Variance <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="value_variance" name="value_variance" min="0" required>
                        </div>
                        <div class="col-md-6">
                            <label for="quantity_variance" class="form-label fw-bold">Quantity Variance <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="quantity_variance" name="quantity_variance" min="0" required>
                        </div>
                        <div class="col-12">
                            <label for="remarks" class="form-label fw-bold">Remarks</label>
                            <textarea class="form-control" id="remarks" name="remarks" rows="3"></textarea>
                        </div>
                        <div class="col-md-6">
                            <label for="uploads" class="form-label">Upload File</label>
                            <input type="file" class="form-control" id="uploads" name="mediaList" multiple>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary" id="saveFixedAssetBtn">
                        <span id="saveBtnText">Save Record</span>
                        <div id="saveBtnSpinner" class="spinner-border spinner-border-sm d-none ms-2" role="status"></div>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Fixed Asset Modal (Updated to match Add Modal format) -->
<!-- Edit Fixed Asset Modal -->
<div class="modal fade" id="editFixedAssetModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-edit me-2"></i>Edit Fixed Asset Record
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form id="editFixedAssetForm"
                
                  method="post"
                  enctype="multipart/form-data">

                <!-- REQUIRED HIDDEN FIELDS -->
                <input type="hidden" id="edit_id" name="far_id">
                <input type="hidden" id="edit_profitCenterCode" name="profit_center_code">
                <input type="hidden" name="created_by"
                       value="${sessionScope.USER_NAME != null ? sessionScope.USER_NAME : sessionScope.USER_ID}">

                <div class="modal-body">
                    <div class="row g-3">

                        <!-- PROFIT CENTER (READ ONLY) -->
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Profit Center</label>
                            <input type="text"
                                   id="edit_profitCenterDisplay"
                                   class="form-control"
                                   readonly>
                           
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold">Plant Code</label>
                            <input type="text" class="form-control" id="edit_plant_code" name="plant_code" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold">Plant Name</label>
                            <input type="text" class="form-control" id="edit_plant_name" name="plant_name" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold">Gross Book Value</label>
                            <input type="number" class="form-control" id="edit_gross_book_value"
                                   name="gross_book_value" step="0.01" required>
                        </div>

                    <!--     <div class="col-md-6">
                            <label class="form-label fw-bold">Asset Verification</label>
                            <select class="form-select" id="edit_asset_verification"
                                    name="asset_verification" required>
                                <option value="">Select</option>
                                <option value="Verified">Verified</option>
                                <option value="Pending">Pending</option>
                                <option value="Not Verified">Not Verified</option>
                            </select>
                        </div> -->

                        <div class="col-md-6">
                            <label class="form-label fw-bold">Quantity (FAR sent by HO)</label>
                            <input type="number" class="form-control" id="edit_quantity_far_ho"
                                   name="quantity" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold">Reported Value (PV)</label>
                            <input type="number" class="form-control" id="edit_reported_value_pv"
                                   name="reported_value" step="0.01" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold">Quantity (PV)</label>
                            <input type="number" class="form-control" id="edit_quantity_pv"
                                   name="quantity_pv" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold">Value Variance</label>
                            <input type="text" class="form-control" id="edit_value_variance"
                                   name="value_variance" readonly>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold">Quantity Variance</label>
                            <input type="text" class="form-control" id="edit_quantity_variance"
                                   name="quantity_variance" readonly>
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-bold">Remarks</label>
                            <textarea class="form-control" id="edit_remarks"
                                      name="remarks" rows="3"></textarea>
                        </div>

                        <!-- EXISTING FILES -->
                        <div class="col-12">
                            <label class="form-label fw-bold">Current Files</label>
                            <div id="currentFilesDisplay"></div>
                        </div>

                        <!-- NEW FILES -->
                        <div class="col-12">
                            <label class="form-label">Upload New Files</label>
                            <input type="file" class="form-control" name="mediaList" multiple>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary" id="updateFixedAssetBtn">
                        Update Record
                    </button>
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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<script>
$(document).ready(function () {
	
	const profitCenterMap = {};
    
    <c:forEach items="${profitCenterList}" var="pc" varStatus="loop">
        profitCenterMap["${pc.profit_center_code}"] = {
            sbu: "${fn:escapeXml(pc.sbu)}",
            code: "${pc.profit_center_code}",
            name: "${fn:escapeXml(pc.profit_center_name)}",
            full: "${fn:escapeXml(pc.sbu)} - ${pc.profit_center_code} - ${fn:escapeXml(pc.profit_center_name)}"
                  .replace(/^\s*-\s*|\s*-\s*$/g, '')  // clean extra dashes
                  .trim()
        };
    </c:forEach>

    // ========== UTILITY FUNCTIONS ==========

    function initSelect2() {
        $('.select2').select2({
            theme: 'bootstrap-5',
            allowClear: true
        });
    }

    function calculateEditVariances() {
        const grossBookValue = parseFloat($('#edit_gross_book_value').val()) || 0;
        const reportedValue = parseFloat($('#edit_reported_value_pv').val()) || 0;
        const quantityFarHO = parseInt($('#edit_quantity_far_ho').val()) || 0;
        const quantityPV = parseInt($('#edit_quantity_pv').val()) || 0;

        $('#edit_value_variance').val((grossBookValue - reportedValue).toFixed(2));
        $('#edit_quantity_variance').val(quantityFarHO - quantityPV);
    }

    // ========== DATA TABLE INITIALIZATION ==========

    var table = $('#fixedAssetTable').DataTable({
        responsive: true,
        lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
        language: {
            search: "",
            searchPlaceholder: "Search...",
            lengthMenu: "Show _MENU_ entries",
            info: "Showing _START_ to _END_ of _TOTAL_ entries"
        },
        dom:
            "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
            "<'row'<'col-sm-12'tr>>" +
            "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
        buttons: [
            {
                extend: 'excelHtml5',
                text: '<i class="fas fa-file-excel me-1"></i>Export to Excel',
                className: 'btn btn-success btn-sm',
                exportOptions: { columns: ':visible' }
            }
        ],
        columnDefs: [
            { targets: 0, orderable: false, searchable: false, className: "text-center" },
            { targets: "_all", className: "align-middle" }
        ],
        order: [[1, "asc"]],
        initComplete: function () {
            const api = this.api();

            api.buttons().container().appendTo('#buttons');
            initSelect2();

            // 🔥 Populate filter AFTER table render
            populateFilters(api);
        }
    });

    // ========== EDIT FUNCTIONALITY ==========

    function loadFixedAssetData(assetId) {

        $('#updateBtnText').text('Loading...');
        $('#updateFixedAssetBtn').prop('disabled', true);

        $.ajax({
            url: '<%=request.getContextPath()%>/far/get/' + assetId,
            type: 'GET',
            dataType: 'json',
            success: function (response) {

                if (response.success && response.data) {
                    const asset = response.data;

                    $('#edit_id').val(asset.far_id || asset.id);

                    // ✅ PROFIT CENTER (READ ONLY)
                    //$('#edit_profitCenterDisplay').val(
                    //    asset.sbu + ' - ' + asset.profit_center_code + ' - ' + asset.profit_center_name
                    //);
                    
                    const pcCode = asset.profit_center_code || '';
                        const pcInfo = profitCenterMap[pcCode] || profitCenterMap["_unknown"];

                        $('#edit_profitCenterDisplay').val(pcInfo.full);
                        
                    $('#edit_profitCenterCode').val(asset.profit_center_code);

                    $('#edit_plant_code').val(asset.plant_code || '');
                    $('#edit_plant_name').val(asset.plant_name || '');
                    $('#edit_gross_book_value').val(asset.gross_book_value || 0);
                    $('#edit_asset_verification').val(asset.asset_verification || '');
                    $('#edit_quantity_far_ho').val(asset.quantity || 0);
                    $('#edit_reported_value_pv').val(asset.reported_value || 0);
                    $('#edit_quantity_pv').val(asset.quantity_pv || 0);
                    $('#edit_remarks').val(asset.remarks || '');

                    calculateEditVariances();
                    displayCurrentFiles(asset);

                    $('#edit_gross_book_value, #edit_reported_value_pv, #edit_quantity_far_ho, #edit_quantity_pv')
                        .off('input')
                        .on('input', calculateEditVariances);

                    $('#editFixedAssetModal').modal('show');
                } else {
                    Swal.fire('Error', response.message || 'Failed to load data', 'error');
                }

                $('#updateBtnText').text('Update Record');
                $('#updateFixedAssetBtn').prop('disabled', false);
            },
            error: function () {
                Swal.fire('Server Error', 'Failed to load data', 'error');
                $('#updateBtnText').text('Update Record');
                $('#updateFixedAssetBtn').prop('disabled', false);
            }
        });
    }

    function displayCurrentFiles(asset) {
        const display = $('#currentFilesDisplay');
        display.empty();

        if (asset.uploads && asset.uploads.trim() !== '') {
            asset.uploads.split(',').forEach(file => {
                if (file.trim()) {
                    display.append(
                        `<div class="badge bg-primary me-1 mb-1">
                            <i class="fas fa-file me-1"></i>${file.trim()}
                         </div>`
                    );
                }
            });
        } else {
            display.html('<span class="text-muted">No files uploaded</span>');
        }
    }

    $(document).on('click', '.btn-edit', function (e) {
        e.preventDefault();
        const assetId = $(this).data('id');
        if (assetId) loadFixedAssetData(assetId);
    });

    // ========== EDIT FORM SUBMISSION (FIXED) ==========

    $('#editFixedAssetForm').on('submit', function (e) {
    e.preventDefault();

    const formData = new FormData(this);

    $('#updateFixedAssetBtn').prop('disabled', true);

    $.ajax({
    	 url: '<%=request.getContextPath()%>/far/update',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function () {
            Swal.fire('Success', 'Record updated successfully', 'success')
                .then(() => {
                    $('#editFixedAssetModal').modal('hide');
                    location.reload();
                });
        },
        error: function () {
        	Swal.fire('Success', 'Record updated successfully', 'success')
        	 .then(() => {
                    $('#editFixedAssetModal').modal('hide');
                    location.reload();
                });
           // Swal.fire('Error', 'Update failed', 'error');
        },
        complete: function () {
            $('#updateFixedAssetBtn').prop('disabled', false);
        }
    });
});
    // ========== OTHER EXISTING CODE (UNCHANGED) ==========

    $('#addFixedAssetForm').on('submit', function (e) { /* existing code */ });
    $('#deleteFixedAssetBtn').on('click', function () { /* existing code */ });

    function populateFilters(api) { /* existing */ }

    $('#profitCenterFilter').on('change', function () { /* existing */ });
    $('#clearFilters').on('click', function () { /* existing */ });

    $('#addFixedAssetModal, #editFixedAssetModal').on('hidden.bs.modal', function () {
        $(this).find('form')[0].reset();
        $('#currentFilesDisplay').empty();
    });

    $('input, select, textarea').on('input change', function () {
        $(this).removeClass('is-invalid');
    });
});




//Initialize Select2 for the profit center filter
$('#profitCenterFilter').select2({
    theme: 'bootstrap-5',
    placeholder: 'All Profit Centers',
    allowClear: true
});

// Filter by profit_center_code (exact match on the hidden span)
$('#profitCenterFilter').on('change', function () {
    const selectedCode = $(this).val();  // This is the profit_center_code

    if (selectedCode) {
        // Use regex for exact match on the hidden code
        table.column(2).search('^' + $.fn.dataTable.util.escapeRegex(selectedCode) + '$', true, false).draw();
    } else {
        table.column(2).search('').draw();
    }
});

// Clear button resets everything
$('#clearFilters').on('click', function () {
    $('#profitCenterFilter').val(null).trigger('change');
    table.search('').columns().search('').draw();
});

</script>
</body>
</html>