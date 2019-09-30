<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="db.users.UsersDAO" %>
<% 
	response.setContentType("text/html; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
%>



<%
	UsersDAO ud = new UsersDAO();
	int drop_result = ud.dropUser(request.getParameter("email"));
	if(drop_result == 1) {
		if(session.getAttribute("email").toString().equals(request.getParameter("email")))
			session.invalidate();
		response.sendRedirect("index.jsp");
	}  else {%>
	<script type="text/javascript">
		alert("서버 오류가 있습니다.");
		location.href = "profile_edit.jsp";
	</script>
<% } %>