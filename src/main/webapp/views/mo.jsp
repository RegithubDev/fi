<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="com.resustainability.reisp.constants.CommonConstants"%>
<!DOCTYPE html>
<html>
<head>
    <title>Inventory Compliance Dashboard</title>
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
            --primary-blue: #0d47a1;
            --secondary-blue: #1565c0;
            --accent-color: #ffc107;
            --success-color: #198754;
            --danger-color: #dc3545;
            --warning-color: #ffc107;
            --card-bg: #ffffff;
            --text-color: #212529;
            --text-muted: #6c757d;
            --header-bg: #ffffff;
            --body-bg: #f8f9fa;
            --border-color: #dee2e6;
            --shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }

        body {
            background-color: var(--body-bg);
            font-family: 'Roboto', sans-serif;
            color: var(--text-color);
            min-height: 100vh;
        }

        /* Header Styling */
        .header-bar {
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            color: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow);
        }

        .header-bar h2 {
            font-weight: 600;
            margin: 0;
        }

        /* Card Styling */
        .card {
            background: var(--card-bg);
            border: none;
            border-radius: 12px;
            box-shadow: var(--shadow);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        /* Button Styling */
        .btn {
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--secondary-blue), var(--primary-blue));
            border: none;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(13, 71, 161, 0.3);
        }

        .btn-success {
            background: linear-gradient(135deg, var(--success-color), #157347);
            border: none;
        }

        .btn-warning {
            background: linear-gradient(135deg, var(--warning-color), #ffb300);
            border: none;
            color: #000;
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--danger-color), #b02a37);
            border: none;
        }

        /* Status Badges */
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-yes {
            background-color: rgba(25, 135, 84, 0.1);
            color: var(--success-color);
            border: 1px solid var(--success-color);
        }

        .status-no {
            background-color: rgba(220, 53, 69, 0.1);
            color: var(--danger-color);
            border: 1px solid var(--danger-color);
        }

        /* Table Styling */
        #inventoryTable thead th {
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            color: white;
            font-weight: 500;
            border: none;
            padding: 1rem;
        }

        #inventoryTable tbody tr {
            transition: background-color 0.2s ease;
        }

        #inventoryTable tbody tr:hover {
            background-color: rgba(13, 71, 161, 0.05);
        }

        /* Filter Section */
        .filter-card {
            background: var(--card-bg);
            border-radius: 12px;
            box-shadow: var(--shadow);
        }

        /* Action Buttons */
        .action-btn {
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .trigger-btn {
            background: linear-gradient(135deg, #6f42c1, #8b5cf6);
            color: white;
            border: none;
        }

        .trigger-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(111, 66, 193, 0.3);
        }

        .trigger-all-btn {
            background: linear-gradient(135deg, #059669, #10b981);
            color: white;
            border: none;
        }

        .trigger-all-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(5, 150, 105, 0.3);
        }

        /* Back and Logout Buttons */
        .back-btn, .logout-btn {
            border-radius: 8px;
            padding: 8px 16px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .back-btn {
            background: transparent;
            border: 2px solid var(--text-muted);
            color: var(--text-muted);
        }

        .back-btn:hover {
            background: var(--text-muted);
            color: white;
        }

        .logout-btn {
            background: transparent;
            border: 2px solid var(--danger-color);
            color: var(--danger-color);
        }

        .logout-btn:hover {
            background: var(--danger-color);
            color: white;
        }

        /* Custom SweetAlert */
        .swal2-popup {
            border-radius: 12px !important;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .header-bar {
                text-align: center;
                padding: 1rem;
            }
            
            .header-bar .btn {
                margin-top: 1rem;
            }
            
            .card-body {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>

<div class="container-fluid py-4">
    <!-- Navigation Buttons -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <a href="<%=request.getContextPath()%>/dashboard" class="btn back-btn">
                    <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                </a>
                <a href="<%=request.getContextPath()%>/logout" class="btn logout-btn">
                    <i class="fas fa-sign-out-alt me-2"></i>Logout
                </a>
            </div>
        </div>
    </div>

    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="header-bar">
                <div class="d-flex justify-content-between align-items-center">
                    <h2><i class="fas fa-clipboard-check me-3"></i>Inventory Compliance Dashboard</h2>
                    <button class="btn btn-warning" id="triggerAllBtn">
                        <i class="fas fa-paper-plane me-2"></i>Trigger All Alerts
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Filter Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title mb-4 fw-bold text-primary">
                        <i class="fas fa-filter me-2"></i>Filter Records
                    </h5>
                    <div class="row g-3 align-items-end">
                        <div class="col-md-4">
                            <label for="profitCenterFilter" class="form-label fw-semibold">Profit Center</label>
                            <select class="form-select select2" id="profitCenterFilter" data-placeholder="Select Profit Center">
                                <option value="">All Profit Centers</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="monthYearFilter" class="form-label fw-semibold">Month-Year</label>
                            <select class="form-select select2" id="monthYearFilter" data-placeholder="Select Period">
                                <option value="">All Periods</option>
                            </select>
                        </div>
                         <div class="col-md-12 mt-3">
                            <div class="d-flex gap-2">
                                <button class="btn btn-primary" id="applyFilters">
                                    <i class="fas fa-search me-2"></i>Apply Filters
                                </button>
                                <button class="btn btn-outline-secondary" id="clearFilters">
                                    <i class="fas fa-times me-2"></i>Clear Filters
                                </button>
                            </div>
                        </div>
                      <!--   <div class="col-md-4">
                            <label for="resultFilter" class="form-label fw-semibold">Compliance Status</label>
                            <select class="form-select" id="resultFilter">
                                <option value="">All Status</option>
                                <option value="Yes">Compliant</option>
                                <option value="No">Non-Compliant</option>
                            </select>
                        </div> -->
                       
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Table -->
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="inventoryTable" class="table table-hover align-middle" style="width:100%;">
                            <thead>
                                <tr>
                                    <th><i class="fas fa-building me-2"></i>Profit Center</th>
                                    <th><i class="fas fa-calendar-alt me-2"></i>Period</th>
                                    <th><i class="fas fa-user me-2"></i>User ID</th>
                                    <th><i class="fas fa-envelope me-2"></i>Email</th>
                                    <th><i class="fas fa-check-circle me-2"></i>Compliance Status</th>
                                    <th class="text-center"><i class="fas fa-bolt me-2"></i>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${inventoryList}" var="item" varStatus="status">
                                    <tr>
                                        <td data-label="Profit Center">
                                            <div class="fw-bold text-primary">${item.profit_center_code}</div>
                                            <div class="small text-muted">${item.profit_center_name}</div>
                                        </td>
                                        <td data-label="Period" class="fw-semibold">${item.month_year}</td>
                                        <td data-label="User ID" class="text-muted">${item.user_id}</td>
                                        <td data-label="Email">
                                            <a href="mailto:${item.email_id}" class="text-decoration-none">
                                                <i class="fas fa-envelope me-1"></i>${item.email_id}
                                            </a>
                                        </td>
                                        <td data-label="Status">
                                            <span class="status-badge ${item.result == 'Yes' ? 'status-yes' : 'status-no'}">
                                                <i class="fas ${item.result == 'Yes' ? 'fa-check' : 'fa-times'} me-1"></i>
                                                ${item.result}
                                            </span>
                                        </td>
                                        <td class="text-center" data-label="Actions">
                                            <div class="d-flex justify-content-center gap-2">
                                                <button class="btn trigger-btn action-btn trigger-single-btn" 
                                                        data-email="${item.email_id}"
                                                        data-profit-center="${item.profit_center_code}"
                                                        data-month-year="${item.month_year}"
                                                        data-user-id="${item.user_id}">
                                                    <i class="fas fa-paper-plane me-1"></i>Trigger Alert
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
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
    // Initialize DataTable
    var table = $('#inventoryTable').DataTable({
        "responsive": true,
        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
        "pageLength": 10,
        "language": {
            "search": "",
            "searchPlaceholder": "Search records...",
            "lengthMenu": "Show _MENU_ entries",
            "info": "Showing _START_ to _END_ of _TOTAL_ entries",
            "infoEmpty": "Showing 0 to 0 of 0 entries",
            "infoFiltered": "(filtered from _MAX_ total entries)"
        },
        "dom": "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
               "<'row'<'col-sm-12'tr>>" +
               "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
        "buttons": [
            {
                extend: 'excelHtml5',
                text: '<i class="fas fa-file-excel me-2"></i>Export Excel',
                className: 'btn btn-success btn-sm',
                exportOptions: {
                    columns: [0, 1, 2, 3, 4]
                }
            },
            {
                extend: 'print',
                text: '<i class="fas fa-print me-2"></i>Print',
                className: 'btn btn-primary btn-sm',
                exportOptions: {
                    columns: [0, 1, 2, 3, 4]
                }
            }
        ],
        "initComplete": function(settings, json) {
            // Initialize Select2
            $('.select2').select2({
                theme: 'bootstrap-5',
                width: '100%'
            });
            
            // Populate filters
            populateFilters();
            
            // Add buttons container
            this.api().buttons().container().appendTo('#inventoryTable_wrapper .col-md-6:eq(0)');
        }
    });

    // Populate filter dropdowns
   function populateFilters() {
    // Get the DataTable instance safely
    var tableInstance = $('#inventoryTable').DataTable();
    
    if (!tableInstance || typeof tableInstance.rows !== 'function') {
        console.error('DataTable not initialized properly');
        setTimeout(populateFilters, 100); // Retry after delay
        return;
    }
    
    // Clear existing options
    $('#profitCenterFilter').find('option:not(:first)').remove();
    $('#monthYearFilter').find('option:not(:first)').remove();

    // Get unique values using DataTable API
    try {
        // Profit Centers from first column
        var pcValues = tableInstance.column(0).data().unique().toArray();
        var periodValues = tableInstance.column(1).data().unique().toArray();

        // Process Profit Centers
        var profitCenters = new Map();
        pcValues.forEach(function(value) {
            if (value) {
                var $cell = $('<div>').html(value);
                var code = $cell.find('.fw-bold').text().trim() || String(value);
                var name = $cell.find('.small').text().trim();
                
                if (code && !profitCenters.has(code)) {
                    profitCenters.set(code, name);
                }
            }
        });

        // Populate Profit Centers
        Array.from(profitCenters.entries())
            .sort((a, b) => (a[1] || a[0]).localeCompare(b[1] || b[0]))
            .forEach(function([code, name]) {
                $('#profitCenterFilter').append(
                    $('<option>', { 
                        value: code, 
                        text: name ? (code + ' - ' + name) : code 
                    })
                );
            });

        // Populate Periods
        periodValues
            .filter(period => period && typeof period === 'string')
            .sort()
            .reverse()
            .forEach(function(period) {
                $('#monthYearFilter').append(
                    $('<option>', { value: period, text: period })
                );
            });

        // Refresh Select2
        $('#profitCenterFilter, #monthYearFilter').trigger('change');
        
    } catch (error) {
        console.error('Error populating filters:', error);
    }
}

    // Apply Filters
    $('#applyFilters').on('click', function() {
        var pcFilter = $('#profitCenterFilter').val();
        var myFilter = $('#monthYearFilter').val();
        var resultFilter = $('#resultFilter').val();

        table.column(0).search(pcFilter || '');
        table.column(1).search(myFilter || '');
        table.column(4).search(resultFilter || '');
        
        table.draw();
    });

    // Clear Filters
    $('#clearFilters').on('click', function() {
        $('#profitCenterFilter, #monthYearFilter, #resultFilter').val('').trigger('change');
        table.search('').columns().search('').draw();
    });

    // Single Trigger Alert
    $(document).on('click', '.trigger-single-btn', function() {
        var email = $(this).data('email');
        var profitCenter = $(this).data('profit-center');
        var monthYear = $(this).data('month-year');
        var userId = $(this).data('user-id');

        Swal.fire({
            title: 'Trigger Alert',
            html: `
                <div class="text-start">
                    <p><strong>Recipient:</strong> ${email}</p>
                    <p><strong>Profit Center:</strong> ${profitCenter}</p>
                    <p><strong>Period:</strong> ${monthYear}</p>
                    <p><strong>User ID:</strong> ${userId}</p>
                    <div class="mb-3">
                        <label for="alertMessage" class="form-label fw-semibold">Custom Message (Optional):</label>
                        <textarea id="alertMessage" class="form-control" rows="3" placeholder="Add a custom message..."></textarea>
                    </div>
                </div>
            `,
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#6f42c1',
            cancelButtonColor: '#6c757d',
            confirmButtonText: '<i class="fas fa-paper-plane me-2"></i>Send Alert',
            cancelButtonText: 'Cancel',
            preConfirm: () => {
                const message = document.getElementById('alertMessage').value;
                return { message: message };
            }
        }).then((result) => {
            if (result.isConfirmed) {
                // Send AJAX request to trigger alert
                $.ajax({
                    url: '<%=request.getContextPath()%>/triggerAlert',
                    type: 'POST',
                    data: {
                        email: email,
                        profitCenter: profitCenter,
                        monthYear: monthYear,
                        userId: userId,
                        message: result.value.message
                    },
                    success: function(response) {
                        Swal.fire({
                            title: 'Success!',
                            text: 'Alert has been triggered successfully',
                            icon: 'success',
                            confirmButtonColor: '#198754'
                        });
                    },
                    error: function(xhr, status, error) {
                        Swal.fire({
                            title: 'Error!',
                            text: 'Failed to trigger alert: ' + error,
                            icon: 'error',
                            confirmButtonColor: '#dc3545'
                        });
                    }
                });
            }
        });
    });

    // Trigger All Alerts
    $('#triggerAllBtn').on('click', function() {
        Swal.fire({
            title: 'Trigger All Alerts',
            html: `
                <div class="text-start">
                    <p>This will send alerts for all visible records in the table.</p>
                    <p class="text-warning"><strong>Warning:</strong> This action cannot be undone.</p>
                    <div class="mb-3">
                        <label for="bulkAlertMessage" class="form-label fw-semibold">Custom Message (Optional):</label>
                        <textarea id="bulkAlertMessage" class="form-control" rows="3" placeholder="Add a custom message for all alerts..."></textarea>
                    </div>
                </div>
            `,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#059669',
            cancelButtonColor: '#6c757d',
            confirmButtonText: '<i class="fas fa-paper-plane me-2"></i>Send All Alerts',
            cancelButtonText: 'Cancel',
            preConfirm: () => {
                const message = document.getElementById('bulkAlertMessage').value;
                return { message: message };
            }
        }).then((result) => {
            if (result.isConfirmed) {
                // Get all visible data
                var data = table.rows({ search: 'applied' }).data();
                var alerts = [];
                
                data.each(function(value, index) {
                    var email = $(value[3]).text().trim();
                    var profitCenter = $(value[0]).find('.fw-bold').text().trim();
                    var monthYear = value[1];
                    var userId = value[2];
                    
                    alerts.push({
                        email: email,
                        profitCenter: profitCenter,
                        monthYear: monthYear,
                        userId: userId,
                        message: result.value.message
                    });
                });

                // Send AJAX request for all alerts
                $.ajax({
                    url: '<%=request.getContextPath()%>/triggerAllAlerts',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(alerts),
                    success: function(response) {
                        Swal.fire({
                            title: 'Success!',
                            text: alerts.length + ' alerts have been triggered successfully',
                            icon: 'success',
                            confirmButtonColor: '#198754'
                        });
                    },
                    error: function(xhr, status, error) {
                        Swal.fire({
                            title: 'Error!',
                            text: 'Failed to trigger alerts: ' + error,
                            icon: 'error',
                            confirmButtonColor: '#dc3545'
                        });
                    }
                });
            }
        });
    });

    // Auto-refresh data every 30 seconds
    setInterval(function() {
        table.ajax.reload(null, false);
    }, 30000);
});
</script>
</body>
</html>