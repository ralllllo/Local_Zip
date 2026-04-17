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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2ad57018f836bb74c10d919e862f189a&libraries=clusterer"></script>
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
}

body {
	margin: 0;
	background-color: #fbe5c0;
}

.container {
	width: 100%;
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 20px;
	padding: 200px 0 0 0;
	box-sizing: border-box;
}

.top-section {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	background-color: #fbe5c0;
	z-index: 1000;
	border-bottom: 2px solid #A66A3F;
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

.categoryDiv {
	border: 1px solid #A66A3F;
	font-size: 15px;
	width: 100%;
	height: 50px;
	margin-top: 7px;
	display: flex;
	align-items: center;
	gap: 10px;
	border: none;
}

.categoryBtnAll {
	margin-left: 10px;
	background-color: #FFB300;
	border-radius: 10px;
	border: 1px solid #FFB300;
	color: #3e5e40;
	height: 30px;
	padding: 0 15px;
	cursor: pointer;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	transition: all 0.2s ease;
}

.categoryBtnAll:hover, .navicon:hover, .topBtn:hover, .join-btn:hover,
	.reportBtn:active, .adminMeeting-btn:hover{
	transform: translateY(-3px); /* 살짝 위로 뜸 */
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #fecc56;
	color: #A66A3F;
}

.categoryBtnAll:active, .navicon:active, .topBtn:active, .join-btn:active,
	.reportBtn:active {
	transform: translateY(2px); /* 아래로 눌림 */
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.categoryBtnAll:first-child {
	margin-left: 25px;
}

.topBtn {
	margin-left: auto;
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
	width: 100px;
	height: 40px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
	transition: all 0.2s ease;
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

.meeting-card {
	width: 300px;
	border: 2px solid #C29F6D90;
	border-radius: 10px;
	background-color: #fbe5c0;
	padding: 35px;
	margin: 0 0 40px 40px;
	display: flex;
	flex-direction: column;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
	cursor: pointer;
}

.card-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-weight: bold;
	font-size: 20px;
	color: #5e361a;
}

.reportDiv {
	position: relative;
	display: inline-flex;
	align-items: center;
	gap: 5px;
	cursor: pointer;
}

.title {
	max-width: 280px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.category {
	display: inline-block;
	line-height: 23px;
	font-size: 12px;
	padding: 3px 8px;
	border-radius: 5px;
	margin-top: 18px;
	margin-bottom: 10px;
	background-color: #FFB300;
	height: 20px;
	color: #286708;
	max-width: 120px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.desc {
	margin-bottom: 10px;
	color: #5e361a;
	overflow: hidden;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.category-row {
	display: flex;
	align-items: center;
	gap: 8px;
	margin-bottom: 10px;
}

.info {
	font-size: 13px;
	color: #555;
	margin-bottom: 10px;
	color: #5e361a;
}

.card-footer {
	text-align: center;
	color: #5e361a;
	margin-top: auto;
}

.join-btn, .joinTwo-btn {
	width: 100%;
	height: 40px;
	background-color: #FFB300;
	border: none;
	border-radius: 10px;
	color: #5e361a;
	margin-top: auto;
	transition: all 0.2s ease;
	cursor: pointer;
}

.join-btn:hover, .joinTwo-btn:hover {
	background-color: #fecc56;
	color: #A66A3F;
}

.report {
	display: none;
	position: absolute;
	top: 30px;
	right: 0px;
	width: 150px;
	z-index: 10;
	font-family: 'GMarketSans';
	border: 1px solid #A66A3F;
	border-radius: 5px;
	background-color: #F2D3A2;
	color: #A66A3F;
	font-size: 12px;
	outline: none;
	padding: 2px;
}

.report-menu {
	font-family: 'GMarketSans';
	border: 1px solid #A66A3F;
	border-radius: 5px;
	background-color: #F2D3A2;
	color: #A66A3F;
	font-size: 12px;
	padding: 2px;
	outline: none;
}

.gauge-wrap {
	width: 100%;
	height: 12px;
	background-color: #f3d9a6;
	border-radius: 999px;
	overflow: hidden;
	margin-bottom: 8px;
	border: 1px solid #d7a25a;
}

.gauge-bar {
	height: 100%;
	background-color: #7BB8C9;
	border-radius: 999px;
}

.gauge-text {
	font-size: 12px;
	color: #5e361a;
	margin-bottom: 10px;
	text-align: right;
}

.nowBtn {
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

.reportBtn {
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	display: none;
	position: absolute;
	top: 55px;
	right: 0;
	width: 90px;
	transition: all 0.2s ease;
	cursor: pointer;
}

.reportBtn:hover {
	transform: translateY(-3px); /* 살짝 위로 뜸 */
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #fecc56;
	color: #A66A3F;
}

.pageBox {
	text-align: center;
	padding: 20px;
	font-size: 18px;
	color: #A66A3F;
	margin-bottom: 55px;
}

.pageBox a {
	display: inline-block;
	min-width: 35px;
	padding: 6px 10px;
	margin: 0 8px;
	text-decoration: none;
	color: #A66A3F;
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

.manage-btn {
	height: 26px;
	display: inline-block;
	line-height: 23px;
	font-size: 12px;
	padding: 3px 8px;
	border: none;
	border-radius: 5px;
	margin-top: 18px;
	margin-bottom: 10px;
	background-color: #7BB8C9;
	color: #5e361a;
	flex-shrink: 0;
}

.closing-btn {
	width: 100%;
	height: 40px;
	border: none;
	border-radius: 10px;
	background-color: #FF9D6E;
	color: #666;
	cursor: not-allowed;
	box-shadow: none;
}

.recruitment-Btn {
	width: 100%;
	height: 40px;
	border: none;
	border-radius: 10px;
	background-color: #f3d9a6;
	color: #5e361a;
	cursor: not-allowed;
	box-shadow: none;
}

.applied-Btn {
	width: 100%;
	height: 40px;
	border: none;
	border-radius: 10px;
	background-color: #bebebe;
	color: #5e361a;
	cursor: not-allowed;
	box-shadow: none;
}

.joined-Btn {
	width: 100%;
	height: 40px;
	border: none;
	border-radius: 10px;
	background-color: #f3d9a6;
	color: #5e361a;
	cursor: not-allowed;
	box-shadow: none;
}

.adminMeeting-btn {
	width: 100%;
	height: 40px;
	background-color: #FFB300;
	border: none;
	border-radius: 10px;
	color: #5e361a;
	margin-top: auto;
	cursor: pointer;
	transition: all 0.2s ease;
}

.swal2-icon.swal2-info .swal2-icon-content {
	font-size: 50px; /* i 크기 */
	transform: translateY(5px);
	line-height: 70px; /* 세로 위치 (핵심🔥) */
}

.swal2-icon.swal2-question .swal2-icon-content {
	font-size: 50px; /* i 크기 */
	transform: translateY(5px);
	line-height: 70px; /* 세로 위치 (핵심🔥) */
}

.swal2-icon.swal2-warning .swal2-icon-content {
	font-size: 50px; /* i 크기 */
	transform: translateY(5px);
	line-height: 70px; /* 세로 위치 (핵심🔥) */
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
			<div class="mainTitle">
			<span>동네 모임.zip</span>
				<c:if test="${admin != 1}">
					<a href="/meeting/meetCreate"><button class="topBtn" type="button">+ 모임 만들기</button></a>
				</c:if>
			</div>
			
				
				<c:if test="${msg == 'over'}">
					<script>
						Swal.fire({
							icon: "info",
							title: "Wait  !",
							text: "모임은 최대 3개까지만 생성할 수 있습니다.",
							iconColor: "#FFB300",
							confirmButtonColor: "#FFB300"
						});
					</script>
					</c:if>
				<c:remove var="msg" scope="session"/>
				
			<div class="categoryDiv">
				<a href="/meeting/list?category=all"><button class="categoryBtnAll ${category == 'all' ? 'nowBtn' : ''}">
					<i class="fa-solid fa-house fa-lg"></i> 전체
				</button></a>
				<a href="/meeting/list?category=운동"><button class="categoryBtnAll ${category == '운동' ? 'nowBtn' : ''}">
					<i class="fa-solid fa-dumbbell fa-lg"></i> 운동
				</button></a>
				<a href="/meeting/list?category=문화"><button class="categoryBtnAll ${category == '문화' ? 'nowBtn' : ''}">
					<i class="fa-solid fa-film fa-lg"></i> 문화
				</button></a>
				<a href="/meeting/list?category=취미"><button class="categoryBtnAll ${category == '취미' ? 'nowBtn' : ''}">
					<i class="fa-solid fa-palette fa-lg"></i> 취미
				</button></a>
				<a href="/meeting/list?category=스터디"><button class="categoryBtnAll ${category == '스터디' ? 'nowBtn' : ''}">
					<i class="fa-solid fa-book fa-lg"></i> 스터디
				</button></a>
			</div>
		</div>
			
			<c:forEach var="i" items="${list}">
				<div class="meeting-card" data-seq="${i.meet_seq}" data-mem_id="${i.mem_id}" data-target_id="${i.mem_id}">
					<div class="card-header">
						<div class="title">${i.meet_title}</div>
						<c:if test="${i.mem_id != loginId}">
							<div class="reportDiv">
								<img src="/resources/images/free-icon-siren1.png" class="reportIcon" style="width: 25px; height: 25px;" ></img>
								<select class="report">
									<option class="report-menu" disabled selected>신고 사유</option>
									<option class="report-menu" value="badContents">부적절한 컨텐츠</option>
									<option class="report-menu" value="badWord">욕설/비방</option>
									<option class="report-menu" value="AD">광고/스팸</option>
								</select>
								<button type="button" class="reportBtn">신고하기</button>
							</div>
						</c:if>
					</div>
					
				<div class="category-row">
					<div class="category">${i.meet_category}</div>
							<c:if test="${i.mem_id == loginId}">
	        					<button type="button" class="manage-btn" data-seq="${i.meet_seq}"><i class="fa-solid fa-crown" style="color: rgb(255, 212, 59);"></i> 관리자</button>
	    					</c:if>
    					</div>
					<div class="desc">${i.meet_introcontents}</div>
					
					
					<div class="info">	
						<div class="location">📍 ${i.mem_address1}</div>	
						<div class="count">👥 ${i.meet_maxpeople}</div>
					</div>

					<div class="card-footer">
						<div class="gauge-wrap">
						    <div class="gauge-bar" 
						         style="width:${i.meet_maxpeople == 0 ? 0 :
						         (i.meet_currentpeople >= i.meet_maxpeople ? 100 :
						         (i.meet_currentpeople * 100) / i.meet_maxpeople)}%;">
						    </div>
						</div>
						<div class="gauge-text">${i.meet_currentpeople} / ${i.meet_maxpeople}명 참여중</div>
						
						<c:choose>
					        <c:when test="${i.meet_currentpeople >= i.meet_maxpeople}">
					            <button class="closing-btn" disabled>모집마감</button>
					        </c:when>
					        <c:when test="${i.mem_id == loginId}">
					            <button class="recruitment-Btn" disabled>모집중</button>
					        </c:when>
					         <c:when test="${joinedSet.contains(i.meet_seq)}">
					            <button class="joined-Btn" disabled>참여중</button>
					        </c:when>
					        <c:when test="${companionSet.contains(i.meet_seq) or admin == 1} ">
					        	<button class="joinTwo-btn" data-seq="${i.meet_seq}" data-nickName="${i.mem_nickname}">참여신청</button>
					        </c:when>
					        <c:when test="${appliedSet.contains(i.meet_seq)}">
					            <button class="applied-Btn" disabled>승인대기중</button>
					        </c:when>
					        <c:when test="${admin != 1}">
								<button class="join-btn" data-seq="${i.meet_seq}" data-nickName="${i.mem_nickname}">참여신청</button>
							</c:when>
							<c:otherwise>
								<button class="adminMeeting-btn" data-seq="${i.meet_seq}" data-nickName="${i.mem_nickname}">자세히보기</button>
							</c:otherwise>
    					</c:choose>
					</div>
				</div>
			</c:forEach>
	</div>
	<c:if test="${not empty navi}">
		<div class="pageBox">

			<c:if test="${navi.needPrev}">
				<a href="/meeting/list?category=${category}&cpage=${navi.startNavi - 1}" class="naviArrow"><i class="fa-solid fa-chevron-left"></i></a>
			</c:if>
		
			<c:forEach var="i" begin="${navi.startNavi}" end="${navi.endNavi}">
				<a href="/meeting/list?category=${category}&cpage=${i}" class="${i == navi.cpage ? 'active' : 'naviNum'}">${i}</a>
			</c:forEach>
		
			<c:if test="${navi.needNext}">
				<a href="/meeting/list?category=${category}&cpage=${navi.endNavi + 1}" class="naviArrow"><i class="fa-solid fa-chevron-right"></i></a>
			</c:if>
	
		</div>
	</c:if>
		
		<div class="bottomBar">
			<a href="/"><i class="navicon fa-solid fa-house fa-2xl" style="color: #A66A3F"></i></a>
			<a href="/map/test"><i class="navicon fa-solid fa-map-location-dot fa-2xl" style="color: #A66A3F"></i></a>
			<a href="/meeting/list?category=all"><i class="nowNavicon fa-solid fa-people-group fa-2xl"></i></a>
			<a href="/feedback/feedbackHome"><i class="navicon fa-solid fa-bullhorn fa-2xl" style="color: #A66A3F"></i></a>
			
		
		<c:choose>
	        <c:when test="${loginId == null}">
	        	<a href="/members/loginUi"><i class="navicon fa-solid fa-user fa-2xl" style="color: #A66A3F"></i></a>
			</c:when>
			<c:when test="${role == 1}">
	        	<a href="/members/mypage"><i class="navicon fa-solid fa-user fa-2xl" style="color: #A66A3F"></i></a>
			</c:when>
			<c:otherwise>
				<a href="/admin/adminPage"><i class="navicon fa-solid fa-user fa-2xl" style="color: #A66A3F"></i></a>
			</c:otherwise>
		</c:choose>
		
		</div>
		
	<script>
			$(".categoryBtnAll").on("click", function(){
			    $(".categoryBtnAll").removeClass("nowBtn");
			    $(this).addClass("nowBtn");
			});
			
			$(".reportIcon").on("click", function (e) {
			    e.stopPropagation();
		        let reportDiv = $(this).closest(".reportDiv");
		        
		        reportDiv.find(".report, .reportBtn").toggle(); 
			});
			
			$(".report").on("click", function (e) {
			    e.stopPropagation();
			});
			
			$(document).on("click", function () {
			    $(".report").hide();
			    $(".reportBtn").hide();
			});
			
			$(document).on("click", ".meeting-card", function(){
			    let seq = $(this).data("seq");
			    location.href = "/meeting/meetingDetail?seq=" + seq;
			});
			
			$(document).on("click", ".join-btn, .reportBtn, .reportIcon, .joinTwo-btn", function (e) {
				e.stopPropagation();
			});
			
			$(document).on("click", ".reportBtn", function(e){
				e.stopPropagation();
				
				let card = $(this).closest(".meeting-card");
				let targetSeq = card.data("seq")
				let targetId = card.data("target_id");
				let reportReason = card.find(".report").val();
				
				if(!reportReason){
					Swal.fire({
						icon: "info",
						title: "Wait  !",
						text: "신고 사유를 선택해 주세요.",
						iconColor: "#FFB300",
						confirmButtonColor: "#FFB300"
					});
					return;
				}
					Swal.fire({
				        icon: "question",
				        title: "Wait !",
				        text: "정말 신고하시겠습니까?",
				        iconColor: "#FFB300",
				        confirmButtonColor: "#FFB300",
				        showCancelButton: true,
				        confirmButtonText: "신고",
				        cancelButtonText: "취소",
				        cancelButtonColor: "#d9d9d9"
				    }).then((result) => {
	
				        // ✅ 확인 눌렀을 때만 실행
				        if(result.isConfirmed){
				        	$.ajax({
								url : "/report/insert",
								type : "post",
								data : {
									target_seq : targetSeq,
									target_id : targetId,
									reports_type : 2,
									reports_reason : reportReason
								},
								success : function(resp){
									if(resp == "success"){
										Swal.fire({
				    						icon: "success",
				    						title: "Success  !",
				    						text: "신고가 접수되었습니다.",
				    						iconColor: "#FFB300",
				    						confirmButtonColor: "#FFB300"
				    					});
										card.find(".report").hide();
										card.find(".reportBtn").hide();
									}else if(resp == "fail"){
										Swal.fire({
				    						icon: "warning",
				    						title: "Already  !",
				    						text: "이미 신고한 모임 입니다.",
				    						iconColor: "#FFB300",
				    						confirmButtonColor: "#FFB300"
				    					});
										card.find(".report").hide();
										card.find(".reportBtn").hide();
									 }
								 }
							});
				          }
					  });
				  });
							
								
			
			
			$(".join-btn").on("click", function(){
				
				// 팝업창 크기
				const width = 800;
			    const height = 400;
	
			    // window.screenX : 브라우저가 모니터에서 시작하는 위치
			    // window.outerWidth / 2 : 브라우저의 가운데 위치
			    // width / 2 : 팝업의 절반
			    const left = window.screenX + (window.outerWidth / 2) - (width / 2);
			    const top = window.screenY + 80; // 상단에서 80px
	
			    let seq = $(this).data("seq");
			    let nickName = $(this).data("nickname");
			    const popup = window.open(
			    		
			        "/meetingMember/applyForm?meet_seq=" + seq + "&nickname=" + nickName,
			        "",
			        `width=${width},height=${height}`
			    );

			    if (popup) {
			        popup.resizeTo(width, height);
			        popup.moveTo(left, top);
			        popup.focus();
			    } 
			})
	</script>
</body>
</html>
