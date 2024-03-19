<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회의실 예약</title>
<link rel="stylesheet" type="text/css" href="/css/insertrev.css" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css">
<style>
/* 추가된 CSS */
/* 날짜 선택 탭의 너비에 따라 나머지 선택란의 너비를 조정 */
.custom-col {
	max-width: 100%; /* 최대 너비 */
}


</style>
</head>
<body>

<header class="index_header">
    <jsp:include page="../layout/header.jsp" />
</header>
<div class="container">
    <div class="card"> 
        <div class="card-body">
           				<h6 class="m-0 font-weight-bold text-primary">
					예약시스템 <i class="fa fa-chevron-right mx-1"></i>회의실 <i
						class="fa fa-chevron-right mx-1">대회의실 예약</i>
				</h6>
            <!-- General Form Elements -->
                <!-- 날짜 선택 -->
                <div class="form-group">
                    <label for="selectedDate">날짜 선택:</label> 
                    <input type="date" id="selectedDate" class="form-control" name="selectedDate" min="<%=LocalDate.now()%>" required>
                </div>

                <!-- 시작 시간 -->
                <div class="form-group">
                    <label for="reStart">시작 시간:</label> 
                    <select id="reStart" name="reStart" class="form-control" required>
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

                <!-- 종료 시간 -->
                <div class="form-group">
                    <label for="reEnd">종료 시간:</label> 
                    <select id="reEnd" name="reEnd" class="form-control" required>
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

                <!-- 회의실 선택 -->
                <div class="form-group">
                    <label for="mrSelect">회의실 선택:</label> 
                    <select id="mrSelect" name="mrSelect" class="form-control" required>
                        <option value="">회의실을 선택하세요</option>
                        <!-- mrList에서 각 아이템을 반복하며 셀렉트 박스 옵션 생성 -->
                        <c:forEach var="mr" items="${mrList}">
                            <option value="${mr.mrId}">${mr.mrName}</option>
                        </c:forEach>
                    </select>
                </div>

				<!-- 예약자 -->
                <div class="form-group">
                    <label for="userId">예약자:</label> 
                    <input value="${login_user.userName}" id="userId" name="userId" readonly="readonly" class="form-control" style="width: 30%;">

                </div>

                <!-- 참석자 수 -->
                <div class="form-group">
                    <label for="reCount">참석자 수:</label> 
                    <input type="text" id="reCount" name="reCount" required class="form-control" style="width: 30%;">

                </div>

                <!-- 버튼 -->
                <div class="text-center mt-4">
                    <button id="btn-insert" class="btn btn-primary">예약등록</button>
                    <button type="reset" class="btn btn-primary">Reset</button>
                </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="/js/revmeet.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>