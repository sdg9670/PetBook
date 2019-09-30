<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="db.reports.ReportsDAO" %>
<%@ page import="db.reports.ReportsDTO" %>
<% 
	response.setContentType("text/html; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
%>



<%
	ReportsDAO rd = new ReportsDAO();
	rd.dropReport(Integer.parseInt(request.getParameter("writeid")));
	response.sendRedirect("index.jsp");
%>