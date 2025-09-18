
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="en">
<head>
    <title>SBU Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    <!-- Select2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css" />
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        :root {
            --primary-color: #4F7C82;
            --secondary-color: #0B2E33;
            --accent-color: #B8E3E9;
            --light-bg: #f8f9fa;
            --dark-text: #212529;
            --success: #28a745;
            --danger: #dc3545;
            --warning: #ffc107;
            --info: #17a2b8;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-bg);
            color: var(--dark-text);
            padding-bottom: 2rem;
        }

        .header-bar {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.15);
            transition: all 0.3s ease;
        }

        .header-bar:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }

        .card {
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 25px;
            border: none;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            overflow: hidden;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        .card-header {
            background: linear-gradient(to right, #f8f9fa, #e9ecef);
            border-bottom: 1px solid rgba(0,0,0,0.1);
            font-weight: 600;
            padding: 15px 20px;
        }

        .table-responsive {
            border-radius: 10px;
            overflow: hidden;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .status-active {
            background-color: #d4edda;
            color: #155724;
        }

        .status-inactive {
            background-color: #f8d7da;
            color: #721c24;
        }

        .action-btn {
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.2s ease;
        }

        .action-btn:hover {
            transform: scale(1.05);
        }

        .toast-notification {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 10000;
            min-width: 300px;
            opacity: 0;
            transform: translateY(-20px);
            transition: all 0.5s ease;
        }

        .toast-notification.show {
            opacity: 1;
            transform: translateY(0);
        }

        .select2-container--bootstrap-5 .select2-selection {
            border-radius: .375rem;
            padding: .375rem .75rem;
            min-height: calc(1.5em + .75rem + 2px);
        }

        .select2-container--bootstrap-5 .select2-selection--single .select2-selection__rendered {
            line-height: 1.5;
        }

        .select2-container--bootstrap-5 .select2-dropdown {
            border-radius: .375rem;
        }

        .modal.fade .modal-dialog {
            transform: translate(0, -50px);
            transition: transform 0.3s ease-out;
        }

        .modal.show .modal-dialog {
            transform: translate(0, 0);
        }

        .btn {
            transition: all 0.3s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        tr {
            transition: all 0.3s ease;
        }

        tr:hover {
            background-color: rgba(79, 124, 130, 0.05) !important;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .animate-fade-in {
            animation: fadeIn 0.6s ease forwards;
        }

        .email-validation {
            margin-top: 5px;
            font-size: 0.875rem;
            display: none;
        }

        .email-valid {
            color: var(--success);
        }

        .email-invalid {
            color: var(--danger);
        }

        .submit-buttons {
            transition: opacity 0.3s ease;
        }

        .buttons-disabled {
            opacity: 0.5;
            pointer-events: none;
        }
    </style>
</head>
<body>
    <!-- Toast Notification -->
    <div class="toast-notification" id="toastNotification">
        <div class="alert alert-dismissible fade show" role="alert">
            <span id="toastMessage"></span>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </div>

    <div class="container-fluid py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <a href="<%=request.getContextPath()%>/home" class="btn btn-dark btn-lg back-btn animate-fade-in">
                    <i class="fas fa-arrow-left me-2"></i>Back
                </a>
            </div>
            <div>
                <a href="<%=request.getContextPath()%>/logout" class="btn btn-outline-dark btn-lg logout-btn animate-fade-in">
                    <i class="fas fa-sign-out-alt me-2"></i>Logout
                </a>
            </div>
        </div>

        <div class="header-bar animate-fade-in">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h2 class="mb-1"><i class="fas fa-building me-2"></i>SBU Management</h2>
                    <p class="mb-0">Manage profit centers and their details</p>
                </div>
                <div>
                    <button class="btn btn-light btn-add-pc me-2" data-bs-toggle="modal" data-bs-target="#addPcModal">
                        <i class="fas fa-plus me-2"></i>Add Profit Center
                    </button>
                    <form action="<%=request.getContextPath()%>/export-pc" method="post" style="display: inline;">
                        <button type="submit" class="btn btn-success btn-export-pc">
                            <i class="fas fa-file-excel me-2"></i>Export to Excel
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <div class="card animate-fade-in">
            <div class="card-header">
                <i class="fas fa-list me-2"></i>SBU List
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="pcTable" class="table table-hover table-striped">
                        <thead class="table-dark">
                            <tr>
                                <th>#</th>
                                <th>Entity Code</th>
                                <th>Entity Name</th>
                                <th>Profit Center Code</th>
                                <th>Profit Center Name</th>
                                <th>SBU</th>
                                <th>Employee ID</th>
                                <th>Employee Name</th>
                                <th>Email</th>
                                <th>Created Date</th>
                                <th>Modified Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${pcList}" var="pc" varStatus="row">
                                <tr>
                                    <td>${fn:length(pcList) - row.index}</td>
                                    <td>${pc.entityCode}</td>
                                    <td>${pc.entityName}</td>
                                    <td>${pc.profitCenterCode}</td>
                                    <td>${pc.profitCenterName}</td>
                                    <td>${pc.sbu}</td>
                                    <td>${pc.empId}</td>
                                    <td>${pc.empName}</td>
                                    <td><span class="badge bg-info">${pc.emailId}</span></td>
                                    <td>${pc.createdDate}</td>
                                    <td>${pc.modifiedDate}</td>
                                    <td>
                                        <span class="status-badge ${pc.status == 'Active' ? 'status-active' : 'status-inactive'}">
                                            ${pc.status}
                                        </span>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-primary action-btn me-1"
                                                data-bs-toggle="modal"
                                                data-bs-target="#editPcModal${pc.id}">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <form action="<%=request.getContextPath()%>/deletePc" method="post" style="display: inline;">
                                            <input type="hidden" name="id" value="${pc.id}">
                                            <button type="submit" class="btn btn-sm btn-danger action-btn"
                                                    onclick="return confirm('Are you sure you want to delete this profit center?');">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Profit Center Modal -->
    <div class="modal fade" id="addPcModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form action="<%=request.getContextPath()%>/addPc" method="post" id="addPcForm">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title"><i class="fas fa-building-plus me-2"></i>Add New SBU</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Entity Code <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="entityCode" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Entity Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="entityName" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Profit Center Code <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="profitCenterCode" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Profit Center Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="profitCenterName" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">SBU <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="sbu" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Employee ID</label>
                                    <input type="text" class="form-control" name="empId">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Employee Name</label>
                                    <input type="text" class="form-control" name="empName">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Email <span class="text-danger">*</span></label>
                                    <input type="email" class="form-control" name="emailId" id="addEmail" required>
                                    <div class="email-validation" id="addEmailValidation"></div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Status <span class="text-danger">*</span></label>
                                    <select class="form-select" name="status" required>
                                        <option value="Active">Active</option>
                                        <option value="Inactive">Inactive</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer submit-buttons">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary" id="addPcBtn">Add SBU</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Profit Center Modals -->
    <c:forEach items="${pcList}" var="pc">
        <div class="modal fade" id="editPcModal${pc.id}" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <form action="<%=request.getContextPath()%>/updatePc" method="post" class="editPcForm" data-original-email="${pc.emailId}">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title"><i class="fas fa-edit me-2"></i>Edit SBU</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="id" value="${pc.id}">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Entity Code <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="entityCode" value="${pc.entityCode}" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Entity Name <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="entityName" value="${pc.entityName}" required>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Profit Center Code <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="profitCenterCode" value="${pc.profitCenterCode}" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Profit Center Name <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="profitCenterName" value="${pc.profitCenterName}" required>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">SBU <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="sbu" value="${pc.sbu}" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Employee ID</label>
                                        <input type="text" class="form-control" name="empId" value="${pc.empId}">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Employee Name</label>
                                        <input type="text" class="form-control" name="empName" value="${pc.empName}">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Email <span class="text-danger">*</span></label>
                                        <input type="email" class="form-control email-input" name="emailId" value="${pc.emailId}" required>
                                        <div class="email-validation email-validation-${pc.id}"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Status <span class="text-danger">*</span></label>
                                        <select class="form-select" name="status" required>
                                            <option value="Active" ${pc.status == 'Active' ? 'selected' : ''}>Active</option>
                                            <option value="Inactive" ${pc.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer submit-buttons">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary update-pc-btn" data-pc-id="${pc.id}">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </c:forEach>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        $(document).ready(function() {
            // Collect all existing emails and their status from the table
            const existingProfitCenters = [];
            $('#pcTable tbody tr').each(function() {
                const email = $(this).find('.badge.bg-info').text().trim();
                const status = $(this).find('.status-badge').text().trim();
                existingProfitCenters.push({ email, status });
            });

            // Initialize DataTable
            $('#pcTable').DataTable({
                responsive: true,
                order: [[0, 'desc']],
                pageLength: 25,
                language: {
                    search: "",
                    searchPlaceholder: "Search profit centers...",
                    lengthMenu: "Show _MENU_ entries",
                    info: "Showing _START_ to _END_ of _TOTAL_ entries",
                    paginate: {
                        previous: "<i class='fas fa-chevron-left'></i>",
                        next: "<i class='fas fa-chevron-right'></i>"
                    }
                },
                dom: '<"row"<"col-md-6"l><"col-md-6"f>>rt<"row"<"col-md-6"i><"col-md-6"p>>',
                initComplete: function() {
                    $('.dataTables_filter input').addClass('form-control');
                    $('.dataTables_length select').addClass('form-select');
                }
            });

            // Function to initialize Select2
            function initSelect2(modal) {
                modal.find('.searchable-select').select2({
                    theme: 'bootstrap-5',
                    dropdownParent: modal
                });
            }

            // Initialize Select2 when modals are shown
            $('#addPcModal').on('shown.bs.modal', function () {
                initSelect2($(this));
                $('#addEmailValidation').hide().removeClass('email-valid email-invalid');
                $('#addPcBtn').prop('disabled', false);
                $('.submit-buttons').removeClass('buttons-disabled');
            });

            $('[id^="editPcModal"]').on('shown.bs.modal', function () {
                initSelect2($(this));
                const pcId = $(this).attr('id').replace('editPcModal', '');
                $(`.email-validation-${pcId}`).hide().removeClass('email-valid email-invalid');
                $(`button[data-pc-id="${pcId}"]`).prop('disabled', false);
                $(this).find('.submit-buttons').removeClass('buttons-disabled');
            });

            // Email validation function
            function validateEmail(email, originalEmail = null) {
                const existingPc = existingProfitCenters.find(pc => pc.email === email);
                if (originalEmail && email === originalEmail) {
                    return true;
                }
                if (!existingPc) {
                    return true;
                }
                if (existingPc.status !== 'Active') {
                    return true;
                }
                return false;
            }

            // Real-time email validation for Add Profit Center form
            $('#addEmail').on('input', function() {
                const email = $(this).val().trim();
                const validationElement = $('#addEmailValidation');

                if (email === '') {
                    validationElement.hide();
                    $('#addPcBtn').prop('disabled', false);
                    $('.submit-buttons').removeClass('buttons-disabled');
                    return;
                }

                const isValid = validateEmail(email);

                if (isValid) {
                    validationElement.html('<i class="fas fa-check-circle"></i> Email is available')
                        .removeClass('email-invalid').addClass('email-valid').show();
                    $('#addPcBtn').prop('disabled', false);
                    $('.submit-buttons').removeClass('buttons-disabled');
                } else {
                    validationElement.html('<i class="fas fa-exclamation-circle"></i> Email already exists with Active status')
                        .removeClass('email-valid').addClass('email-invalid').show();
                    $('#addPcBtn').prop('disabled', true);
                    $('.submit-buttons').addClass('buttons-disabled');
                }
            });

            // Real-time email validation for Edit Profit Center forms
            $(document).on('input', '.email-input', function() {
                const email = $(this).val().trim();
                const form = $(this).closest('.editPcForm');
                const originalEmail = form.data('original-email');
                const pcId = form.find('.update-pc-btn').data('pc-id');
                const validationElement = $(`.email-validation-${pcId}`);
                const submitBtn = form.find('.update-pc-btn');

                if (email === '') {
                    validationElement.hide();
                    submitBtn.prop('disabled', false);
                    form.find('.submit-buttons').removeClass('buttons-disabled');
                    return;
                }

                const isValid = validateEmail(email, originalEmail);

                if (isValid) {
                    validationElement.html('<i class="fas fa-check-circle"></i> Email is available')
                        .removeClass('email-invalid').addClass('email-valid').show();
                    submitBtn.prop('disabled', false);
                    form.find('.submit-buttons').removeClass('buttons-disabled');
                } else {
                    validationElement.html('<i class="fas fa-exclamation-circle"></i> Email already exists with Active status')
                        .removeClass('email-valid').addClass('email-invalid').show();
                    submitBtn.prop('disabled', true);
                    form.find('.submit-buttons').addClass('buttons-disabled');
                }
            });

            // Form submission handling for Add Profit Center
            $('#addPcForm').submit(function(e) {
                const email = $('#addEmail').val().trim();
                if (!validateEmail(email)) {
                    e.preventDefault();
                    showToast('Email already exists with Active status. Please use a different email address.', 'danger');
                    $('#addEmail').focus();
                    return false;
                }
            });

            // Handle edit form submissions
            $('.editPcForm').submit(function(e) {
                const form = $(this);
                const email = form.find('.email-input').val().trim();
                const originalEmail = form.data('original-email');
                if (email !== originalEmail && !validateEmail(email)) {
                    e.preventDefault();
                    showToast('Email already exists with Active status. Please use a different email address.', 'danger');
                    form.find('.email-input').focus();
                    return false;
                }
            });

            // Show success message if present
            <c:if test="${not empty success}">
                showToast('${success}', 'success');
            </c:if>

            // Show error message if present
            <c:if test="${not empty error}">
                showToast('${error}', 'danger');
            </c:if>

            // Add animation to modals when they are shown
            $('.modal').on('show.bs.modal', function() {
                $(this).find('.modal-content').addClass('animate__animated animate__fadeInDown');
            });

            // Remove animation classes when modal is closed
            $('.modal').on('hidden.bs.modal', function() {
                $(this).find('.modal-content').removeClass('animate__animated animate__fadeInDown');
            });
        });

        // Toast notification function
        function showToast(message, type) {
            const toast = $('#toastNotification');
            const alert = toast.find('.alert');

            alert.removeClass('alert-success alert-danger alert-warning alert-info');
            alert.addClass('alert-' + type);
            $('#toastMessage').text(message);
            toast.addClass('show');

            setTimeout(function() {
                toast.removeClass('show');
            }, 5000);
        }
    </script>
</body>
</html>
