<!-- leaveModal.jsp -->
<form id="applyLeaveForm" class="needs-validation" novalidate>
  <div class="modal-header">
    <h5 class="modal-title" id="leaveModalLabel">Apply Leave</h5>
    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
  </div>

  <div class="modal-body">

    <!-- Employee -->
    <div class="mb-3">
      <label for="leaveEmp" class="form-label">Employee</label>
      <select id="leaveEmp" class="form-select" required aria-describedby="leaveEmpHelp"></select>
      <div id="leaveEmpHelp" class="form-text">
        Leave will be applied to the selected employee.
      </div>
      <div class="invalid-feedback">Employee selection is required.</div>
    </div>

    <!-- Multi-day toggle -->
    <div class="form-check form-switch mb-4">
      <input class="form-check-input" type="checkbox" id="multiDayToggle" aria-describedby="multiToggleNote">
      <label class="form-check-label" for="multiDayToggle">
        Apply for multiple days
      </label>
      <span id="multiToggleNote" class="visually-hidden">
        Toggle between single and multi-day leave
      </span>
    </div>

    <!-- Multi-day -->
    <div class="row g-3 multi-only d-none mb-4">
      <div class="col-md">
        <label for="leaveFrom" class="form-label">Leave From</label>
        <input type="date" id="leaveFrom" class="form-control">
      </div>
      <div class="col-md">
        <label for="leaveTo" class="form-label">Leave Till</label>
        <input type="date" id="leaveTo" class="form-control">
      </div>
    </div>

    <!-- Single-day -->
    <div class="single-only">
      <div class="mb-4">
        <label for="leaveDate" class="form-label">Leave Date</label>
        <input type="date" id="leaveDate" class="form-control">
      </div>

      <fieldset class="mb-4">
        <legend class="fs-6 fw-normal mb-1">Duration</legend>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="radio" name="duration" id="fullDay" value="Full" checked>
          <label class="form-check-label" for="fullDay">Full Day</label>
        </div>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="radio" name="duration" id="halfDay" value="Half">
          <label class="form-check-label" for="halfDay">Half Day</label>
        </div>

        <!-- Half-day sub-options -->
        <div id="halfDayBlock" class="mt-3 d-none">
          <div class="row g-3 align-items-end">
            <!-- Half-day selector -->
            <div class="col-12 col-md">
              <label for="halfType" class="form-label">Select Slot</label>
              <select id="halfType" class="form-select">
                <option value="FIRST">First Half</option>
                <option value="SECOND">Second Half</option>
              </select>
            </div>

            <!-- Check-In -->
            <div class="col-12 col-md">
              <label for="checkInTime" class="form-label">Check-In Time</label>
              <input type="text" id="checkInWorkTime" class="form-control time-picker" placeholder="HH:MM" data-input
                required>
            </div>

            <!-- Check-Out -->
            <div class="col-12 col-md">
              <label for="checkOutTime" class="form-label">Check-Out Time</label>
              <input type="text" id="checkOutWorkTime" class="form-control time-picker" placeholder="HH:MM" data-input
                required>
            </div>
          </div>
        </div>

      </fieldset>
    </div>

    <!-- Leave type & remarks -->
    <div class="mb-4">
      <label for="leaveType" class="form-label">Leave Type</label>
      <select id="leaveType" class="form-select">
        <option value="SL">Sick Leave</option>
        <option value="CL">Casual Leave</option>
        <option value="EL">Earned Leave</option>
        <option value="ML">Maternity Leave</option>
        <option value="PL">Paternity Leave</option>
      </select>
    </div>

    <div class="mb-3">
      <label for="leaveRemarks" class="form-label">Remarks</label>
      <textarea id="leaveRemarks" class="form-control" rows="2"></textarea>
    </div>
  </div>

  <div class="modal-footer">
    <button type="submit" class="btn btn-primary">Apply</button>
    <button type="button" class="btn btn-secondary" id="leaveCancelBtn" data-bs-dismiss="modal">
      Cancel
    </button>
  </div>
</form>

<!-- JS (leave-form) -->
<script>
  $(() => {
    /* ---------- cached selectors ---------- */
    const $form = $('#applyLeaveForm');
    const $toggleMulti = $('#multiDayToggle');
    const $duration = $('input[name="duration"]');
    const $halfBlock = $('#halfDayBlock');
    const $timeInputs = $('#checkInWorkTime, #checkOutWorkTime');
    const $checkInTime = $('#checkInWorkTime');
    const $checkOutTime = $('#checkOutWorkTime');
    const $multiOnly = $('.multi-only');
    const $singleOnly = $('.single-only');

    /* ---------- UI helpers ---------- */
    // Utility to merge date and time: yyyy-mm-dd + hh:mm  =>  yyyy-mm-ddThh:mm
    function isoDateTime(dateId, timeId) {
      const d = $(dateId).val()?.trim();
      const t = $(timeId).val()?.trim();

      if (!d || !t) {
        return "";
      }

      return d + "T" + t;
    }

    const toggleViews = () => {
      const multi = $toggleMulti.is(':checked');
      $multiOnly.toggleClass('d-none', !multi);
      $singleOnly.toggleClass('d-none', multi);
      if (multi) $halfBlock.addClass('d-none');
    };

    const toggleHalfDay = () => {
      const show = $('#halfDay').is(':checked');
      $halfBlock.toggleClass('d-none', !show);
      $timeInputs.prop('required', show);
    };

    const resetForm = () => {
      $form[0].reset();
      $form.removeClass('was-validated');
      toggleViews();
      toggleHalfDay();
    };

    const closeLeaveModal = () => {
      const $modal = $('#applyLeaveModal');
      $modal.one('hidden.bs.modal', () => {
        $('#attendanceTable').DataTable().ajax.reload(null, false);
        resetForm();
      });

      $modal.modal('hide');

      setTimeout(() => {
        if ($('.modal-backdrop').length) {
          $('.modal-backdrop').remove();
          $('body').removeClass('modal-open');
        }
      }, 500);
    }

    /* ---------- event wiring ---------- */
    $toggleMulti.on('change', toggleViews);
    $duration.on('change', toggleHalfDay);
    $('#leaveCancelBtn').on('click', resetForm);

    // initial state
    toggleViews();
    toggleHalfDay();

    /* ---------- submit ---------- */
    $form.on('submit', e => {
      e.preventDefault();
      if (!e.currentTarget.checkValidity()) {
        $form.addClass('was-validated');
        return;
      }

      const [empCode = '', employeeName = ''] =
        ($('#leaveEmp').val() || '').split(' - ');

      const multi = $toggleMulti.is(':checked');
      const half = $('#halfDay').is(':checked') && !multi;

      // date checks ----------------------------------------------------------
      if (multi) {
        const from = $('#leaveFrom').val(),
          to = $('#leaveTo').val();
        if (!from || !to || to < from)
          return alert('Please choose a valid From and To date.');
      } else {
        const workDate = $('#leaveDate').val();
        if (!workDate) return alert('Please choose a leave date.');
        if (half && !$checkInTime.val() && !$checkOutTime.val())
          return alert('Check-In and Check-Out times are required for Half Day.');
      }

      // build payload --------------------------------------------------------
      const dto = {
        empCode,
        employeeName,
        leaveType: $('#leaveType').val(),
        remarks: $('#leaveRemarks').val(),
        multiple: multi,
        halfDay: half,
        halfDaySlot: half ? $('#halfType').val() : null,
        checkIn: half ? isoDateTime('#leaveDate', '#checkInWorkTime') : null,
        checkOut: half ? isoDateTime('#leaveDate', '#checkOutWorkTime') : null,
        fromDate: multi ? $('#leaveFrom').val() : null,
        toDate: multi ? $('#leaveTo').val() : null,
        workDate: multi ? null : $('#leaveDate').val()
      };

      // ajax ---------------------------------------------------------------
      $.ajax({
        url: '<%= request.getContextPath() %>/v2/attendance/leave',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(dto)
      })
        .done((response, _status, _xhr) => {
          const msg = (response && response.message) || response || 'Leave applied successfully';
          alert(msg);

          closeLeaveModal();
        })
        .fail(xhr =>
          alert(xhr.responseText || 'Error submitting leave')
        );
    });
  });
</script>
