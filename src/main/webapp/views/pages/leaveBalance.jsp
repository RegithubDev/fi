<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Leave Balance</title>

<script src="https://cdn.tailwindcss.com"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link
	href="https://cdn.datatables.net/2.3.2/css/dataTables.dataTables.min.css"
	rel="stylesheet">
<script src="https://cdn.datatables.net/2.3.2/js/dataTables.min.js"></script>
</head>
<body class="flex flex-col h-full">

	<jsp:include page="/views/layout/header.jsp" />
	<jsp:include page="/views/layout/menu.jsp" />
	<script>const ctx = '<%=request.getContextPath()%>';</script>

	<div class="flex-1 min-h-0 p-6 flex flex-col gap-4">
		<div class="flex gap-4 flex-wrap items-center">
			<input id="globalSearch" placeholder="Search name or code…"
				class="border rounded-md px-4 py-2 flex-grow max-w-sm" /> <select
				id="pageSize" class="border rounded-md px-3 py-2">
				<option>10</option>
				<option>20</option>
				<option>30</option>
				<option>40</option>
				<option>50</option>
			</select>
		</div>

		<!-- Card with scrollable table body -->
		<div
			class="flex-1 flex flex-col bg-white shadow-sm rounded-2xl ring-1 ring-gray-200">

			<!-- Scrollable table body with sticky thead -->
			<div class="overflow-y-auto max-h-96">
				<table id="leaveTable"
					class="w-full text-sm divide-y divide-gray-200">
					<thead class="bg-gray-100 sticky top-0 z-10">
						<tr>
							<th class="text-left font-semibold px-4 py-2">#</th>
							<th class="text-left font-semibold px-4 py-2">Employee Code</th>
							<th class="text-left font-semibold px-4 py-2">Employee Name</th>
							<th class="text-left font-semibold px-4 py-2">Date of
								Joining</th>
							<th class="text-left font-semibold px-4 py-2">Casual Leave</th>
							<th class="text-left font-semibold px-4 py-2">Earned Leave</th>
							<th class="text-left font-semibold px-4 py-2">Sick Leave</th>
						</tr>
					</thead>
					<tbody class="divide-y divide-gray-100 text-sm"></tbody>
				</table>
			</div>
		</div>
	</div>

	<script>
const COLS = [
  {data:'id'},
  {data:'empCode'},
  {data:'empName'},
  {data:'hireDate'},
  {data:'casualLeave'},
  {data:'earnedLeave'},
  {data:'sickLeave'}
];

const dt = new DataTable('#leaveTable', {
  serverSide: true,
  processing: true,
  dom: 'tip',
  pagingType: 'simple_numbers',
  pageLength: 10,
  lengthChange: false,
  info: true,
  ordering: true,
  order: [[0, 'asc']],
  search: false,
  autoWidth: false,
  columns: COLS,
  columnDefs: [{ targets: '_all', defaultContent: '-' }],
  createdRow: row => row.classList.add('hover:bg-gray-100'),
  drawCallback: () => {
    document.querySelectorAll('div.dataTables_paginate a:not(.current)')
      .forEach(btn => btn.classList.add('hover:bg-gray-200', 'rounded', 'border', 'px-2', 'py-1', 'text-sm'));
  },
  ajax: {
    url: ctx + '/api/v1/leave/list',
    data: req => {
      const ord = req.order?.[0] ?? { column: 0, dir: 'asc' };
      return {
        page:       req.start / req.length,
        size:       req.length,
        sort:       COLS[ord.column].data,
        direction:  ord.dir.toUpperCase(),
        q:          $('#globalSearch').val().trim()
      };
    },
    dataSrc: res => {
      res.recordsTotal = res.totalElements ?? 0;
      res.recordsFiltered = res.totalElements ?? 0;
      return Array.isArray(res.content) ? res.content : [];
    }
  }
});

let tmr;
$('#globalSearch').on('input', function() {
  clearTimeout(tmr); tmr = setTimeout(() => dt.draw(), 500);
});
$('#pageSize').on('change', function() {
  dt.page.len(+this.value).draw();
});
</script>
</body>
</html>
