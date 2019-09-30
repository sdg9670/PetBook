<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="db.pets.PetsDAO" %>
<%@ page import="db.users.UsersDAO" %>
<%@ page import="db.users.UsersDTO" %>
<%@ page import="etc.Etc" %>
<% 
	response.setContentType("text/html; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
%>


<jsp:useBean id="pet" class="db.pets.PetsDTO">
	<jsp:setProperty property="*" name="pet"/>
</jsp:useBean>

<%
if(pet.getBirthday() == null || !Etc.checkRegex(pet.getBirthday(), "^(19|20)\\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$"))
{
%>
	<script type="text/javascript">
		alert("생일 형식이 잘못되었습니다.");
		location.href = "pet_add.jsp";
	</script>
<%
	return ;
} else if(pet.getName() == null || !Etc.checkRegex(pet.getName(), "^[가-힣a-zA-Z0-9\\w\\.]{1,32}+$" ))
{
%>
	<script type="text/javascript">
		alert("이름 형식이 잘못되었습니다.");
		location.href = "pet_add.jsp";
	</script>
<%
	return ;
} else if(pet.getType() == null || !Etc.checkRegex(pet.getType(), "^[가-힣a-zA-Z0-9\\w\\.]{1,32}+$"))
{
%>
	<script type="text/javascript">
		alert("종류 형식이 잘못되었습니다.");
		location.href = "pet_add.jsp";
	</script>
<%
	return ;
} else if(pet.getIntroduce() == null)
	pet.setIntroduce("");

UsersDAO udo = new UsersDAO();
UsersDTO udt = udo.getUser(session.getAttribute("email").toString());


pet.setPetuser(udt.getId());
%>


<%
	PetsDAO pd = new PetsDAO();
	int reg_result = pd.updatePet(pet);
	if(reg_result == 1) {
%>
<jsp:forward page="profile.jsp">
	<jsp:param value="<%=pet.getId()%>" name="petid"/>
</jsp:forward>
<%
		response.sendRedirect("profile.jsp");
	} else {%>
	<script type="text/javascript">
		alert("서버 오류가 있습니다.");
		location.href = "pet_add.jsp";
	</script>
<% } %>