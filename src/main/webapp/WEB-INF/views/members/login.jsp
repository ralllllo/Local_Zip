<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리동네.zip</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="icon" type="image/png" sizes="512x512" href="/resources/images/pavicon.png">

<style>
@font-face {
	font-family: 'GMarketSans';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansLight.woff')
		format('woff');
	font-weight: 300;
	font-display: swap;
}

@font-face {
	font-family: 'GMarketSans';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff')
		format('woff');
	font-weight: 500;
	font-display: swap;
}

@font-face {
	font-family: 'GMarketSans';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansBold.woff')
		format('woff');
	font-weight: 700;
	font-display: swap;
}

button, body {
	font-family: 'GMarketSans', sans-serif;
	color: #5e361a;
}

body {
	margin: 0;
	background-color: #F2D3A2;
}

.container {
	position : relative;
	z-index: 2;
	width: 100%;
	min-height: 100vh;
	background-color: #fbe5c0;
}

.mainTitle {
	padding-left: 20px;
	font-weight: bold;
	font-size: 50px;
	color: #A66A3F;
	border-bottom: 2px solid #A66A3F;
	height: 100px;
	line-height: 100px;
	background-color: #F2D3A2;
}

.divTotal {
	padding: 20px 0;
	margin: 195px auto 0;
	width: 800px;
	min-height: 380px;
	border-radius: 60px;
	background-color: #F2D3A2;
	position: relative;
	text-align: center;
	box-shadow: 0 4px 10px rgba(0,0,0,0.2);
}

.form-row {
	display: flex;
	align-items: center;
	margin-bottom: 15px;
	justify-content: center;
}

label {
	width: 70px;
	text-align: right;
	margin-right: 10px;
	font-weight: bold;
}

.id, .pw {
	width: 300px;
	padding: 5px;
}

hr {
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
	bottom: 120px;
	width: 700px;
	border-color: #A66A3F;
}

.loginBtn, .JoinBtn {
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
	height: 40px;
	width: 90px;
}

.backBtn {
	position: absolute;
	left: 44%;
	bottom: 35px;
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
	height: 40px;
	width: 90px;
}

.loginBox {
	display: flex;
	justify-content: center;
	margin-top: 25px;
	margin-left: 23px;
	gap: 40px;
}

.inputArea{
	position: absolute;
    top: 90px;  
    left: 48%;
    transform: translateX(-50%);
}

.linkDiv{
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
	bottom: 100px;   
	display: flex;
	flex-direction: column;
	align-items: center;
	gap: 15px;
}
.loginBtn:hover,
.JoinBtn:hover,
.backBtn:hover{
    transform: translateY(-3px);
    box-shadow: 0 6px 15px rgba(0,0,0,0.3);
    background-color: #fecc56;
	color: #A66A3F;
}

.loginBtn:active,
.JoinBtn:active,
.backBtn:active{
    transform: translateY(2px);
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
}
      
.loginBtn, .JoinBtn, .backBtn {
    cursor: pointer;
	transition: all 0.2s ease;
}

.linkText{
	display: flex;
	gap: 60px;
	font-size: 14px;
	font-weight: 500;
	margin-left: 10px;
	color: #5e361a;
}

a:link{color:black;text-decoration:none;}
a:visited{color:black;text-decoration:none;}

input{
	outline: none;
}

.leftImg, .rightImg{
	position: absolute;
	bottom: 0;
	width: 450px;
	height: 170px;
	z-index: -1;
	pointer-events: none;
}

.leftImg{
    left: 0;
}

.rightImg{
	right: 0;
}

.swal2-icon.swal2-info .swal2-icon-content {
   font-size: 50px;
   transform: translateY(5px);
   line-height: 70px;
}

.linkDiv a {
	color: #5e361a;
}

</style>
</head>
<body>
	<div class="container">
		<div class="mainTitle">우리 동네.zip 로그인</div>
		<form action="/members/login" class="frm" method="post">
			<div class="divTotal">
				<div class="inputArea">
					<div class="form-row">
						<label>· ID : </label><input name="mem_id" value="${mem_id}" class="id" type="text" placeholder="아이디를 입력해주세요.">
					</div>
	
					<div class="form-row">
						<label>· PW : </label><input name="mem_password" class="pw" type="password" placeholder="비밀번호를 입력해주세요.">
					</div>
					
				<div class="loginBox">
					<!-- submit 버튼 -->
					<div class="signUpDiv">
						<button class="loginBtn" type="submit">Login</button>
					</div>
					<!-- 일반 버튼 -->
					<div class="signUpDiv">
						<a href="/members/join"><button class="JoinBtn" type="button">Join</button></a>
					</div>
				</div>
			</div>
				<hr>
				<div class="linkDiv">
					<div class="linkText">
						<a href="/find/toFindId"><div>아이디 찾기</div></a>
						<a href="/find/toFindPw"><div>비밀번호 찾기</div></a>
					</div>
				</div>
				<div>
					<a href="/"><button class="backBtn" type="button">Back</button></a>
				</div>
			</div>
		</form>
		<img class="leftImg" src="/resources/images/왼쪽 모서리 풀.png">
    	<img class="rightImg" src="/resources/images/오른쪽 모서리 풀.png">
	</div>
	
	<script>
		let pwMsg = "${pwMsg}";
	    if (pwMsg && pwMsg !== "") { // 비밀번호 변경 msg
	    	Swal.fire({
	            icon: "success",
	            title: "Success !",
	            text: pwMsg,
	            iconColor: "#FFB300",
	            confirmButtonColor: "#FFB300"
	        });
	    }
	
		let msg = "${msg}";
		let endDate = "${endDate}";
		
		if(msg == "empty"){
			Swal.fire({
				icon: "info",
				title: "Wait  !",
				text: "아이디와 비밀번호를 입력해주세요.",
				iconColor: "#FFB300",
				confirmButtonColor: "#FFB300"
			});
		}else if(msg == "fail"){
			Swal.fire({
				icon: "error",
				title: "Fail  !",
				text: "탈퇴한 계정입니다. 새로운 계정을 생성해 주세요.",
				iconColor: "#EB0000",
				confirmButtonColor: "#FFB300"
			});
		}else if(msg == "idFail") {
			Swal.fire({
				icon: "error",
				title: "Fail  !",
				text: "존재하지 않는 계정입니다.",
				iconColor: "#EB0000",
				confirmButtonColor: "#FFB300"
			});
		}else if(msg == "pwFail") {
			Swal.fire({
				icon: "error",
				title: "Fail  !",
				text: "비밀번호가 틀립니다.",
				iconColor: "#EB0000",
				confirmButtonColor: "#FFB300"
			});
		}else if(msg == "banned"){
			let alertMsg = "🚨 서비스 이용이 제한된 계정입니다.\n";
				if(endDate == "영구 정지"){
					alertMsg += "<br>상태 : 영구정지</br>";
				}else{
					alertMsg += "<br>제한 해제일 : "  + endDate + "</br>";
				}
				Swal.fire({
			        icon: "error",
			        title: "접근 제한",
			        html: alertMsg,   // 기존 문자열 그대로
			        iconColor: "#EB0000",
			        confirmButtonColor: "#FFB300"
			    });
			}
		
		let lmsg = "${lmsg}";
		
		if(lmsg == "loginFail"){
			Swal.fire({
				icon: "error",
				title: "Error  !",
				text: "로그인에 실패했습니다. 다시 시도해 주세요.",
				iconColor: "#EB0000",
				confirmButtonColor: "#FFB300"
			});
		}
	</script>
	
</body>
</html>