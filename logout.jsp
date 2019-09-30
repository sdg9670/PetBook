<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<%
	session.invalidate();
	response.sendRedirect("main.jsp");
%>