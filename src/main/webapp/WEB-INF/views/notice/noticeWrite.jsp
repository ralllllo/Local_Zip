<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리동네.zip</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="icon" type="image/png" sizes="512x512" href="/resources/images/pavicon.png">

<style>
/* 폰트 */
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

* {
	box-sizing: border-box;
}

body, html {
	margin: 0;
	padding: 0;
}

button, body, div, input {
	font-family: 'GMarketSans', sans-serif;
}

.container {
	width: 100%;
	min-height: 100vh;
	background-color: #fbe5c0;
}

.headBox {
	width: 100%;
	height: 100px;
	padding-left: 20px;
	font-weight: bold;
	font-size: 50px;
	color: #A66A3F;
	background-color: #F2D3A2;
	border-bottom: 2px solid #A66A3F;
	line-height: 100px;
	z-index: 1000;
}

.mainTitle {
	width: 100%;
	font-weight: bold;
	font-size: 50px;
	color: #A66A3F;
	border-bottom: 2px solid #A66A3F;
	background-color: #F2D3A2;
	height: 100px;
	line-height: 100px;
	display: flex;
	padding: 0 20px;
	justify-content: space-between;
	align-items: center;
	box-sizing: border-box;
}

.writeDetail {
	margin: auto;
	width: 1000px;
	height: auto;
	border-radius: 10px;
	background-color: #fbe5c0;
	padding: 35px;
	margin-top: 100px;
	background-color: #F2D3A2;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}


.titleDiv, .locationDiv, .TextDiv {
	padding: 10px;
	border-bottom: 1px dotted #A66A3F;
}

.TextDetail {
	min-height: 300px;
	border: 1px solid #A66A3F;
	background-color: #fbe5c0;
	width: 100%;
	height: auto;
	top: 30px;
	left: 0;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	z-index: 10;
	font-family: 'GMarketSans';
	border-radius: 5px;
	color: #A66A3F;
	font-size: 15px;
	padding: 2px;
	outline: none;
	resize: none;
}

.TextTitle {
	font-weight: bold;
	font-size: 23px;
	color: #5e361a;
	border: none;
	padding-left: 2px;
}

.title, .location{
	font-weight: bold;
	font-size: 23px;
	color: #5e361a;
}

.inputLink, .inputPw {
	padding: 5px;
	background-color: #fbe5c0;
	border-radius: 10px;
	border: none;
	font-size: 15px;
	width: 400px;
	word-break: break-all;
	white-space: normal;
}

.bottomBtn {
	display: flex;
	justify-content: center;
	gap: 20px;
	margin-top: 20px;
	margin-bottom: 10px;
}

.requestBtn, .backBtn {
	width: 350px;
	height: 40px;
	background-color: #FFB300;
	border: none;
	border-radius: 10px;
	color: #5e361a;
	font-size: 17px;
	font-weight: bold;
	transition: all 0.2s ease;
	cursor: pointer;
}

.requestBtn:hover, .backBtn:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #fecc56;
	color: #A66A3F;
}

.requestBtn:active, .backBtn:active {
	transform: translateY(2px);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.inputBox {
	border: 1px solid #A66A3F;
	background-color: #fbe5c0;
	width: 100%;
	height: 35px;
	top: 30px;
	left: 0;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	z-index: 10;
	font-family: 'GMarketSans';
	border-radius: 5px;
	color: #A66A3F;
	font-size: 15px;
	padding: 2px;
	outline: none;
}

.leftImg, .rightImg{
	position: absolute;
	width: 450px;
	height: 170px;
	z-index: 10;
	bottom: 0;
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
</style>
</head>
<body>

	<div class="container">
		<div class="headBox">공지사항</div>

		<form action="/admin/insertNotice" method="post" class="frm">
			<div class="writeDetail">
				<div class="titleDiv">
					<div class="title">제목</div>
					<div class="titleContent">
						<input name="post_title" class="inputBox" maxlength="100" type="text" style="border: #fbe5c0" placeholder="제목을 입력해주세요">
					</div>
					
				</div>

				<div class="TextDiv">
					<div class="TextTitle">내용</div>
					<textarea name="post_contents" class="TextDetail" type="text" placeholder="내용을 작성해주세요" maxlength="1000" style="border: #fbe5c0"></textarea>
				</div>
	
			</div>
	
				<div class="bottomBtn">
					<button class="requestBtn">작성 완료</button>
					<button class="backBtn" type="button" onclick="history.back();">뒤로가기</button>
				</div>
		</form>
		<img class="leftImg" src="/resources/images/왼쪽 모서리 풀.png">
    	<img class="rightImg" src="/resources/images/오른쪽 모서리 풀.png">
	</div>

	<script>
		// submit 전 공백에 대한 안내메시지
		$(".frm").on("submit",function(e){
			e.preventDefault(); // 기본 제출 막기
			
			// 공백 예외 처리
			if($(".inputBox").val() == ""){
				Swal.fire({
					icon: "info",
					title: "Wait  !",
					text: "제목을 입력해주세요.",
					iconColor: "#FFB300",
					confirmButtonColor: "#FFB300"
				});
				$(".inputBox").focus();
				return false;
			}else if($(".TextDetail").val() == ""){
				Swal.fire({
					icon: "info",
					title: "Wait  !",
					text: "내용을 입력해주세요.",
					iconColor: "#FFB300",
					confirmButtonColor: "#FFB300"
				});
				$(".TextDetail").focus();
				return false;
			}
			Swal.fire({
				icon: "success",
				title: "Success  !",
				text: "글이 등록되었습니다.",
				iconColor: "#FFB300",
				confirmButtonColor: "#FFB300"
			}).then(() => {
				this.submit();
			});
		});
	</script>
</body>
</html>