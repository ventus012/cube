<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>
<div id="wrapper">
		<!-- Sidebar -->
		<ul
			class="navbar-nav sidebar sidebar-dark accordion"
			style="background-image: linear-gradient(to bottom, #398e65, #35835e, #317956, #2e6e4f, #2a6448);"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center mx-2"
				href="/index"> <img src="/image/logo_3.svg" alt="CUBE_icon"
				style="width: auto; height: 30px;">

				<div class="sidebar-brand-text mx-2">CUBE</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item active"><a class="nav-link" href="/my_main">
					<i class="fas fa-fw fa-home"></i> <span>My</span>
			</a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">My</div>
			
			<li class="nav-item"><a class="nav-link" href="/my_profileCheckPw">
					<i class="fas fa-user-alt mr-2"></i> <span>내 정보</span>
			</a></li>
			
			<li class="nav-item"><a class="nav-link" href="/my_changePwCheckPw">
					<i class="fas fa-key"></i> <span>비밀번호 변경</span>
			</a></li>
			

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

		</ul>
		<!-- End of Sidebar -->
		</div>
</body>
</html>