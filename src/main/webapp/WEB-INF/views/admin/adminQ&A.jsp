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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
	gap: 5px;
}

.categoryBtnAll:hover {
	transform: translateY(-3px); /* 살짝 위로 뜸 */
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #fecc56;
	color: #A66A3F;
}

.navicon:hover {
	transform: translateY(-3px); /* 살짝 위로 뜸 */
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

.categoryBtnAll:active, .navicon:active {
	transform: translateY(2px); /*아래로 눌림*/
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.nowBtn {
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

.categoryBtnAll:active {
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

.categoryAndWriterDiv {
	width: 100%;
	background-color: #F2D3A2;
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-size: 14px;
	border: none;
	padding: 10px 15px;
	margin: 0;
}

.replyAdminId {
	padding-bottom: 10px;
	font-size: 14px;
	color: #5e361a;
	font-weight: bold;
}

.categoryAndWriter {
	display: flex;
	gap: 20px;
	align-items: center;
}

.inputQaReply {
	background-color: #F2D3A2;
	color: #A66A3F;
	border-radius: 10px;
	border: none;
	font-size: 15px;
	width: 100%;
	resize: none;
	outline: none;
	font-family: 'GMarketSans';
}

.answerDiv {
	padding: 5px;
	background-color: #F2D3A2;
	color: #A66A3F;
	border-radius: 10px;
	border: none;
	margin: 0 0 5px 0;
	font-size: 15px;
	flex: 1;
	width: auto;
	min-width: 0;
	min-height: 40px;
	font-family: 'GMarketSans';
}

.replyBtn {
	margin: 0 0 7px 15px;
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	width: 100px;
	height: 40px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
	font-size: 15px;
}

.replyTextAndBtn {
	display: flex;
	gap: 10px;
}

.qaReply {
	padding: 10px 15px;
	border-radius: 10px;
}

.replyRow {
	display: flex;
	flex-direction: column;
	gap: 8px;
}

.adminProfileDiv {
	margin-left: 0;
}

.category {
	font-size: 14px;
	height: 25px;
	background-color: #FFB300;
	border-radius: 10px;
	border: 1px solid #FFB300;
	color: #3e5e40;
	align-items: center;
	vertical-align: middle;
	line-height: 18px;
	padding: 5px;
}

.postBox {
	width: 95%;
	max-width: 1000px;
	margin: 20px auto 0 auto;
	background-color: #fbe5c0;
	border-radius: 5px;
	overflow: hidden;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
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

.titleContent {
	font-weight: bold;
	font-size: 18px;
	color: #5e361a;
}

.textContent {
	font-size: 15px;
	color: #444;
	min-height: 60px;
	color: #5e361a;
}

.titleContent, .textContent{
	word-break: keep-all;
	overflow-wrap: break-word;
}

/* 답변 영역 (와이어프레임의 하단 칸) */
.answerBox {
	background-color: #F2D3A2;
	border-top: 1px solid #A66A3F;
	padding: 15px;
	color: #5e361a;
}

.answerLabel {
	font-weight: bold;
	color: #5e361a;
	margin-bottom: 5px;
	display: block;
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

.answerBtnDiv {
	margin: 30px auto 0 auto;
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 100px;
}

.answerBtnDiv>button {
	background-color: #fbe5c0;
	color: #5e361a;
	font-weight: bold;
	border: none;
	width: 100px;
	height: 40px;
	font-size: 15px;
}

.adminBtnArea {
	display: flex;
	gap: 10px;
	flex-shrink: 0;
}

.adminBtn, .replyBtn {
	margin: 0 0 7px 15px;
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	width: 100px;
	height: 40px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
	font-size: 15px;
}

.pageBox {
	text-align: center;
	padding: 20px;
	font-size: 18px;
	color: #A66A3F;
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

.answerDiv.editing {
	background-color: transparent !important;
	padding: 0 !important;
	border: none !important;
}

a {
	text-decoration: none;
}

img {
	width: 16.67px;
	height: 16.10px;
}

.textContent, .answerDiv, .inputQaReply{
	white-space: pre-wrap;
}

.filterBtn {
	transition: all 0.2s ease;
	cursor: pointer;
}

.adminBtn, .UpdateBtn, .replyBtn {
	transition: all 0.2s ease;
	cursor: pointer;
}

.adminBtn:hover, .UpdateBtn:hover, .replyBtn:hover {
	transform: translateY(-3px); /* 살짝 위로 뜸 */
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #fecc56;
	color: #A66A3F;
}

.swal2-icon.swal2-question .swal2-icon-content {
	font-size: 50px; /* i 크기 */
	transform: translateY(5px);
	line-height: 70px; /* 세로 위치 (핵심🔥) */
}

.swal2-icon.swal2-info .swal2-icon-content {
	font-size: 50px; /* i 크기 */
	transform: translateY(5px);
	line-height: 70px; /* 세로 위치 (핵심🔥) */
}

.answerDiv{
	word-break: keep-all;
	overflow-wrap: break-word;
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
				<a href="/admin/toAdminNotice?cPage=1"><button class="categoryBtnAll ${menu == 'notice' ? 'nowBtn' : ''}">
					<i class="fa-solid fa-bullhorn fa-lg"></i> 공지사항
				</button></a>
			</div>
		</div>
		
		<div class="answerBtnDiv">
				<button class="navicon filterBtn allBtn ${status == 'all' ? 'nowBtn' : ''}" data-status="all">전체 ${qaAllCount}</button>
				<button class="navicon filterBtn ${status == '0' ? 'nowBtn' : ''}" data-status="0">답변대기 ${qaCount}</button>
				<button class="navicon filterBtn ${status == '1' ? 'nowBtn' : ''}" data-status="1">답변완료 ${qaDoneCount}</button>
		</div>
		
		<div id="qaListWrap">
			<c:forEach var="i" items="${list}">
			    <div class="postBox">
			        <div class="postHeader">
			        <div class="categoryAndWriter">
				        <div>작성자: ${i.mem_id}</div>
				        <div class="category">
						    <c:choose>
						        <c:when test="${i.qa_category == 0}">계정/로그인</c:when>
						        <c:when test="${i.qa_category == 1}">이용문의</c:when>
						        <c:otherwise>기타</c:otherwise>
						    </c:choose>
						</div>
					</div>
			            <div>${i.qa_create_date}</div>
			        </div>
			
			        <div class="postBody">
				        <div class="rowItem1">
				        	<span class="labelName">제목</span>
				        	<div class="titleContent">${i.qa_title}</div>
			        	</div>
				        <div class="rowItem2">   	
				            <span class="labelName">내용</span>
				            <div class="textContent">${i.qa_contents}</div>
		            	</div>
			        </div>
		<div class="qaReply">
	    	<div class="qaReplyRow">
		        <div class="adminProfileDiv">
		            <div class="replyAdminId">관리자</div>
		        </div>

      	 	<!-- 답변 없는 경우 -->
	        <c:if test="${i.qa_status == 0}">
	            <form action="/admin/answer" method="post" id="frm">
	            	<input type="hidden" name="cpage" value="${currentPage}">
					<input type="hidden" name="status" value="${status}">
	                <input type="hidden" name="qa_seq" value="${i.qa_seq}">
	                <div class="replyTextAndBtn">
	                    <textarea placeholder="댓글을 입력하세요." class="inputQaReply" name="admin_answer"></textarea>
						<button class="replyBtn" type="submit">등록</button>
	                </div>
	            </form>
	        </c:if>
	
	        <!-- 답변 있는 경우 -->
	        <c:if test="${i.qa_status != 0}">
	            <div class="replyTextAndBtn">
	                <div class="answerDiv">${i.admin_answer}</div>
	                <div class="adminBtnArea">
	                    <button class="adminBtn updateBtn" type="button" data-seq="${i.qa_seq}">수정</button>
	                    <button class="adminBtn deleteBtn" type="button" data-seq="${i.qa_seq}">삭제</button>
	                    <button class="UpdateBtn saveBtn replyBtn" type="button" data-seq="${i.qa_seq}" style="display:none">저장</button>
	                    <button class="UpdateBtn cenBtn replyBtn" type="button" data-seq="${i.qa_seq}" style="display:none">취소</button>
			                </div>
			            </div>
			        </c:if>
		    	</div>
			</div>
			    </div>
			</c:forEach>
		</div>
		
		
		<div class="pageBox"></div>
    	
		<div class="bottomBar">
			<a href="/"><i class="navicon fa-solid fa-house fa-2xl" style="color: #A66A3F"></i></a> 
			<a href="/map/test"><i class="navicon fa-solid fa-map-location-dot fa-2xl" style="color: #A66A3F"></i></a>
			<a href="/meeting/list?category=all"><i class="navicon fa-solid fa-people-group fa-2xl" style="color: #A66A3F"></i></a> 
			<a href="/feedback/feedbackHome"><i class="navicon fa-solid fa-bullhorn fa-2xl" style="color: #A66A3F"></i></a> 
			<a href="/admin/adminPage"><i class="nowNavicon fa-solid fa-user fa-2xl"></i></a>
		</div>
	</div>
	
	<script>
			
	
			let recordTotalCount = ${recordTotalCount}; // 데이터개수
			let recordCountPerPage = ${recordCountPerPage} // 몇 개 게시글 표시?
			let naviCountPerPage = ${naviCountPerPage} // 네비게이터 몇 개 표시?
			let currentPage = ${currentPage} // 시작페이지
			let currentStatus = "${status}"
					
			let pageTotalCount = Math.ceil(recordTotalCount/recordCountPerPage);
			// 시작 / 끝 페이지 지정
			let startNavi = Math.floor(((currentPage - 1) / naviCountPerPage)) * naviCountPerPage + 1;
			let endNavi = startNavi + naviCountPerPage - 1;
			
			if(endNavi > pageTotalCount){
				endNavi = pageTotalCount;
			}
			
			let needPrev = true;
			let needNext = true;
			
			if(startNavi == 1){needPrev = false};
			if(endNavi == pageTotalCount){needNext = false};
			
			
			if(needPrev){
				let prev = $("<a>");
				prev.attr("href","/admin/adminQA?cpage=" + (startNavi-1) + "&status=" + currentStatus);
				prev.html("<< ");
				$(".pageBox").append(prev);
			}
			
			for(let i = startNavi; i <= endNavi; i++){
				let navi = $("<a>");
				navi.attr("href","/admin/adminQA?cpage=" + i + "&status=" + currentStatus);
				navi.html(i + " ");
				
				if(i == currentPage){
					navi.addClass("active");
				}
				$(".pageBox").append(navi);
			}
			
			if(needNext){
				let next = $("<a>");
				next.attr("href", "/admin/adminQA?cpage=" + (endNavi+1) + "&status=" + currentStatus);
				next.html(">>");
				$(".pageBox").append(next);
			}
			
			
			$(document).on("click", ".filterBtn", function(){
			    // 1. 모든 필터 버튼에서 활성화 클래스 제거 (기존 navicon 효과 등 포함)
			    $(".filterBtn").removeClass("nowBtn");
			    
			    // 2. 클릭한 버튼에만 활성화 클래스 추가
			    $(this).addClass("nowBtn");
		
			    let status = $(this).data("status");
			    location.href = "/admin/adminQA?cpage=1&status=" + status;
			});
				
			$(document).on("submit", "#frm", function(e){
				let textarea = $(this).find(".inputQaReply");
				
				// 데이터추출
	            let replyContents = textarea.val(); 
	            let value = replyContents.trim();  
	  			// 내용 제한
	            let limit = 1000;     
	  			 
				if(value == ""){
					e.preventDefault();
					Swal.fire({
						icon: "info",
						title: "Wait  !",
						text: "내용을 입력해 주세요.",
						iconColor: "#FFB300",
						confirmButtonColor: "#FFB300"
					});
					return false;
					}
					
				// 글자수 초과 체크
	          	if (replyContents.length > limit) {
		        	  e.preventDefault(); // 초과되면 제출 막기
		              let currentLen = replyContents.length;
		              let overText = replyContents.substring(limit, limit + 100); 
	
		              Swal.fire({
		                  icon: "warning",
		                  title: "댓글 글자수 초과!",
		                  html: "현재 댓글이 <b>" + currentLen + "자</b>입니다. (제한: 1000자)<br><br>" +
		                        "<div style='color:red; background:#fff1f1; padding:15px; border-radius:5px; text-align:left; font-size:14px; border:1px solid #ffcccc; white-space: pre-wrap; word-break: break-all;'>" +
		                        "<b>이 부분부터 삭제해주세요:</b><br><br>" +
		                        "<span style='color:#555;'>... " + overText + "</span></div>",
		                  iconColor: "#EB0000",
		                  confirmButtonColor: "#FFB300"
		              });
		              return;
		          	}
				})
			
			$(document).on("click", ".updateBtn", function(){
				let parentRow = $(this).closest(".replyTextAndBtn");
				let answerDiv = parentRow.find(".answerDiv");
				let originText = answerDiv.text().trim();
				let seq = $(this).data("seq");
				
				answerDiv.data("origin", originText);
				
				answerDiv.addClass("editing");
				answerDiv.html(`<textarea class="inputQaReply inputUpdate" id="inputUpdate_\${seq}" data-origin="\${originText}">\${originText}</textarea>`);
				
				let textarea = $("#inputUpdate_" + seq)[0];
				textarea.style.height = "auto";
				textarea.style.height = textarea.scrollHeight + "px";
			   
					parentRow.find(".adminBtn").hide();
					parentRow.find(".UpdateBtn").show();
				});
			
				$(document).on("click", ".cenBtn", function(){
					let parentRow = $(this).closest(".replyTextAndBtn");
				    let answerDiv = parentRow.find(".answerDiv");
				    
				    let originalText = answerDiv.data("origin");
				    answerDiv.html(originalText);
				    answerDiv.removeClass("editing");
				    
				    parentRow.find(".saveBtn, .cenBtn").hide();
				    parentRow.find(".updateBtn, .deleteBtn").show();
				});
				
				$(document).on("click", ".saveBtn", function(){
					let btn = $(this);
					let seq = btn.data("seq");
		             
					 // 데이터추출
		             let replyContents = $("#inputUpdate_" + seq).val();
		             // 엔터(\n)를 포함한 실제 텍스트 추출 (innerText 사용)
		             let updateContents = replyContents.trim();
		  			 // 내용 제한
		             let limit = 1000;     
		             
					if(updateContents == ""){
						Swal.fire({
    						icon: "info",
    						title: "Wait  !",
    						text: "내용을 입력해 주세요.",
    						iconColor: "#FFB300",
    						confirmButtonColor: "#FFB300"
    					});
						return;
					}

			          // 글자수 초과 체크
			          if (replyContents.length > limit) {
			              let currentLen = replyContents.length;
			              let overText = replyContents.substring(limit, limit + 100); 

			              Swal.fire({
			                  icon: "warning",
			                  title: "댓글 글자수 초과!",
			                  html: "현재 댓글이 <b>" + currentLen + "자</b>입니다. (제한: 1000자)<br><br>" +
			                        "<div style='color:red; background:#fff1f1; padding:15px; border-radius:5px; text-align:left; font-size:14px; border:1px solid #ffcccc; white-space: pre-wrap; word-break: break-all;'>" +
			                        "<b>이 부분부터 삭제해주세요:</b><br><br>" +
			                        "<span style='color:#555;'>... " + overText + "</span></div>",
			                  iconColor: "#EB0000",
			                  confirmButtonColor: "#FFB300"
			              });
			              return;
			          }
					$.ajax({
						url : "/admin/answerUpdate",
						type : "post",
						data : {
							qa_seq : seq,
							admin_answer : updateContents
						},
						success : function(resp){
							
								let parentRow = btn.closest(".replyTextAndBtn");
							    let answerDiv = parentRow.find(".answerDiv");
							    
							    
							    Swal.fire({
		    						icon: "success",
		    						title: "Success  !",
		    						text: "수정되었습니다.",
		    						iconColor: "#FFB300",
		    						confirmButtonColor: "#FFB300"
		    					});
							    
								answerDiv.removeClass("editing");
								answerDiv.html(updateContents);
								
								parentRow.find(".saveBtn, .cenBtn").hide();
				                parentRow.find(".updateBtn, .deleteBtn").show();
							
						},
						error : function(){
							Swal.fire({
								icon: "error",
								title: "Error  !",
								text: "수정 실패",
								iconColor: "#EB0000",
								confirmButtonColor: "#FFB300"
							});
						}
					});
				});
				
			$(document).on("click", ".deleteBtn", function(){
				let seq = $(this).data("seq");
				
				Swal.fire({
			        icon: "question",
			        title: "정말 삭제하시겠습니까?",
			        text: "삭제 후에는 복구할 수 없습니다.",
			        iconColor: "#FFB300",
			        confirmButtonColor: "#FFB300",
			        showCancelButton: true,
			        confirmButtonText: "삭제",
			        cancelButtonText: "취소",
			        cancelButtonColor: "#d9d9d9"
			    }).then((result) => {
				
					if(result.isConfirmed){
						$.ajax({
							url : "/admin/answerReset",
							type : "post",
							data : {qa_seq : seq},
							success : function(resp){
								
								Swal.fire({
			                        icon: "success",
			                        title: "Success !",
			                        text: "삭제되었습니다.",
			                        iconColor: "#FFB300",
			                        confirmButtonColor: "#FFB300"
			                    }).then(() => {
			                        location.reload();
			                    });
							 }
						});
					}
				});
			});
			
			$(document).on("input", ".inputQaReply", function(){
			    this.style.height = "auto";
			    this.style.height = this.scrollHeight + "px";
			});
			
			
	</script>
</body>
</html>