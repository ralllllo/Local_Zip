<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리동네.zip</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
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
	height: 100%;
	overflow: hidden;
}

button, body {
	font-family: 'GMarketSans', sans-serif;
}

.container {
	position: relative;
	top: 100px;
	width: 100%;
	min-height: 100vh;
	background-color: #fbe5c0;
}

.headBox {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100px;
	padding-left:20px;
	font-weight: bold;
	font-size: 50px;
	color: #A66A3F;
	background-color: #F2D3A2;
	border-bottom: 2px solid #A66A3F;
	line-height: 100px;
	z-index: 1000;
}

.midBox {
	position: absolute;
	width: 100%;
	height: 780px;
	width: 100%;
}

.imgBox {
	width: 100%;
	height: 58%;
}

.errorCode {
	width: 100%;
	height: 10%;
	font-size: 45px;
	font-weight: bold;
	color: #FF8200;
	text-shadow: 1px 1px 1px #d49500; /* [가로위치][세로위치][번짐정도][색상] */
	text-align: center;
}

.errorMsgBox {
	width: 100%;
	height: 90px;
	color: #5e361a;
}

.errorMsg {
	width: 100%;
	text-align: center;	
}

.homeBtn {
	margin: auto;
	margin-top:5px;
	width: 500px;
	height: 80px;
	border-top-right-radius: 50px;
	border-top-left-radius: 50px;
	border-bottom-right-radius: 50px;
	border-bottom-left-radius: 50px;
	font-size: 28px;
	font-weight: bold;
	color: #3e5e40;
	background-color: #ffb300;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	transition: 0.3s;
	display: flex;
	justify-content: center;
	align-items: center; 
}

.homeBtn:hover {
	background-color: #fecc56;
	color: #A66A3F;
	transform: translateY(-3px);
}

.bottomBox {
	border: 1px solid #A66A3F;
	position: fixed;
	bottom: 0;
	left: 0;
	width: 100%;
	height: 60px;
	display: flex;
	align-items: center;
	justify-content: center;
	z-index: 1000;
	border-top: 2px solid #A66A3F;
	background-color: #F2D3A2;
	gap: 200px;
}

.leftWay, .rightWay {
	position: absolute;
	width: 200px;
	height: 200px;
	top: 115px;
}

.errorImg {
	position: absolute;
	left: 800px;
	top: 50px;
	width: 350px;
}

.leftWay {
	left: 550px;
	transform: rotate(-10deg);
}

.rightWay {
	right: 550px;
	transform: rotate(15deg);
}

.leftImg, .rightImg {
	position: absolute;
	width: 500px;
	height: 200px;
	z-index: 10;
	bottom: -15px;
}

.leftImg {
	left: 0;
}

.rightImg {
	right: 0;
}

.navicon:hover {
   transform: translateY(-3px);
   box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

.navicon:active {
   transform: translateY(2px);
   box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}
</style>

</head>
<body>

	<div class="container">
		<div class="headBox">우리 동네.zip</div>
		<div class="midBox">
			<div class="imgBox">
				<img class="leftWay" src="/resources/images/path.png"> 
				<img class="errorImg" src="/resources/images/errorImg.png">
				<img class="rightWay" src="/resources/images/pathway.png"> 
				<img class="leftImg" src="/resources/images/왼쪽 모서리 풀.png">
				<img class="rightImg" src="/resources/images/오른쪽 모서리 풀.png">
			</div>

			<div class="errorCode">길을 잃으신 것 같아요!</div>

			<div class="errorMsgBox">
				<div class="errorMsg">
					입력하신 주소가 정확한지 확인해주세요.<br> 원하시는 페이지가 존재하지 않거나, 현재 사용할 수 없는 상태입니다.
				</div>
			</div>
			<div class="homeBtn" onclick="location.href='/';">우리동네.zip 홈으로 가기</div>
		</div>

		<div class="bottomBox">
			<a href="/"><i class="navicon fa-solid fa-house fa-2xl" style="color: #A66A3F"></i></a> <a href="/map/test"><i
				class="navicon fa-solid fa-map-location-dot fa-2xl" style="color: #A66A3F"></i></a> <a href="/meeting/list?category=all"><i
				class="navicon fa-solid fa-people-group fa-2xl" style="color: #A66A3F"></i></a> <a href="/feedback/feedbackHome"><i
				class="navicon fa-solid fa-bullhorn fa-2xl" style="color: #A66A3F"></i></a> <a href="/members/mypage"><i
				class="navicon fa-solid fa-user fa-2xl" style="color: #A66A3F"></i></a>
		</div>
	</div>
</body>
</html>