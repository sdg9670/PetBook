<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="db.pets.PetsDAO"%>

<%
	PetsDAO pdao = new PetsDAO();
	pdao.setFollowing(Integer.parseInt(request.getParameter("userid")), Integer.parseInt(request.getParameter("petid")));
%>
	<jsp:forward page="profile.jsp">
		<jsp:param value="<%=request.getParameter(\"prouseremail\")%>" name="email"/>
		<jsp:param value="<%=request.getParameter(\"petid\")%>" name="petid"/>
	</jsp:forward>