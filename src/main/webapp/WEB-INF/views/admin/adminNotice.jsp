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
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2ad57018f836bb74c10d919e862f189a&libraries=clusterer"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
* {box-sizing: border-box;}

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
}

body {
	margin: 0;
	background-color: #fbe5c0;
}

.container {
	width: 100%;
	min-height: 100vh;
	padding-top: 160px;
	padding-bottom: 65px;
}

.top-section {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	background-color: #fbe5c0;
	z-index: 1000;
	border-bottom: 2px solid #A66A3F;
	border: none;
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
	padding-left: 20px;
}

.categoryDiv {
	border: 1px solid #A66A3F;
	font-size: 15px;
	width: 100%;
	height: 50px;
	margin-top: 13px;
	display: flex;
	align-items: center;
	gap: 10px;
	border: none;
}

.categoryBtnAll {
	margin-left: 20px;
	background-color: #FFB300;
	border-radius: 10px;
	border: 1px solid #FFB300;
	color: #286708;
	height: 30px;
	padding: 0 15px;
	cursor: pointer;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	transition: all 0.2s ease;
	line-height: 30px;
	display: flex;
    align-items: center;
    gap : 5px;
}

.categoryBtnAll:hover, .navicon:hover {
	transform: translateY(-3px); /* 살짝 위로 뜸 */
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #fecc56;
	color: #A66A3F;
} 

.categoryBtnAll:active, .navicon:active {
	transform: translateY(2px); /*아래로 눌림*/
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); 
}

.nowBtn{
	background-color: #fecc56;
	color: #A66A3F;
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	height: 30px;
	border: 1px solid #FFB300;
	align-items: center;
	vertical-align: middle;
	cursor: pointer;
	transition: 0.3s;
}

.categoryBtnAll:active{
    transform: translateY(2px);
}

.bottomBar {
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

.categoryAndWriterDiv{
 	width: 100%; 
 	background-color:#F2D3A2;
 	display:flex;
 	justify-content: space-between;
 	align-items: center;
 	font-size: 14px;
 	border:none;
 	padding: 10px 15px;
 	margin:0;
}

.replyAdminId{
	padding-bottom: 10px;
	font-size: 14px;
	color: #5e361a;
	font-weight: bold;
}

.categoryAndWriter{
 	display:flex;
 	gap:20px;
 	align-items: center;
}

.inputQaReply{
 	padding:5px;
 	background-color: #F2D3A2;
 	color: #A66A3F;
 	border-radius: 10px;
 	border:none;
 	margin: 0 0 5px 0;
 	font-size:15px;
 	width:100%;
 	height: 40px;
 	word-break: break-all;
 	white-space: normal;
 	resize: none;
 	outline: none;
 	font-family: 'GMarketSans';
}


.replyTextAndBtn{
 	display:flex;
 	align-items:flex-start;
 	gap:10px;
}

.qaReply{
	padding: 10px 15px;
	border-radius: 10px;
}

.replyRow {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.adminProfileDiv{
 	margin-left: 0;
}

.category{
 	font-size:14px;
    height: 25px;
 	background-color: #FFB300;
	border-radius: 10px;
 	border: 1px solid #FFB300;
 	color: #3e5e40;
 	align-items: center;
 	vertical-align: middle;
 	line-height: 18px;
 	padding:5px;
}

.postBox {
        width: 95%;
        max-width: 1000px;
        margin: 20px auto 0 auto;
        background-color: #fbe5c0;
        border-radius: 5px;
        overflow: hidden;
        box-shadow: 0 4px 6px rgba(0,0,0,0.3);
    }

.postHeader {
        background-color: #F2D3A2;
        padding: 10px 15px;
        font-size: 14px;
        border-bottom: 1px solid #A66A3F;
        color: #A66A3F;
        display: flex;
        justify-content: space-between;
    }

.postBody {
        padding: 15px 15px 5px 15px;
    }

.rowItem1 {
        border: 0px solid #ccc;
        margin-bottom: 10px;
        padding: 10px;
        border-radius: 5px;
        background-color: #F2D3A2;
    }

.rowItem2 {
        border: 0px solid #ccc;
        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
        padding: 10px;
        border-radius: 5px;
    }
    
.labelName {
        font-size: 12px;
        color: #5e361a;;
        display: block;
        margin-bottom: 5px;
    }

.titleContent { font-weight: bold; font-size: 18px; color: #5e361a;}
.textContent { font-size: 15px; color: #444; min-height: 60px; color: #5e361a;}

    /* 답변 영역 (와이어프레임의 하단 칸) */
.answerBox {
        background-color: #F2D3A2;
        border-top: 1px solid #A66A3F;
        padding: 15px;
        color : #5e361a;
    }
.answerLabel {
        font-weight: bold;
        color: #5e361a;
        margin-bottom: 5px;
        display: block;
    }



.WriteBtnDiv{
 	margin: 30px auto 0 auto;
 	display: flex;
 	justify-content: center;
 	align-items: center;
 	gap: 100px;
 }
 
.WriteBtnDiv>button{
 	 background-color: #FFB300;
     color: #5e361a;
     font-weight: bold;
     border-radius: 10px;
     border:none;
     width: 200px;
 	 height: 40px;
 	 font-size:15px;
 } 
 
.adminBtnArea{
 	display:flex;
	gap:10px;
	flex-shrink:0;
 }
.adminBtn{
 	margin: 0 0 7px 15px;
 	background-color: #ffb300;
    color: #5e361a;
    border: 1px solid #ffb300;
    border-radius: 10px;
    width: 100px;
 	height: 40px;
 	box-shadow: 0 4px 10px rgba(0,0,0,0.3);
 	font-size:15px;
 }
 
.postBox {
	width: 95%;
	max-width: 1000px;
	margin: 20px auto;
	background-color: #fbe5c0; /* 와이어프레임의 흰색 배경 느낌 */
	border-radius: 5px;
	overflow: hidden;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
}
.postBox:hover{
	cursor: pointer;
}
.postHeader {
	background-color: #F2D3A2;
	padding: 10px 15px;
	font-size: 14px;
	border-bottom: 1px solid #A66A3F;
	color: #A66A3F;
}
.postBody {
	padding: 15px;
}
.rowItem1 {
	border: 0px solid #ccc;
	padding: 10px;
	border-radius: 5px;
	background-color: #F2D3A2;
}

.titleContent {
	font-weight: bold;
	font-size: 18px;
	color: #5e361a;
}
.emptyBox {
	width: 100%;
	height: 600px;
	font-size: 25px;
	color: #5e361a;
	text-align: center;
}

.pageBox {
	text-align: center;
	padding: 20px;
	font-size: 18px;
	color: #A66A3F;
	transform: translateX(-20px);
}

.pageBox span {
	margin: 0 10px;
	cursor: pointer;
}

a{
	text-decoration: none;
}

img{
	width: 16.67px;
	height: 16.10px;
}

.page a{
	margin: 10px;
	color: #A66A3F;
	display: inline-block;
	min-width:35px;
    padding:6px 0px 6px 0px;
	border-radius:6px;
    transition:0.2s;
    font-weight: normal;
    cursor: pointer;
}

.pageBox a.active{
	background-color:#fecc56;
    font-weight: bold;
    color: #5e361a;
}

.pageBox a:hover{
    background-color:#F2D3A2;
}

.filterBtn{
	transition: all 0.2s ease;
	cursor: pointer;
}

.nowNavicon{
   transform: translateY(-3px); /* 살짝 위로 뜸 */
   box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
   color: #e6a83e;
}
</style>
</head>

<body>
	
	<div class="container">
		<div class="top-section">
			<div class="mainTitle">관리자.zip</div>
			<div class="categoryDiv">
				<a href="/admin/adminPage"><button class="categoryBtnAll ${menu == 'dashboard' ? 'nowBtn' : ''}">
					<i class="fa-solid fa-chart-column fa-lg"></i> 대시보드
				</button></a>
				<a href="/admin/adminBlackList?cpage=1&status=all"><button class="categoryBtnAll ${menu == 'report' ? 'nowBtn' : ''}"> 
					<img src="/resources/images/adminSiren.png"></img> 신고관리
				</button></a>
				<a href="/admin/adminQA?cpage=1&status=all"><button class="categoryBtnAll ${menu == 'qa' ? 'nowBtn' : ''}">
					<i class="fa-solid fa-headset fa-lg"></i> 고객지원
				</button></a>
				<a href="/admin/toAdminNotice"><button class="categoryBtnAll ${menu == 'notice' ? 'nowBtn' : ''}">
					<i class="fa-solid fa-bullhorn fa-lg"></i> 공지사항
				</button></a>
			</div>
		</div>
		
		<div class="WriteBtnDiv">
			<button class="navicon filterBtn" type="button" onclick="location.href='/admin/toNoticeWrite'">공지사항 작성하기</button>
		</div>
		
		<c:choose>
			<c:when test="${not empty list}">
				<c:forEach var="i" items="${list}">
				<div class="postBox" onclick="location.href='/notice/toNoticeDetail?notice_seq=${i.notice_seq}&cPage=${cPage}'">
					<input type="hidden" name="notice_seq" value="${i.notice_seq}">
					<div class="postHeader">${i.notice_date}</div>
					<div class="postBody">
						<div class="rowItem1">
							<div class="titleContent">${i.notice_title}</div>
						</div>
					</div>
				</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="emptyBox">등록된 공지사항이 없습니다.</div>
			</c:otherwise>
		</c:choose>
		
		<div class="pageBox">
			 <span class="page"></span>
		</div>
    	
		<div class="bottomBar">
			<a href="/"><i class="navicon fa-solid fa-house fa-2xl" style="color: #A66A3F"></i></a> 
			<a href="/map/test"><i class="navicon fa-solid fa-map-location-dot fa-2xl" style="color: #A66A3F"></i></a>
			<a href="/meeting/list?category=all"><i class="navicon fa-solid fa-people-group fa-2xl" style="color: #A66A3F"></i></a> 
			<a href="/feedback/feedbackHome"><i class="navicon fa-solid fa-bullhorn fa-2xl" style="color: #A66A3F"></i></a> 
			<a href="/admin/adminPage"><i class="nowNavicon fa-solid fa-user fa-2xl"></i></a>
		</div>
	</div>
	
	<script>			
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
		prev.attr("href","/admin/toAdminNotice?cPage="+(startNavi-1)); 
		prev.html("<< ");
		$(".page").append(prev);
	}
		
	for(let i = startNavi; i <= endNavi; i++) {
		let navi = $("<a>");
		navi.attr("href", "/admin/toAdminNotice?cPage="+i);
		navi.html(i + " ");
		$(".page").append(navi);
		
		if (i === currentPage) {
	        navi.addClass("active");
	    }
	}
	if(needNext) {
		let next = $("<a>");
		next.attr("href", "/admin/toAdminNotice?cPage="+(endNavi+1));
		next.html(" >>");
		$(".page").append(next);
	}

	</script>
</body>
</html>