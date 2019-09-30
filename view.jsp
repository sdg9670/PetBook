<%@ page  language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="nav.jsp" %>

	<div class="container">
		<div class="col-md-12" id="post-data">
			<jsp:include page="loadMoreData.jsp">
				<jsp:param value="view" name="type"/>
				<jsp:param value="1" name="amount"/>
				<jsp:param value="<%=request.getParameter(\"last_id\")+\"_0\"%>" name="last_id"/>
			</jsp:include>
		</div>
	</div>


<%@ include file="footer.jsp" %>
