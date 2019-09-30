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
if(users.getBirthday() == null || !Etc.checkRegex(users.getBirthday(), "^(19|20)\\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$"))
{
%>
	<script type="text/javascript">
		alert("생일 형식이 잘못되었습니다.");
		location.href = "profile_edit.jsp";
	</script>
<%
	return ;
} else if(users.getName() == null || !Etc.checkRegex(users.getName(), "^[가-힣a-zA-Z0-9\\w\\.]{3,32}+$"))
{
%>
	<script type="text/javascript">
		alert("이름 형식이 잘못되었습니다.");
		location.href = "profile_edit.jsp";
	</script>
<%
	return ;
} else if(users.getIntroduce() == null)
	users.setIntroduce("");
%>


<%
	UsersDAO ud = new UsersDAO();
	users.setEmail(request.getParameter("email"));
	users.setName(request.getParameter("name"));
	users.setBirthday(request.getParameter("birthday"));
	users.setIntroduce(request.getParameter("introduce"));
	int reg_result = ud.updateUser(users);
	if(reg_result == 1) {
		%>
		<jsp:forward page="profile.jsp">
			<jsp:param value="<%=users.getEmail()%>" name="email"/>
		</jsp:forward>
		<%
	} else {%>
	<script type="text/javascript">
		alert("서버 오류가 있습니다.");
		location.href = "profile_edit.jsp";
	</script>
<% } %>