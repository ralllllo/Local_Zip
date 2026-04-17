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
}

button, body {
	font-family: 'GMarketSans', sans-serif;
}

.container {
	position: relative;
	width: 100%;
	min-height: 100vh;
	border: 1px solid black;
	background-color: #fbe5c0;
}

.headBox {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100px;
	padding: 0 30px;
	background-color: #F2D3A2;
	border-bottom: 2px solid #A66A3F;
	z-index: 1000;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.backBtn {
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
	height: 30px;
	position: relative;
	top: 15px;
	right: 15px;
	cursor: pointer;
	transition: all 0.3s ease;
}

.backBtn:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #fecc56;
	color: #A66A3F;
}

.backBtn:active {
	transform: translateY(2px);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
	background-color: #ffb300;
}

.mainTitle {
	font-weight: bold;
	font-size: 50px;
	color: #A66A3F;
	white-space: nowrap; /* 글자가 아래로 절대 안 떨어지게 고정 */
}

.nowBtn {
	background-color: #fecc56;
	color: #A66A3F;
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	height: 25px;
	border-radius: 10px;
	border: 1px solid #FFB300;
	align-items: center;
	vertical-align: middle; /* 버튼들끼리 줄이 안 맞을 때를 대비 */
	cursor: pointer;
	transition: 0.3s;
}

.topBtn {
	height: 25px;
	background-color: #FFB300;
	border-radius: 10px;
	border: 1px solid #FFB300;
	color: #3e5e40;
	align-items: center;
	vertical-align: middle;
	transition: 0.3s;
}

.bodyBox {
	width: 100%;
	min-height: auto;
	padding-top: 120px;
	color: #5e361a;
	padding-bottom: 20px;
}

/* 바디박스 수정 */
.orderBox {
	text-align: right;
	font-size: 14px;
	position: relative;
	top: 30px;
	width: 95%;
	max-width: 1500px;
	margin: auto;
	border-radius: 10px;
}

.orderBtn:hover {
	background-color: #fecc56;
}

.titleIdBox {
	width: 95%;
	max-width: 1500px;
	min-height: 100px;
	height: auto;
	margin: auto;
	margin-bottom: 30px;
	border-radius: 10px;
	display: flex;
}

.profileName {
	font-size: 45px;
	display: flex;
	align-items: center;
	margin: 30px;
}

.profileLocal {
	font-size: 30px;
	display: flex;
	align-items: center;
}

.postBox {
	width: 95%;
	max-width: 1500px;
	min-height: 200px;
	height: auto;
	margin: auto;
	margin-bottom: 30px;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
	border-radius: 10px;
}

.postUpBox {
	width: 100%;
	height: 95px;
	display: flex;
	border-radius: 10px 10px 0 0;
	background-color: #F2D3A2;
}

.postProfile {
	width: 100px;
	height: 100px;
	border: 4px solid #A66A3F;
	border-radius: 50%;
	position: relative;
	top: 10px;
	left: 10px;
}

.contentProfile {
	margin-top: -10px;
	margin-left: 2px;
}

.postInfoBox {
	width: 300px;
	min-height: 50px;
	position: relative;
	left: 20px;
	top: 23px;
	flex-grow: 1;
}

.postInfoUp, .postInfoDown {
	display: flex;
}

.postMidBox {
	width: 100%;
	height: auto;
}

.profileTime {
	font-size: 14px;
	display: flex;
	align-items: center;
	width: auto;
	height: 45px;
	margin-left: 7px;
}

.postTitle {
	margin: auto;
	width: 95%;
	height: 40px;
	font-size: 20px;
	margin-top: 5px;
	line-height: 40px;
	color: #5e361a;
	white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis; /* 넘치는 부분을 ...으로 표시 */
    display: block;
}

.postContent {
	margin: auto;
	width: 95%;
	height: 1.5em; /* 한 줄 높이만큼 고정 */
	line-height: 1.5em;
	font-size: 15px;
	background-color: #f0d8af;
	border-radius: 5px;
	padding: 0 10px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	display: block;
}

.navicon:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

.navicon:active {
	transform: translateY(2px);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
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

.pageBox {
	width: 100%;
	text-align: center;
	padding: 20px 0;
	margin-bottom: 80px;
	font-size: 18px;
	color: #A66A3F;
	font-weight: bold;
}

.emptyBox {
	width: 100%;
	height: auto;
	padding: 50px 0;
	font-size: 25px;
	color: #5e361a;
	text-align: center;
}

.page a {
	margin: 10px;
	color: #A66A3F;
	display: inline-block;
	text-decoration: none;
	min-width: 35px;
	padding: 6px 0px 6px 0px;
	border-radius: 6px;
	transition: 0.2s;
	font-weight: normal;
	cursor: pointer;
}

.pageBox a.active {
	background-color: #fecc56;
	font-weight: bold;
	color: #5e361a;
}

.pageBox a:hover {
	background-color: #F2D3A2;
}

.nowNavicon{
   transform: translateY(-3px);
   box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
   color: #e6a83e;
}
</style>

</head>
<body>

	<div class="container">

		<div class="headBox">
			<div class="mainTitle">내 작성글.zip</div>
			<div class="backBtnDiv">
				<a href="/members/mypage"> <input class="backBtn" type="button" value="내.zip으로 가기">
				</a>
			</div>
		</div>

		<div class="bodyBox">

			<div class="titleIdBox">
				<div class="postProfile">
					<img class="contentProfile" src="/resources/images/Profile.png" width="80px">
				</div>
				<div class="profileName profileInfo" style="color: #5e361a;">${nickname}</div>
				<div class="profileLocal profileInfo" style="color: #5e361a;">( 지역(동) : ${dong} )</div>
			</div>

			<c:choose>
				<c:when test="${empty listAll}">
					<div class="emptyBox">등록된 게시글이 없습니다.</div>
				</c:when>

				<c:otherwise>
					<c:forEach var="i" items="${listAll}">
						<div class="postBox" data-seq="${i.post_seq}" style="cursor:pointer;">
							<div class="postUpBox">
								<div class="postInfoBox">
									<div class="postInfoUp">
										<div class="profileCatagory profileInfo">
											<button class="topBtn" type="button">
												<c:choose>
													<c:when test="${i.post_category == 'lifeInfo'}">생활정보</c:when>
													<c:when test="${i.post_category == 'food'}">맛집/카페</c:when>
													<c:when test="${i.post_category == 'talk'}">고민/이야기</c:when>
													<c:when test="${i.post_category == 'beauty'}">미용/패션</c:when>
													<c:otherwise>${i.post_category}</c:otherwise>
												</c:choose>
											</button>
										</div>
									</div>

									<div class="postInfoDown">
										<div class="profileTime profileInfo" style="color: #5e361a;">작성일자 : ${i.post_date}</div>
									</div>
								</div>
							</div>

							<div class="postMidBox">
								<div class="postTitle">${i.post_title}</div>
								<div class="postContent">${i.post_contents}</div>
							</div>
						</div>

					</c:forEach>
					<div class="pageBox">
						<span class="page"></span>
					</div>
				</c:otherwise>
			</c:choose>
		</div>

		<div class="bottomBox">
			<a href="/"><i class="navicon fa-solid fa-house fa-2xl" style="color: #A66A3F"></i></a>
			<a href="/map/test"><i class="navicon fa-solid fa-map-location-dot fa-2xl" style="color: #A66A3F"></i></a>
			<a href="/meeting/list?category=all"><i class="navicon fa-solid fa-people-group fa-2xl" style="color: #A66A3F"></i></a>
			<a href="/feedback/feedbackHome"><i class="navicon fa-solid fa-bullhorn fa-2xl" style="color: #A66A3F"></i></a>

			<c:choose>
				<c:when test="${loginId == null}">
					<a href="/members/loginUi"><i class="navicon fa-solid fa-user fa-2xl" style="color: #A66A3F"></i></a>
				</c:when>
				<c:when test="${role == 1}">
					<a href="/members/mypage"><i class="nowNavicon fa-solid fa-user fa-2xl"></i></a>
				</c:when>
				<c:otherwise>
					<a href="/admin/adminPage"><i class="nowNavicon fa-solid fa-user fa-2xl"></i></a>
				</c:otherwise>
			</c:choose>

		</div>
	</div>
	
	<script>
	
		// 게시글 목록을 눌렀을때, => postDetail.jsp 이동 시.
		$(document).on("click", ".postBox", function(e) {
		    let post_seq = $(this).data("seq");
		    location.href = "/board/postDetail?post_seq=" + post_seq + "&cPage=${cPage}&from=myPosts";
		});
		
		
		// 하단 네비바 구성 cpage
		let recordTotalCount = ${totalCount};
		let recordCountPerPage = 10;
		let naviCountPerPage = 10;
		let currentPage = ${cPage};
	
		let pageTotalCount = Math.ceil(recordTotalCount/recordCountPerPage);
		   
		let startNavi = Math.floor(((currentPage - 1)/naviCountPerPage)) * naviCountPerPage + 1;
		let endNavi = startNavi + naviCountPerPage - 1;
		   
		if(endNavi > pageTotalCount) {
		   endNavi = pageTotalCount;
		}
		$(".page").empty();
		   
		let needPrev = true; // <<
		let needNext = true; // >>
		   
		if(startNavi == 1){needPrev = false;}
		if(endNavi == pageTotalCount){needNext = false;}
		   
		if(needPrev) {
		   let prev = $("<a>"); 
		   prev.attr("href","/members/myPosts?cPage="+(startNavi-1)); 
		   prev.html("<< ");
		   $(".page").append(prev);
		}
		      
		for(let i = startNavi; i <= endNavi; i++) {
		  let navi = $("<a>");
		  navi.attr("href", "/members/myPosts?cPage="+i);
		  navi.html(i + " ");
		  $(".page").append(navi);
		      
		  if (i === currentPage) {
		       navi.addClass("active");
		   }
		}
		
		if(needNext) {
		   let next = $("<a>");
		   next.attr("href", "/members/myPosts?cPage="+(endNavi+1));
		   next.html(" >>");
		   $(".page").append(next);
		}
	</script>

</body>
</html>