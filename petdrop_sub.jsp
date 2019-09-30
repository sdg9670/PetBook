<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="db.pets.PetsDAO" %>
<% 
	response.setContentType("text/html; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
%>



<%
	PetsDAO pd = new PetsDAO();
	int drop_result = pd.dropPet(Integer.parseInt(request.getParameter("petid")));
	if(drop_result == 1) {
		response.sendRedirect("profile.jsp");
	}  else {%>
	<script type="text/javascript">
		alert("서버 오류가 있습니다.");
		location.href = "pet_edit.jsp";
	</script>
<% } %>