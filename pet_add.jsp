<%@ page  language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="nav.jsp" %>

	<div class="container">
		<div style="margin: auto; max-width:500px;">
			<hr class="garo" style="width:550px; margin:20px 0px 20px 0px"/>
			<div style="margin-top:20px">
				<form name="form1" method="post" action="pet_add_sub.jsp" style="text-align:center;">
					<h2>반려동물 추가</h2>
					<div  style="max-width:250px; display: inline-block !important;">
						<div class="input-group" style="margin:5px">
							<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
							<input id="name" type="text" class="form-control" name="name" placeholder="Name">
						</div>
						<div class="input-group" style="margin:5px">
							<span class="input-group-addon"><i class="glyphicon glyphicon-gift"></i></span>
							<input id="birthday" type="text" class="form-control" name="birthday" placeholder="Birthday ex) 1997-01-29">
						</div>
						<div class="input-group" style="margin:5px">
							<span class="input-group-addon"><i class="glyphicon glyphicon-tag"></i></span>
							<input id="type" type="text" class="form-control" name="type" placeholder="종류">
						</div>
						<div class="input-group" style="margin:5px">
							<span class="input-group-addon"><i class="glyphicon glyphicon-info-sign"></i></span>
							<textarea class="form-control" rows="5" id="intro" name="introduce" placeholder="소개"></textarea>
						</div>
						<button type="submit" class="btn btn-md" style="margin:5px">추가</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>

<%@ include file = "footer.jsp" %>