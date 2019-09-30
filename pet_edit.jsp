<%@ page  language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="nav.jsp" %>
<%@ page import = "db.pets.PetsDAO" %>
<%@ page import = "db.pets.PetsDTO" %>
<%
	PetsDAO pdao = new PetsDAO();
	PetsDTO pdto = pdao.getPet(Integer.parseInt(request.getParameter("petid")));
%>
	<div class="container">
		<div style="margin: auto; max-width:500px;">
			<div class="row" style=" text-align:center; margin-top:20px">				
				<div class="col-sm-4">
					<img src="<%=pdto.getProfilepicture()%>" class="img-circle" style="width: 150px; height: 150px;"><br>
					<form name="file_upload" action="pet_upload.jsp" enctype="multipart/form-data" method="post" class="filebox">
					  <label for="ex_file">업로드</label>
					  <input type="hidden" name="petid" value="<%=pdto.getId()%>">
					  <input type="file" name="file1" id="ex_file" onchange="document.file_upload.submit();">
					</form>
				</div>
				<div class="col-sm-8">
					<h1>
						<b><%=pdto.getName()%></b><br><br>
						<form action="petdrop_sub.jsp" method="post" name="petdrop">
							<input type="hidden" name="petid" value="<%=pdto.getId()%>">
							<button type="button" class="btn btn-danger" onclick="document.petdrop.submit();">삭제</button>
						</form>
					</h1>
				</div>
			</div>
			<hr class="garo" style="width:550px; margin:20px 0px 20px 0px"/>
			<div style="margin-top:20px">
				<form method="post" action="pet_edit_sub.jsp" style="text-align:center;">
					<h2>개인정보 수정</h2>
					<div  style="max-width:250px; display: inline-block !important;">
						<div class="input-group" style="margin:5px">
							<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
							<input id="name" type="text" class="form-control" name="name" placeholder="Name" value="<%=pdto.getName()%>">
						</div>
						<div class="input-group" style="margin:5px">
							<span class="input-group-addon"><i class="glyphicon glyphicon-gift"></i></span>
							<input id="birthday" type="text" class="form-control" name="birthday" placeholder="Birthday ex) 1997-01-29" value="<%=pdto.getBirthday()%>">
						</div>
						<div class="input-group" style="margin:5px">
							<span class="input-group-addon"><i class="glyphicon glyphicon-tag"></i></span>
							<input id="type" type="text" class="form-control" name="type" placeholder="종류" value="<%=pdto.getType()%>">
						</div>
						<div class="input-group" style="margin:5px">
							<span class="input-group-addon"><i class="glyphicon glyphicon-info-sign"></i></span>
							<textarea class="form-control" rows="5" id="intro" name="introduce" placeholder="소개"><%=pdto.getIntroduce()%></textarea>
						</div>
						<input type="hidden" name="id" value="<%=pdto.getId()%>">
						<button type="submit" class="btn btn-md" style="margin:5px;  background-color: #777777; color:#FFFFFF;">반려동물 정보 수정</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>

<%@ include file = "footer.jsp" %>