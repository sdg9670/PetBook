<%@ page  language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="db.users.UsersDAO" %>
<%@ page import="db.users.UsersDTO" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Iterator" %>

<%@ include file="nav.jsp" %>
<% 
	String key = request.getParameter("key");
	if(key == null || key.length() == 0)
		{
%>


	<script type="text/javascript">
		alert("검색할 내용을 입력하세요.");
		location.href="<%=request.getParameter("url")%>";
	</script>
<% } %>
<div class="container">
	<div style="margin: auto; margin-top:60px; margin-bottom:30px; max-width:450px; text-align:center; background-color:#ffffff; padding:20px;">
			
		<div class="row">
			<a href="#">
				<div class="col-xs-12">
					인물
				</div>
			</a>
		</div>
		<hr class="garo" style="margin-top:10px; margin-bottom:10px"></hr>
		<ul class="list-group">
<%
	UsersDAO users = new UsersDAO();
	Vector<UsersDTO>  userList= users.searchUser(key);
	Iterator<UsersDTO> it = userList.iterator();
	
	UsersDTO user;
	int i = 0;
	while(it.hasNext()) {
		user=it.next();
%>
			<form name="proform_<%=i%>" method="post" action="profile.jsp">
				<a href="#" onclick="document.proform_<%=i%>.submit();" class="list-group-item" style="border: 0 none;">
					<div class="row">
						<input name="email" type="hidden" value="<%=user.getEmail()%>">
						<div class="col-xs-3">
							<img src="<%=user.getProfilepicture()%>" class="img-circle" style="width: 100px; height: 100px;">
						</div>
						<div class="col-xs-9" style="text-align:left;">
							<b><%=user.getName()%></b><br>
							<span style="font-size: 0.7em;"><%=user.getBirthday()%></span><br>
							<%=user.getIntroduce().replace("\r\n", "<br>")%>
						</div>
					</div>
				</a>
			</form>
<% i++; } %>
		</ul>
	</div>
</div>

<%@ include file = "footer.jsp" %>