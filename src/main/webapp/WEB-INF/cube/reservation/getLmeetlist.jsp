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
<body id="page-top">
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 text-primary">
					예약시스템<i class="fas fa-chevron-right mx-1"></i>회의실<i
						class="fas fa-chevron-right mx-1"></i>대회의실 등록현황
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
						<table
							class="table table-bordered text-gray-900 border-bottom-primary"
							width="100%" cellspacing="0">
							<thead>
								<tr align="center">
									<th>예약자 ID</th>
									<th>예약 항목</th>
									<th>참석 인원</th>
									<th>예약 날짜</th>
									<th>시작 시간</th>
									<th>종료 시간</th>
									<th>위치</th>
									<th>장소</th>
									<c:if test="${isAdmin}">
										<!-- 예약 변경 텍스트 -->
										<th>예약변경</th>
										<!-- 예약 삭제 텍스트 -->
										<th>예약취소</th>
									</c:if>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="reservation" items="${revList}">
									<tr align="center">
										<!-- 예약자 ID, 예약 항목, ... 등 각 열의 데이터를 출력합니다. -->
										<td>${reservation.userId.userId}</td>
										<td>${reservation.reItem}</td>
										<td>${reservation.reCount}</td>
										<td>${reservation.reDate}</td>
										<td>${reservation.reStart}</td>
										<td>${reservation.reEnd}</td>
										<td>${reservation.reNum.mrLocation }</td>
										<td>${reservation.reNum.mrName}</td>
										<!-- 예약 변경 및 취소 버튼 -->
										<c:if test="${isAdmin}">
											<td>
												<form action="/updateRev/${reservation.reId}" method="get">
													<button class="btn btn">
														<i class="fas fa-pen-to-square"></i>
													</button>
												</form>
											</td>
											<td>
												<form class="delete-form">
													<input type="hidden" class="reId"
														value="${reservation.reId}">
													<button class="btn btn btn-delete">
														<i class="fas fa-trash"></i>
													</button>
												</form>
											</td>
										</c:if>
									</tr>
								</c:forEach>
							</tbody>
						</table>
				</table>


			</div>
		</div>
	</div>
	<script src="/js/revmeet.js"></script>
</body>
</html>