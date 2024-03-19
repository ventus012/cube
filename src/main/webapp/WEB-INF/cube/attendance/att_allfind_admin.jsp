<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.noDataMessage {
	font-size: 20px;
	margin-top: 50px;
	text-align: center;
	color: red;
	display: none;
}
</style>
</head>


<body id="page-top">
<header class="index_header">
	<jsp:include page="../layout/header.jsp" />
</header>
	<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
			<div class = "float-right mr-3" id="goBack" style="cursor: pointer;"><i class="fas fa-arrow-left"></i></div>
			<h6 class="m-0 text-secondary">
					근태<i class="fas fa-chevron-right mx-1"></i>관리자<i class="fas fa-chevron-right mx-1"></i>팀 근태 조회<i class="fas fa-chevron-right mx-1"></i>${user.userTeamId.teamName}팀 사원 근태 조회<i class="fas fa-chevron-right mx-1"></i>${user.userName}
				</h6>
			</div>
			<div class="card-body">
			<div class = "float-right">
				<div class=monthSelectBox>
				<select id="monthSelect" class="custom-select custom-select-sm form-control form-control-sm mb-3 border border-primary" style= "width:100px"
						onchange="filterByMonth()">
						<option value="all">전체</option>
						<option value="01">1월</option>
						<option value="02">2월</option>
						<option value="03">3월</option>
						<option value="04">4월</option>
						<option value="05">5월</option>
						<option value="06">6월</option>
						<option value="07">7월</option>
						<option value="08">8월</option>
						<option value="09">9월</option>
						<option value="10">10월</option>
						<option value="11">11월</option>
						<option value="12">12월</option>
					</select>
				</div>
				</div>
				
				<table class="table table-bordered text-gray-900 border-bottom-primary" width="100%" cellspacing="0" >
					<thead>
						<tr align ="center">
							<th>사용자</th>
							<th>날짜</th>
							<th>출근시간</th>
							<th>퇴근시간</th>
							<th>유형</th>
							<th>초과근무 시작</th>
							<th>초과근무 종료</th>
							<th colspan=3>상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="attendance" items="${attList}">
							<tr align = "center">
								<td>${attendance.userId.userName}<input type="hidden" id="attId" value = "${attendance.attId}"></td>
								<td>${attendance.attDate}</td>
								<td
									style="color: ${attendance.attStart > '09:00:00' ? 'red' : 'black'}">
									${attendance.getformatattStart() == null ? '주말 출근' : attendance.getformatattStart()}</td>
								<td>${attendance.getformatattEnd()}</td>
								<td>${attendance.attType}</td>
								<c:choose>
									<c:when
										test="${empty attendance.attOtStart and empty attendance.attOtEnd}">
										<td colspan="2">초과근무 신청 내역 없음</td>
									</c:when>
									<c:otherwise>
										<td>${attendance.getformatattOtStart()}</td>
										<td>${attendance.getformatattOtEnd()}</td>
									</c:otherwise>
								</c:choose>
								<td>${attendance.attStatus}</td>
								<td width = 5%><button class="btn btn-primary text-xs px-1 mx-0 appbtn">승인</button></td>
								<td width = 5%><button class="btn btn-danger text-xs px-1 mx-0 rejectbtn">반려</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<p id="noDataMessage" class="noDataMessage">선택한 월에 대한 근무내역이
					없습니다.</p>


				<script>
					function filterByMonth() {
						var selectedMonth = document
								.getElementById("monthSelect").value;
						var rows = document.querySelectorAll("tbody tr");

						var hasData = false;

						rows.forEach(function(row) {
							var date = row.children[1].innerText;
							var month = date.split("-")[1];

							if (selectedMonth === "all"
									|| month === selectedMonth) {
								row.style.display = "";
								hasData = true;
							} else {
								row.style.display = "none";
							}
						});

						var noDataMessage = document
								.getElementById("noDataMessage");
						noDataMessage.style.display = hasData ? "none"
								: "block";
					}
				</script>


			</div>
		</div>
	</div>
	<script src="/js/att.js"></script>
</body>
</html>