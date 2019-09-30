<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="db.users.UsersDAO" %>

<%
	response.setContentType("text/html; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");

	String email = request.getParameter("email");
	String password = request.getParameter("password");
	
	UsersDAO ud = new UsersDAO();
	int result = ud.loginUser(email, password);
	if(result == 1) {
		session.setAttribute("email", email);
%>
<jsp:forward page="index.jsp"/>
<%
	} else if (result == 0) {
%>
	<script type="text/javascript">
		alert("이메일 또는 비밀번호가 잘못되었습니다.");
		location.href = "main.jsp";
	</script>
<%
	} else {
%>
	<script type="text/javascript">
		alert("서버 오류가 있습니다.");
		history.back();
	</script>
<% } %>