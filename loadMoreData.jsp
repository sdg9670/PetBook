<%@page import="db.pictures.PicturesDAO"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="db.writes.WritesDAO" %>
<%@ page import="db.writes.WritesDTO" %>
<%@ page import="db.pets.PetsDAO" %>
<%@ page import="db.pets.PetsDTO" %>
<%@ page import="db.pictures.PicturesDTO" %>
<%@ page import="db.users.UsersDAO" %>
<%@ page import="db.users.UsersDTO" %>
<%@ page import="db.comments.CommentsDAO" %>
<%@ page import="db.comments.CommentsDTO" %>
<%@ page import="db.reports.ReportsDAO" %>
<%@ page import="db.reports.ReportsDTO" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Iterator" %>

<%
	String splitStrArr[] = request.getParameter("last_id").toString().split("_");
	int id = Integer.parseInt(splitStrArr[0]); 
	int amount = Integer.parseInt(request.getParameter("amount"));
	int puid = Integer.parseInt(splitStrArr[1]);
	String type = request.getParameter("type");
	WritesDAO wdao = new WritesDAO();
	PetsDAO pdao = new PetsDAO();
	PetsDTO pdto =null;
	UsersDAO udao = new UsersDAO(); 
	UsersDTO udto = null;
	UsersDTO cur_udto = udao.getUser(session.getAttribute("email").toString());
%>
	<script>
	function go2(commentid, writeid){ 
		var form = document.createElement("form");
		form.setAttribute("charset", "UTF-8");
		form.setAttribute("method", "Post"); 
		form.setAttribute("action", "commentdrop_sub.jsp");
		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "commentid");
		hiddenField.setAttribute("value", commentid);
		form.appendChild(hiddenField);
		hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "writeid");
		hiddenField.setAttribute("value", writeid);
		form.appendChild(hiddenField);
		document.body.appendChild(form);
		form.submit();
	} 
	function go3(email, petid){ 
		var form = document.createElement("form");
		form.setAttribute("charset", "UTF-8");
		form.setAttribute("method", "Post"); 
		form.setAttribute("action", "profile.jsp");
		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "email");
		hiddenField.setAttribute("value", email);
		form.appendChild(hiddenField);
		hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "petid");
		hiddenField.setAttribute("value", petid);
		form.appendChild(hiddenField);
		document.body.appendChild(form);
		form.submit();
	} 
	</script>
<%
	for(int i = 0; i < amount; i ++)
	{
		int comment_count = 0;
		CommentsDTO[] last_comments =  {null, null, null};
		if(!type.equals("view"))
			id -= 1;
		WritesDTO wdto = wdao.getWrite(type, id, puid);
		if(wdto != null) {
			id=wdto.getId();
			pdto = pdao.getPet(wdto.getPet());
			udto = udao.getUser(pdto.getPetuser());
			if(pdto != null) {
			PicturesDAO picdao = new PicturesDAO();
			PicturesDTO picdto = picdao.getPicture(wdto.getPicture());
%>
	
	<div id="menu_<%=id%>" class="hide">
		<div class="list-group" style="margin: 0px; padding: 0px;">
			<%if(udto.getEmail().equals(cur_udto.getEmail()) || cur_udto.getAdmin() == 1) {%>
		  <a href="#" class="list-group-item" data-toggle="modal" data-target="#edit_<%=id%>" style="border: 0 none;">수정</a>
		  <a href="writedrop_sub.jsp?writeid=<%=id%>&type=<%=type%>" class="list-group-item" style="border: 0 none;">삭제</a>
		  <%} %>
		  <a href="#" class="list-group-item" data-toggle="modal" data-target="#report_<%=id%>" style="border: 0 none;">신고</a>
		</div>
	</div>

	<%if(udto.getEmail().equals(cur_udto.getEmail()) || cur_udto.getAdmin() == 1) {%>
	<div id="edit_<%=id%>" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content form-group">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">글 수정</h4>
				</div>
				<form action="write_edit_sub.jsp" method="post" enctype="multipart/form-data">
				<div class="modal-body">
				  <textarea class="form-control" name="content" rows="10"><%=wdto.getContent()%></textarea>
				  <input type="file" name="file1">
				  <input type="hidden" name="writeid" value="<%=id%>">
				  <input type="hidden" name="type" value="<%=type%>">
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-default">수정</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
				</form>
			</div>
		</div>
	</div>
	<%}%>
	<div id="report_<%=id%>" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content form-group">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">글 신고</h4>
				</div>
				<form action="report_sub.jsp" method="post">
				<div class="modal-body">
				  <textarea class="form-control" name="content" rows="10"></textarea>
				  <input type="hidden" name="writeid" value="<%=id%>">
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-default">신고</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
				</form>
			</div>
		</div>
	</div>
	
	<div id="more_comment_<%=id%>" class="modal fade" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content form-group">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">댓글 더보기</h4>
				</div>
				<div class="modal-body">
					<hr class="garo"></hr>
					<%
						CommentsDAO cdao = new CommentsDAO();
						Vector<CommentsDTO>  commentList= cdao.getComment(id);
						Iterator<CommentsDTO> it = commentList.iterator();
						
						CommentsDTO comment;
						while(it.hasNext()) {
							comment_count ++;
							comment=it.next();
							last_comments[0] = last_comments[1];
							last_comments[1] = last_comments[2];
							last_comments[2] = comment;
							UsersDTO commentUser = udao.getUser(comment.getUser());
							
					%>
					<div class="row">
						<div class="col-xs-3"><a onclick="go3('<%=commentUser.getEmail()%>', '-1');"><img src="<%=commentUser.getProfilepicture()%>" class="img-circle" style="width: 50px; height: 50px;"> <b><%=commentUser.getName()%></b></a></div>
						<div class="col-xs-4"><%=comment.getContent() %></div>
						<div class="col-xs-3"><%=comment.getCommentdatetime() %></div>
						<div class="col-xs-2"> <a onclick="go2('<%=comment.getId() %>', '<%=id%>');" >삭제</a></div>
					</div>
					<hr class="garo"></hr>
					
					<%} %>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<div id="reports_<%=id%>" class="modal fade" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content form-group">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">신고 내용</h4>
				</div>
				<div class="modal-body">
					<hr class="garo"></hr>
					<%
						ReportsDAO rdao = new ReportsDAO();
						Vector<ReportsDTO>  reportList= rdao.getReport(id);
						Iterator<ReportsDTO> it_r = reportList.iterator();
						
						ReportsDTO report;
						while(it_r.hasNext()) {
							report=it_r.next();
							UsersDTO reportUser = udao.getUser(report.getUser());
					%>
					<div class="row">
						<div class="col-xs-3"><a onclick="go3('<%=reportUser.getEmail()%>', '-1');"><img src="<%=reportUser.getProfilepicture()%>" class="img-circle" style="width: 50px; height: 50px;"> <b><%=reportUser.getName()%></b></a></div>
						<div class="col-xs-9"><%=report.getContent() %></div>
					</div>
					<hr class="garo"></hr>
					
					<%} %>
				</div>
				<div class="modal-footer">
					<form method="post" action="reportdrop_sub.jsp">
						<input type="hidden" name="writeid" value=<%=id%>>
						<button type="submit" class="btn btn-default">신고 취소</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="post-id" id="<%=id%>_<%=puid%>">
			<div id="panel"  style="margin: auto; max-width:450px; text-align:center; margin-top:10px;">
				<div style="background-color:#ffffff; padding:0px">
					<div class="row" style="padding:5px">
						<div class="col-xs-2"><a onclick="go3('<%=udto.getEmail()%>', '<%=pdto.getId()%>');"><img src="<%=pdto.getProfilepicture()%>" class="img-circle" style="width: 50px; height: 50px;"></a></div>
						<div class="col-xs-4" style="text-align:left;"><a onclick="go3('<%=udto.getEmail()%>', '<%=pdto.getId()%>');"><%=pdto.getName() %><br><font size="0.6em"><%=udto.getName() %></font></a></div>
						<div class="col-xs-6" style="text-align:right; font-size:0.8em"><%=wdto.getWritedatetime()%><a href="#" rel="popover" data-trigger="focus" data-placement="bottom" data-popover-content="#menu_<%=id%>"><img src="images/menubutton.jpg" style="width: 20px;  height:auto"></a></div>
					</div>
					<%if(cur_udto.getAdmin() == 1) {%>
					<div style="text-align:center; padding-left:10px"><button class="btn btn-danger" style="margin:5px;" data-toggle="modal" data-target="#reports_<%=id%>">신고 내용</button></div>
					<% } %>
					<div style="text-align:left; padding-left:10px"><%=wdto.getContent().replace("\r\n",  "<br>")%></div>
					<%if(!picdto.getPath().equals("none")) {%><img src="<%=picdto.getPath()%>" class="img-rounded" style="max-width:100%;  height: auto; max-hegiht:500px; margin: 0.2em 0 0.2em 0"><%}%>
					<div style="text-align:center">
						<img src="images/comment.png" style="width: 25px;  height: auto;"><%=comment_count %>
					</div>
					<div style="text-align:left;; padding-left:10px">
						<%if(comment_count > 3) {%>
						<div style="color:#7F7F7F; font-size:0.9em"><a href="#" data-toggle="modal" data-target="#more_comment_<%=id%>">댓글 더보기...</a></div>
						<%}
							for(int ix = 0; ix < last_comments.length; ix++) {
								if(last_comments[ix] != null) {

									UsersDTO last_commentUser = udao.getUser(last_comments[ix].getUser());
								%>
								<div style="font-size:0.8em"><a onclick="go3('<%=last_commentUser.getEmail()%>', '-1');"><b><%=last_commentUser.getName() %></b></a><%=last_comments[ix].getContent()%></div>
								<%}
								}%>
					</div>
					<form method="post" action="comment_sub.jsp">		
						<div class="form-group input-group" style="margin-top:0.5em; font-size:0.8em">
							<span class="input-group-addon" style="border:none; background-color:transparent; outline: none; box-shadow: none;"><i class="glyphicon glyphicon-pencil"></i></span>
							<input class="form-control" id="text" name="content" placeholder="댓글 입력" style="border:none; background-color:transparent; outline: none; box-shadow: none;">
							<input type="hidden" name="writeid" value="<%=id%>">
						</div>
					</form>
				</div>
			</div>
		</div>
		
<%
		}
	}
}%>