<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">


<meta charset="UTF-8">
<title>예약 목록</title>
</head>
<body>
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">
				예약시스템 <i class="fa fa-chevron-right mr-1"></i>나의예약목록
			</h6>
		</div>
		<div class="card-body">
						<table class="float-right">


					<div class="input-group" style="width: 200px; float: right;">
						<input type="text" class="form-control bg-light border-0 small"
							placeholder="Search for..." aria-label="Search"
							aria-describedby="basic-addon2">
						<div class="input-group-append">
							<button class="btn btn-primary" type="button">
								<i class="fas fa-search fa-sm"></i>
							</button>
						</div>
					</div>
			<div class="table-responsive">
				<table class="table table-bordered" id="dataTable" width="100%"
					cellspacing="0">

					<table
						class="table table-bordered text-gray-900 border-bottom-primary"
						width="100%" cellspacing="0">
						<thead>
							<tr align="center">
								<th>예약자 ID</th>
								<th>예약 항목</th>
								<th>참석/탑승 인원</th>
								<th>예약 날짜</th>
								<th>시작 시간</th>
								<th>종료 시간</th>
								<th>장소 또는 차량</th>
								<th>예약변경</th>
								<!-- 수정 버튼 추가 -->
								<th>삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="reservation" items="${revList}">
								<tr align="center">
									<td>${reservation.userId.userId}</td>
									<td>${reservation.reItem}</td>
									<td>${reservation.reCount}</td>
									<td>${reservation.reDate}</td>
									<td>${reservation.reStart}</td>
									<td>${reservation.reEnd}</td>
									<td>${reservation.reNum.mrName}</td>
									<td><a href="/updateRev/${reservation.reId}"
										class="btn btn"><i class="fas fa-pen-to-square" style="color: blue;"></i></a>
									</td>
									<td>
										<form class="delete-form">
											<input type="hidden" class="reId" value="${reservation.reId}">
											<button class="btn btn btn-delete">
												<i class="fas fa-trash"style="color: red;"></i>
											</button>
										</form>
									</td>
								</tr>
							</c:forEach>
							<c:forEach var="carreservation" items="${carList}">
								<tr align="center">
									<td>${carreservation.userId.userId}</td>
									<td>${carreservation.creItem}</td>
									<td>${carreservation.creCount}</td>
									<td>${carreservation.creDate}</td>
									<td>${carreservation.creStart}</td>
									<td>${carreservation.creEnd}</td>
									<td>${carreservation.creNum.carName}</td>
									<td><a href="/updateCar/${carreservation.creId}"
										class="btn btn"> <i class="fas fa-pen-to-square"
											style="color: blue;"></i>
									</a></td>

									<td>
										<form class="delete-form">
											<input type="hidden" class="creId"
												value="${carreservation.creId}">
											<button class="btn btn btn-delete">
												<i class="fas fa-trash" style="color: red"></i>
											</button>

										</form>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

				</table>
			</div>
		</div>
	</div>
</body>
<script src="/js/revmeet.js"></script>
<script src="/js/revcar.js"></script>
</html>
