<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="db.comments.CommentsDAO"%>
<%@ page import="db.comments.CommentsDTO"%>
<%@ page import="db.users.UsersDAO"%>
<%@ page import="db.users.UsersDTO"%>
<%
	request.setCharacterEncoding("utf-8");
	CommentsDAO cdao = new CommentsDAO();
	CommentsDTO comment = new CommentsDTO();
	UsersDAO udao = new UsersDAO();
	UsersDTO udto = udao.getUser(session.getAttribute("email").toString());
	comment.setContent(request.getParameter("content"));
	comment.setUser(udto.getId());
	comment.setWrite(Integer.parseInt(request.getParameter("writeid")));
	cdao.createComment(comment);
%>
<jsp:forward page="view.jsp">
	<jsp:param value="<%=request.getParameter(\"writeid\")%>" name="last_id"/>
</jsp:forward>