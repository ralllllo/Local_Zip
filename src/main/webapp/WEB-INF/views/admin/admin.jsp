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
	color: #3e5e40;
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
	transform: translateY(2px); /* 아래로 눌림 */
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}
.nowBtn{
	background-color: #fecc56;
	color: #A66A3F;
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	height: 30px;
	border-radius: 10px;
	border: 1px solid #FFB300;
	align-items: center;
	vertical-align: middle;
	cursor: pointer;
	transition: 0.3s;
}

.categoryBtnAll:active{
    transform: translateY(2px);
}

.menuDiv{
	width: 1600px;
	margin: 200px auto 30px auto;
	display:flex;
}
.menuDetail{
	width: 20%;
	margin: 0 auto 0 auto;
	background-color: #F2D3A2;
	border-radius: 20px;
}

.chart-box {
	width: 80%;
	height: 400px;
	padding: 40px;
	box-sizing: border-box;
	background-color: white;
	margin:auto auto 40px auto;
}

.chart-rowDiv{
	display: flex;
	gap: 30px;
	margin: 25px auto;
	width: 80%;
}
.chart-row, .chart-rowGen{
	width: 50%;
    position: relative;
    padding-top: 40px;
}

.rowText, .rowTextGen, .categoryText, .visitText{
	font-size: 20px;
	font-weight: bold;
	color: #5e361a;
}

.category-wrap, .visit-wrap{
    width: 80%;
    margin: 40px auto 70px auto;
    position: relative;
    padding-top: 60px;   /* 제목 올라갈 자리 */
}

.categoryText, .visitText {
    position: absolute;
    top: 0;
    left: 0;
    width: 300px;
    height: 50px;
    line-height: 50px;
    text-align: center;
    background-color: #F2D3A2;
    border-radius: 20px;
    font-weight: bold;
    z-index: 2;
}

.visitText {
    position: absolute;
    top: 0;
    left: 0;
    width: 150px;
    height: 50px;
    line-height: 50px;
    text-align: center;
    background-color: #F2D3A2;
    border-radius: 20px;
    font-weight: bold;
    z-index: 2;
}

.category-box, .visit-box{
    width: 100%;
    height: 400px;
    padding: 35px;
    box-sizing: border-box;
    background-color: white;
    margin: 0;
}

.rowText, .rowTextGen{
	text-align:center;
	width: 100px;
	height: 50px;
	line-height: 52px;
	background-color: #F2D3A2;
	border-radius: 20px;
	margin-bottom: 10px;
}

.chart-box.small {
	width: 100%;
	height: 290px;
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


.membersIcon, .visitantIcon, .askIcon{
	font-size:30px;
	padding: 10px 10px 0 20px;
}

.allMembersDiv, .visitantDiv, .askDiv{
	display: flex;
	flex-direction: column;
	padding: 10px;
}

.members, .visitant, .ask{
	display: flex;
	align-items: center;
	gap:10px;
	font-weight: bold;
	font-size: 20px;
	color: #5e361a;
}

.membersCount, .visitantCount, .askCount{
	font-weight: bold;
	color: #286708;
}

a{
	text-decoration: none;
}

img{
	width: 16.67px;
	height: 16.10px;
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
				<a href="/admin/adminPage"><button class="categoryBtnAll ${menu == 'dashboard' ? 'nowBtn' : ''}" type="button">
					<i class="fa-solid fa-chart-column fa-lg"></i> 대시보드
				</button></a>
				<a href="/admin/adminBlackList?cpage=1&status=all"><button class="categoryBtnAll ${menu == 'report' ? 'nowBtn' : ''}" type="button">
					<img src="/resources/images/adminSiren.png"></img> 신고관리
				</button></a>
				<a href="/admin/adminQA?cpage=1&status=all"><button class="categoryBtnAll ${menu == 'qa' ? 'nowBtn' : ''}" type="button">
					<i class="fa-solid fa-headset fa-lg"></i> 고객지원
				</button></a>
				<a href="/admin/toAdminNotice?cPage=1"><button class="categoryBtnAll ${menu == 'notice' ? 'nowBtn' : ''}" type="button">
					<i class="fa-solid fa-bullhorn fa-lg"></i> 공지사항
				</button></a>
			</div>
		</div>
		
	
		<div class="menuDiv">
			<div class="members menuDetail">
				<div class="membersIcon"><i class="fa-solid fa-user"></i></div>
				<div class="allMembersDiv">
					<div class="allMembers">총 회원</div>
					<div class="membersCount">${memberCount}</div>
				</div>
			</div>
			
			<div class="visitant menuDetail">
				<div class="visitantIcon"><i class="fa-solid fa-chart-column"></i></div>
				<div class="visitantDiv">
					<div class="allVisitant">오늘 방문자</div>
					<div class="visitantCount">${todayVisitCount}</div>
				</div>
			</div>
			
			<div class="ask menuDetail">
				<div class="askIcon"><i class="fa-solid fa-headset"></i></div>
				<div class="askDiv">
					<div class="allAsk">대기 문의</div>
					<div class="askCount">${qaCount}</div>
				</div>
			</div>
		</div>
	
		<div class="visit-wrap">
			<div class="visitText">일별 방문자</div>
			<div class="chart-box visit-box">
				<canvas id="visitChart"></canvas>
			</div>
		</div>
		
		<div class="chart-rowDiv">
			<div class="chart-row">
				<div class="rowText">연령대별</div>
				<div class="chart-box small">
					<canvas id="ageChart"></canvas>
				</div>
			</div>
				
			<div class="chart-rowGen">
				<div class="rowTextGen">성별별</div>
				<div class="chart-box small">
					<canvas id="genderChart"></canvas>
				</div>
			</div>
		</div>
		
		<div class="category-wrap">
			<div class="categoryText">카테고리별 게시글 현황</div>
			<div class="chart-box category-box">
				<canvas id="categoryChart"></canvas>
			</div>
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
			let labels = [];
			let totalData = [];
			let newData = [];
			
			<c:forEach var="i" items="${dailyCount}">
				labels.push("${i.day}일");
				totalData.push(${i.totalCount});
				newData.push(${i.newCount});
			</c:forEach>
	
	
			let visitCtx = document.getElementById('visitChart'); // 선 차트
			
			new Chart(visitCtx, {
			    type: 'line',
			    data: {
			        labels: labels,
			        datasets: [
			            {
			                label: '총 방문자',
			                data: totalData,
			                borderColor: '#E76F51',
			                backgroundColor: 'rgba(85,85,85,0.2)',
			                tension: 0.3
			            },
			            {
			                label: '신규 방문자',
			                data: newData,
							borderColor: '#F6BD60',
			                backgroundColor: 'rgba(180,180,180,0.2)',
			                tension: 0.3
			            }
			        ]
			    },
			    options: {
			        responsive: true,
			        maintainAspectRatio: false,
			        scales:{ 
			        	y: {
			        		beginAtZero: true
			        	}			        	
			        }
			    }
			});
		
			let ageLabels = [];
			let ageData = [];
			
			<c:forEach var="i" items="${ageCount}">
				ageLabels.push("${i.ageGroup}");
				ageData.push(${i.count});
			</c:forEach>
			
			let ageCtx = document.getElementById('ageChart'); // 연령대 도넛 차트
			
			new Chart(ageCtx, {
			    type: 'doughnut',
			    data: {
			        labels: ageLabels ,
			        datasets: [{
			            data: ageData,
			            backgroundColor: ['#F7E1AE', '#F6BD60', '#F4A261', '#E76F51', '#D1495B']
			        }]
			    },
			    options: {
			        responsive: true,
			        maintainAspectRatio: false
			    }
			});
			
			let genderLabels = [];
			let genderData = [];
			
			<c:forEach var="i" items="${genderCount}">
				<c:choose>
					<c:when test="${i.gender == 1}">
						genderLabels.push("남");
					</c:when>
					<c:otherwise>
						genderLabels.push("여");
					</c:otherwise>
				</c:choose>
				genderData.push(${i.count});
			</c:forEach>
			
			let genderCtx = document.getElementById('genderChart'); // 성별 도넛 차트

			new Chart(genderCtx, {
			    type: 'doughnut',
			    data: {
			        labels: genderLabels,
			        datasets: [{
			            data: genderData,
			            backgroundColor: ['#F4A261', '#E76F51']
			        }]
			    },
			    options: {
			        responsive: true,
			        maintainAspectRatio: false
			    }
			});
			
			let categoryLabels = [];
			let categoryData = [];
			let visitData = [];
			
			<c:forEach var="i" items="${categoryCount}">
				<c:choose>
					<c:when test="${i.postCategory == 'lifeInfo'}">
						categoryLabels.push("생활정보");
					</c:when>
					<c:when test="${i.postCategory == 'food'}">
						categoryLabels.push("맛집/카페");
					</c:when>
					<c:when test="${i.postCategory == 'talk'}">
						categoryLabels.push("고민/이야기");
					</c:when>
					<c:when test="${i.postCategory == 'beauty'}">
						categoryLabels.push("미용/패션");
					</c:when>
				</c:choose>
				categoryData.push(${i.count});
				visitData.push(${i.visitCount});
			</c:forEach>
			
			let categoryCtx = document.getElementById('categoryChart'); // 카테고리별 게시글 현황

			new Chart(categoryCtx, {
			    type: 'bar',
			    data: {
			        labels: categoryLabels,
			        datasets: [
			            {
			                label: '게시글 수',
			                data: categoryData,
			                backgroundColor: '#F7E1AE',
			                categoryPercentage: 0.7,
			                barPercentage: 0.7
			            },
			            {
			                label: '유입 방문자 수',
			                data: visitData,
			                backgroundColor: '#E76F51',
			                categoryPercentage: 0.7,
			                barPercentage: 0.7
			            }
			        ]
			    },
			    options: {
			        responsive: true,
			        maintainAspectRatio: false,
	                scales: {
	    	            y: {
	    	                beginAtZero: true
	    	            }
	    	        }
			    }
			});
</script>
</body>
</html>