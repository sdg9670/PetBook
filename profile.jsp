<%@ page  language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import = "db.users.UsersDAO" %>
<%@ page import = "db.users.UsersDTO" %>
<%@ page import = "db.pets.PetsDAO" %>
<%@ page import = "db.pets.PetsDTO" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Iterator" %>
<%@ include file="nav.jsp" %>

<%
	UsersDTO udto = new UsersDTO();
	UsersDAO udao = new UsersDAO();
	String email = request.getParameter("email")==null ? session.getAttribute("email").toString() : request.getParameter("email");
	udto = udao.getUser(email);
	UsersDTO cur_udto = udao.getUser(session.getAttribute("email").toString());
	int petid = request.getParameter("petid") == null ? -1 : Integer.parseInt(request.getParameter("petid") );
	PetsDTO pets = null;
	PetsDAO pdo = new PetsDAO();
	if(petid != -1)
	{
		pets = pdo.getPet(petid);
	}
%>
<style>
	.ajax-load{
		width: 100%;
	}
</style>

<script type="text/javascript">
    $(window).scroll(function() {
        if($(window).scrollTop() + $(window).height() >= $(document).height()) {
            var last_id = $(".post-id:last").attr("id");
            loadMoreData(last_id);
        }
    });
    function loadMoreData(last_id){
      $.ajax(
            {
                url: 'loadMoreData.jsp?type=pet&amount=1&last_id=' + last_id,
                type: "get",
                beforeSend: function()
                {
                    $('.ajax-load').show();
                }
            })
            .done(function(data)
            {
            	if(data == " "){
	                return;
	            }
                $('.ajax-load').hide();
                $("#post-data").append(data);
            })
            .fail(function(jqXHR, ajaxOptions, thrownError)
            {
                  //alert('server not responding...');
            });
    }

	function go4(email){ 
		var form = document.createElement("form");
		form.setAttribute("charset", "UTF-8");
		form.setAttribute("method", "Post"); 
		form.setAttribute("action", "profile_edit.jsp");
		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "email");
		hiddenField.setAttribute("value", email);
		form.appendChild(hiddenField);
		document.body.appendChild(form);
		form.submit();
	} 
	function go(email, value){ 
		if(value == -1)
	   		window.location.href="pet_add.jsp"; 
		else
		{
			var form = document.createElement("form");
			form.setAttribute("charset", "UTF-8");
			form.setAttribute("method", "Post"); 
			form.setAttribute("action", "profile.jsp");
			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "email");
			hiddenField.setAttribute("value", email);
			form.appendChild(hiddenField);
			hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "petid");
			hiddenField.setAttribute("value", value);
			form.appendChild(hiddenField);
			document.body.appendChild(form);
			form.submit();
		}
	} 
</script> 




	<div id="write" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content form-group">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">글 작성</h4>
				</div>
				<form action="write_sub.jsp" method="post" enctype="multipart/form-data">
				<div class="modal-body">
				  <textarea name="content" class="form-control" rows="10"></textarea>
				  <input type="file" name="file1">
				  <%if(petid != -1)
				  { %>
				  <input type="hidden" name="petid" value="<%=pets.getId()%>">
				 <%}%>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-default">작성</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
				</form>
			</div>

		</div>
	</div>

	<div class="container">
		<div style="margin: auto; max-width:450px;">
			<div class="row" style="margin-top:20px;">				
				<div class="col-sm-4" style="text-align:center">
					<img src="<%=udto.getProfilepicture()%>" class="img-circle" style="width: 150px; height: 150px;">
				</div>
				<div class="col-sm-8" style="padding:0px 50px 0px 50px;">
					<h3>
						<b><%=udto.getName()%></b>
					</h3>
					<b>생일</b> <%=udto.getBirthday().toString()%><br>
					<b>소개</b><br><%=udto.getIntroduce().replace("\r\n",  "<br>")%><br>
					<%if(email.equals(session.getAttribute("email")) || cur_udto.getAdmin() == 1) {%>
						<div style="text-align:right"><a href="#" onclick="go4('<%=udto.getEmail()%>');"><span class="glyphicon glyphicon-pencil"></span>&nbsp;개인정보 수정</a></div>
					<%}%>
				</div>
			</div>
			
			<hr class="garo" style="width:450px; margin:20px 0px 20px 0px"/>
			
			<div class="row" style="margin-top:20px;">				
				<div class="col-sm-4" style="text-align:center">
					<%if(petid != -1) {%>
					<img src="<%=pets.getProfilepicture() %>" class="img-circle" style="width: 150px; height: 150px;"><br><br>
					<%} %>
					<div class="form-group">
						<select class="form-control" id="sel_pet" style="max-width:200px;" onchange="go('<%=email%>', this.value);">
							<%
							PetsDAO pdao = new PetsDAO();
							Vector<PetsDTO>  petList= pdao.getPetsList(udto.getId());
							Iterator<PetsDTO> it = petList.iterator();
							
							PetsDTO pdto;
							int i = 0;
							int firstpet = -1;
							while(it.hasNext()) {
								pdto=it.next();
							%>
							<option <%if(i==0 || pdto.getId()==petid){%>selected="selected"<%}%> value="<%=pdto.getId()%>"><%=pdto.getName()%></option>
							<%
								i++;
								if(i == 1)
									firstpet = pdto.getId();
							}
							if(i == 0) {%>
							<option value="-1"> </option>
							<%}%>
							<% if(email.equals(session.getAttribute("email"))) {%>
							<option value="-1">반려동물 추가</option>
							<%} %>
						</select>
					</div>
				</div>
				<div class="col-sm-8" style="padding:0px 50px 0px 50px">
				<% 
					if(petid == -1)
					{
						if(i > 0)
						{
							petid = firstpet;
				%>
						<jsp:forward page="profile.jsp">
							<jsp:param value="<%=email%>" name="email"/>
							<jsp:param value="<%=petid%>" name="petid"/>
						</jsp:forward>
				<%
						}
					}
					else
					{
				%>
					<h3>
						<b><%=pets.getName()%></b>
					</h3>
					<b>생일</b> <%=pets.getBirthday()%><br>
					<b>종류</b> <%=pets.getType()%><br>
					<b>소개</b><br><%=pets.getIntroduce().replace("\r\n",  "<br>")%><br>
					<br>
					<b>팔로워</b> <%=pdo.getFollowingCount(pets.getId()) %><br>
					<%if(email.equals(session.getAttribute("email"))) {%>
					<form action="pet_edit.jsp" method="post" name="petform">
						<input type="hidden" name="petid" value="<%=pets.getId()%>">
						<div style="text-align:right"><a onclick="document.petform.submit();"><span class="glyphicon glyphicon-pencil"></span>&nbsp;반려동물 정보 수정</a></div>
					</form>
					<% } else { 
					%>
					<form method="post" action="following_sub.jsp">
					<%
						if(pdao.getFollowing(cur_udto.getId(), pets.getId())) {
					%>
						<button type="submit" class="btn  btn-sm" style="margin:5px; background-color: #FFB2F5; color:#000000;">Following..</button>
					<% } else {%>
						<button type="submit" class="btn  btn-sm" style="margin:5px; background-color: #777777; color:#FFFFFF;">Follow?</button>
					<%}%>
						<input type="hidden" name="userid" value="<%=cur_udto.getId()%>">
						<input type="hidden" name="petid" value="<%=pets.getId()%>">
						<input type="hidden" name="prouseremail" value="<%=udto.getEmail()%>">
					<%}%>
					</form>
				<%}%>
				</div>
			</div>
		</div>
	</div>
	<% if(petid != -1) { %>
	<div class="container" style="margin-top:30px;">
		<div style="text-align:center">
		<% if(udto.getEmail().equals(cur_udto.getEmail())) {%>
			<button class="btn  btn-md" style="margin:5px; background-color: #777777; color:#FFFFFF;" data-toggle="modal" data-target="#write" >글쓰기</button>
		<%} %>
		</div>
		<div class="col-md-12" id="post-data">
			<jsp:include page="loadMoreData.jsp">
				<jsp:param value="pet" name="type"/>
				<jsp:param value="5" name="amount"/>
				<jsp:param value="<%=\"999999999_\"+pets.getId()%>" name="last_id"/>
			</jsp:include>
		</div>
	</div>
	<div class="ajax-load text-center" style="display:none">
    	<p><img src="images/loader.gif">Loading...</p>
	</div>
</body>
<% } %>
<%@ include file = "footer.jsp" %>