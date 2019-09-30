<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="db.reports.ReportsDAO"%>
<%@ page import="db.reports.ReportsDTO"%>
<%@ page import="db.users.UsersDAO"%>
<%@ page import="db.users.UsersDTO"%>
<%
	request.setCharacterEncoding("utf-8");
	ReportsDAO rdao = new ReportsDAO();
	ReportsDTO report = new ReportsDTO();
	UsersDAO udao = new UsersDAO();
	UsersDTO udto = udao.getUser(session.getAttribute("email").toString());
	report.setContent(request.getParameter("content"));
	report.setUser(udto.getId());
	report.setWrite(Integer.parseInt(request.getParameter("writeid")));
	rdao.createReport(report);
%>
<jsp:forward page="view.jsp">
	<jsp:param value="<%=request.getParameter(\"writeid\")%>" name="last_id"/>
</jsp:forward>