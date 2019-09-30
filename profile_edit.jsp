<%@ page  language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="nav.jsp" %>
<%@ page import = "db.users.UsersDAO" %>
<%@ page import = "db.users.UsersDTO" %>
<%
	UsersDAO udao = new UsersDAO();
	UsersDTO udto = udao.getUser(request.getParameter("email"));
%>
	<div class="container">
		<div style="margin: auto; max-width:500px;">
			<div class="row" style=" text-align:center; margin-top:20px">				
				<div class="col-sm-4">
					<img src="<%=udto.getProfilepicture()%>" class="img-circle" style="width: 150px; height: 150px;">
					<form name="file_upload" action="profile_upload.jsp" enctype="multipart/form-data" method="post" class="filebox">
					  <label for="ex_file">업로드</label>
					  <input type="hidden" name="email" value=<%=udto.getEmail()%>>
					  <input type="file" name="file1" id="ex_file" onchange="document.file_upload.submit();">
					</form>
				</div>
				<div class="col-sm-8">
					<h1>
						<b><%=udto.getName()%></b>
					</h1>
					<br><%=udto.getEmail()%><br><br>
					<form method="post" action="userdrop_sub.jsp">
						<input type="hidden" name="email" value="<%=udto.getEmail()%>">
						<button type="submit" class="btn btn-danger" style="margin:5px;" onClick="location.href='userdrop_sub.jsp';">회원 탈퇴</button>
					</form>
				</div>
			</div>
			<hr class="garo" style="width:550px; margin:20px 0px 20px 0px"/>
			<div style="margin-top:20px">
				<form method="post" action="profile_edit_pass_sub.jsp" style="text-align:center;">
					<h2>비밀번호 변경</h2>
					<div  style="max-width:250px; display: inline-block !important;">
						<div class="input-group" style="margin:5px">
							<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
							<input id="password" type="password" class="form-control" name="password" placeholder="Password">
						</div>
						<div class="input-group" style="margin:5px">
							<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
							<input id="password_confirm" type="password" class="form-control" name="password_confirm" placeholder="Password Confirm">
						</div>
					  	<input type="hidden" name="email" value=<%=udto.getEmail()%>>
						<button type="submit" class="btn btn-md" style="margin:5px;  background-color: #777777; color:#FFFFFF;">비밀번호 변경</button>
					</div>
				</form>
				<hr class="garo" style="width:550px; margin:20px 0px 20px 0px"/>
				<form name="form1" method="post" action="profile_edit_sub.jsp" style="text-align:center;">
					<h2>개인정보 수정</h2>
					<div  style="max-width:250px; display: inline-block !important;">
						<div class="input-group" style="margin:5px">
							<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
							<input id="name" type="text" class="form-control" name="name" placeholder="Name" value="<%=udto.getName()%>">
						</div>
						<div class="input-group" style="margin:5px">
							<span class="input-group-addon"><i class="glyphicon glyphicon-gift"></i></span>
							<input id="birthday" type="text" class="form-control" name="birthday" placeholder="Birthday ex) 1997-01-29" value="<%=udto.getBirthday()%>">
						</div>
						<div class="input-group" style="margin:5px">
							<span class="input-group-addon"><i class="glyphicon glyphicon-info-sign"></i></span>
							<textarea class="form-control" rows="5" id="intro" name="introduce" placeholder="소개"><%=udto.getIntroduce()%></textarea>
						</div>
					  	<input type="hidden" name="email" value=<%=udto.getEmail()%>>
						<button type="submit" class="btn btn-md" style="margin:5px; background-color: #777777; color:#FFFFFF;">정보 수정</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>

<%@ include file = "footer.jsp" %>