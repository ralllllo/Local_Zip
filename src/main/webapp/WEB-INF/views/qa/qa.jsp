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
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="icon" type="image/png" sizes="512x512" href="/resources/images/pavicon.png">

<style>
/* 기존 폰트 및 기본 스타일 유지 */
@font-face {
	font-family: 'GMarketSans';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansLight.woff')
		format('woff');
	font-weight: 300;
}

@font-face {
	font-family: 'GMarketSans';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff')
		format('woff');
	font-weight: 500;
}

@font-face {
	font-family: 'GMarketSans';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansBold.woff')
		format('woff');
	font-weight: 700;
}

* {
	box-sizing: border-box;
}

body, html {
	margin: 0;
	padding: 0;
	font-family: 'GMarketSans', sans-serif;
}

.container {
	position: relative;
	padding-top: 100px;
	width: 100%;
	min-height: 100vh;
	background-color: #fbe5c0;
	padding-bottom: 80px;
}

/* 헤더 스타일 */
.headBox {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100px;
	display:flex;
	justify-content: space-between;
	align-items: center;
	padding-left: 20px;
	font-weight: bold;
	font-size: 50px;
	color: #A66A3F;
	background-color: #F2D3A2;
	border-bottom: 2px solid #A66A3F;
	line-height: 100px;
	z-index: 1000;
}

.backBtn{
    background-color: #ffb300;
    color: #5e361a;
    border: 1px solid #ffb300;
    border-radius: 10px;
    font-weight: bold;
    transition: all 0.2s ease;
    cursor: pointer;
    position: relative;
    top:10px;
    right: 40px;
    height: 30px;
}

.backBtn:hover{
	transform: translateY(-3px);
   	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #fecc56;
   	color: #A66A3F;
}

/* 상단 사용자 정보 섹션 */
.userInfoSection {
	margin: 20px auto;
	width : 1000px;
	padding: 20px;
	position: relative;
	
}

.userIcon {
	font-size: 50px;
	color: #A66A3F;
	margin-right: 15px;
	border: 5px solid #A66A3F;
	border-radius: 100px;
}

.userName {
	font-size: 24px;
	font-weight: bold;
	color: #333;
	position: relative;
	top: -30px;
}

/* 게시글 박스 (와이어프레임 구조) */
.postBox {
	width: 1000px;
	max-width: 1000px;
	margin: 20px auto;
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
}

.postBody {
	padding: 15px;
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
	margin-bottom: 10px;
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

/* 하단 페이지네이션 */
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

/* 글쓰기 버튼 */
.writeBtn {
	position: fixed;
	right: 30px;
	bottom: 90px;
	width: 60px;
	height: 60px;
	border-radius: 50%;
	background-color: #A66A3F;
	border: none;
	color: white;
	font-size: 30px;
	cursor: pointer;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
	z-index: 999;
	transition: all 0.3s ease;
}

.writeBtn:hover{
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #d69e76;
 
}

.writeBtn:activr{
	transform: translateY(2px);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

/* 하단바 */
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

.bottomBox i {
	color: #A66A3F;
	cursor: pointer;
}

.emptyBox {
	width: 100%;
	height: 600px;
	font-size: 25px;
	color: #5e361a;
	text-align: center;
}

.page a{
	margin: 10px;
	color: #A66A3F;
	display: inline-block;
	text-decoration: none;
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

.textContent, .answerText{
	white-space: pre-wrap;
}

.navicon:hover {
   transform: translateY(-3px);
   box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

.navicon:active {
   transform: translateY(2px);
   box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.editBtn:hover, .delBtn:hover,
.cancleBtn:hover, .okBtn:hover {
    background-color: #fecc56;
    color: #A66A3F;
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

.editBtn:active, .delBtn:active,
.cancleBtn:active, .okBtn:active {
	transform: translateY(2px);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.editBtn, .delBtn {
	cursor: pointer;
	border: #fbe5c0;
	color: #5e361a;
	font-size: 13px;
	font-weight: bold;
	background-color: #FFB300;
	width: 50px;
	height: 20px;
	border-radius: 5px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	transition: all 0.2s ease;
}

.cancleBtn, .okBtn {
	display: none;
	cursor: pointer;
	border: #fbe5c0;
	color: #5e361a;
	font-size: 13px;
	font-weight: bold;
	background-color: #FFB300;
	width: 50px;
	height: 20px;
	border-radius: 5px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	transition: all 0.2s ease;
}

 .titleContent[contenteditable="true"],
 .textContent[contenteditable="true"] {
	border: 1px solid #FFB300;
	border-radius: 5px;
	padding: 5px;
}

.titleContent[contenteditable="true"]:focus,
 .textContent[contenteditable="true"]:focus {
 	outline: none;
	border: 1px solid #FFB300;
	border-radius: 5px;
	padding: 5px;
}

.titleContent, .textContent, .answerText {
	word-break: keep-all;
	overflow-wrap: break-word;
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
		<div class="mainTitle">고객지원(Q&A)</div>
			<div class="backBtnDiv">
				<a href="/members/mypage"> <input class="backBtn" type="button" value="내.zip으로 가기">
				</a>
			</div>
		</div>
		
		
		<div class="userInfoSection">
			<img class="userIcon" src="/resources/images/birdprofile.png" style="width: 80px;"> 
			<span class="userName">${nickname}</span>
		</div>

		<c:choose>
			<c:when test="${not empty list}">
				<c:forEach var="i" items="${list}">
				<div class="postBox">
					<div class="postHeader">작성일자 : ${i.qa_create_date}
					<c:if test="${i.qa_status == 0}">
					<input class="editBtn" type="button" value="수정" data-seq="${i.qa_seq}">
					<input class="delBtn" type="button" value="삭제" data-seq="${i.qa_seq}">
					<input class="okBtn" type="button" value="완료" data-seq="${i.qa_seq}">
					<input class="cancleBtn" type="button" value="취소" data-seq="${i.qa_seq}">
					</c:if>
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
					<div class="answerBox">
						<span class="answerLabel">답변 댓글</span>
						<c:choose>
						<c:when test="${i.qa_status == 1}">
						<div class="answerText">${i.admin_answer}</div>
						</c:when>
						<c:otherwise>답변 대기중 입니다.</c:otherwise>
						</c:choose>
					</div>
				</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="emptyBox">등록된 게시글이 없습니다.</div>
			</c:otherwise>
		</c:choose>

		<div class="pageBox">
			 <span class="page"></span>
		</div>

		<button class="writeBtn" type="button"
			onclick="location.href='/qa/toWrite?cPage=${cPage}'">
			<i class="fa-solid fa-pencil"></i>
		</button>
		<div class="bottomBox">
			<a href="/"><i class="navicon fa-solid fa-house fa-2xl" style="color: #A66A3F"></i></a>
			<a href="/map/test"><i class="navicon fa-solid fa-map-location-dot fa-2xl" style="color: #A66A3F"></i></a>
			<a href="/meeting/list?category=all"><i class="navicon fa-solid fa-people-group fa-2xl" style="color: #A66A3F"></i></a>
			<a href="/feedback/feedbackHome"><i class="navicon fa-solid fa-bullhorn fa-2xl" style="color: #A66A3F"></i></a>
			<a href="/members/mypage"><i class="nowNavicon fa-solid fa-user fa-2xl" style="color: #e6a83e"></i></a>
		</div>
	</div>
	<script>
		//수정버튼
			$(".editBtn").on("click",function(){
				let box = $(this).closest(".postBox");
		    	
		    	let title = box.find(".titleContent").html();
		    	let contents = box.find(".textContent").html();
		    	
		    	box.data("original-title", title);
		        box.data("original-contents", contents);
		    	
		    	box.find(".titleContent").attr("contenteditable", "true");
		        box.find(".textContent").attr("contenteditable", "true");
		    	
		    	box.find(".editBtn, .delBtn").hide();
		    	box.find(".cancleBtn, .okBtn").show();
			})
				//수정취소
			 $(".cancleBtn").on("click", function(){
		        	
		        	let box = $(this).closest(".postBox");
		        	
		        	box.find(".titleContent").html(box.data("original-title"));
		        	box.find(".textContent").html(box.data("original-contents"));
		        	        	 
		        	box.find(".titleContent").attr("contenteditable", "false");
		            box.find(".textContent").attr("contenteditable", "false");
		            
		        	box.find(".okBtn, .cancleBtn").hide();
		        	box.find(".delBtn, .editBtn").show();
		        })
		    
		        //수정완료
		    $(".okBtn").on("click", function(){
		        	
		        	let box = $(this).closest(".postBox");
		        	let seq = $(this).data("seq");
		        	let title = box.find(".titleContent").html().trim(); // 엔터 살리기
		        	let contents = box.find(".textContent").html().trim(); // 엔터 살리기
		        	
		        	let titleCheck = box.find(".titleContent").text().trim(); // 빈칸 체크
		        	let contentsCheck = box.find(".textContent").text().trim(); // 빈칸 체크
		            
		            // 엔터(\n)를 포함한 실제 텍스트 추출 (innerText 사용)
		            let titleContent = document.querySelector(".titleContent").innerText; 
		            let textContent = document.querySelector(".textContent").innerText; 
		  
		            let titleLimit = 50; // 제목 제한
		            let limit = 1000;     // 내용 제한
		
			        	if(titleCheck === "" && contentsCheck === ""){
			                Swal.fire({
			                    icon: "info",
			                    title: "Wait !",
			                    text: "제목과 내용을 입력해주세요.",
			                    iconColor: "#FFB300",
			                    confirmButtonColor: "#FFB300"
			                });
			                return;
			            }
        	
        	
			        	// 빈값 검사
			            if(titleCheck === ""){
			                Swal.fire({
			                    icon: "info",
			                    title: "Wait !",
			                    text: "제목을 입력해주세요.",
			                    iconColor: "#FFB300",
			                    confirmButtonColor: "#FFB300"
			                });
			                return;
			            } 
			        	if(contentsCheck === "") {
			            	Swal.fire({
			                    icon: "info",
			                    title: "Wait !",
			                    text: "내용을 입력해주세요.",
			                    iconColor: "#FFB300",
			                    confirmButtonColor: "#FFB300"
			                });
			                return;
			            }
			        	
						// 3. 제목 글자수 초과 체크
			          if (titleContent.length > titleLimit) {
			              let currentTitleLen = titleContent.length;
			              let overTitle = titleContent.substring(titleLimit, titleLimit + 50); // 제목은 짧으니 50자만
			              
			              Swal.fire({
			                  icon: "warning",
			                  title: "제목 글자수 초과!",
			                  html: "현재 제목이 <b>" + currentTitleLen + "자</b>입니다. (제한: 50자)<br><br>" +
			                        "<div style='color:red; background:#fff1f1; padding:15px; border-radius:5px; text-align:left; font-size:13px; border:1px solid #ffcccc; word-break: break-all;'>" +
			                        "<b>제목 뒷부분을 삭제해주세요:</b><br><br>" +
			                        "<span style='color:#555;'>... " + overTitle + "</span></div>",
			                  iconColor: "#EB0000",
			                  confirmButtonColor: "#FFB300"
			              });
			              return;
			          }
			
			          // 4. 내용 글자수 초과 체크
			          if (textContent.length > limit) {
			              let currentLen = textContent.length;
			              let overText = textContent.substring(limit, limit + 100); 
			
			              Swal.fire({
			                  icon: "warning",
			                  title: "내용 글자수 초과!",
			                  html: "현재 내용이 <b>" + currentLen + "자</b>입니다. (제한: 1000자)<br><br>" +
			                        "<div style='color:red; background:#fff1f1; padding:15px; border-radius:5px; text-align:left; font-size:14px; border:1px solid #ffcccc; white-space: pre-wrap; word-break: break-all;'>" +
			                        "<b>이 부분부터 삭제해주세요:</b><br><br>" +
			                        "<span style='color:#555;'>... " + overText + "</span></div>",
			                  iconColor: "#EB0000",
			                  confirmButtonColor: "#FFB300"
			              });
			              return;
			          }
			          box.find(".titleContent").attr("contenteditable", "false");
			          box.find(".textContent").attr("contenteditable", "false");
			          
						$.ajax({
							url:"/qa/update",
							data:{qa_seq:seq,
								qa_title:title,
								qa_contents:contents},
							type: "post"
						}).done(function(){
								Swal.fire({
								icon: "success",
								title: "Success  !",
								text: "수정되었습니다.",
								iconColor: "#FFB300",
								confirmButtonColor: "#FFB300"
							}).then(() => {
								location.reload();
							});
						});
			        	
			        }) 
        
		   	// 삭제버튼
		   	$(".delBtn").on("click", function(){
		        	
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
						
						if(result.isConfirmed) {
		        		
		        		$.ajax ({
		        			url: "/qa/delete",
		        			type: "post",
		        			data: { qa_seq: seq },
		        			
		        			success: function(resp) {
		        				if(resp === "successDel") {
		        					
		        					// 삭제 성공 알림
		        					Swal.fire({
										icon: "success",
										title: "Success  !",
										text: "삭제되었습니다.",
										iconColor: "#FFB300",
										confirmButtonColor: "#FFB300"
		        					}).then(() => {
		        						location.reload(); // 새로고침
		        					});
		        					
		        				}
		        				else {
		        					Swal.fire({
										icon: "error",
										title: "Error  !",
										text: "문제가 발생해 삭제할 수 없습니다.",
										iconColor: "#EB0000",
										confirmButtonColor: "#FFB300"
		        					});
		        				}
		        			},
		        			error: function() {
		        				Swal.fire({
									icon: "error",
									title: "Error  !",
									text: "에러 발생",
									iconColor: "#EB0000",
									confirmButtonColor: "#FFB300"
		        				});
		        			}
		        		});
		        	} 
		        });
			});
			
			let recordTotalCount = ${totalCount};
			let recordCountPerPage = 5;
			let naviCountPerPage = 5;
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
					prev.attr("href","/qa/toQa?cPage="+(startNavi-1)); 
					prev.html("<< ");
					$(".page").append(prev);
				}
					
				for(let i = startNavi; i <= endNavi; i++) {
					let navi = $("<a>");
					navi.attr("href", "/qa/toQa?cPage="+i);
					navi.html(i + " ");
					$(".page").append(navi);
					
					if (i === currentPage) {
				        navi.addClass("active");
				    }
				}
				if(needNext) {
					let next = $("<a>");
					next.attr("href", "/qa/toQa?cPage="+(endNavi+1));
					next.html(" >>");
					$(".page").append(next);
				}
			
			$(document).on("keydown", ".titleContent[contenteditable='true']", function(e){
	        	if(e.key === "Enter"){
	          	  e.preventDefault(); // 기본 동작 막기
	        	}
		    });
	</script>
	
</body>
</html>