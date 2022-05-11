<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
<style type="text/css">

	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
	
	h1 {
		text-align: center;
		}
	
	.info {
		margin-right: 100px;
		}
	
	.info3 {
			text-align: center;
			color: #A9A9A9;
		}
	
		.jumbotron {
		
	 		background-color:LightSteelBlue;
	
		}
</style>
<title>학식 공유 게시판</title>
</head>
<body style="font-family: 'Gowun Dodum', sans-serif">
	<div>
	<a href="main.jsp"><img src = "school.png" style="margin-left: 740px; margin-top: 10px; width:50px; height:50px;"></a>
	</div>
	<br>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px">
				<form method="post" action="memberJoinAction.jsp">
					<h3 style="text-align: center;"><strong>회원가입</strong></h3>
					<br>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="학번" name="memberID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="memberPassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름" name="memberName" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="학교명" name="memberSchool" maxlength="20">
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일" name="memberEmail" maxlength="20">
					</div>
					<input type="submit" class="button form-control" value="회원가입">	
				</form>
			</div>
		</div>
	</div>
	<hr>
	<footer class="container">
		<p class = "text-center"> Copyright &copy; Cho Sodam All Rights Reserved.</p>
	</footer>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</body>
</html>