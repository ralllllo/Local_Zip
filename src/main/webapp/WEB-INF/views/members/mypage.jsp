<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리동네.zip</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="icon" type="image/png" sizes="512x512" href="/resources/images/pavicon.png">

<style>
* {
	box-sizing: border-box;
}

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

button, body, input {
	font-family: 'GMarketSans', sans-serif;
	color: #5e361a;
}

body, html {
	margin: 0;
	padding: 0;
	background-color: #fbe5c0;
}

.container {
	z-index: 3;
	width: 100%;
	min-height: 100vh;
	padding-bottom: 80px;
	position: relative;
}

.topBar {
	width: 100%;
	padding-left: 20px;
	border-bottom: 2px solid #A66A3F;
	background-color: #F2D3A2;
	height: 100px;
	align-items: center;
	justify-content: space-between;
	display: flex;
}

.mainTitle {
	font-weight: bold;
	font-size: 50px;
	color: #A66A3F;
}

.logoutBtnDiv {
	margin-right: 30px;
	margin-top: 25px;
}

.bottomBar {
	border: 2px solid #A66A3F;
	background-color: #F2D3A2;
	position: fixed;
	bottom: 0;
	left: 0;
	width: 100%;
	height: 60px;
	display: flex;
	align-items: center;
	justify-content: center;
	z-index: 1000;
	gap: 200px;
}

.userBarDiv {
	width: 1750px;
	height: 200px;
	margin-top: 20px;
	margin-left: 75px;
	border-radius: 10px;
	font-size: 30px;
	color: #A66A3F;
	position: relative;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

.userBar {
	width: 100%;
	height: 100%;
	border-radius: 10px;
	display: block;
}

.userBarContents {
	font-size: 40px;
	color: #A66A3F;
	font-weight: bold;
	position: absolute;
	top: 50%;
	left: 53%;
	transform: translate(-50%, -50%);
}

hr {
	margin-top: 20px;
	width: 97%;
	border-color: #A66A3F;
}

.navicon:hover, .myInfo:hover, .myWrite:hover, .myLike:hover, .myClub:hover,
	.CS:hover, .notice:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

.logoutBtn {
	background-color: #FFB300;
	color: #5e361a;
	border: none;
	height: 30px;
	width: 80px;
	border-radius: 5px;
	line-height: 32px;
}

.logoutBtn:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #fecc56;
	color: #A66A3F;
}

.myInfo, .myWrite, .myLike, .myClub, .CS, .notice, .logoutBtn {
	cursor: pointer;
	transition: all 0.2s ease;
}

.navicon:active, .myInfo:active, .myWrite:active, .myLike:active,
	.myClub:active, .CS:active, .notice:active, .logoutBtn:active {
	transform: translateY(2px);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.divContainer {
	width: 1600px;
	height: 420px;
	background-color: #F2D3A2;
	margin-left: 160px;
	margin-top: 25px;
	border-radius: 20px;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	padding-top: 5px;
	position: relative;
	z-index: 1;
}

.myInfoDiv {
	position: relative;
	left: 1550px;
}

.myActiveTitle, .FAQTitle {
	height: 60px;
	font-size: x-large;
	font-weight: bold;
	margin-top: 25px;
	margin-left: 110px;
}

.FAQTitle {
	margin-top: 20px;
}

.myActiveDiv, .FAQDiv {
	display: flex;
	gap: 20px;
	width: 90%;
	height: 125px;
	margin-left: 115px;
}

.myWrite, .myLike, .myClub, .myInfo {
	width: 300px;
	height: 115px;
	background-color: #fbe5c0;
	border-radius: 30px;
}

.myInfo {
	width: 300px;
}

.myInfoTitle {
	margin-top: 20px;
}

.myWriteIcon, .myLikeIcon, .myClubIcon, .myInfoIcon {
	width: 30%;
	height: 100%;
}

.myWriteContents, .myLikeContents, .myClubContents, .myInfoContents {
	width: 70%;
	height: 100%;
}

.myWriteIcon, .myWriteContents, .myLikeIcon, .myLikeContents,
	.myClubIcon, .myClubContents, .myInfoIcon, .myInfoContents {
	float: left;
}

.myWriteTitle, .myWriteNum, .myLikeTitle, .myLikeNum, .myClubTitle,
	.myClubNum, .myInfoTitle {
	height: 50%;
	font-size: x-large;
	font-weight: bold;
	line-height: 85px;
	margin-left: 50px;
}

.myWriteTitle, .myLikeTitle, .myClubTitle {
	font-size: x-large;
}

.myWriteNum, .myLikeNum, .myClubNum {
	font-size: x-large;
	color: #286708;
	line-height: 45px;
}

.icon {
	width: 60px;
	height: 60px;
	margin-left: 30px;
	margin-top: 30px;
}

.CS, .notice {
	width: 688px;
	height: 60px;
	background-color: #fbe5c0;
	border-radius: 15px;
	font-size: x-large;
	font-weight: bold;
	padding-left: 30px;
	padding-top: 10px;
}

.leftImg, .rightImg {
	position: absolute;
	width: 330px;
	height: 180px;
	z-index: 2;
	bottom: 50px;
}

.leftImg {
	left: 0;
}

.rightImg {
	right: 0;
}

a {
	color: #5e361a;
	text-decoration: none;
}

a:visited {
	color: #5e361a;
}

.nowNavicon {
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	color: #e6a83e;
}
.FAQDiv a {
	height: 60px;
}
</style>
</head>
<body>
	<div class="topBar">
		<div class="mainTitle">내.zip</div>
		<div class="logoutBtnDiv">
			<a href="/members/logout"><input class="logoutBtn" type="button"
				value="로그아웃"></a>
		</div>
	</div>
	<div class="userBarDiv">
		<div class="userBarContents">${nickname}님,반가워요!</div>
		<img class="userBar" src="/resources/images/userbar.png">
	</div>
	<hr>
	<div class="divContainer">
		<div class="myActiveTitle">· 나의 활동</div>
		<div class="myActiveDiv">
			<a href="/members/myInfo">
				<div class="myInfo">
					<div class="myInfoIcon">
						<img src="/resources/images/settings.png" class="icon">
					</div>
					<div class="myInfoContents">
						<div class="myInfoTitle">내 정보.zip</div>
					</div>
				</div>
			</a> <a href="/members/myPosts?cPage=1">
				<div class="myWrite">
					<div class="myWriteIcon">
						<img src="/resources/images/text1.png" class="icon">
					</div>
					<div class="myWriteContents">
						<div class="myWriteTitle">작성글</div>
						<div class="myWriteNum">${writeCount}</div>
					</div>
				</div>
			</a> <a href="/members/myLikes?cPage=1">
				<div class="myLike">
					<div class="myLikeIcon">
						<img src="/resources/images/love.png" class="icon">
					</div>
					<div class="myLikeContents">
						<div class="myLikeTitle">관심 게시글</div>
						<div class="myLikeNum">${likeCount}</div>
					</div>
				</div>
			</a> <a href="/meeting/myMeeting">
				<div class="myClub">
					<div class="myClubIcon">
						<img src="/resources/images/people.png" class="icon">
					</div>
					<div class="myClubContents">
						<div class="myClubTitle">모임</div>
						<div class="myClubNum">${meetingCount }</div>
					</div>
				</div>
			</a>
		</div>

		<div class="FAQTitle">· 고객센터</div>
		<div class="FAQDiv">
			<a href="/qa/toQa?cPage=1"><div class="CS">고객지원 ></div> </a>
			<a href="/notice/toNotice?cPage=1"><div class="notice">공지사항 ></div></a>
		</div>

	</div>
	<img class="leftImg" src="/resources/images/왼쪽 모서리 풀.png">
	<img class="rightImg" src="/resources/images/오른쪽 모서리 풀.png">

	<div class="bottomBar">
		<a href="/"><i class="navicon fa-solid fa-house fa-2xl"
			style="color: #A66A3F"></i></a> <a href="/map/test"><i
			class="navicon fa-solid fa-map-location-dot fa-2xl"
			style="color: #A66A3F"></i></a> <a href="/meeting/list?category=all"><i
			class="navicon fa-solid fa-people-group fa-2xl"
			style="color: #A66A3F"></i></a> <a href="/feedback/feedbackHome"><i
			class="navicon fa-solid fa-bullhorn fa-2xl" style="color: #A66A3F"></i></a>

		<c:choose>
			<c:when test="${loginId == null}">
				<a href="/members/loginUi"><i
					class="navicon fa-solid fa-user fa-2xl" style="color: #A66A3F"></i></a>
			</c:when>
			<c:when test="${role == 1}">
				<a href="/members/mypage"><i
					class="nowNavicon fa-solid fa-user fa-2xl"></i></a>
			</c:when>
			<c:otherwise>
				<a href="/admin/adminPage"><i
					class="nowNavicon fa-solid fa-user fa-2xl"></i></a>
			</c:otherwise>
		</c:choose>

	</div>
</body>
</html>