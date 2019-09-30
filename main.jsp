<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="head.jsp" %>

<%
	if(session.getAttribute("email") != null)
		response.sendRedirect("index.jsp");
%>
<body>
	<div style="text-align: center;">
		<h1 style="color: rgb(241, 196, 15); font-size:59px; font-weight: bold;">PetBoook</h1>
		<h5 style="color: #000000;">PetBook에 오신 것을 환영합니다.<br>이제 반려동물의 이야기로 다양한 커뮤니케이션을 해보세요 !</h5>
	</div>
	<br>
	<br>
	<br>
	<div class="container"  style="margin: auto; max-width:600px; text-align:center;">
		<div class="row">
			<div class="col-sm-6" style="text-align:center">
				<img src="images/main_cat.jpg" width=280px class="img-thumbnail" alt="Petboot Main Image">
			</div>
			<div class="col-sm-6">
				<h3>로그인</h3>
				<form method="post" action="login_sub.jsp" style="text-align:center;">
					<div  style="max-width:250px; display: inline-block !important;">			
						<div class="input-group" style="margin:5px;">
							<span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
							<input id="email" type="text" class="form-control" name="email" placeholder="Email">
						</div>
						<div class="input-group" style="margin:5px;">
							<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
							<input id="password" type="password" class="form-control" name="password" placeholder="Password">
						</div>

				  		<button type="submit" class="btn btn-md" style="margin:5px">로그인</button>
					</div>
				</form>
				<hr class="garo"></hr>
				<form>
					<h3>혹시 계정이 없으신가요?</h3>
				  	<button class="btn btn-md" style="margin:5px" onclick="location.href='reg.jsp'; return false;">회원가입</button>
				</form>
			</div>
		</div>
	</div>
	<br><br><br>


<%@ include file="footer.jsp" %>