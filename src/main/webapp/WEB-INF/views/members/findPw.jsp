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
	margin: 160px auto 0;
	width: 550px;
	min-height: 400px;
	border-radius: 60px;
	background-color: #F2D3A2;
	position: relative;
	text-align: center;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

.form-row {
	display: flex;
    align-items: center;
    justify-content: flex-start;
    width: 100%;
    max-width: 480px;
    margin-bottom: 15px;
}

label {
	width: 116px;
	text-align: right;
	margin-right: 15px;
	font-weight: bold;
	font-size: 16px;
	flex-shrink: 0;
}

.email, .auth_code, .mem_id, .pw, .checkPw {
	flex: 1;
	height: 35px;
	padding: 0 10px;
	border: 0px solid black;
	border-radius: 5px;
	box-sizing: border-box;
	background-color: #fbe5c0;
	color : #5e361a;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

.mem_id {
    margin-right: 80px; 
}

.pw, .checkPw {
    margin-right: 64px;
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
	width: 70px;
	height: 35px;
	margin-left: 10px;
	border-radius: 10px;
	cursor: pointer;
	flex-shrink: 0;
	font-weight: bold;
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
}

.backBtn ,.okBtn {
	position: static;
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
	height: 40px;
	width: 100px;
}
.inputArea {
	width: 100%;
	padding: 40px 20px;
	display: flex;
	flex-direction: column;
	align-items: center;
	box-sizing: border-box;
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

.requestBtn:hover, .certifyBtn:hover, .backBtn:hover, .okBtn:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #fecc56;
	color: #A66A3F;
}

.requestBtn:active, .certifyBtn:active, .backBtn:active, .okBtn:active 
	{
	transform: translateY(2px);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.requestBtn, .certifyBtn, .backBtn, .okBtn {
	cursor: pointer;
	transition: all 0.2s ease;
}

.correct, .incorrect {
	display: none;
	font-size: small;
	margin-top: -15px;
}

hr {
	width: 100%;
	border: 0;
	border-top: 1px solid #A66A3F;
	margin: 30px 0;
	position: static;
	transform: none;
}

.btnBox {
	position: relative;
	margin-top: 20px;
	padding-bottom: 30px;
	text-align: center;
}
.okBtn{
	width: 100px;
	height: 40px;
	margin-left: 10px;
	border-radius: 10px;
	cursor: pointer;
	flex-shrink: 0;
	font-weight: bold;
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	display : none;
}

.pwLabel{
	margin-left: 17px;
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
    font-size: 50px;
    transform: translateY(5px);
    line-height: 70px;
}

.swal2-icon.swal2-question .swal2-icon-content {
    font-size: 50px;
    transform: translateY(5px);
    line-height: 70px;
}

.swal2-icon.swal2-warning .swal2-icon-content {
    font-size: 50px; 
    transform: translateY(5px);
    line-height: 70px; 
}
.swal2-icon.swal2-info .swal2-icon-content {
    font-size: 50px; 
    transform: translateY(5px);
    line-height: 70px; 
}

.swal2-icon.swal2-question .swal2-icon-content {
    font-size: 50px;
    transform: translateY(5px);
    line-height: 70px;
}

.swal2-icon.swal2-error .swal2-icon-content {
    font-size: 50px;
    transform: translateY(5px);
    line-height: 70px;
}

.correct{
	color: #286708;
	margin-top: 5px;
}

.incorrect{
	color: #de4f28;
	margin-top: 5px;
}
</style>
</head>

<body>
	<div class="container">
		<div class="mainTitle">우리 동네.zip PW 찾기</div>
		<form action="/auth/updateMyPw" class="frm" method="post">
			<div class="divTotal">
				<div class="inputArea">
					<div class="form-row">
						<label>· 아 이 디 : </label> <input name="mem_id" class="mem_id"
							type="text" placeholder="아이디">
					</div>

					<div class="form-row">
						<label>· E M a i l : </label> <input name="email" class="email"
							type="text" placeholder="본인 확인 이메일">
						<button class="requestBtn" type="button">전송</button>
					</div>

					<div class="form-row">
						<label>· 인 증 번 호 : </label> <input name="auth_code" class="auth_code"
							type="text" placeholder="인증번호 입력">
						<button class="certifyBtn" type="button">인증</button>
					</div>

					<hr>

					<div id="pwResetArea"
						style="display:none; width: 100%; flex-direction: column; align-items: center;">
						<div class="form-row">
							<label class="pwLabel">· 새 비밀번호 :</label><input name="pw" class="pw" type="password"
								placeholder="새 비밀번호를 입력해주세요">
						</div>
						<div class="form-row">
							<label class="pwLabel">· 비밀번호 확인 :</label><input name="checkPw" class="checkPw"
								type="password" placeholder="비밀번호를 동일하게 입력해주세요.">
						</div>
						<div class="correct">비밀번호가 일치합니다.</div>
						<div class="incorrect">비밀번호가 일치하지 않습니다.</div>
					</div>
				</div>

				<div class="btnBox">
				<button class="okBtn" type="button">확인</button>
					<a href="/members/loginUi"><button class="backBtn"
							type="button">돌아가기</button></a>
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
						mem_id : $(".mem_id").val(),
						email : $(".email").val(),
						auth_type : 3
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
					} else if (resp == "empty") {
						Swal.fire({
							icon: "error",
							title: "Empty  !",
							text: "가입된 정보가 없습니다.",
							iconColor: "#EB0000",
							confirmButtonColor: "#FFB300"
						});
					}else if(resp=="failEmail"){
						Swal.fire({
							icon: "error",
							title: "Empty  !",
							text: "이메일이 정확하지 않습니다.",
							iconColor: "#EB0000",
							confirmButtonColor: "#FFB300"
						});
					}else {
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
		
		$(".checkPw").on("input",function(){
			$(".correct").hide();
			$(".incorrect").show();
			if ($(".pw").val() != $(".checkPw").val()) {
				$(".correct").hide();
				$(".incorrect").show();
			}else {
				$(".correct").show();
				$(".incorrect").hide();
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
						$("#pwResetArea").show();
						$(".okBtn").show();
						

					} else if (resp.status === "fail") {
						Swal.fire({
	                        icon: "error",
	                        title: "Fail !",
	                        text: resp.msg,
	                        iconColor: "#EB0000",
	                        confirmButtonColor: "#FFB300"
	                    });
						/* alert(resp.msg); */
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

		$(".okBtn").on("click",function(e) {
				e.defaultPrevented;

				// pw
				let pw1 = document.getElementsByClassName("pw")[0];
				let pw2 = document.getElementsByClassName("checkPw")[0];
				let correct = document.getElementsByClassName("correct")[0];
				let incorrect = document.getElementsByClassName("incorrect")[0];

				if (pw1.value == "" || pw2.value == "") {
					Swal.fire({
   						icon: "info",
   						title: "Wait  !",
   						text: "비밀번호를 입력해주세요.",
   						iconColor: "#FFB300",
   						confirmButtonColor: "#FFB300"
   					});
					return false;
				} else {
					let regex = /^[A-Za-z\d!@#$%^&*]{8,16}$/;
					let pwResult = regex.test(pw1.value);
					if (!pwResult) {
						Swal.fire({
							icon: "error",
							title: "InCorrect  !",
							text: "비밀번호를 다시 설정해주세요.\n8~16자의 영문 대소문자,숫자,특수문자(!@#$%^&*) 사용 가능",
							iconColor: "#EB0000",
							confirmButtonColor: "#FFB300"
						});
						pw1.value = "";
						pw1.focus();
						return false;
					} else if (pw1.value != pw2.value) {
						incorrect.style.display = "block";
						correct.style.display = "none";
						return false;
					} else {
						correct.style.display = "block";
						incorrect.style.display = "none";
						$(".frm").submit();
					}
				}
			})
		$(document).ready(function(){
			let message = "${pwMsg}";
			
	    if (message && message !== "") {
	    	Swal.fire({
				icon: "success",
				title: "Success  !",
				text: message,
				iconColor: "#FFB300",
				confirmButtonColor: "#FFB300"
			});
	    }
	});
	
	</script>

</body>
</html>