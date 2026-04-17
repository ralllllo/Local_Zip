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
	padding-top: 150px;
	width: 100%;
	min-height: 100vh;
	border: 1px solid black;
	background-color: #fbe5c0;
}

.headBoxDiv {
	position: fixed;
	top: 0;
	left: -10px;
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

.headBox {
	font-weight: bold;
	font-size: 50px;
	color: #A66A3F;
	line-height: normal;
}

.backBtnDiv {
	width: 90px;
	height: 50px;
	display: flex;
	align-items: center;
	margin-top: 31px;
}

.backBtn {
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
	height: 30px;
	cursor: pointer;
}

.topBtn {
	height: 25px;
	background-color: #FFB300;
	border-radius: 10px;
	border: 1px solid #FFB300;
	color: #3e5e40;
	align-items: center;
	vertical-align: middle;
	cursor: pointer;
	transition: 0.3s;
}

.bodyBox {
	width: 100%;
	min-height: 100vh;
	margin-top: 30px;
	color: #5e361a;
	padding-bottom: 50px;
}

.postBox {
	width: 95%;
	max-width: 1150px;
	min-height: 200px;
	height: auto;
	margin: 30px auto;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
	overflow: hidden;
}

.postUpBox {
	width: 100%;
	display: flex;
	align-items: center;
	padding: 30px 20px;
	border-radius: 10px 10px 0 0;
	background-color: #F2D3A2;
}

.postInfoBox {
	width: 100%;
}

.postMidBox {
	padding: 40px 0;
	width: 100%;
	height: auto;
}

.postTitle {
	font-size: 24px;
	font-weight: bold;
	margin: 0;
	white-space: pre-line;
    word-break: break-all;
}

.postContents {
	margin: 0 auto;
	width: 90%;
	font-size: 16px;
	background-color: #f0d8af;
	border-radius: 5px;
	padding: 0 10px;
	line-height: 1.6;
	word-break: break-all;
	white-space: pre-wrap;
	border-bottom-left-radius: 0;
	border-bottom-right-radius: 0;
}

.afterHeart {
	display: inline;
	color: red;
}

.navicon:hover, .backBtn:hover, .upBtn:hover, .delBtn:hover, .OBtn:hover,
	.XBtn:hover, .changeBtns:hover{
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #fecc56;
	color: #A66A3F;
	transition: all 0.2s ease;
}

.navicon:active, .backBtn:active, .upBtn:active, .delBtn:active, .OBtn:active,
	.XBtn:active, .changeBtns:active{
	transform: translateY(2px);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.changeBtns {
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
	cursor: pointer;
}

.completeBtn ,.cancelBtn{
	display : none;
	margin-left: 5px;
}

.updateBtn, .deleteBtn{
	margin-left: 5px;
}

.postContents[contenteditable="true"] {
    border: 1px solid #FFB300;
    border-radius: 5px;
    padding: 5px;
}

.postContents[contenteditable="true"]:focus {
    outline: none;
    border: 1px solid #FFB300;
}

.postTitle[contenteditable="true"] {
    border: 1px solid #FFB300;
    border-radius: 5px;
    padding: 5px;
}

.postTitle[contenteditable="true"]:focus {
    outline: none;
    border: 1px solid #FFB300;
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

hr {
	width: 97%;
	margin-bottom: 40px;
	border: 1px solid #cdaa69;
}

a {
	color: #5e361a;
	text-decoration: none;
}

.delBtn, .XBtn {
	margin-left: 5px;
}

.upBtn, .delBtn, .OBtn, .XBtn {
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
}

.OBtn, .XBtn {
	display: none;
}

.writerName {
	margin-top: 10px;
}

.writeTime {
	margin-top: 6px;
}

hr {
	border: 1px dotted #5e361a;
}

.swal2-icon.swal2-info .swal2-icon-content {
    font-size: 50px;
    transform: translateY(5px);
    line-height: 70px;
}
		
.swal2-icon.swal2-question .swal2-icon-content {
    font-size: 50px;
    transform: translateY(5px);
    line-height: 70px;
}

.noticeImg {
    display: block;
    width: 90%;
    max-width: 800px;
    margin: 0 auto 20px auto;
    border-radius: 10px;
}

.noticeDiv{
	margin: 0 auto;
	width: 90%;
	background-color: #f0d8af;
	border-radius: 5px;
	line-height: 1.6; 
	padding: 20px 20px 25px;
	border-top-left-radius: 0;
	border-top-right-radius: 0;
}
</style>
</head>
<body>
	<div class="container">
		<div class="headBoxDiv">
			<div class="headBox">공지사항</div>
			<div class="backBtnDiv">
				<!-- 게시글을 누르기 전에 보고있었던 목록의 페이지를 기억해서, 누르면 전으로 돌아가는 기능 : onclick="history.back();" -->
				<c:choose>
					<c:when test="${role==0}">
					<a href="/admin/toAdminNotice?cPage=${cPage}"><input class="backBtn" type="button" value="목록으로"></a>
					</c:when>
					
					<c:when test="${empty role}"> <!-- 비회원 role이 없는 경우 empty role -->
					<a href="/"><input class="backBtn" type="button" value="목록으로"></a>
					</c:when>
					
					<c:otherwise>
					<a href="/notice/toNotice?cPage=${cPage}"><input class="backBtn" type="button" value="목록으로"></a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		
		<div class="bodyBox">
			<div class="postBox">
			<form action="" method="post" class="frm">
				<div class="postUpBox">
					<div class="postInfoBox">
						<div class="postInfoDown">
							<div class="postTitle" style="color: #5e361a;">${dto.notice_title}</div>
						</div>
					</div>
					<c:if test="${role==0}">
					<input type="button" class="changeBtns updateBtn" value="수정">
					<input type="button" class="changeBtns deleteBtn" value="삭제">
					<input type="button" class="changeBtns completeBtn" value="완료">
					<input type="button" class="changeBtns cancelBtn" value="취소">
					</c:if>
				</div>

				<div class="postMidBox">
					<div class="postContents">${dto.notice_content}</div>
					<div class="noticeDiv">
					<c:choose>
				        <c:when test="${dto.notice_title == '📢 「따스한 봄 따라가요」 행사 안내'}">
				            <img src="${pageContext.request.contextPath}/resources/images/NoticeBanner01.png" class="noticeImg">
				        </c:when>
				        <c:when test="${dto.notice_title == '📢 「우리 동네 봄맞이 플리마켓」 행사 안내'}">
				            <img src="${pageContext.request.contextPath}/resources/images/NoticeBanner02.png" class="noticeImg">
				        </c:when>
				        <c:when test="${dto.notice_title == '📢 「별빛 아래, 토요 영화 상영회」 안내'}">
				            <img src="${pageContext.request.contextPath}/resources/images/NoticeBanner03.png" class="noticeImg">
				        </c:when>
				        <c:when test="${dto.notice_title == '📢 「커피 향 가득한 쉼, 담온재 오픈」'}">
				            <img src="${pageContext.request.contextPath}/resources/images/NoticeBanner04.png" class="noticeImg">
				        </c:when>
				    </c:choose>
				    </div>
				</div>
			</form>
			</div>

			<div class="bottomBox">
				<a href="/"><i class="navicon fa-solid fa-house fa-2xl" style="color: #A66A3F"></i></a> 
				<a href="/map/test"><i class="navicon fa-solid fa-map-location-dot fa-2xl" style="color: #A66A3F"></i></a> 
				<a href="/meeting/list?category=all"><i class="navicon fa-solid fa-people-group fa-2xl" style="color: #A66A3F"></i></a> 
				<a href="/feedback/feedbackHome"><i class="navicon fa-solid fa-bullhorn fa-2xl" style="color: #A66A3F"></i></a>
				<a href="/members/mypage"><i class="navicon fa-solid fa-user fa-2xl" style="color: #A66A3F"></i></a>
			</div>
		</div>
	</div>

	<script>
	
		let currentTitle = "${dto.notice_title}";
	    let currentContent = `${dto.notice_content}`;
	    
			$(".updateBtn").on("click",function(){
				$(".completeBtn").show();
				$(".cancelBtn").show();
				$(".updateBtn").hide();
				$(".deleteBtn").hide();
				
				$(".postTitle").attr("contenteditable","true");
				$(".postContents").attr("contenteditable","true");
				
			})
			
			$(".cancelBtn").on("click",function(){
				$(".completeBtn").hide();
				$(".cancelBtn").hide();
				$(".updateBtn").show();
				$(".deleteBtn").show();
				
				$(".postTitle").attr("contenteditable","false");
				$(".postContents").attr("contenteditable","false");
				$(".postTitle").html(currentTitle);
				$(".postContents").html(currentContent);
				
			})
			
		$(".completeBtn").on("click", function() {
		    // 1. 데이터 추출 (innerText를 사용하여 태그를 제외한 실제 글자수 계산)
		    let newTitle = $(".postTitle").text().trim();
		    let newContent = $(".postContents").html();
		    let newContentText = $(".postContents").text().trim();
		    
		    // 글자수 제한 설정
		    let titleLimit = 100; // 제목 제한
		    let contentLimit = 1000; // 내용 제한
		
		    // 2. 미입력 체크
		    if (newTitle == "" || newContentText == "") {
		        Swal.fire({
		            icon: "info",
		            title: "입력 확인",
		            text: "제목과 내용을 모두 입력해 주세요.",
		            iconColor: "#FFB300",
		            confirmButtonColor: "#FFB300"
		        });
		        return;
		    }
		
		    // 3. 제목 글자수 초과 체크 (추가된 부분)
		    if (newTitle.length > titleLimit) {
		        let overTitle = newTitle.substring(titleLimit, titleLimit + 30);
		        Swal.fire({
		            icon: "warning",
		            title: "제목 글자수 초과!",
		            html: "현재 제목이 <b>" + newTitle.length + "자</b>입니다. (제한: 100자)<br><br>" +
		                  "<div style='color:red; background:#fff1f1; padding:15px; border-radius:5px; text-align:left; font-size:13px; border:1px solid #ffcccc; word-break: break-all;'>" +
		                  "<b>제목 뒷부분을 삭제해주세요:</b><br><br>" +
		                  "<span style='color:#555;'>... " + overTitle + "</span></div>",
		            iconColor: "#EB0000",
		            confirmButtonColor: "#FFB300"
		        });
		        return;
		    }
		
		    // 4. 내용 글자수 초과 체크 (추가된 부분)
		    if (newContentText.length > contentLimit) {
		        let overText = newContentText.substring(contentLimit, contentLimit + 50);
		        Swal.fire({
		            icon: "warning",
		            title: "내용 글자수 초과!",
		            html: "현재 내용이 <b>" + newContentText.length + "자</b>입니다. (제한: 1000자)<br><br>" +
		                  "<div style='color:red; background:#fff1f1; padding:15px; border-radius:5px; text-align:left; font-size:14px; border:1px solid #ffcccc; white-space: pre-wrap; word-break: break-all;'>" +
		                  "<b>이 부분부터 삭제해주세요:</b><br><br>" +
		                  "<span style='color:#555;'>... " + overText + "</span></div>",
		            iconColor: "#EB0000",
		            confirmButtonColor: "#FFB300"
		        });
		        return;
		    }
		
		    // 5. 서버 전송 (AJAX)
		    $.ajax({
		        url: "/admin/updateNotice",
		        data: {
		            seq: "${dto.notice_seq}",
		            notice_title: newTitle,
		            notice_content: newContent
		        },
		        type: "post"
		    }).done(function(resp) {
		        if (resp == "success") {
		            Swal.fire({
		                icon: "success",
		                title: "Success!",
		                text: "수정되었습니다.",
		                iconColor: "#FFB300",
		                confirmButtonColor: "#FFB300"
		            });
		            currentTitle = newTitle;
		            currentContent = newContent;
		            
		            // 전송 성공 시에만 버튼 상태 되돌리기
		            $(".completeBtn").hide();
		            $(".cancelBtn").hide();
		            $(".updateBtn").show();
		            $(".deleteBtn").show();
		            $(".postTitle, .postContents").attr("contenteditable", "false");
		        } else {
		            Swal.fire({
		                icon: "error",
		                title: "Error!",
		                text: "공지사항 수정에 실패했습니다.",
		                iconColor: "#EB0000",
		                confirmButtonColor: "#FFB300"
		            });
		        }
		    });
		});
		
		$(".deleteBtn").on("click",function(){
			
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
			            url: "/admin/deleteNotice",
			            type: "POST",
			            data: { notice_seq: "${dto.notice_seq}" }
			        })
			        .done(function(resp) {
			            if (resp === "success") {
			            	Swal.fire({
								icon: "success",
								title: "Success  !",
								text: "삭제되었습니다.",
								iconColor: "#FFB300",
								confirmButtonColor: "#FFB300"
							}).then(() => {
									location.href = "/admin/toAdminNotice?cPage="+${cPage};
								});
			            } else {
			            	Swal.fire({
								icon: "error",
								title: "Error  !",
								text: "문제가 발생해 삭제할 수 없습니다.",
								iconColor: "#EB0000",
								confirmButtonColor: "#FFB300"
							});
					           	   }
					            });
					         }
		   			 	});
					});
		
		$(document).on("keydown", ".postContents[contenteditable='true']", function(e){
		    if(e.key === "Enter"){
		        e.preventDefault(); // 기본 동작 막기

		        document.execCommand("insertLineBreak"); // 줄바꿈 삽입
			    }
			});
		
		$(document).on("keydown", ".postTitle[contenteditable='true']", function(e){
	            if(e.key === "Enter"){
	                e.preventDefault(); // 기본 동작 막기
	            }
	       });	
	</script>
</body>
</html>