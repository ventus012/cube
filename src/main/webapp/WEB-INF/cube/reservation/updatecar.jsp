<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>차량 예약 수정</title>
</head>
<body>
<input type="hidden" id="creId" value="${creId}">
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>

	<div class="container">
		<div class="card">
			<div class="card-body">
				<h6 class="m-0 font-weight-bold text-primary">
					예약시스템 <i class="fa fa-chevron-right mx-1"></i>나의 예약 목록 <i
						class="fa fa-chevron-right mx-1">예약변경</i>
				</h6>



				<div class="form-group">
					<label for="creDate">날짜 선택:</label> <input type="date" id="creDate"
						class="form-control" name="creDate" min="<%=LocalDate.now()%>"
						required>
				</div>


				<div class="form-group">
					<label for="creStart">시작 시간:</label> <select id="creStart"
						name="creStart" class="form-control" required>
						<option value="">시간을 선택하세요</option>
						<!-- 오전 9시부터 오후 6시까지의 옵션 생성 -->
						<c:forEach begin="9" end="18" var="hour">
							<c:set var="hour" value="${hour < 10 ? '09' : hour}" />
							<c:set var="amPm" value="${hour >= 12 ? '오후' : '오전'}" />
							<c:set var="hour12" value="${hour > 12 ? hour - 12 : hour}" />
							<option value="<c:out value='${hour}'/>:00">${amPm}
								<c:out value='${hour12}' />:00
							</option>
							<option value="<c:out value='${hour}'/>:30">${amPm}
								<c:out value='${hour12}' />:30
							</option>
						</c:forEach>
					</select>
				</div>

				<div class="form-group">
					<label for="creEnd">종료 시간:</label> <select id="creEnd"
						name="creEnd" class="form-control" required>
						<option value="">시간을 선택하세요</option>
						<!-- 오전 9시부터 오후 6시까지의 옵션 생성 -->
						<c:forEach begin="9" end="18" var="hour">
							<c:set var="hour" value="${hour < 10 ? '09' : hour}" />
							<c:set var="amPm" value="${hour >= 12 ? '오후' : '오전'}" />
							<c:set var="hour12" value="${hour > 12 ? hour - 12 : hour}" />
							<option value="<c:out value='${hour}'/>:00">${amPm}
								<c:out value='${hour12}' />:00
							</option>
							<option value="<c:out value='${hour}'/>:30">${amPm}
								<c:out value='${hour12}' />:30
							</option>
						</c:forEach>
					</select>
				</div>

				<!-- 탑승인원 필드를 제외한 나머지 코드 -->

				<div class="form-group">
					<label for="creNum">차량 선택:</label> <select id="creNum"
						name="creNum" class="form-control" required>
						<option value="">차량을 선택하세요</option>
						<!-- carList에서 각 아이템을 반복하며 셀렉트 박스 옵션 생성 -->
						<c:forEach var="car" items="${creList}">
							<option value="${car.carId}">${car.carName}</option>
						</c:forEach>
					</select>

				</div>

				<!-- 예약자 -->
				<div class="form-group">
					<label for="userId">예약자:</label> <input
						value="${login_user.userName}" id="userId" name="userId"
						readonly="readonly" class="form-control" style="width: 30%;">

				</div>



				<!-- 버튼 -->
				<div class="text-center mt-4">
					<button id="btn-update" class="btn btn-primary">예약변경</button>
					<button type="reset" class="btn btn-secondary">Reset</button>
				</div>

			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script src="/js/revcar.js"></script>
</body>
</html>
