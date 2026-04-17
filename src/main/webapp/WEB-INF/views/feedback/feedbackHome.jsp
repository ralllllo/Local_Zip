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

/* 폰트 지정 */
button, body {
	font-family: 'GMarketSans', sans-serif;
}

.container {
	position: relative;
	padding-top: 100px;
	padding-bottom: 90px;
	width: 100%;
	min-height: 100vh;
	/* 최소 높이 지정 : 브라우저 */
	background-color: #fbe5c0;
}

.headBox {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100px;
	padding-left: 20px;
	font-weight: bold;
	font-size: 50px;
	color: #A66A3F;
	background-color: #F2D3A2;
	border-bottom: 2px solid #A66A3F;
	/* 아래쪽만 줄 그음 */
	line-height: 100px;
	z-index: 1000;
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



.writeBtn:hover, .editBtn:hover, .delBtn:hover,
 .cancleBtn:hover, .okBtn:hover, .fileDelBtn:hover
	{
    background-color: #fecc56;
    color: #A66A3F;
   
	transform: translateY(-3px); /* 살짝 위로 뜸 */
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

.navicon:hover, .reportBtn:hover {
	background-color: #fecc56;
    color: #A66A3F;
	transform: translateY(-3px);
	/* 살짝 위로 뜸 */
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

.navicon:active, .editBtn:active, .delBtn:active, .cancleBtn:active,
	.okBtn:active, .fileDelBtn:active{
	transform: translateY(2px);
	/* 아래로 눌림 */
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.writeBtn:hover{
	background-color: #fecc56;
	color: #A66A3F;
}
.suggestionBox {
	width: 1600px;
	height: 300px;
}

a {
	text-decoration: none;
	color: inherit;
}
.writeBtn {
	cursor: pointer;
	transition: all 0.2s ease;
	display:block;
	width: 1500px;
	height: 100px;
	margin: auto;
	cursor: pointer;
	margin-top:1%;
	margin-bottom:1%;
	border: #fbe5c0;
	color: #5e361a;
	font-size: 30px;
	font-weight: bold;
	background-color: #FFB300;
	border-radius: 5px;
	
	/* 그림자 효과 */
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	/* 애니메이션 부드럽게 */
	transition: all 0.2s ease;
}
.postBox {
	/* 수정: 고정 1500px 제거 */
	width: 1500px;
	max-width: 1500px;
	/* 적당히 보기 좋은 최대 너비 설정 */
	min-height: 200px;
	height: auto;
	margin: auto;
	margin-top: 30px;
	border-radius: 10px;
	/* 그림자 효과 */
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
}

.postUpBox {
	width: 100%;
	height: 95px;
	display: flex;
	border-radius: 10px 10px 0 0;
	background-color: #F2D3A2;
}

.postProfile {
	width: 75px;
	height: 75px;
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
	position: relative;
	left: 20px;
	top: 20px;
	flex-grow: 1;
	/* 신고박스 오른쪽으로 딱 붙게 하기 위해 빈공간을 쭉 늘려주는 코드 */
}

.postInfoUp, .postInfoDown {
	display: flex;
}

/* 신고 영역 스타일 */
.reportArea {
	position: relative;
	top: 8px;
	right: 20px;
	display: flex;
	flex-direction: column;
	/* 아이콘과 선택창을 세로로 배치 */
	align-items: flex-end;
	/* 오른쪽 정렬 */
	gap: 5px;
}

.reportSelect {
	font-family: 'GMarketSans';
	border: 1px solid #A66A3F;
	border-radius: 5px;
	background-color: #F2D3A2;
	color: #A66A3F;
	font-size: 12px;
	outline: none;
	display: none;
}

.reportBtn {
	cursor: pointer;
	transition: all 0.2s ease; 

	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
	display: none;
}

.profileInfo {
	width: auto;
	margin-right: 15px;
	/* 정보 사이의 간격 일정하게 부여 */
	/*수직 정렬*/
	display: flex;
	align-items: center;
	font-size: 14px;
	color: #333;
}

.postTitle {
	margin: auto;
	width: 95%;
	height: 40px;
	font-size: 20px;
	margin-top: 5px;
	line-height: 40px;
}

.postMidBox {
	width: 100%;
	height: auto;
}

.postTitle {
	margin: auto;
	width: 95%;
	height: auto;
	font-size: 20px;
	margin-top: 5px;
	color: #5e361a;
	line-height: 40px;
}

.postContent{
	margin: auto;
	width: 95%;
	line-height: 1.5em;
	font-size: 18px;
	background-color: #f0d8af;
	border-radius: 0 0 5px 5px;
	color: #5e361a;
	white-space: pre-wrap;
	word-break: break-all;
	display: block;
	padding:10px 0 5px 13px;
}


.postDownBox {
	width: 95%;
	margin: auto;
	margin-top: 5px;
	min-height: 40px;
	display: flex;
	gap: 20px;
}

.navicon2 {
	font-size: 15px;
}

.navicon3 {
	margin-right: 10px;
}

.postLikeBox, .postCommentBox {
	display: flex;
	align-items: center;
	min-width: 80px;
	width: auto;
	gap: 10px;
	color: #5e361a;
	cursor: pointer;
	transition: 0.3s;
}

.profileTime {
	margin-top: 5px;
}

.agreeIcon.active {
	color: #5e361a;
}

.noIcon.active {
	color: #5e361a;
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
	/* 그림자 효과 */
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	/* 애니메이션 부드럽게 */
	transition: all 0.2s ease;
}

.fileDelBtn {
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
	transition: all 0.2s ease;
	cursor: pointer;
}

.btnBox {
	display: flex;
	gap: 8px;
}

.cancleBtn, .okBtn {
	cursor: pointer;
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
	/* 그림자 효과 */
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	/* 애니메이션 부드럽게 */
	transition: all 0.2s ease;
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

.suggestionImages {
	min-height: auto;
	line-height: 0;
}

.suggestionImages img {
	max-width: 100%;
	max-height: 500px; /* 부모 너비를 넘지 않게 함 */
	display: block;
	width: 500px;
	padding: 10px 0 0 10px;
	margin: 0;
}
.imageContainer {
	overflow: hidden;
	margin: auto;
	width: 95%;
	font-size: 15px;
	background-color: #f0d8af;
	border-radius: 5px 5px 0 0;
	padding: 0px 4px;
	margin: auto;
}

.file-item .fileName {
	color: #b24c4c;
	font-size: 13px;
}
.fileDownload {
	display:none;
	margin: auto;
	width: 95%;
	padding: 10px 10px;
}

.fileHeader{
	display: flex;
	align-items: center;
	gap: 10px;
}

.newFileDiv {
	display: none;
	margin-top: 5px;
	margin-left: 40px;
}
/*  입력창 테두리 속성 */
 .postTitle[contenteditable="true"],
 .postContent[contenteditable="true"] {
	border: 1px solid #FFB300;
	padding: 5px;
}

.postTitle{
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
}
.postTitle[contenteditable="true"]:focus,
.postContent[contenteditable="true"]:focus{
	outline: none;
	border: 1px solid #FFB300;
}
.okBtn:focus {
    outline: none;
}

.reportIcon{
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

		<div class="headBox">동네 건의.zip</div>
		<a href="/feedback/feedbackWrite"><button class="writeBtn"
				type="button">
				<i class="navicon3 fa-solid fa-bullhorn fa-xl"></i> 새 건의 작성하기
			</button></a>

		<c:forEach var="i" items="${list}">
			<div class="postBox">
				<div class="postUpBox">
					<div class="postProfile">
						<img class="contentProfile" src="/resources/images/Profile.png"
							width="60px">
					</div>

					<div class="postInfoBox">
						<div class="postInfoUp">
							<div class="profileName profileInfo" style="color: #5e361a;">${i.mem_nickname}</div>
							<div class="profileName profileInfo" style="color: #5e361a;">${i.mem_dong}</div>
						</div>

						<div class="postInfoDown">
							<div class="profileTime profileInfo" style="color: #5e361a;">${i.suggestion_writedate}</div>
						</div>
						<c:if test="${loginId == i.mem_id}">
							<div class="btnBox">
								<input class="editBtn" type="button" value="수정"
									data-seq="${i.suggestion_seq}"><input class="delBtn"
									type="button" value="삭제" data-seq="${i.suggestion_seq}">
								<input class="okBtn" type="button" value="완료"
									data-seq="${i.suggestion_seq}"><input class="cancleBtn"
									type="button" value="취소" data-seq="${i.suggestion_seq}">
							</div>
						</c:if>
					</div>

					<c:if test="${loginId != i.mem_id && i.mem_role != 0}">
						<div class="reportArea">
							<img src="/resources/images/free-icon-siren1.png"
								class="reportIcon"
								style="width: 25px; height: 25px; margin-bottom: 5px"></img> <select
								class="reportSelect" name="reports_reason">
								<option value="" disabled selected>신고 사유</option>
								<option value="badContents" class="reportOption">부적절한
									콘텐츠</option>
								<option value="badWord" class="reportOption">욕설/비방</option>
								<option value="AD" class="reportOption">광고/스팸</option>
							</select> <input class="reportBtn" type="button" value="신고하기"
								data-seq="${i.suggestion_seq}" data-targetid="${i.mem_id}">
						</div>
					</c:if>
				</div>

				<div class="postMidBox">

					<div class="postTitle">${i.suggestion_title}</div>

					<c:if test="${not empty imageMap[i.suggestion_seq]}">
						<div class="imageContainer">
							<div class="suggestionImages">
								<c:forEach var="file" items="${imageMap[i.suggestion_seq]}">
									<div class="img-wrapper">
										<img src="/upload/${file.attach_sysname}">
									</div>
								</c:forEach>
							</div>
						</div>
					</c:if>

					<div class="postContent">${i.suggestion_contents}</div>
					<c:if test="${not empty imageMap[i.suggestion_seq]}">
						<div class="fileDownload">
							첨부 파일
							<c:forEach var="file" items="${imageMap[i.suggestion_seq]}"
								varStatus="status">
								<div class="file-item">
									<label class="fileName" data-ori="${file.attach_oriname}"
										data-sys="${file.attach_sysname}">
										${file.attach_oriname} </label>
									<button type="button" class="fileDelBtn"
										data-sys="${file.attach_sysname}">X</button>
								</div>
							</c:forEach>
						</div>
					</c:if>
					<div class="newFileDiv">
						<input type="file" class="newFiles" name="newFiles"
							accept="image/*" multiple>
					</div>
				</div>

				<div class="postDownBox" data-seq="${i.suggestion_seq}">

					<c:set var="myType" value="" />

					<!-- 새로고침 후에도 처음 상태 유지 -->
					<c:forEach var="r" items="${myReaction}">
						<c:if test="${r.suggestion_seq == i.suggestion_seq}">
							<c:set var="myType" value="${r.reaction_type}" />
						</c:if>
					</c:forEach>

					<div class="postLikeBox">
						<i
							class="navicon2 ${myType eq 'LIKE' ? 'fa-solid' : 'fa-regular'} fa-thumbs-up fa-2xl agreeIcon"></i>
						동의해요 <span class="agreeCount">${i.suggestion_like}</span>
					</div>

					<div class="postCommentBox">
						<i
							class="navicon2 ${myType eq 'UNLIKE' ? 'fa-solid' : 'fa-regular'} fa-thumbs-down fa-2xl noIcon"
							style="color: #5e361a;"></i> 잘 모르겠어요 <span class="noCount">${i.suggestion_unlike}</span>
					</div>
				</div>
			</div>
		</c:forEach>
		<div class="pageBox"></div>
	</div>

	<div class="bottomBox">
		<a href="/"><i class="navicon fa-solid fa-house fa-2xl" style="color: #A66A3F"></i></a>
		<a href="/map/test"><i class="navicon fa-solid fa-map-location-dot fa-2xl" style="color: #A66A3F"></i></a>
		<a href="/meeting/list?category=all"><i class="navicon fa-solid fa-people-group fa-2xl" style="color: #A66A3F"></i></a>
		<a href="/feedback/feedbackHome"><i class="nowNavicon fa-solid fa-bullhorn fa-2xl"></i></a>
		<a href="/members/mypage"><i class="navicon fa-solid fa-user fa-2xl" style="color: #A66A3F"></i></a>
	</div>

	<script>
	// 좋아요
	$(".postLikeBox").on("click", function () {

	    let btn = $(this);
	    let postDownBox = btn.closest(".postDownBox");
	    let suggestion_seq = postDownBox.attr("data-seq");

	    let likeCountSpan = btn.find(".agreeCount");
	    let unlikeBtn = postDownBox.find(".postCommentBox");
	    let unlikeCountSpan = unlikeBtn.find(".noCount");

	    $.ajax({
	        url: "/feedback/selectReaction",
	        type: "post",
	        data: { suggestion_seq: suggestion_seq }
	    }).done(function(check){

	        if(check === "login"){
	            Swal.fire({
	                icon: "warning",
	                title: "Wait !",
	                text: "로그인 후 이용 가능합니다.",
	                iconColor: "#FFB300",
	                confirmButtonColor: "#FFB300"
	            });
	            return;
	        }

	        $.ajax({
	            url: "/feedback/like",
	            type: "post",
	            data: { suggestion_seq: suggestion_seq }
	        }).done(function(like){

	            if(like === "alreadyLike"){
	                return;
	            }

	            $.ajax({
	                url: "/feedback/likeCount",
	                type: "post",
	                data: { suggestion_seq: suggestion_seq }
	            }).done(function(likeCount){
	                likeCountSpan.text(likeCount);
	            });
	            
	            $.ajax({
	                url: "/feedback/unlikeCount",
	                type: "post",
	                data: { suggestion_seq: suggestion_seq }
	            }).done(function(unlikeCount){
	                unlikeCountSpan.text(unlikeCount);
	            });

	            if(like === "insertLike" || like === "updateLike"){
	                btn.find("i").removeClass("fa-regular").addClass("fa-solid");
	                unlikeBtn.find("i").removeClass("fa-solid").addClass("fa-regular");
	            }
	        });
	    });
	});
	
	// 싫어요
	$(".postCommentBox").on("click", function () {

    let btn = $(this);
    let postDownBox = btn.closest(".postDownBox");
    let suggestion_seq = postDownBox.attr("data-seq");

    let unlikeCountSpan = btn.find(".noCount");
    let likeBtn = postDownBox.find(".postLikeBox");
    let likeCountSpan = likeBtn.find(".agreeCount");

    $.ajax({
        url: "/feedback/selectReaction",
        type: "post",
        data: { suggestion_seq: suggestion_seq }
    }).done(function(check){

        if(check === "login"){
            Swal.fire({
                icon: "warning",
                title: "Wait !",
                text: "로그인 후 이용 가능합니다.",
                iconColor: "#FFB300",
                confirmButtonColor: "#FFB300"
            });
            return;
        }

        $.ajax({
            url: "/feedback/unlike",
            type: "post",
            data: { suggestion_seq: suggestion_seq }
        }).done(function(unlike){

            if(unlike === "alreadyUnlike"){
                return;
            }

            $.ajax({
                url: "/feedback/likeCount",
                type: "post",
                data: { suggestion_seq: suggestion_seq }
            }).done(function(likeCount){
                likeCountSpan.text(likeCount);
            });

            $.ajax({
                url: "/feedback/unlikeCount",
                type: "post",
                data: { suggestion_seq: suggestion_seq }
            }).done(function(unlikeCount){
                unlikeCountSpan.text(unlikeCount);
            });

            if(unlike === "insertUnlike" || unlike === "updateUnlike"){
                btn.find("i").removeClass("fa-regular").addClass("fa-solid");
                likeBtn.find("i").removeClass("fa-solid").addClass("fa-regular");
            }
        });
    });
});

        // 신고버튼을 눌렀을 때, 내가 누른 게시글 신고버튼만 눌림
        $(".reportIcon").on("click", function (e) {
			e.stopPropagation();
			let reportArea = $(this).closest(".reportArea");
			reportArea.find(".reportSelect, .reportBtn").toggle();
        })
        
        // 신고 시, 유형별로 db에 넣기
        $(".reportBtn").on("click", function(){
        	
        	// 클릭한 버튼에서 값 가져옴
        	let target_seq = $(this).data("seq");
        	let reports_type = 0; // 신고 종류(게시글)
        	let target_id = $(this).data("targetid");
        	let reports_reason = $(this).closest(".postBox").find(".reportSelect").val();
        	
        	if(!reports_reason || reports_reason === "신고 사유"){
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
        		title: "Wait  !",
		        text: "정말 신고하시겠습니까?",
		        icon: "question",
                showCancelButton: true,
                iconColor: "#FFB300",
                confirmButtonColor: "#FFB300",
                cancelButtonColor: "#d9d9d9",
                confirmButtonText: "신고",
                cancelButtonText: "취소"
            }).then((result) => {

                if(result.isConfirmed){
        	
        	
        	
        	// 신고 사유 가져오는 코드
        	$.ajax({
        		url:"/report/insert",
        		type:"post",
        		data: {
        			target_seq: target_seq,
        			reports_type: reports_type,
        		 	target_id: target_id, 
                    reports_reason: reports_reason
        		},
        		success: function(resp) { 
        			 if(resp === "success") {  // 컨트롤러에서 return한 값
        				 Swal.fire({
        						icon: "success",
        						title: "Success  !",
        						text: "신고가 접수되었습니다",
        						iconColor: "#FFB300",
        						confirmButtonColor: "#FFB300"
        					});
        	            } else if(resp === "fail") {
        	            	Swal.fire({
        						icon: "warning",
        						title: "Already  !",
        						text: "이미 신고한 글 입니다",
        						iconColor: "#FFB300",
        						confirmButtonColor: "#FFB300"
        					});
        	            } else if(resp === "login") {
        	            	Swal.fire({
         						icon: "warning",
         						title: "Wait  !",
         						text: "로그인 후 이용 가능합니다.",
         						iconColor: "#EB0000",
         						confirmButtonColor: "#FFB300"
         					});
        	                location.href = "/members/loginUi";
        	            } else {
        	            	Swal.fire({
        						icon: "error",
        						title: "Fail !",
        						text: "관리자의 댓글은 신고가 불가합니다.",
        						iconColor: "#EB0000",
        						confirmButtonColor: "#FFB300"
        					});
        	            }
                	}
        		});
             }
         });
      });
        
        // 좋아요 버튼, 신고버튼 클릭 시에는 페이지 이동 X
        $(".postLikeBox, .reportArea, .reportIcon, .reportSelect, .reportBtn").on("click", function (e) {
		    e.stopPropagation();
		});
      //파일이 비어있거나 잘못된 파일형식을 올렸을때 alert
		$(document).on("change",".newFiles", function() {
	    let file = this.files[0];	
	
	    if (!file) return;
	    
	    // 1. MIME 타입 체크 (가장 권장)
	    if (!file.type.match("image.*")) {
	        Swal.fire({
				icon: "info",
				title: "Wait  !",
				text: "이미지 파일만 업로드 가능합니다!",
				iconColor: "#FFB300",
				confirmButtonColor: "#FFB300"
			});
	        $(this).val(""); // 선택된 파일 초기화
	        return;
	    }
		});
     // 파일 삭제 버튼을 눌렀을때
		$(document).on("click", ".fileDelBtn", function() {
		    $(this).closest(".file-item").addClass("delete-target").hide();
		});
        
        // 수정 버튼 클릭 -> 완료/취소 버튼으로 변경
        $(".editBtn").on("click", function(){
        	
        	let box = $(this).closest(".postBox");
        	
        	let title = box.find(".postTitle").html();
        	let contents = box.find(".postContent").html();
        
        	box.data("original-title", title);
            box.data("original-contents", contents);
        	
        	box.find(".postTitle").attr("contenteditable", "true");
            box.find(".postContent").attr("contenteditable", "true");
            
			$(".postTitle").css({
				"border":"1px solid #FFB300",
				"padding-top":"0px",
				"margin-top":"0px"
			});
			$(".postContent").css({
			    "border": "1px solid #FFB300",
			    "border-top-left-radius": "0px",
			    "border-top-right-radius": "0px",
			    "padding": "10px 0 5px 12px"
			});
        	
        	box.find(".newFileDiv").show();
        	box.find(".fileDownload").show();
        	box.find(".editBtn, .delBtn").hide();
        	box.find(".cancleBtn, .okBtn").show();
        })
        
        // 수정 버튼 -> 취소 버튼 -> 수정/삭제 버튼으로 변경
        $(".cancleBtn").on("click", function(){
        	
        	let box = $(this).closest(".postBox");
        	
        	box.find(".postTitle").html(box.data("original-title"));
        	box.find(".postContent").html(box.data("original-contents"));
        	
        	$(".file-item").removeClass("delete-target").show();
        	 
        	box.find(".postTitle").attr("contenteditable", "false");
            box.find(".postContent").attr("contenteditable", "false");
            
			$(".postTitle").css({
				"border":"none",
				"padding-top":"0px",
				"margin-top":"0px"
			});
			$(".postContent").css({
				"border":"none",
			    "border-top-left-radius": "0px",
			    "border-top-right-radius": "0px",
			    "padding": "10px 0 5px 12px"
			});
            
        	box.find(".newFileDiv").hide();
        	box.find(".fileDownload").hide();
        	box.find(".okBtn, .cancleBtn").hide();
        	box.find(".delBtn, .editBtn").show();
        })
        
        
        // 게시글 수정 버튼
        $(".okBtn").on("click", function(){
        	
        	let box = $(this).closest(".postBox");
        	let seq = $(this).data("seq");
        	
        	let titleCheck = box.find(".postTitle").text().trim(); // 빈칸 체크
			let contentsCheck = box.find(".postContent").text().trim(); // 빈칸 체크

        	// 1. 데이터 추출
            let title = box.find(".postTitle").html().trim(); // DB 저장용 (엔터 포함)
            let contents = box.find(".postContent").html().trim(); // DB 저장용 (엔터 포함)
            
            // 글자수 체크용 (순수 텍스트만 추출)
            let titleText = box.find(".postTitle")[0].innerText.trim();
            let contentsText = box.find(".postContent")[0].innerText; 

            let titleLimit = 100; // 제목 제한
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
        	
        	// 4. 제목 글자수 초과 체크
            if (titleText.length > titleLimit) {
                let currentTitleLen = titleText.length;
                let overTitle = titleText.substring(titleLimit, titleLimit + 50);
                
                Swal.fire({
                    icon: "warning",
                    title: "제목 글자수 초과!",
                    html: "현재 제목이 <b>" + currentTitleLen + "자</b>입니다. (제한: 100자)<br><br>" +
                          "<div style='color:red; background:#fff1f1; padding:15px; border-radius:5px; text-align:left; font-size:13px; border:1px solid #ffcccc; word-break: break-all;'>" +
                          "<b>제목 뒷부분을 삭제해주세요:</b><br><br>" +
                          "<span style='color:#555;'>... " + overTitle + "</span></div>",
                    iconColor: "#EB0000",
                    confirmButtonColor: "#FFB300"
                });
                return;
            }

            // 5. 내용 글자수 초과 체크
            if (contentsText.length > limit) {
                let currentLen = contentsText.length;
                let overText = contentsText.substring(limit, limit + 100); 

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
            
            box.find(".postTitle").attr("contenteditable", "false");
            box.find(".postContent").attr("contenteditable", "false");
            box.find(".postTitle").css("border", "none"); //1px solid rgb(242, 211, 162)
            box.find(".postContent").css("border", "1px solid #F2D3A2"); // 1px solid #F2D3A2
        	
            let formData = new FormData();
		    formData.append("suggestion_seq", seq);
		    formData.append("suggestion_title", title);
		    formData.append("suggestion_contents", contents);
		    
		    let deleteFiles = [];
		    box.find(".delete-target").each(function() {
		        deleteFiles.push($(this).find(".fileName").data("sys"));
		    });
		    
		    if(deleteFiles.length > 0) {
		    	for(let i=0; i<deleteFiles.length; i++){
		            formData.append("deleteFiles", deleteFiles[i]);
		        }
		    }

		    let newFiles = box.find(".newFiles")[0].files;
		    for (let i = 0; i < newFiles.length; i++) {
		        formData.append("attachments", newFiles[i]);
		    }
			
			$.ajax({
				url:"/feedback/update",
				data:formData,
				processData: false,
		        contentType: false,
				type: "post"
			}).done(function(resp){
				if(resp == "adminFail"){
					Swal.fire({
						icon: "error",
                        title: "Fail !",
                        text: "신고된 게시물은 수정할 수 없습니다.",
                        iconColor: "#EB0000",
                        confirmButtonColor: "#FFB300"
                    }).then(() => {
                    	
                    	box.find(".postTitle").html(box.data("original-title"));
                    	box.find(".postContent").html(box.data("original-contents"));
                    	
                    	$(".file-item").removeClass("delete-target").show();
                    	 
                    	box.find(".postTitle").attr("contenteditable", "false");
                        box.find(".postContent").attr("contenteditable", "false");
                        
            			$(".postTitle").css({
            				"border":"none",
            				"padding-top":"0px",
            				"margin-top":"0px"
            			});
            			$(".postContent").css({
            				"border":"none",
            			    "border-top-left-radius": "0px",
            			    "border-top-right-radius": "0px",
            			    "padding": "10px 0 5px 12px"
            			});
                        
                    	box.find(".newFileDiv").hide();
                    	box.find(".fileDownload").hide();
                    	box.find(".okBtn, .cancleBtn").hide();
                    	box.find(".delBtn, .editBtn").show();
                    })
				}else if(resp == "success"){
					Swal.fire({
						icon: "success",
						title: "Success  !",
						text: "수정되었습니다.",
						iconColor: "#FFB300",
						confirmButtonColor: "#FFB300"
					}).then(() => {
						location.reload();
					});
				}
			});
        });
        
        // 게시글 삭제 버튼
        $(".delBtn").on("click", function(){
        	
        	let seq = $(this).data("seq");
        	
        	Swal.fire({
        		title: "정말 삭제하시겠습니까?",
		        text: "삭제 후에는 복구할 수 없습니다.",
		        icon: "question",
				iconColor: "#FFB300",
				confirmButtonColor: "#FFB300",
					showCancelButton: true,
					confirmButtonText: "삭제",
					cancelButtonText: "취소",
					cancelButtonColor: "#d9d9d9"
			}).then((result) => {
				
				if(result.isConfirmed) {
        		
        		$.ajax ({
        			url: "/feedback/delete",
        			type: "post",
        			data: { suggestion_seq: seq },
        			
        			success: function(resp) {
        			if(resp == "adminFail"){
        				Swal.fire({
        					icon: "error",
                            title: "Error !",
                            text: "신고된 게시물은 삭제할 수 없습니다.",
                            iconColor: "#EB0000",
                            confirmButtonColor: "#FFB300"
                        });
                     return;
        			}else if(resp === "successDel") {
        					
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
			
        $(document).on("keydown", ".postMidBox[contenteditable='true']", function(e){
            if(e.key === "Enter"){
                e.preventDefault(); // 기본 동작 막기

                document.execCommand("insertLineBreak"); // 줄바꿈 삽입
            }
        });
        
        // 하단 네비게이션 바 구현
        $("document").ready(function(){
        let recordTotalCount = Number("${recordTotalCount}"); // 전체 게시물 수
        let recordCountPerPage = Number("${recordCountPerPage}"); // 한 페이지에 몇 개 보여줄지
        let naviCountPerPage = Number("${naviCountPerPage}"); //  한 번에 몇 개 페이지 번호 보여줄지
        let currentPage = Number("${currentPage}"); // 현재 페이지
        
        let pageTotalCount = Math.ceil(recordTotalCount / recordCountPerPage); //  총 페이지 개수 구하기
        
       	let startNavi = Math.floor(((currentPage - 1)/naviCountPerPage)) * naviCountPerPage + 1;
        let endNavi = startNavi + naviCountPerPage - 1;
        
        if(endNavi > pageTotalCount) {
        	endNavi = pageTotalCount;
        }
        
        for(let i = startNavi; i <= endNavi; i++) {
        	let navi = $("<a>");
        	navi.attr("href", "/feedback/feedbackHome?cPage="+i);
        	navi.html(i + " ");
        	
        	if(i == currentPage) {
        		navi.addClass("active");
        	}
        	
        	$(".pageBox").append(navi);
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