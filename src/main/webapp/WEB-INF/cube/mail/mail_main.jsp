<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>SendMailList</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
<link rel="stylesheet" type="text/css" href="/css/mailList.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</head>
<style>
    .btn-center {
        display: flex;
        justify-content: center;
        align-items: center;
    }
  
</style>
<body id="page-top">
	<header class="index_header">
		<jsp:include page="../layout/header.jsp" />
	</header>
	<div class="container-fluid">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
			
				<h6 class="m-0 text-gray-600">
					메일<i class="fas fa-chevron-right mx-1"></i>메인 검색
				</h6>
			</div>
			<div class="card-body">



              <h3>보낸 메일 검색</h3>
				<table class="table">
							<tr>
								<td><select
									class="custom-select custom-select-sm form-control form-control-sm"
									name="mailType" id="mailType">
										<option value="sendMail">보낸 메일</option>
										<option value="receiveMail">받은 메일</option>
								</select></td>
								<td><select
									class="custom-select custom-select-sm form-control form-control-sm"
									name="searchType" id="searchType">
										<option value="UserName">이름</option>
										<option value="MailTitle">제목</option>
										<option value="MailContent">내용</option>
								</select></td>
								<td>
									<div class="input-group">
										<input type="text"
											class="form-control bg-light border-0 small"
											placeholder="검색할 단어를 입력하세요" aria-label="Search"
											aria-describedby="basic-addon2" id="searchInput">
										<div class="input-group-append">
											<button id="btn-search" class="btn btn-primary">
												<i class="fas fa-search fa-sm"></i>
											</button>
																								
										</div>
									</div>
									<input id="sendMailId" type=hidden value="${SendMail.sendMailId}">
						    <input id="receiveMailId" type=hidden value="${ReceiveMail.receiveMailId}">
								</td>
							</tr>
								
						</table>
						<c:if test="${searchMailType eq 'sendMail'}">
							<h3>보낸 메일</h3>
							<table class="table">
					<thead>
						<tr>
							<th>메일 번호</th>
							<th>제목</th>
							<th>받는 사람</th>
							<th>보낸 날짜</th>
							<th class="text-center">휴지통 이동</th>
							<th class="text-center">중요메일함 이동</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="mail" items="${mailList}">
							<tr>
								<td>${mail.sendMailId}<input type="hidden"
									value="${mail.sendMailId}" id="sendMailId"></td>
								<td><a href="/getSendMail/${mail.sendMailId}"
									>${mail.sendMailTitle}</a></td>
								<td>${mail.sendMailReceiverEmail}</td>
								<td>${mail.sendMailReservationDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
								<td><a href="/changeSendIsDelete/${mail.sendMailId}"
									class="btn-center"> <i class="fas fa-trash"></i></a></td>
								<td><a href="/changeSendImportant/${mail.sendMailId}"
									class="btn-center"><i class="fas  fa-star"></i></a></td>

							</tr>
						</c:forEach>
					</tbody>
				</table>
						</c:if>
						<c:if test="${searchMailType eq 'receiveMail'}">
						<table class="table">
					<thead>
						<tr>
							<th>메일 번호</th>
							<th>제목</th>
							<th>보낸 사람</th>
							<th>받은시간</th>
							<th>읽음 여부</th>
							<th>읽은 날짜</th>
							<th class="text-center">휴지통 이동</th>
							<th class="text-center">중요메일함 이동</th>



						</tr>
					</thead>
					<tbody>
						<c:forEach var="mail" items="${mailList}">

							<tr>
								<!-- 메일 순번  -->
								<td>${mail.receiveMailId}<input type="hidden"
									value="${mail.receiveMailId}" id="receiveMailId"></td>
								<!-- 제   목  -->
								<td><a href="/getReceiveMail/${mail.receiveMailId}"> ${mail.receiveMailTitle}</a></td>
								<!-- 보낸 사람  -->
								<td>${mail.receiveMailSenderEmail}</td>
								<!-- 받은 시간  -->
								<td>${mail.receiveMailReservationDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
								<!-- 읽음 여부  -->
								<td>${mail.receiveMailReadStatus}</td>
								<!-- 읽은 날짜  -->
								<td>${mail.receiveMailReadDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"))}</td>
								<!-- 휴지통 이동 -->
								<td><a href="/changeReceiveIsDelete/${mail.receiveMailId}"
									class="btn-center"> <i class="fas fa-trash"></i></a></td>
								<!-- 중요함 이동 -->
								<td><a href="/changeReceiveImportant/${mail.receiveMailId}"
									class="btn-center"><i class="fas  fa-star"></i></a></td>

							</tr>

						</c:forEach>
					</tbody>
				</table>
						</c:if>
						
		
		
		<!-- 모달 -->				


<div class="container mt-3">
  
  <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#myModal">
    사용자 검색
  </button>
</div>

<!-- The Modal -->
<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">수신자를 선택해서 추가하세요</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
     <table class="table">
							<tr>
								<td><select
									class="custom-select custom-select-sm form-control form-control-sm"
									name="searchType" id="searchType">
										<option value="UserName">이름</option>
										<option value="Team">부서</option>
								</select></td>
								<td>
									<div class="input-group">
										<input type="text"
											class="form-control bg-light border-0 small"
											placeholder="검색할 단어를 입력하세요" aria-label="Search"
											aria-describedby="basic-addon2" id="searchInput1">
										<div class="input-group-append">
											<button id="btn-userSearch" class="btn btn-primary">
												<i class="fas fa-search fa-sm"></i>
											</button>															
										</div>
									</div>
								</td>
							</tr>
						</table>
						<c:if test="${searchType eq 'UserName'}">
							<table class="table">
					<thead>
						<tr>
							<th>사원 이름</th>
							<th>사원 번호</th>
							<th>해당 부서</th>
							<th>사원 메일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="user" items="${userList}">
							<tr>
							<td>${user.userName}</td>
							<td>${user.userNum}</td>
							<td>${user.userTeamId.teamName}</td>
							<td>${user.userEmail}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
						</c:if>
						<c:if test="${searchType eq 'Team'}">
						<table class="table">
					<thead>
						<tr>
							<th>부서</th>
							<th>직급</th>
							<th>이름</th>
							<th>메일</th>
						</tr>
					</thead>
				<!-- 	<tbody>
						<c:forEach var="user" items="${userList}">
							<tr>
							    <td>${user.userTeamId.teamName}</td>
								<td>${user.UserPosition.userPosition}</td>
							    <td>${user.userName}</td>	
							    <td>${user.userEmail}</td>	
							</tr>
						</c:forEach>
					</tbody>
					 -->
				</table>
						</c:if>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
		
						
		<!--자동완성  -->				
			<div class="container mt-3">
  
  <form>
    <label for="browser" class="form-label"></label>
    <input class="form-control" list="browsers" name="browser" id="browser">
    <datalist id="browsers">
    <c:forEach var="user" items="${userList}">
      <option value="${user.userName}">${user.userEmail} 
      </c:forEach>
    </datalist>    
    <button type="button" class="btn btn-primary mt-3" onclick="submitForm()">Submit</button>
  </form>
</div>

<script>
function submitForm() {
	  var selectedBrowser = document.getElementById("browser").value;
	  window.location.href = "/mail_main/" + selectedBrowser;
}

$("#btn-userSearch").on("click", () => {
    alert("검색 요청");

    let searchType = $("#searchType").val();
    let searchInput = $("#searchInput1").val();

    $.ajax({
        type: "GET",
        url: "/mail_main/"+searchType+"/"+searchInput,
        dataType: "json",
    }).done(function(response) {
        console.log(response);
        alert("검색 완료");

        // 받은 데이터를 화면에 표시하는 코드를 작성
        let tableBody = $("#userTable tbody");
        tableBody.empty(); // 테이블 내용 초기화

        $.each(response, function(index, user) {
            let row = "<tr>" +
                        "<td>" + user.userName + "</td>" +
                        "<td>" + user.userNum + "</td>" +
                        "<td>" + user.userTeamId.teamName + "</td>" +
                        "<td>" + user.userEmail + "</td>" +
                      "</tr>";
            tableBody.append(row); // 새로운 행 추가
        });
    }).fail(function(error) {
        console.error(error);
        alert("검색 실패: " + error);
    });
});
	      


	     
	    
	  
	
	
</script>			
	
					
						
						
						
						
</div>
</div>
</div>
<script src="/js/mailSearch.js"></script>


</body>
</html>