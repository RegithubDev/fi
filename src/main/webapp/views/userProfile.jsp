<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="en">
<head>
    <title>User Management</title>
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

        /* Custom switch styling */
        .switch-container {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 24px;
            margin-right: 10px;
        }

        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 24px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .slider {
            background-color: var(--primary-color);
        }

        input:checked + .slider:before {
            transform: translateX(26px);
        }

        /* Multiple select styling */
        .multiple-select {
            display: none;
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
        
        /* Role-based controls */
        .role-based-control {
            display: none;
        }
        
        /* Email validation */
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
                <a href="<%=request.getContextPath()%>/fi-d26827851841284wjvwunfuqwhfbwqr7212hfu"
                   class="btn btn-dark btn-lg back-btn animate-fade-in">
                    <i class="fas fa-arrow-left me-2"></i>Back
                </a>
            </div>
            <div>
                <a href="<%=request.getContextPath()%>/logout"
                   class="btn btn-outline-dark btn-lg logout-btn animate-fade-in">
                    <i class="fas fa-sign-out-alt me-2"></i>Logout
                </a>
            </div>
        </div>

        <div class="header-bar animate-fade-in">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h2 class="mb-1"><i class="fas fa-users me-2"></i>User Management</h2>
                    <p class="mb-0">Manage system users and their permissions</p>
                </div>
                <button class="btn btn-light btn-add-user" data-bs-toggle="modal" data-bs-target="#addUserModal">
                    <i class="fas fa-plus me-2"></i>Add User
                </button>
            </div>
        </div>

        <div class="card animate-fade-in">
            <div class="card-header">
                <i class="fas fa-list me-2"></i>User List
            </div>
            <div class="card-body">
                <div class="table-responsive">
                  <table id="usersTable" class="table table-hover table-striped">
    <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Username</th> <!-- ✅ New column -->
            <th>Email</th>
            <th>Profit Center</th>
            <th>Role</th>
            <th>Created On</th>
            <th>Modified On</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${usersList}" var="user" varStatus="row">
            <tr>
                <td>${fn:length(usersList) - row.index}</td>

                <!-- ✅ Username field added -->
                <td>${user.user_name}</td>

                <td><span class="badge bg-info user-email">${user.email_id}</span></td>
                <td>
                    <c:set var="codes" value="${fn:split(user.profit_center_code, ',')}" />
                    <c:set var="unique" value="" />
                    <c:forEach var="code" items="${codes}">
                        <c:if test="${not fn:contains(unique, code)}">
                            <c:out value="${code}" />
                            <c:set var="unique" value="${unique},${code}" />
                            <br/>
                        </c:if>
                    </c:forEach>
                </td>
                <td>${user.role}</td>
                <td>${user.created_on}</td>
                <td>${user.modified_on}</td>
                <td>
                    <span class="status-badge ${user.status == 'Active' ? 'status-active' : 'status-inactive'}">
                        ${user.status}
                    </span>
                </td>
                <td>
                 
                     <button class="btn btn-sm btn-primary action-btn me-1"
        data-bs-toggle="modal"
        data-bs-target="#editUserModal${user.id}">
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

    <!-- Add User Modal -->
<!-- Add User Modal -->
            <div class="modal fade" id="addUserModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form action="<%=request.getContextPath()%>/addUser" method="post" id="addUserForm">
                    <div class="modal-header bg-primary text-white">               
    <h5 class="modal-title"><i class="fas fa-user-plus me-2"></i>Add New User</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                <div class="modal-body">
                    <!-- Row 1 -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">User ID</label>
                            <input type="text" class="form-control" name="user_id" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">User Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="user_name" required>
                        </div>
                    </div>

                    <!-- Row 2 -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" name="email_id" id="addEmail" required>
                            <div class="email-validation" id="addEmailValidation"></div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Role</label>
                            <select class="form-select role-select" name="role" required>
                                <option value="">Select Role</option>
                                <option value="Admin">Admin</option>
                                <option value="User">User</option>
                                <option value="Management">Management</option>
                                <option value="SA">Super Admin</option>
                            </select>
                            <!-- Toggle switch below Role for Management -->
                            <div class="switch-container mt-2 management-controls" style="display: none;">
                                <label class="me-2 mb-0">Multiple Profit Centers</label>
                                <label class="switch mb-0">
                                    <input type="checkbox" id="multipleProfitCenterToggle">
                                    <span class="slider"></span>
                                </label>
                            </div>
                        </div>
                    </div>

                    <!-- Row 3: Status + Profit Center Code (side by side) -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Status</label>
                            <select class="form-select" name="status" required>
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="profit-center-container">
                                <div class="standard-profit-center">
                                    <label class="form-label">Profit Center Code</label>
                                    <select class="form-select searchable-select" name="profit_center_code_standard" style="width: 100%;">
                                        <option value="">Select Profit Center</option>
                                        <c:forEach items="${profitCenterList}" var="profitCenter">
                                            <option value="${profitCenter.profit_center_code}">
                                                ${profitCenter.profit_center_code} - ${profitCenter.profit_center_name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="multiple-profit-center" style="display: none;">
                                    <label class="form-label">Select Profit Centers</label>
                                    <select class="form-select searchable-select" name="profit_center_codes" multiple="multiple" style="width: 100%;">
                                        <c:forEach items="${profitCenterList}" var="profitCenter">
                                            <option value="${profitCenter.profit_center_code}">
                                                ${profitCenter.profit_center_code} - ${profitCenter.profit_center_name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer submit-buttons">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary" id="addUserBtn">Add User</button>
                </div>
            </form>
        </div>
    </div>
</div>

  
<!-- Edit User Modals -->
<!-- Edit User Modals -->
<c:forEach items="${usersList}" var="user">
    <c:set var="isManagement" value="${user.role == 'Management'}" />
    <c:set var="hasMultiple" value="${fn:contains(user.profit_center_code, ',')}" />
    <c:set var="originalStandardPC" value="${user.profit_center_code}" />
    <c:set var="originalSinglePC" value="${hasMultiple ? '' : user.profit_center_code}" />
    <c:set var="originalMultiPCs" value="${hasMultiple ? user.profit_center_code : ''}" />

    <div class="modal fade" id="editUserModal${user.id}" tabindex="-1" aria-labelledby="editUserModalLabel${user.id}" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <form action="<%=request.getContextPath()%>/updateUser" method="post" class="editUserForm" data-original-email="${user.email_id}">

                    <!-- Modal Header -->
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title" id="editUserModalLabel${user.id}">
                            <i class="fas fa-user-edit me-2"></i>Edit User
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <!-- Modal Body -->
                    <div class="modal-body">
                        <input type="hidden" name="id" value="${user.id}">

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">User ID</label>
                                <input type="text" class="form-control" name="user_id" value="${user.user_id}" readonly>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">User Name</label>
                                <input type="text" class="form-control" name="user_name" value="${user.user_name}" required>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control email-input" name="email_id" value="${user.email_id}" required>
                                <div class="email-validation email-validation-${user.id}"></div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Role</label>
                                <select class="form-select role-select" name="role" data-original-role="${user.role}" required>
                                    <option value="Admin" ${user.role == 'Admin' ? 'selected' : ''}>Admin</option>
                                    <option value="User" ${user.role == 'User' ? 'selected' : ''}>User</option>
                                    <option value="Management" ${user.role == 'Management' ? 'selected' : ''}>Management</option>
                                    <option value="SA" ${user.role == 'SA' ? 'selected' : ''}>Super Admin</option>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Status</label>
                                <select class="form-select" name="status" required>
                                    <option value="Active" ${user.status == 'Active' ? 'selected' : ''}>Active</option>
                                    <option value="Inactive" ${user.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <!-- Management controls -->
                                <div class="role-based-control management-controls" style="${isManagement ? 'display:block' : 'display:none'}">
                                    <div class="switch-container mb-2">
                                        <label class="switch">
                                            <input type="checkbox" class="multipleProfitCenterToggleEdit" ${hasMultiple ? 'checked' : ''} data-original-multiple="${hasMultiple}">
                                            <span class="slider"></span>
                                        </label>
                                        <span>Multiple Profit Centers</span>
                                    </div>
                                    <div class="mb-3 singleProfitCenterEdit" style="${hasMultiple ? 'display:none' : 'display:block'}">
                                        <label class="form-label">Profit Center Code</label>
                                        <select class="form-select searchable-select" name="profit_center_code" style="width:100%;" data-original-value="${originalSinglePC}">
                                            <option value="">Select Profit Center</option>
                                            <c:forEach items="${profitCenterList}" var="pc">
                                                <option value="${pc.profit_center_code}" ${user.profit_center_code == pc.profit_center_code ? 'selected' : ''}>
                                                    ${pc.profit_center_code} - ${pc.profit_center_name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="mb-3 multipleProfitCenterEdit" style="${hasMultiple ? 'display:block' : 'display:none'}">
                                        <label class="form-label">Select Profit Centers</label>
                                        <select class="form-select searchable-select" name="profit_center_codes" multiple="multiple" style="width:100%;" data-original-values="${originalMultiPCs}">
                                            <c:forEach items="${profitCenterList}" var="pc">
                                                <c:set var="sel" value="${fn:contains(user.profit_center_code, pc.profit_center_code)}" />
                                                <option value="${pc.profit_center_code}" ${sel ? 'selected' : ''}>
                                                    ${pc.profit_center_code} - ${pc.profit_center_name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <!-- Standard profit center for non-Management -->
                                <div class="mb-3 standard-profit-center" style="${isManagement ? 'display:none' : 'display:block'}">
                                    <label class="form-label">Profit Center Code</label>
                                    <select class="form-select searchable-select" name="profit_center_code_standard" style="width:100%;" data-original-value="${originalStandardPC}">
                                        <option value="">Select Profit Center</option>
                                        <c:forEach items="${profitCenterList}" var="pc">
                                            <option value="${pc.profit_center_code}" ${user.profit_center_code == pc.profit_center_code ? 'selected' : ''}>
                                                ${pc.profit_center_code} - ${pc.profit_center_name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Modal Footer -->
                    <div class="modal-footer submit-buttons">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary update-user-btn" data-user-id="${user.id}">Save Changes</button>
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
    const existingUsers = [];
    $('#usersTable tbody tr').each(function() {
        const email = $(this).find('.user-email').text().trim();
        const status = $(this).find('.status-badge').text().trim();
        existingUsers.push({ email, status });
    });
    
    console.log('Existing users:', existingUsers); // For debugging
    
    // Initialize DataTable
    $('#usersTable').DataTable({
        responsive: true,
        order: [[0, 'desc']],
        pageLength: 25,
        language: {
            search: "",
            searchPlaceholder: "Search users...",
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
    $('#addUserModal').on('shown.bs.modal', function () {
        initSelect2($(this));
        $('#addEmailValidation').hide().removeClass('email-valid email-invalid');
        $('#addUserBtn').prop('disabled', false);
        $('.submit-buttons').removeClass('buttons-disabled');
    });
    
    // Reset Add User Modal on close
    $('#addUserModal').on('hidden.bs.modal', function () {
        console.log('Add User Modal Reset'); // For debugging
        const $form = $('#addUserForm');
        
        // Reset the form fields
        $form[0].reset();
        
        // Reset Select2 dropdowns
        $form.find('.searchable-select').each(function() {
            $(this).val(null).trigger('change');
        });
        
        // Reset the multiple profit center toggle
        $('#multipleProfitCenterToggle').prop('checked', false).trigger('change');
        
        // Reset visibility of profit center sections
        $form.find('.management-controls').hide();
        $form.find('.standard-profit-center').show();
        $form.find('.multiple-profit-center').hide();
        
        // Clear email validation message
        $('#addEmailValidation').hide().removeClass('email-valid email-invalid').html('');
        
        // Enable submit button
        $('#addUserBtn').prop('disabled', false);
        $form.find('.submit-buttons').removeClass('buttons-disabled');
    });
    
    $('[id^="editUserModal"]').on('shown.bs.modal', function () {
        initSelect2($(this));
        const userId = $(this).attr('id').replace('editUserModal', '');
        $(`.email-validation-${userId}`).hide().removeClass('email-valid email-invalid');
        $(`button[data-user-id="${userId}"]`).prop('disabled', false);
        $(this).find('.submit-buttons').removeClass('buttons-disabled');
    });
    
    // Email validation function
    function validateEmail(email, originalEmail = null) {
        const existingUser = existingUsers.find(user => user.email === email);
        
        if (originalEmail && email === originalEmail) return true;
        if (!existingUser) return true;
        if (existingUser.status !== 'Active') return true;
        return false;
    }
    
    // Real-time email validation for Add User
    $('#addEmail').on('input', function() {
        const email = $(this).val().trim();
        const validationElement = $('#addEmailValidation');
        
        if (email === '') {
            validationElement.hide();
            $('#addUserBtn').prop('disabled', false);
            $('.submit-buttons').removeClass('buttons-disabled');
            return;
        }
        
        const isValid = validateEmail(email);
        
        if (isValid) {
            validationElement.html('<i class="fas fa-check-circle"></i> Email is available')
                .removeClass('email-invalid')
                .addClass('email-valid')
                .show();
            $('#addUserBtn').prop('disabled', false);
            $('.submit-buttons').removeClass('buttons-disabled');
        } else {
            validationElement.html('<i class="fas fa-exclamation-circle"></i> Email already exists with Active status')
                .removeClass('email-valid')
                .addClass('email-invalid')
                .show();
            $('#addUserBtn').prop('disabled', true);
            $('.submit-buttons').addClass('buttons-disabled');
        }
    });
    
    // Real-time email validation for Edit User forms
    $(document).on('input', '.email-input', function() {
        const email = $(this).val().trim();
        const form = $(this).closest('.editUserForm');
        const originalEmail = form.data('original-email');
        const userId = form.find('.update-user-btn').data('user-id');
        const validationElement = $(`.email-validation-${userId}`);
        const submitBtn = form.find('.update-user-btn');
        
        if (email === '') {
            validationElement.hide();
            submitBtn.prop('disabled', false);
            form.find('.submit-buttons').removeClass('buttons-disabled');
            return;
        }
        
        const isValid = validateEmail(email, originalEmail);
        
        if (isValid) {
            validationElement.html('<i class="fas fa-check-circle"></i> Email is available')
                .removeClass('email-invalid')
                .addClass('email-valid')
                .show();
            submitBtn.prop('disabled', false);
            form.find('.submit-buttons').removeClass('buttons-disabled');
        } else {
            validationElement.html('<i class="fas fa-exclamation-circle"></i> Email already exists with Active status')
                .removeClass('email-valid')
                .addClass('email-invalid')
                .show();
            submitBtn.prop('disabled', true);
            form.find('.submit-buttons').addClass('buttons-disabled');
        }
    });

    // Role selection handler for Add User form
    $('#addUserModal .role-select').change(function() {
        const role = $(this).val();
        const $modal = $('#addUserModal');
        const $managementControls = $modal.find('.management-controls');
        const $profitCenterContainer = $modal.find('.profit-center-container');

        if (role === 'Management') {
            $managementControls.slideDown(300);
            $profitCenterContainer.find('.standard-profit-center').slideDown(300);
            $profitCenterContainer.find('.multiple-profit-center').slideUp(300);
            $('#multipleProfitCenterToggle').prop('checked', false);
        } else {
            $managementControls.slideUp(300);
            $profitCenterContainer.find('.standard-profit-center').slideDown(300);
            $profitCenterContainer.find('.multiple-profit-center').slideUp(300);
        }
    });

    // Toggle between single and multiple profit centers for Add User
    $('#multipleProfitCenterToggle').change(function() {
        const $modal = $('#addUserModal');
        if ($(this).is(':checked')) {
            $modal.find('.standard-profit-center').slideUp(300);
            $modal.find('.multiple-profit-center').slideDown(300);
        } else {
            $modal.find('.multiple-profit-center').slideUp(300);
            $modal.find('.standard-profit-center').slideDown(300);
        }
    });

    // Role selection handler for Edit User forms
    $(document).on('change', '.editUserForm .role-select', function() {
        const role = $(this).val();
        const $form = $(this).closest('.editUserForm');
        const $managementControls = $form.find('.management-controls');
        const $standardProfitCenter = $form.find('.standard-profit-center');

        if (role === 'Management') {
            $managementControls.slideDown(300);
            $standardProfitCenter.slideUp(300);

            // Show appropriate profit center section based on current toggle state
            const $toggle = $managementControls.find('.multipleProfitCenterToggleEdit');
            if ($toggle.is(':checked')) {
                $managementControls.find('.singleProfitCenterEdit').slideUp(300);
                $managementControls.find('.multipleProfitCenterEdit').slideDown(300);
            } else {
                $managementControls.find('.singleProfitCenterEdit').slideDown(300);
                $managementControls.find('.multipleProfitCenterEdit').slideUp(300);
            }
        } else {
            $managementControls.slideUp(300);
            $standardProfitCenter.slideDown(300);
        }
    });

    // Toggle for Edit User modals
    $(document).on('change', '.multipleProfitCenterToggleEdit', function() {
        const $managementControls = $(this).closest('.management-controls');
        if ($(this).is(':checked')) {
            $managementControls.find('.singleProfitCenterEdit').slideUp(300);
            $managementControls.find('.multipleProfitCenterEdit').slideDown(300);
        } else {
            $managementControls.find('.multipleProfitCenterEdit').slideUp(300);
            $managementControls.find('.singleProfitCenterEdit').slideDown(300);
        }
    });
    
    // Add User Form submission
    $('#addUserForm').submit(function(e) {
        const email = $('#addEmail').val().trim();
        
        if (!validateEmail(email)) {
            e.preventDefault();
            showToast('Email already exists with Active status. Please use a different email address.', 'danger');
            $('#addEmail').focus();
            return false;
        }
        
        const role = $('#addUserForm .role-select').val();
        
        if (role === 'Management') {
            if ($('#multipleProfitCenterToggle').is(':checked')) {
                const selected = $('select[name="profit_center_codes"]').val();
                if (!selected || selected.length === 0) {
                    showToast('Please select at least one profit center', 'danger');
                    e.preventDefault();
                    return;
                }
                $('<input>').attr({
                    type: 'hidden',
                    name: 'profit_center_code',
                    value: selected.join(',')
                }).appendTo('#addUserForm');
            } else {
                const selected = $('select[name="profit_center_code_standard"]').val();
                if (!selected) {
                    showToast('Please select a profit center', 'danger');
                    e.preventDefault();
                    return;
                }
                $('<input>').attr({
                    type: 'hidden',
                    name: 'profit_center_code',
                    value: selected
                }).appendTo('#addUserForm');
            }
        } else {
            const selected = $('select[name="profit_center_code_standard"]').val();
            if (!selected) {
                showToast('Please select a profit center', 'danger');
                e.preventDefault();
                return;
            }
            $('<input>').attr({
                type: 'hidden',
                name: 'profit_center_code',
                value: selected
            }).appendTo('#addUserForm');
        }
    });
    
    // Handle edit form submissions
    $('.editUserForm').submit(function(e) {
        const form = $(this);
        const email = form.find('.email-input').val().trim();
        const originalEmail = form.data('original-email');
        
        if (email !== originalEmail && !validateEmail(email)) {
            e.preventDefault();
            showToast('Email already exists with Active status. Please use a different email address.', 'danger');
            form.find('.email-input').focus();
            return false;
        }
        
        const role = form.find('.role-select').val();
        
        if (role === 'Management') {
            const isMultiple = form.find('.multipleProfitCenterToggleEdit').is(':checked');
            
            if (isMultiple) {
                const selected = form.find('select[name="profit_center_codes"]').val();
                if (!selected || selected.length === 0) {
                    showToast('Please select at least one profit center', 'danger');
                    e.preventDefault();
                    return;
                }
                $('<input>').attr({
                    type: 'hidden',
                    name: 'profit_center_code',
                    value: selected.join(',')
                }).appendTo(form);
            } else {
                const selected = form.find('.singleProfitCenterEdit select').val();
                if (!selected) {
                    showToast('Please select a profit center', 'danger');
                    e.preventDefault();
                    return;
                }
                $('<input>').attr({
                    type: 'hidden',
                    name: 'profit_center_code',
                    value: selected
                }).appendTo(form);
            }
        } else {
            const selected = form.find('.standard-profit-center select').val();
            if (!selected) {
                showToast('Please select a profit center', 'danger');
                e.preventDefault();
                return;
            }
            $('<input>').attr({
                type: 'hidden',
                name: 'profit_center_code',
                value: selected
            }).appendTo(form);
        }
    });
    
    // Show success/error messages from backend
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

    // Reset edit modal fields to original values
    $('[id^="editUserModal"]').on('hidden.bs.modal', function () {
        const formEl = $(this).find('form')[0];
        const $form = $(this).find('form');
        if (formEl) formEl.reset();

        $form.find('.searchable-select').each(function() {
            const originalValue = $(this).attr('data-original-value');
            const originalValues = $(this).attr('data-original-values');
            if ($(this).attr('multiple')) {
                if (originalValues) {
                    $(this).val(originalValues.split(',')).trigger('change');
                } else {
                    $(this).val([]).trigger('change');
                }
            } else {
                $(this).val(originalValue || '').trigger('change');
            }
        });

        const originalEmail = $form.data('original-email');
        $form.find('.email-input').val(originalEmail);

        $form.find('.role-select').each(function() {
            const originalRole = $(this).data('original-role');
            $(this).val(originalRole).trigger('change');
        });

        $form.find('.multipleProfitCenterToggleEdit').each(function() {
            const wasChecked = $(this).data('original-multiple');
            $(this).prop('checked', wasChecked === true || wasChecked === 'true').trigger('change');
        });

        $form.find('[class^="email-validation-"]').hide().removeClass('email-valid email-invalid').html('');
    });

}); // end document.ready

// Toast notification
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