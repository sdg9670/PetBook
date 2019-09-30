<%@ page  language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="nav.jsp" %>
<%@ page import = "db.users.UsersDAO" %>
<%@ page import = "db.users.UsersDTO" %>
<%
	UsersDAO udao = new UsersDAO();
	UsersDTO udto = null;
	if(session.getAttribute("email") != null)
	{
		udto = udao.getUser(session.getAttribute("email").toString());
	}

	String temp = new String(); 
	if(udto.getAdmin() == 1)
		temp="report";
	else
		temp="index";
%>
<style>
	.ajax-load{
		width: 100%;
	}
</style>

<script type="text/javascript">
var check = 0;
function loadMoreData(last_id){
	  $.ajax(
	        {
	            url: 'loadMoreData.jsp?type=<%=temp%>&amount=1&last_id=' + last_id,
	            type: "get",
	            beforeSend: function()
	            {
	                $('.ajax-load').show();
	            }
	        })
	        .done(function(data)
	        {
	        	if(data.length == " "){
	                return ;
	            }
	            $('.ajax-load').hide();
	            $("#post-data").append(data);
	        })
	        .fail(function(jqXHR, ajaxOptions, thrownError)
	        {
	              //alert('server not responding...');
	        });
	  check = 0;
	}
$(window).scroll(function() {
    if($(window).scrollTop() + $(window).height() >= $(document).height()) {
        var last_id = $(".post-id:last").attr("id");
        if(check == 0)
       	{
       		setTimeout("loadMoreData('" +last_id+"')", 300);
            $('.ajax-load').show();
       		check = 1;
       	}
    }
});
</script>

	<div class="container">
		<div class="col-md-12" id="post-data">

			<jsp:include page="loadMoreData.jsp">
				<jsp:param value="<%=temp%>" name="type"/>
				<jsp:param value="5" name="amount"/>
				<jsp:param value="<%=\"999999999_\"+udto.getId()%>" name="last_id"/>
			</jsp:include>
		</div>
	</div>
	<div class="ajax-load text-center" style="display:none">
    	<p><img src="images/loader.gif">Loading...</p>
	</div>


<%@ include file="footer.jsp" %>
