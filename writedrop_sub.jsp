<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="db.writes.WritesDAO" %>
<% 
	response.setContentType("text/html; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
%>



<%
	WritesDAO wd = new WritesDAO();
	int drop_result = wd.dropWrite(Integer.parseInt(request.getParameter("writeid")));
	String type = request.getParameter("type");
	if(drop_result == 1) {
		if(type.equals("pet"))
			response.sendRedirect("profile.jsp");
		else if(type.equals("index"))
			response.sendRedirect("index.jsp");
		else if(type.equals("report"))
			response.sendRedirect("index.jsp");
	}  else {%>
	<script type="text/javascript">
		alert("서버 오류가 있습니다.");
		location.href = "profile_edit.jsp";
	</script>
<% } %>