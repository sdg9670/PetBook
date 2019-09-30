<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="db.comments.CommentsDAO" %>
<%@ page import="db.comments.CommentsDTO" %>
<% 
	response.setContentType("text/html; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
%>



<%
	CommentsDAO cd = new CommentsDAO();
	int drop_result = cd.dropComment(Integer.parseInt(request.getParameter("commentid")));
	if(drop_result == 1) {
	%>
	<jsp:forward page="view.jsp">
		<jsp:param value="<%=request.getParameter(\"writeid\")%>" name="last_id"/>
	</jsp:forward>
	<%
	}  else {%>
	<script type="text/javascript">
		alert("서버 오류가 있습니다.");
		location.href = "profile_edit.jsp";
	</script>
<% } %>