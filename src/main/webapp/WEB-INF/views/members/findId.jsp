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
.container{
	position : relative;
	z-index: 2;
	width:100%;
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
	width: 550px;
	min-height: 270px;
	border-radius: 60px;
	background-color: #F2D3A2;
	position: relative;
	text-align: center;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
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
	margin-left : 14px;
}

.email, .auth_code {
	width: 300px;
	padding: 5px;
	background-color: #fbe5c0;
	border-radius: 5px;
	border : 0px;
	color : #5e361a;
	height : 30px;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

hr {
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
	bottom: 120px;
	width: 700px;
	border-color: #A66A3F;
}

.requestBtn, .certifyBtn {
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
	height: 40px;
	width: 90px;
	margin-left : 16px;
}

.backBtn, .loginBtn {
	position: absolute;
	left: 40%;
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

.inputArea {
	position: absolute;
	top: 90px;
	left: 48%;
	transform: translateX(-50%);
}

.linkDiv {
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
	bottom: 100px;
	display: flex;
	flex-direction: column;
	align-items: center;
	gap: 15px;
}

.linkText {
	display: flex;
	gap: 60px;
	font-size: 14px;
	font-weight: 500;
	margin-left: 10px;
}

.requestBtn:hover, .certifyBtn:hover, .backBtn:hover, .loginBtn:hover {
	transform: translateY(-3px); /* 살짝 위로 뜸 */
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #fecc56;
	color: #A66A3F;
}

.requestBtn:active, .certifyBtn:active, .backBtn:active, .loginBtn:hover {
	transform: translateY(2px); /* 아래로 눌림 */
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}
.requestBtn, .certifyBtn, .backBtn, .loginBtn{
	cursor: pointer;
	transition: all 0.2s ease;
}
.leftImg, .rightImg{
	position: absolute;
	width: 450px;
	height: 170px;
	z-index: -1;
	pointer-events: none;
	bottom: 0;
}
.leftImg{
    left: 0;
}
.rightImg{
	right: 0;
}
input{
	outline: none;
}

.swal2-icon.swal2-info .swal2-icon-content {
    font-size: 50px;     /* i 크기 */
    transform: translateY(5px);
    line-height: 70px;   /* 세로 위치 (핵심🔥) */
}

.swal2-icon.swal2-question .swal2-icon-content {
    font-size: 50px;     /* i 크기 */
    transform: translateY(5px);
    line-height: 70px;   /* 세로 위치 (핵심🔥) */
}

.swal2-icon.swal2-warning .swal2-icon-content {
    font-size: 50px;     /* i 크기 */
    transform: translateY(5px);
    line-height: 70px;   /* 세로 위치 (핵심🔥) */
}

.swal2-icon.swal2-error .swal2-icon-content {
    font-size: 50px;     /* i 크기 */
    transform: translateY(5px);
    line-height: 70px;   /* 세로 위치 (핵심🔥) */
}
</style>
</head>

<body>
	<div class="container">
		<div class="mainTitle">우리 동네.zip ID 찾기</div>
		<form action="/members/login" class="frm" method="post">
			<div class="divTotal">
				<div id="resultArea" style="display:none; padding: 30px 0;">
        <p style="font-size: 18px; margin-bottom: 10px;">찾으시는 아이디는</p>
        <div style="background-color: #fbe5c0; display: inline-block; padding: 10px 30px; border-radius: 20px; box-shadow: inset 0 2px 5px rgba(0,0,0,0.1);">
            <strong id="foundedId" style="font-size: 24px; color: #A66A3F;"></strong>
        </div>
        <p style="font-size: 18px; margin-top: 10px;">입니다.</p>
        <button type="button" class="loginBtn" onclick="location.href='/members/loginUi'" style="position:static; margin-top:20px;">로그인하기</button>
    </div>
				<div class="inputArea">
					<div class="form-row">
						<label>· EMail : </label><input name="email" class="email"
							type="text" placeholder="본인 확인 이메일">
						<button class="requestBtn" type="button">인증요청</button>
					</div>
					<div class="form-row">
						<label>· Code : </label><input name="auth_code" class="auth_code"
							type="text" placeholder="인증번호 입력">
						<button class="certifyBtn" type="button">인증하기</button>
					</div>
				</div>
				<div>
					<a href="/members/loginUi"><button class="backBtn" type="button">돌아가기</button></a>
				</div>
			</div>
		</form>
		<img class="leftImg" src="/resources/images/왼쪽 모서리 풀.png">
    	<img class="rightImg" src="/resources/images/오른쪽 모서리 풀.png">
	</div>

	<script>
	
		// 이메일 인증 요청 보내기
		$(".requestBtn").on("click", function() {
			if ($(".email").val() == "") {
				Swal.fire({
					icon: "info",
					title: "Wait  !",
					text: "이메일을 입력해주세요.",
					iconColor: "#FFB300",
					confirmButtonColor: "#FFB300"
				});
				return false;
			} else {
				$.ajax({
					url : "/auth/mailCheck",
					type : "post",
					data : {
						email : $(".email").val(),
						auth_type : 2
					}

				}).done(function(resp) {
					if (resp == "success") {
						Swal.fire({
    						icon: "success",
    						title: "Success  !",
    						text: "이메일로 인증번호를 발송했습니다.",
    						iconColor: "#FFB300",
    						confirmButtonColor: "#FFB300"
    					});
					}else if(resp == "empty"){
						Swal.fire({
							icon: "error",
							title: "Empty  !",
							text: "가입된 정보가 없습니다.",
							iconColor: "#EB0000",
							confirmButtonColor: "#FFB300"
						});
					} else {
						Swal.fire({
							icon: "error",
							title: "Error  !",
							text: "인증번호 발송을 실패했습니다. 다시 시도해주세요.",
							iconColor: "#EB0000",
							confirmButtonColor: "#FFB300"
						});
					}
				});
			}
		});
		
		//이메일 인증 확인 

		$(".certifyBtn").on("click", function() {
			if ($(".auth_code").val() === "") {
				Swal.fire({
					icon: "info",
					title: "Wait  !",
					text: "인증코드를 입력해주세요.",
					iconColor: "#FFB300",
					confirmButtonColor: "#FFB300"
				});
				return false;
			} else {
				$.ajax({
					url : "/auth/findMyId",
					type : "post",
					data : {
						email : $(".email").val(),
						auth_code : $(".auth_code").val()
					},
					dataType : "json"
				}).done(function(resp) {
					if (resp.status === "success") {
						Swal.fire({
    						icon: "success",
    						title: "Success  !",
    						text: "인증에 성공하였습니다.",
    						iconColor: "#FFB300",
    						confirmButtonColor: "#FFB300"
    					});
						// 입력창 영역을 숨기고 결과 영역을 보여줌
							$(".inputArea").hide();
							$(".backBtn").hide();
							$("#foundedId").text(resp.myId);
							$("#resultArea").show();
							$(".loginBtn").show();
					} else if (resp.status === "fail") {
						alert(resp.msg);
					} else if (resp.status === "wrong_code") {
						Swal.fire({
							icon: "error",
							title: "Error  !",
							text: "인증번호가 일치하지 않습니다.",
							iconColor: "#EB0000",
							confirmButtonColor: "#FFB300"
						});
						$(".auth_code").val("").focus();
					}

				});
			}
		})
	</script>

</body>
</html>