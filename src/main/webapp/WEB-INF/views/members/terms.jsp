<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리동네.zip</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
	integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
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
	background-color: #FFEFD5;
	color: #5e361a;
}

.container {
	width: 100%;
	height: 100%;
	background-color: #FFEFD5;
}

.title{
	text-align: center;
	font-size: x-large;
	font-weight: bold;
	height: 80px;
	line-height: 80px;
	background-color: #FFC846;
	margin-bottom: 30px;
}

.num1Div, .num2Div, .num3Div{
	display:flex;
	font-size: large;
	height: 30%;
	margin-bottom: 30px;
	margin-right: 30px;
}

.num1, .num2, .num3{
	width: 25%;
	text-align: center;
	line-height: 70px;
	height: 70px;
	border-radius: 100px;
	box-shadow: 0 2px 5px rgba(0,0,0,0.3);
	background-color: #FDF5E6;
	margin-left: 20px;
	font-weight: bold;
}

.num1{
	width: 23%;
}

.num1_contents, .num2_contents, .num3_contents{
	margin-left: 20px;
}

.contents_title1, .contents_title2, .contents_title3{
	font-size: 20px;
	margin-top: 5px;
	margin-bottom: 10px;
}

.contents_1, .contents_2{
	font-size: 15px;
}

.contents_1{
	margin-bottom: 10px;
}

.icon{
	color: #5e361a;
}

.leftImg, .rightImg{
	position: absolute;
	width: 330px;
	height: 120px;
	z-index: 10;
	bottom: 0;
}

.leftImg{
    left: 0;
}

.rightImg{
	right: 0;
}
</style>
</head>
<body>
	<div class="container">
		<div class="title"><i class="fa-solid fa-house-chimney fa-xl icon"></i> 우리동네.zip 이용약관 안내</div>
		<div class="num1Div">
			<div class="num1">1</div>
			<div class="num1_contents">
				<div class="contents_title1">원활한 소통과 이용자 배려</div>
				<div class="contents_1">· 이용자는 서로를 존중하고 배려하는 태도로 커뮤니티 활동에 참여해야 하며, 이를 위반하는 경우 서비스 이용이 제한될 수 있습니다. </div>
				<div class="contents_2">· 건전한 소통 환경 조성을 위해 서비스 개선에 대한 이용자의 다양한 의견 제시는 언제든지 환영합니다.</div>
			</div>
		</div>
		<div class="num2Div">
			<div class="num2">2</div>
			<div class="num2_contents">
				<div class="contents_title2">사이트 이용 기준 및 제한</div>
				<div class="contents_1">· 사이트의 목적과 무관한 광고, 도배, 허위 정보 게시 및 부적절한 콘텐츠 등록 시 사전 고지 없이 게시물이 삭제되거나 이용이 제한될 수 있습니다.</div>
				<div class="contents_2">· 타 이용자에게 불쾌감을 주거나 서비스 운영을 방해하는 행위는 금지되며, 반복 시 계정 이용이 제한될 수 있습니다.</div>
			</div>
		</div>
		<div class="num3Div">
			<div class="num3">3</div>
			<div class="num3_contents">
				<div class="contents_title3">개인정보 보호 및 보안</div>
				<div class="contents_1">· 회원 가입 시 제공된 개인정보는 관련 법령에 따라 안전하게 보호되며, 이용자의 동의 없이 제3자에게 제공되거나 외부에 유출되지 않습니다.</div>
				<div class="contents_2">· 이용자는 계정 정보 보호를 위해 비밀번호 관리에 주의해야 하며, 개인정보 변경 시 즉시 수정할 책임이 있습니다.</div>
			</div>
		</div>
		<img class="leftImg" src="/resources/images/왼쪽 모서리 풀.png">
    	<img class="rightImg" src="/resources/images/오른쪽 모서리 풀.png">
	</div>
</body>
</html>