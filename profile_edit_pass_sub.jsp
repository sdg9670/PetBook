<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import = "db.users.UsersDAO" %>
<%@ page import = "etc.Etc" %>
<%
	response.setContentType("text/html; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="users" class="db.users.UsersDTO">
	<jsp:setProperty property="*" name="users"/>
</jsp:useBean>

<%
if(users.getPassword() == null || request.getParameter("password_confirm") == null || users.getPassword().length() < 3)
{
%>
	<script type="text/javascript">
		alert("비밀번호 형식이 잘못되었습니다.");
		location.href = "profile_edit.jsp";
	</script>
<%
return ;
} else if(!users.getPassword().equals(request.getParameter("password_confirm")))
{
%>
	<script type="text/javascript">
		alert("비밀번호가 서로 일치하지 않습니다.");
		location.href = "profile_edit.jsp";
	</script>
<%
	return ;
} 
%>


<%
	UsersDAO ud = new UsersDAO();
	users.setEmail(request.getParameter("email"));
	int result = ud.changePassword(users);
	if(result == 1) {
		%>
		<jsp:forward page="profile_edit.jsp">
			<jsp:param value="<%=users.getEmail()%>" name="email"/>
		</jsp:forward>
		<%
	} else {%>
	<script type="text/javascript">
		alert("서버 오류가 있습니다.");
		location.href = "profile_edit.jsp";
	</script>
<% } %>