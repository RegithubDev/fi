<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="en">
<head>
    <title>Profit Center Management</title>
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

        /* Select2 Customization */
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

        /* Modal animations */
        .modal.fade .modal-dialog {
            transform: translate(0, -50px);
            transition: transform 0.3s ease-out;
        }

        .modal.show .modal-dialog {
            transform: translate(0, 0);
        }

        /* Button animations */
        .btn {
            transition: all 0.3s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        /* Table row animations */
        tr {
            transition: all 0.3s ease;
        }

        tr:hover {
            background-color: rgba(79, 124, 130, 0.05) !important;
        }

        /* Custom animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .animate-fade-in {
            animation: fadeIn 0.6s ease forwards;
        }

        /* Toast notification */
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
                <a href="<%=request.getContextPath()%>/fi-d26827851841284wjvwunfuqwhfbwqr7212hfu" class="btn btn-dark btn-lg back-btn animate-fade-in">
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
                    <h2 class="mb-1"><i class="fas fa-chart-pie me-2"></i>Profit Center Management</h2>
                    <p class="mb-0">Manage profit centers and their details</p>
                </div>
                <button class="btn btn-light btn-add-pc" data-bs-toggle="modal" data-bs-target="#addProfitCenterModal">
                    <i class="fas fa-plus me-2"></i>Add Profit Center
                </button>
            </div>
        </div>

        <div class="card animate-fade-in">
            <div class="card-header">
                <i class="fas fa-list me-2"></i>Profit Center List
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="profitcentersTable" class="table table-hover table-striped">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Entity Code</th>                              
                                <th>Profit Center Code</th>
                                <th>Profit Center Name</th>
                                <th>SBU</th>
                                <th>Created On</th>
                                <th>Modified On</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${pcList}" var="pc" varStatus="row">
                                <tr>
                                    <td>${fn:length(pcList) - row.index}</td>
                                    <td>${pc.entity_code}</td>                                      
                                    <td>${pc.profit_center_code}</td>
                                    <td>${pc.profit_center_name}</td>
                                    <td>${pc.sbu}</td>
                                    <td>${pc.created_on}</td>
                                    <td>${pc.modified_on}</td>
                                    <td>
                                        <span class="status-badge ${pc.status == 'Active' ? 'status-active' : 'status-inactive'}">
                                            ${pc.status}
                                        </span>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-primary action-btn me-1"
        data-bs-toggle="modal"
        data-bs-target="#editProfitCenterModal${pc.id}">
    <i class="fas fa-edit"></i>
</button>
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
    <div class="modal fade" id="addProfitCenterModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form action="<%=request.getContextPath()%>/addpc" method="post" id="addProfitCenterForm">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title"><i class="fas fa-plus me-2"></i>Add New Profit Center</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Entity Code <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="entity_code" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Profit Center Code <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="profit_center_code" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Profit Center Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="profit_center_name" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">SBU <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="sbu" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Status <span class="text-danger">*</span></label>
                                <select class="form-select" name="status" required>
                                    <option value="Active">Active</option>
                                    <option value="Inactive">Inactive</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add Profit Center</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Profit Center Modals -->
    <c:forEach items="${pcList}" var="pc">
        <div class="modal fade" id="editProfitCenterModal${pc.id}" tabindex="-1" aria-labelledby="editProfitCenterModalLabel${pc.id}" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <form action="<%=request.getContextPath()%>/updatepc" method="post">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title" id="editProfitCenterModalLabel${pc.id}">
                                <i class="fas fa-edit me-2"></i>Edit Profit Center
                            </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                        
                            <input type="hidden" name="id" value="${pc.id}">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Entity Code <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="entity_code" value="${pc.entity_code}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Profit Center Code <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="profit_center_code" value="${pc.profit_center_code}" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Profit Center Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="profit_center_name" value="${pc.profit_center_name}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">SBU <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="sbu" value="${pc.sbu}" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Status <span class="text-danger">*</span></label>
                                    <select class="form-select" name="status" required>
                                        <option value="Active" ${pc.status == 'Active' ? 'selected' : ''}>Active</option>
                                        <option value="Inactive" ${pc.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
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
        // Initialize DataTable
        $('#profitcentersTable').DataTable({
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

        // Show success/error messages from backend (assuming you set these in request attributes)
        <c:if test="${not empty successMessage}">
            showToast('${successMessage}', 'success');
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            showToast('${errorMessage}', 'danger');
        </c:if>
        
        // Modal animations
        $('.modal').on('show.bs.modal', function() {
            $(this).find('.modal-content').addClass('animate__animated animate__fadeInDown');
        });
        
        $('.modal').on('hidden.bs.modal', function() {
            $(this).find('.modal-content').removeClass('animate__animated animate__fadeInDown');
        });

        // Form submissions can be handled here if needed, but basic form post should work
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