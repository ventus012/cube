<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>
.col-xl-4{
	height: 330px;
}

</style>
</head>
<body id="page-top">
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<div class="container-fluid">
		<div class="row">
			<!-- 1번줄 -->
			<div class="col-xl-4 col-md-4 mb-4">
				<div class="card border-left-primary shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="font-weight-bold text-primary mb-1">
									<i class="fas fa-bullhorn mr-3"></i>공지사항
								</div>
								<table class="table text-gray-900 text-xs m-0" width="100%"
									cellspacing="0">
									<tbody>
										<c:forEach var="board" items="${nBoardList}">
											<tr align="left">
												<td class="p-2"><span class="font-weight-bold"><a
														href="getNotice/${board.nboardId}">${board.nboardTitle}</a></span>
													<c:set var="currentDate"
														value="<%= java.time.LocalDate.now() %>" /> <c:if
														test="${board.nboardCreated.toLocalDate() == pageScope.currentDate}">
														<i class="fas fa-exclamation-circle fa-xs"
															style="color: #e81756;"></i>
													</c:if> <br>
												<span class="text-gray-600">[2024-02-24 18:00:00] <span
														class="float-right">${board.nboardWriter.userPosition}
															${board.nboardWriter.userName}</span></span></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-xl-4 col-md-4 mb-4">
				<div class="card border-left-primary shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="font-weight-bold text-primary mb-1">
									<i class="fas fa-clipboard-list mr-3"></i>${login_user.userTeamId.teamName}팀
									게시판
								</div>
								<table class="table text-gray-900 text-xs m-0" width="100%"
									cellspacing="0">
									<tbody>
										<c:forEach var="board" items="${teamBoardList}">
											<tr align="left">
												<td class="p-2"><span class="font-weight-bold"><a
														href="getBoard/${login_user.userTeamId.teamId}/${board.boardId}">${board.boardTitle}</a></span>
													<c:if
														test="${board.boardCreated.toLocalDate() == pageScope.currentDate}">
														<i class="fas fa-exclamation-circle fa-xs"
															style="color: #e81756;"></i>
													</c:if> <br>
												<span class="text-gray-600">[2024-02-24 18:00:00] <span
														class="float-right">${board.boardWriter.userPosition}
															${board.boardWriter.userName}</span></span></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xl-4 col-md-4 mb-4">
				<div class="card border-left-success shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="font-weight-bold text-success mb-1">
									<i class="far fa-calendar-check mr-3"></i>오늘 일정
								</div>
								
							</div>
						</div>
					</div>
				</div>
			</div>
			
				
				
				
			</div>
				
		<!-- 1번줄끝 -->

		<div class="row">
			<!-- 2번줄 -->
			<div class="col-xl-4 col-md-4 mb-4">
				<div class="card border-left-danger shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="font-weight-bold text-danger mb-1">
									<i class="fas fa-user-friends mr-3"></i>${login_user.userTeamId.teamName}팀
								</div>
								<table class="table text-xs text-gray-900 m-0" width="100%"
									cellspacing="0">
									<tbody>
										<c:if test="${leader ne null}">
											<tr align=center>
												<th class="p-1">팀장</th>
												<td class="p-1">${leader.userName}</td>
												<td class="p-1">${leader.userMobile}</td>
												<td class="p-1"><a
													href="/mail_send/${leader.userEmail}">${leader.userEmail}</a></td>
											</tr>
										</c:if>
										<c:forEach var="user" items="${team}">
											<tr align=center>
												<td class="p-1">팀원</td>
												<td class="p-1">${user.userName}</td>
												<td class="p-1">${user.userMobile}</td>
												<td class="p-1"><a href="/mail_send/${user.userEmail}">${user.userEmail}</a></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xl-4 col-md-4 mb-4">
				<div class="card border-left-info shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="font-weight-bold text-info mb-1">
									<i class="fas fa-envelope mr-3"></i>${login_user.userName}님 메일함
								</div>
								<table class="table text-gray-900 text-xs m-0" width="100%"
									cellspacing="0">
									<tbody>
										<c:forEach var="mail" items="${receivedMail}">
											<tr align="left">
												<td width=10%><i class="far fa-envelope fa-lg"></i></td>
												<td class="p-2"><span class="font-weight-bold"><a
														href="/getReceiveMail/${mail.receiveMailId}">
															${mail.receiveMailTitle}</a></span> <br>
												<span class="text-gray-600">[2024-02-24 18:00:00] <span
														class="float-right">${mail.receiveMailSenderEmail}</span></span></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xl-4 col-md-4 mb-4">
				<div class="card border-left-dark shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="font-weight-bold text-dark mb-1">
									<i class="fas fa-briefcase mr-3"></i>근태
									<span class= "float-right">
									<button class = "btn btn-dark px-1 py-0" id = "togglebnt" onclick="toggleChart()"><i class="fas fa-exchange-alt"></i></button>
									</span>
								</div>

									<canvas id="myChart" width = "300" height= "250"></canvas>
								
								</div>
							</div>									
						</div>
					</div>
				</div>
		</div>
		<!-- 2번줄 끝 -->
		<div class="row">
			<!-- 3번줄 -->

			

			
			
		</div>
		<!-- 3번줄끝 -->

	</div>

	<script>
	let myChart;
	
	let chartType = 'time';

	function toggleChart() {
	    if (chartType === 'day') {
	        showTimeChart();
	        chartType = 'time';
	    } else {
	        showDayChart();
	        chartType = 'day';
	    }
	}
	
	window.onload = function() {
	    renderChart(timeLabels, timeData, timecolor);
	};
	
	function showTimeChart() {
	    myChart.destroy();
        renderChart(timeLabels, timeData, timecolor);
    }
	
    function showDayChart() {
    	myChart.destroy();
        renderChart(dayLabels, dayData, daycolor);
    }
    
    let dayData = ${dayTypeList};
	let timeData = ${attTypeList};
	let timeLabels = ['정상근무', '연차', '공가', '초과','미실시'];
	let dayLabels = ['정상근무', '연차', '공가', '반차','미실시'];
	let daycolor = ["#0d6efd", "#ffc107", "#dc3545", "#fd7e14", "lightgrey"];
	let timecolor = ["#0d6efd", "#ffc107", "#dc3545", "#198754", "lightgrey"];
	
	function renderChart(labels, typeList, color) {
	var chartArea = document.getElementById('myChart').getContext('2d'); 
	myChart = new Chart(chartArea, {
    	type: 'doughnut',
    	data: {
        	labels: labels,
        	datasets: [{
            	label: '# of Votes',
            	data: typeList,
            	backgroundColor: color,
            borderWidth: 1
        	}]
    	},
    	options: {
    		responsive: false,
    	}
	});
	}
	</script>
	
</body>
</html>