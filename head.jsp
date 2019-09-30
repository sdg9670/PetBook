<%@ page  language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
	  	
		<link rel="stylesheet" href="css/bootstrap.css">
	  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	  	<script src="js/bootstrap.js"></script>
		<link rel="stylesheet" href="css/PetBook.css">
		<title>PetBook</title>
	</head>

	<script>
		$(function(){
			$('[rel="popover"]').popover({
				container: 'body',
				html: true,
				content: function () {
					var clone = $($(this).data('popover-content')).clone(true).removeClass('hide');
					return clone;
				}
			}).click(function(e) {
				e.preventDefault();
			});
		});
	</script>