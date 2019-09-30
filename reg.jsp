<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="head.jsp" %>
<body>
	<div style="text-align: center;">
		<h1 style="color: rgb(241, 196, 15); font-size:59px; font-weight: bold;">PetBoook</h1>
		<h5 style="color: #000000;">PetBook에 오신 것을 환영합니다.<br>이제 반려동물의 이야기로 다양한 커뮤니케이션을 해보세요 !</h5>
	</div>
	<br>
	<br>
	<br>
	
		<form method="post" action="reg_sub.jsp" style="text-align:center;">
			<h3>회원가입</h3>
			<div  style="max-width:250px; display: inline-block !important;">
				<div class="input-group" style="margin:5px">
					<span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
					<input id="email" type="text" class="form-control" name="email" placeholder="Email">
				</div>
				<div class="input-group" style="margin:5px">
					<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
					<input id="password" type="password" class="form-control" name="password" placeholder="Password">
				</div>
				<div class="input-group" style="margin:5px">
					<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
					<input id="password_confirm" type="password" class="form-control" name="password_confirm" placeholder="Password Confirm">
				</div>
				<div class="input-group" style="margin:5px">
					<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
					<input id="name" type="text" class="form-control" name="name" placeholder="Name">
				</div>
				<div class="input-group" style="margin:5px">
					<span class="input-group-addon"><i class="glyphicon glyphicon-gift"></i></span>
					<input id="birthday" type="text" class="form-control" name="birthday" size="8" placeholder="Birthday ex) 1997-01-29">
				</div>
				<div class="input-group" style="margin:5px">
					<span class="input-group-addon"><i class="glyphicon glyphicon-info-sign"></i></span>
					<textarea class="form-control" rows="5" id="introduce" name="introduce" placeholder="소개"></textarea>
				</div>
				<button type="submit" class="btn btn-md" style="margin:5px">회원가입</button>
			</div>
		</form>
	
		
		<div class="col-sm-4"></div>
	<br><br><br>


<%@ include file="footer.jsp" %>