<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="db.users.UsersDAO" %>
<%@ page import="etc.Etc" %>
<% 
	response.setContentType("text/html; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
%>


<jsp:useBean id="users" class="db.users.UsersDTO">
	<jsp:setProperty property="*" name="users"/>
</jsp:useBean>

<%
/*
1. 이메일 형식 체크
    String regex = "^[_a-zA-Z0-9-\\.]+@[\\.a-zA-Z0-9-]+\\.[a-zA-Z]+$";

2. 숫자만 입력 체크
    String regex = "^[0-9]+$";  // 정수형만 체크
   String regex = "^[+-]?\\d*(\\.?\\d*)$";  //실수형까지 체크

3. 아이디 형식 체크
    String regex = "[0-9a-zA-Z가-힣\\w\\.]+$";
    
4. 날짜 체크
"^(19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])$"

*/
if(users.getEmail() == null || !Etc.checkRegex(users.getEmail(), "^[_a-zA-Z0-9-\\.]+@[\\.a-zA-Z0-9-]+\\.[a-zA-Z]+$") || users.getEmail().length() > 128)
{
%>
	<script type="text/javascript">
		alert("이메일 형식이 잘못되었습니다.");
		location.href = "reg.jsp";
	</script>
<%
	return ;
} else if(users.getPassword() == null || request.getParameter("password_confirm") == null || users.getPassword().length() < 3)
{
%>
	<script type="text/javascript">
		alert("비밀번호 형식이 잘못되었습니다.");
		location.href = "reg.jsp";
	</script>
<%
	return ;
} else if(!users.getPassword().equals(request.getParameter("password_confirm")))
{
%>
	<script type="text/javascript">
		alert("비밀번호가 서로 일치하지 않습니다.");
		location.href = "reg.jsp";
	</script>
<%
	return ;
}  else if(users.getBirthday() == null || !Etc.checkRegex(users.getBirthday(), "^(19|20)\\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$"))
{
%>
	<script type="text/javascript">
		alert("생일 형식이 잘못되었습니다.");
		location.href = "reg.jsp";
	</script>
<%
	return ;
} else if(users.getName() == null || !Etc.checkRegex(users.getName(), "^[가-힣a-zA-Z0-9\\w\\.]{3,32}+$"))
{
%>
	<script type="text/javascript">
		alert("이름 형식이 잘못되었습니다.");
		location.href = "reg.jsp";
	</script>
<%
	return ;
} else if(users.getIntroduce() == null)
	users.setIntroduce("");
%>


<%
	UsersDAO ud = new UsersDAO();
	int reg_result = ud.registerUser(users);
	if(reg_result == 1) {
		session.setAttribute("email", users.getEmail());
		response.sendRedirect("index.jsp");
	} else if(reg_result == 0) { %>
	<script type="text/javascript">
		alert("이미 해당 이메일은 이미 사용 중 입니다.");
		location.href = "reg.jsp";
	</script>
<% } else {%>
	<script type="text/javascript">
		alert("서버 오류가 있습니다.");
		location.href = "reg.jsp";
	</script>
<% } %>