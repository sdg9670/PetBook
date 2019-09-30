<%@ page  language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

	<%@ include file="head.jsp" %>

	<%
		if(session.getAttribute("email") == null)
		{
	%>
		<jsp:forward page="main.jsp"/>
	<%} %>
	<body style="background-color: #f4f4f4;">
		<nav class="navbar navbar-fixed-top navbar-default" role="navigation">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
						data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
						<span class="sr-only"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="index.jsp" style="font-weight:bold">Pet Book</a>
				</div>
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav navbar-right" style="font-weight:bold">
						<li><a href="profile.jsp">My</a></li>
						<li><a href="logout.jsp">Logout</a></li>
					</ul>
					<form method="post" action="search.jsp" class="navbar-form">
						<div class="form-group">
							<input type="hidden" name="url" value="<%=request.getRequestURI()%>">
							<input type="text" class="form-control" name="key" style="max-width: 300px; margin:0 auto" placeholder="내용을 입력하세요.">
						</div>
						<button type="submit" class="btn btn-default">검색</button>
					</form>
				</div>
			</div>
		<hr class="garo"></hr>
		</nav>
	<div style="margin:0px 0px 50px 0px"> </div>