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

        .file-upload-area {
            border: 2px dashed #ccc;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .file-upload-area:hover {
            border-color: var(--primary-gov-blue);
            background-color: #f8f9fa;
        }
        .file-upload-area.dragover {
            border-color: var(--primary-gov-blue);
            background-color: #e3f2fd;
        }
        .file-list {
            margin-top: 10px;
        }
        .file-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 8px;
            background: #f8f9fa;
            border-radius: 4px;
            margin-bottom: 5px;
        }
        .file-item .remove-file {
            color: #dc3545;
            cursor: pointer;
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
                <!-- Fixed: Uses Bootstrap native modal trigger -->
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
                            <select class="form-select select2" id="profitCenterFilter" data-placeholder="Select Profit Center">
                                <option value=""></option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label for="monthYearFilter" class="form-label fw-bold">Period (Month-Year)</label>
                            <select class="form-select select2" id="monthYearFilter" data-placeholder="Select Period">
                                <option value=""></option>
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
                            <th>Entity Code</th>
                            <th>Entity Name</th>
                            <th>Profit Center Code</th>
                            <th>Profit Center Name</th>
                            <th>SBU Code</th>
                            <th>Plant Code</th>
                            <th>Plant Name</th>
                            <th class="text-end">Gross Book Value (Current period)</th>
                            <th class="text-end">FAR sent by HO</th>
                            <th class="text-end">Asset Verification</th>
                            <th class="text-end">Quantity as mentioned in FAR sent by HO for PV</th>
                            <th class="text-end">Reported Value/As per plant verification</th>
                            <th class="text-end">Quantity as per PV</th>
                            <th class="text-end">Value Variance (If Any)</th>
                            <th class="text-end">Qty Variance (If Any)</th>
                            <th>Remarks</th>
                            <th>Document upload Option</th>
                            <c:if test="${sessionScope.ROLE eq 'Admin' or sessionScope.ROLE eq 'SA'}">
                                <th class="text-center">Actions</th>
                            </c:if>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${fixedAssetList}" var="asset" varStatus="index">
                            <tr>
                                <td>${asset.entity_code}</td>
                                <td>${asset.entity_name}</td>
                                <td>
                                    <div class="fw-bold">${asset.profit_center_code}</div>
                                    <div class="small text-muted">${asset.profit_center_name}</div>
                                </td>
                                <td>${asset.profit_center_name}</td>
                                <td>${asset.sbu_code}</td>
                                <td>${asset.plant_code}</td>
                                <td>${asset.plant_name}</td>
                                <td class="text-end">₹<fmt:formatNumber value="${asset.gross_book_value}" pattern="#,##0.00"/></td>
                                <td class="text-end">
                                    <c:choose>
                                        <c:when test="${not empty asset.far_sent_by_ho}">
                                            <a href="<%=CommonConstants.SAFETY_FILE_SAVING_PATH_LOC%>far/${asset.far_sent_by_ho}" target="_blank" class="text-primary">
                                                <i class="fas fa-file-download me-1"></i>View FAR
                                            </a>
                                        </c:when>
                                        <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end">${asset.asset_verification}</td>
                                <td class="text-end">${asset.quantity_far_ho}</td>
                                <td class="text-end">₹<fmt:formatNumber value="${asset.reported_value_pv}" pattern="#,##0.00"/></td>
                                <td class="text-end">${asset.quantity_pv}</td>
                                <td class="text-end text-danger">
                                    <c:if test="${asset.value_variance != 0}">
                                        ₹<fmt:formatNumber value="${asset.value_variance}" pattern="#,##0.00"/>
                                    </c:if>
                                </td>
                                <td class="text-end text-danger">
                                    <c:if test="${asset.qty_variance != 0}">
                                        ${asset.qty_variance}
                                    </c:if>
                                </td>
                                <td>${asset.remarks}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty asset.document_upload}">
                                            <c:forEach var="file" items="${fn:split(asset.document_upload, ',')}">
                                                <a href="<%=CommonConstants.SAFETY_FILE_SAVING_PATH_LOC%>far/${file}" target="_blank" class="badge bg-primary text-white d-block mb-1">
                                                    <i class="fas fa-download me-1"></i>${file}
                                                </a>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise><span class="text-muted">No file</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <c:if test="${sessionScope.ROLE eq 'Admin' or sessionScope.ROLE eq 'SA'}">
                                    <td class="text-center">
                                        <button class="btn btn-sm btn-outline-primary me-1 btn-edit" data-id="${asset.id}">
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
                        <!-- Hidden field for created_by (from session) -->
                        <input type="hidden" name="created_by" value="${sessionScope.USER_NAME != null ? sessionScope.USER_NAME : sessionScope.USER_ID}" />

                        <div class="col-md-6">
                            <label for="entity_code" class="form-label fw-bold">Entity Code <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="entity_code" name="entity_Code" required>
                        </div>
                        <div class="col-md-6">
                            <label for="entity_name" class="form-label fw-bold">Entity Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="entity_name" name="entity_Name" required>
                        </div>
                        <div class="col-md-6">
                            <label for="profit_center_code" class="form-label fw-bold">Profit Center Code <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="profit_center_code" name="profit_Center_Code" required>
                        </div>
                        <div class="col-md-6">
                            <label for="profit_center_name" class="form-label fw-bold">Profit Center Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="profit_center_name" name="profit_Center_Name" required>
                        </div>
                        <div class="col-md-6">
                            <label for="sbu_code" class="form-label fw-bold">SBU Code</label>
                            <input type="text" class="form-control" id="sbu_code" name="sbu">
                        </div>
                        <div class="col-md-6">
                            <label for="plant_code" class="form-label fw-bold">Plant Code <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="plant_code" name="plant_Code" required>
                        </div>
                        <div class="col-md-6">
                            <label for="plant_name" class="form-label fw-bold">Plant Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="plant_name" name="plant_Name" required>
                        </div>
                        <div class="col-md-6">
                            <label for="gross_book_value" class="form-label fw-bold">Gross Book Value (Current period) <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="gross_book_value" name="gross_Book_Value" step="0.01" min="0" required>
                        </div>
                        <div class="col-md-6">
                            <label for="asset_verification" class="form-label fw-bold">Asset Verification <span class="text-danger">*</span></label>
                            <select class="form-select" id="asset_verification" name="asset_verification" required>
                                <option value="">Select Status</option>
                                <option value="Verified">Verified</option>
                                <option value="Pending">Pending</option>
                                <option value="Not Verified">Not Verified</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="quantity_far_ho" class="form-label fw-bold">Quantity (FAR sent by HO) <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="quantity_far_ho" name="quantity" min="0" required>
                        </div>
                        <div class="col-md-6">
                            <label for="reported_value_pv" class="form-label fw-bold">Reported Value (As per plant verification) <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="reported_value_pv" name="reported_Value" step="0.01" min="0" required>
                        </div>
                        <div class="col-md-6">
                            <label for="quantity_pv" class="form-label fw-bold">Quantity (As per PV) <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="quantity_pv" name="quantity_PV" min="0" required>
                        </div>
                        <div class="col-12">
                            <label for="remarks" class="form-label fw-bold">Remarks</label>
                            <textarea class="form-control" id="remarks" name="remarks" rows="3"></textarea>
                        </div>

                        <!-- FAR Document Upload (Single File) -->
                        <div class="col-12">
                            <label class="form-label fw-bold">FAR Document Upload</label>
                            <div class="file-upload-area" id="farUploadArea">
                                <i class="fas fa-cloud-upload-alt fa-3x text-muted mb-3"></i>
                                <p class="mb-2">Drag & drop your FAR file here or click to browse</p>
                                <p class="text-muted small">Supported formats: PDF, DOC, DOCX, XLS, XLSX (Max: 10MB)</p>
                                <input type="file" class="d-none" id="far_file" name="far_file" accept=".pdf,.doc,.docx,.xls,.xlsx">
                            </div>
                            <div class="file-list" id="farFileList"></div>
                        </div>

                        <!-- Additional Documents (Multiple Files) -->
                        <div class="col-12">
                            <label class="form-label fw-bold">Additional Documents (Optional)</label>
                            <div class="file-upload-area" id="docUploadArea">
                                <i class="fas fa-cloud-upload-alt fa-3x text-muted mb-3"></i>
                                <p class="mb-2">Drag & drop additional documents or click to browse</p>
                                <p class="text-muted small">You can upload multiple files (Max: 10MB each)</p>
                                <input type="file" class="d-none" id="documents" name="documents" multiple accept=".pdf,.doc,.docx,.xls,.xlsx,.jpg,.jpeg,.png">
                            </div>
                            <div class="file-list" id="docFileList"></div>
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
    // Initialize Select2
    function initSelect2() {
        $('.select2').select2({
            theme: 'bootstrap-5',
            allowClear: true,
            placeholder: $(this).data('placeholder')
        });
    }

    // Initialize DataTable
    var table = $('#fixedAssetTable').DataTable({
        "responsive": true,
        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
        "language": {
            "search": "",
            "searchPlaceholder": "Search...",
            "lengthMenu": "Show _MENU_ entries",
            "info": "Showing _START_ to _END_ of _TOTAL_ entries",
            "paginate": {
                "first": "First",
                "last": "Last",
                "next": "Next",
                "previous": "Previous"
            }
        },
        "dom": "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
               "<'row'<'col-sm-12'tr>>" +
               "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
        "buttons": [
            {
                extend: 'excelHtml5',
                text: '<i class="fas fa-file-excel me-1"></i>Export to Excel',
                className: 'btn btn-success btn-sm',
                exportOptions: {
                    columns: ':visible'
                }
            }
        ],
        "initComplete": function(settings, json) {
            this.api().buttons().container().appendTo('#buttons');
            initSelect2();
            populateFilters(this.api());
        }
    });

    // File upload functionality
    function setupFileUpload(uploadAreaId, fileInputId, fileListId) {
        const uploadArea = $(`#${uploadAreaId}`);
        const fileInput = $(`#${fileInputId}`);
        const fileList = $(`#${fileListId}`);

        uploadArea.on('click', function() {
            fileInput.click();
        });

        uploadArea.on('dragover', function(e) {
            e.preventDefault();
            uploadArea.addClass('dragover');
        });

        uploadArea.on('dragleave', function() {
            uploadArea.removeClass('dragover');
        });

        uploadArea.on('drop', function(e) {
            e.preventDefault();
            uploadArea.removeClass('dragover');
            const files = e.originalEvent.dataTransfer.files;
            handleFiles(files, fileList, fileInputId);
        });

        fileInput.on('change', function(e) {
            handleFiles(e.target.files, fileList, fileInputId);
        });
    }

    function handleFiles(files, fileList, inputName) {
        fileList.empty();
        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            if (file.size > 10 * 1024 * 1024) {
                Swal.fire({
                    icon: 'error',
                    title: 'File too large',
                    text: `${file.name} exceeds 10MB limit`
                });
                continue;
            }
            addFileItem(file, fileList, inputName);
        }
    }

    function addFileItem(file, fileList, inputName) {
        const fileItem = $('<div>').addClass('file-item');
        const fileInfo = $('<div>').html(`
            <i class="fas fa-file me-2"></i>
            <span>${file.name}</span>
            <small class="text-muted ms-2">(${(file.size / 1024 / 1024).toFixed(2)} MB)</small>
        `);
        const removeBtn = $('<i>').addClass('fas fa-times remove-file');

        removeBtn.on('click', function() {
            fileItem.remove();
        });

        fileItem.append(fileInfo).append(removeBtn);
        fileList.append(fileItem);
    }

    // Initialize file upload areas
    setupFileUpload('farUploadArea', 'far_file', 'farFileList');
    setupFileUpload('docUploadArea', 'documents', 'docFileList');

    // Reset form when modal is closed
    $('#addFixedAssetModal').on('hidden.bs.modal', function () {
        $('#addFixedAssetForm')[0].reset();
        $('#farFileList, #docFileList').empty();
        $('.is-invalid').removeClass('is-invalid');
    });

    // Form submission
    $('#addFixedAssetForm').on('submit', function(e) {
        e.preventDefault();

        const requiredFields = ['entity_code', 'entity_name', 'profit_center_code', 'profit_center_name',
                               'plant_code', 'plant_name', 'gross_book_value', 'asset_verification',
                               'quantity_far_ho', 'reported_value_pv', 'quantity_pv'];

        let isValid = true;
        requiredFields.forEach(field => {
            const value = $(`#${field}`).val();
            if (!value || value.trim() === '') {
                $(`#${field}`).addClass('is-invalid');
                isValid = false;
            } else {
                $(`#${field}`).removeClass('is-invalid');
            }
        });

        if (!isValid) {
            Swal.fire({
                icon: 'error',
                title: 'Validation Error',
                text: 'Please fill in all required fields marked with *'
            });
            return;
        }

        const grossBookValue = parseFloat($('#gross_book_value').val()) || 0;
        const reportedValue = parseFloat($('#reported_value_pv').val()) || 0;
        const quantityFarHO = parseInt($('#quantity_far_ho').val()) || 0;
        const quantityPV = parseInt($('#quantity_pv').val()) || 0;

        $('#saveBtnText').text('Saving...');
        $('#saveBtnSpinner').removeClass('d-none');
        $('#saveFixedAssetBtn').prop('disabled', true);

        const formData = new FormData(this);
        formData.append('value_variance', (grossBookValue - reportedValue).toFixed(2));
        formData.append('qty_variance', quantityFarHO - quantityPV);

        $.ajax({
            url: '<%=request.getContextPath()%>/addFixedAsset',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                $('#saveBtnText').text('Save Record');
                $('#saveBtnSpinner').addClass('d-none');
                $('#saveFixedAssetBtn').prop('disabled', false);

                if (response.success) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success!',
                        text: 'Fixed Asset record added successfully',
                        timer: 2000,
                        showConfirmButton: false
                    }).then(() => {
                        $('#addFixedAssetForm')[0].reset();
                        $('#farFileList').empty();
                        $('#docFileList').empty();
                        $('#addFixedAssetModal').modal('hide');
                        location.reload();
                    });
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error!',
                        text: response.message || 'Failed to add record'
                    });
                }
            },
            error: function() {
                $('#saveBtnText').text('Save Record');
                $('#saveBtnSpinner').addClass('d-none');
                $('#saveFixedAssetBtn').prop('disabled', false);
                Swal.fire({
                    icon: 'error',
                    title: 'Server Error',
                    text: 'An error occurred while saving the record.'
                });
            }
        });
    });

    // Filters
    $('#profitCenterFilter, #monthYearFilter').on('change', function () {
        var pcVal = $('#profitCenterFilter').val();
        table.column(2).search(pcVal ? '^' + $.fn.dataTable.util.escapeRegex(pcVal) + '$' : '', true, false).draw();
    });

    $('#clearFilters').on('click', function () {
        $('#profitCenterFilter, #monthYearFilter').val(null).trigger('change');
    });

    function populateFilters(api) {
        var currentPC = $('#profitCenterFilter').val();

        populateSelect(api, 2, '#profitCenterFilter', currentPC, function(cell) {
            var code = $(cell).find('.fw-bold').text().trim();
            var name = $(cell).find('.small').text().trim();
            if (code) return { code: code, text: code + ' - ' + name };
            return null;
        });
    }

    function populateSelect(api, columnIndex, selectId, currentValue, dataExtractor) {
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
        itemsArray.sort((a, b) => a.text.localeCompare(b.text));

        itemsArray.forEach(item => {
            select.append($('<option>', { value: item.code, text: item.text }));
        });

        select.val(currentValue);
    }

    // Edit button (placeholder)
    $('.btn-edit').on('click', function() {
        const assetId = $(this).data('id');
        alert('Edit functionality for ID: ' + assetId + ' (to be implemented)');
    });

    // Remove validation on input
    $('input, select, textarea').on('input change', function() {
        $(this).removeClass('is-invalid');
    });
});
</script>
</body>
</html>