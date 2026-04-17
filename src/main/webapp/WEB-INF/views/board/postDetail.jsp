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
<link rel="stylesheet" href="/resources/summernote/summernote-lite.css">
<!--  summernote -->
<script src="/resources/summernote/summernote-lite.js"></script>
<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
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
	top: 100px;
	width: 100%;
	min-height: 100vh;
	background-color: #fbe5c0;
	overflow-x: hidden;
	overflow-y: hidden;
}

.headBoxDiv {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100px;
	padding-left: 20px;
	background-color: #F2D3A2;
	border-bottom: 2px solid #A66A3F;
	line-height: 100px;
	z-index: 1000;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.headBox {
	width: 500px;
	font-weight: bold;
	font-size: 50px;
	color: #A66A3F;
}

.backBtnDiv {
	margin-right: 40px;
	margin-top : 30px;
    position: static; 
}

.backBtn {
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
	height: 30px;
	transition: all 0.2s ease;
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
	padding-bottom: 200px;
}

.postBox {
	width: 1500px;
	max-width: 1500px;
	min-height: 200px;
	height: auto;
	margin: auto;
	margin-top: 30px;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
}

.postUpBox {
	width: 100%;
	height: 95px;
	display: flex;
	border-radius: 10px 10px 0 0;
	background-color: #F2D3A2;
}

.replyUpBox {
	width: 100%;
	min-height: auto;
	display: flex;
	background-color: #fbe5c0;
	padding: 10px 0 20px 0;
}

.replyUpBox:first-child {
	margin-top: 0;
}

.postProfile, .replyProfileBox {
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

.replyProfile {
	margin-top: -3px;
	margin-left: -5px;
}

.postInfoBox {
	width: 300px;
	min-height: 50px;
	position: relative;
	left: 20px;
	top: 23px;
	flex-grow: 1;
}

.replyInfoBox {
	width: 300px;
	min-height: 50px;
	position: relative;
	flex-grow: 1;
	margin-top: 5px;
	margin-right: 5px;
	margin-left: 20px;
}

.postInfoUp, .replyInfoUp {
	display: flex;
}

.replyInfoUP {
	align-items: center;
	width: 100%;
	padding-right: 40px;
}

.fileName:hover {
	cursor: pointer;
}

.replyInfoDown {
	margin-top: 0px;
	width: 70%;
	min-height: 40px;
	border-radius: 5px;
	background-color: #f0d8af;
	color: #5e361a;
	padding: 10px;
	line-height: normal;
	word-break: break-all;
}

.profileInfo, .replyInfo {
	width: auto;
	margin-right: 15px;
	display: flex;
	align-items: center;
	font-size: 14px;
	color: #333;
}

/* 신고 영역 스타일 */
.reportArea {
	display: flex;
	flex-direction: column;
	align-items: flex-end;
	margin-left: auto;
	position: absolute;
	top: 5px;
	right: 20px;
	z-index: 10;
}

.reportIcon {
	color: #A66A3F;
	font-size: 20px;
	cursor: pointer;
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
	line-height: 40px;
}

.postContents, .fileContainer {
	overflow: hidden;
	margin: auto;
	width: 95%;
	font-size: 15px;
	background-color: #f0d8af;
	padding: 0px 4px;
	margin: auto;
}

.fileContainer {
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
}

.postContents {
	border-bottom-left-radius: 5px;
	border-bottom-right-radius: 5px;
	padding: 10px 0 5px 13px;
	white-space: pre-line;
    word-break: break-all;
}

#summernote {
	display: none;
}

.postImages {
	min-height: auto;
	line-height: 0;
}

.postImages img {
	max-width: 100%;
	max-height: 500px;
	display: block;
	border-radius: 8px;
	width: 500px;
	padding: 10px 0 0 10px;
	margin: 0;
}

.fileDownload {
	margin: auto;
	width: 95%;
	padding: 10px 10px;
}

.postDownBox {
	width: 95%;
	margin: auto;
	min-height: 40px;
	display: flex;
}

.postLikeBox, .postCommentBox {
	display: flex;
	align-items: center;
	min-width: 80px;
	width: auto;
	gap: 10px;
	cursor: pointer;
	transition: 0.3s;
}

.beforeHeart:hover, .comment:hover {
	color: #cdaa69;
}

.beforeHeart {
	display: inline;
}

.afterHeart {
	display: none;
	color: red;
}

.postLikeBox.active .beforeHeart {
	display: none;
}

.postLikeBox.active .afterHeart {
	display: inline;
}

.navicon:hover, .applyBtn:hover, .backBtn:hover, .updateBtn:hover,
	.deleteBtn:hover, .completeBtn:hover, .cancelBtn:hover, .upBtn:hover,
	.delBtn:hover, .OBtn:hover, .XBtn:hover, .fileDelBtn:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #fecc56;
	color: #A66A3F;
}

.navicon:active, .applyBtn:active, .backBtn:active, .updateBtn:active,
	.deleteBtn:active, .completeBtn:active, .cancelBtn:active, .upBtn:active,
	.delBtn:active, .OBtn:active, .XBtn:active, .fileDelBtn:active {
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

hr {
	width: 97%;
	margin: 10px 0 0 20px;
	border: 1px solid #cdaa69;
}

a {
	color: #5e361a;
	text-decoration: none;
}

.replyBox {
	width: 1500px;
	max-width: 1500px;
	min-height: 200px;
	height: auto;
	margin: auto;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
	border-radius: 10px;
}

.replyTitle {
	margin: 20px auto 0 auto;
	width : 1500px;
	height: 50px;
	font-weight: bold;
	font-size: x-large;
	color: #A66A3F;
}

.reportBtn {
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
	display: none;
	position: absolute;
	top: 53px;
	left: 15px;
	width: 90px;
	transition: all 0.2s ease;
	cursor: pointer;
}

.reportBtn:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #fecc56;
	color: #A66A3F;
}

.reportBtn:active {
	transform: translateY(2px);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
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

.newReplyBox {
	display: flex;
	background-color: #F2D3A2;
}

.newReplyDiv {
	width: 90%;
	border-radius: 10px;
	margin: 15px;
	margin-left: 65px;
	margin-top: 20px;
}

.newReply {
	width: 100%;
	background-color: #fbe5c0;
	border-radius: 10px;
	border: none;
	font-family: 'GMarketSans';
	color: #5e361a;
	outline: none;
	resize: none;
}

.applyBtnDiv {
	width: 10%;
}

.applyBtn {
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
	margin-left: 10px;
	margin-top: 20px;
	width: 60px;
	height: 40px;
	font-size: medium;
	transition: all 0.2s ease;
	cursor: pointer;
}

.btnDiv {
	width: 95px;
}

.deleteBtn, .cancelBtn, .delBtn, .XBtn {
	margin-left: 5px;
}

.updateBtn, .deleteBtn, .completeBtn, .cancelBtn, .upBtn, .delBtn, .OBtn,
	.XBtn, .fileDelBtn {
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
	transition: all 0.2s ease;
	cursor: pointer;
}

.completeBtn, .cancelBtn, .OBtn, .XBtn, .fileDelBtn {
	display: none;
}

.editCompleteDiv {
	position: relative;
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

.replyContents[contenteditable="true"], .postTitle[contenteditable="true"],
.postContents[contenteditable="true"] {
	border: 1px solid #FFB300;
	border-radius: 5px;
	padding: 5px;
}

.replyContents[contenteditable="true"]:focus {
	outline: none;
	border: 1px solid #FFB300;
}

.postTitle[contenteditable="true"]:focus, .postContents[contenteditable="true"]:focus {
	outline: none;
	border: 1px solid #FFB300;
}

.file-item .fileName {
	color: #b24c4c;
	font-size: 13px;
}

.newFileDiv {
	display: none;
	margin-top: 10px;
	margin-left: 45px;
}

.replyContents, .postContents {
	white-space: pre-wrap;
}

.postContents {
	white-space: pre-line;
}

.swal2-icon.swal2-question .swal2-icon-content {
	font-size: 50px;
	transform: translateY(5px);
	line-height: 70px;
}
</style>

</head>
<body>
   <div class="container">

      <div class="headBoxDiv">
         <div class="headBox">게시글 자세히보기</div>
         <div class="backBtnDiv">
            <input class="backBtn" type="button" value="목록으로">
         </div>
      </div>
      <div class="bodyBox">
         <div class="postBox" data-seq="${dto.post_seq}">

            <div class="postUpBox">

               <div class="postProfile">
                  <img class="contentProfile" src="/resources/images/Profile.png"
                     style="width: 60px;">
               </div>
               <div class="postInfoBox">
                  <div class="postInfoUp">
                     <div class="profileName profileInfo" style="color: #5e361a;">${dto.mem_nickname}</div>
                     <div class="profileLocal profileInfo" style="color: #5e361a;">${dto.mem_dong }</div>

                  </div>

                  <div class="postInfoDown">
                     <div class="profileTime profileInfo" style="color: #5e361a;">${dto.post_date }</div>
                     <c:if test="${dto.mem_id == loginId}">
                        <div class="btnDiv">
                           <div class="editDiv">
                              <input class="updateBtn" type="button" value="수정"> <input
                                 class="deleteBtn" type="button" value="삭제">
                           </div>
                           <div class="editCompleteDiv">
                              <input class="completeBtn" type="button" value="완료"> <input
                                 class="cancelBtn" type="button" value="취소">
                           </div>
                        </div>
                     </c:if>
                  </div>
               </div>
            </div>
            <div class="postMidBox">

               <div class="postTitle">${dto.post_title }</div>
               <div class="fileContainer">
                  <c:if test="${not empty fileList}">
                     <div class="postImages">
                        <c:forEach var="file" items="${fileList}">
                           <c:set var="fileName" value="${file.attach_sysname}" />
                           <c:set var="lowerName" value="${fileName.toLowerCase()}" />

                           <c:if
                              test="${lowerName.endsWith('.jpg') || lowerName.endsWith('.jpeg') || 
                          lowerName.endsWith('.png') || lowerName.endsWith('.gif') || 
                          lowerName.endsWith('.webp')}">
                              <div class="img-wrapper">
                                 <img src="/upload/${file.attach_sysname}">
                              </div>
                           </c:if>
                        </c:forEach>
                     </div>
                  </c:if>
               </div>
               <div class="postContents">${dto.post_contents}</div>

               <c:if test="${not empty fileList}">
                  <div class="fileDownload">
                     첨부 파일
                     <c:forEach var="i" items="${fileList}" varStatus="status">
                        <div class="file-item">
                           <label class="fileName" data-ori="${i.attach_oriname}"
                              data-sys="${i.attach_sysname}"> ${i.attach_oriname} </label>
                           <button type="button" class="fileDelBtn"
                              data-sys="${i.attach_sysname}">X</button>
                        </div>
                     </c:forEach>
                  </div>
               </c:if>
               <div class="newFileDiv">
                  <input type="file" class="newFiles" name="newFiles" multiple>
               </div>
            </div>

            <div class="postDownBox">

               <div
                  class="postLikeBox ${dto.post_like_check == 1 ? 'active' : ''}">
                  <i class="fa-regular fa-heart fa-xl beforeHeart"></i> <i
                     class="fa-solid fa-heart fa-xl afterHeart"></i>

                  <div class="likeCount infoCount">${dto.post_like}</div>
               </div>

               <div class="postCommentBox">
                  <i class="fa-regular fa-comment fa-xl comment"></i>

                  <div id="commentCount" class="commentCount infoCount">${dto.post_hit}</div>

               </div>

            </div>

         </div>

         <div class="replyContainer">
            <div class="replyTitle">댓글</div>
            <div class="replyBox">
               <div class="newReplyBox">
                  <div class="newReplyDiv">
                     <textarea class="newReply" type="text" placeholder="댓글을 입력하세요."
                        maxlength="300"></textarea>
                  </div>
                  <div class="applyBtnDiv">
                     <input class="applyBtn" type="submit" value="등록">
                  </div>
               </div>

            </div>
         </div>
         <div class="bottomBox">
            <a href="/"><i class="navicon fa-solid fa-house fa-2xl"
               style="color: #A66A3F"></i></a> <a href="/map/test"><i
               class="navicon fa-solid fa-map-location-dot fa-2xl"
               style="color: #A66A3F"></i></a> <a href="/meeting/list?category=all"><i
               class="navicon fa-solid fa-people-group fa-2xl"
               style="color: #A66A3F"></i></a> <a href="/feedback/feedbackHome"><i
               class="navicon fa-solid fa-bullhorn fa-2xl" style="color: #A66A3F"></i></a>
            <a href="/members/mypage"><i
               class="navicon fa-solid fa-user fa-2xl" style="color: #A66A3F"></i></a>

         </div>
      </div>
   </div>

   <script>
      
      let loginId = "${loginId}";
      let postSeq = "${dto.post_seq}"
      let postTitle = $(".postTitle");
      let postContents = $(".postContents");
      
      
      
      // 게시글 수정 버튼 클릭 시
      $(".updateBtn").on("click",function(){
         // 기존 내용 저장
         postTitle.data("originTitle", postTitle.text());
          postContents.data("originContents", postContents.html());
          
         $(".completeBtn").css({"display":"inline"});
         $(".cancelBtn").css({"display":"inline"});
         $(".updateBtn").css({"display":"none"});
         $(".deleteBtn").css({"display":"none"});
         $(".fileDelBtn").show();
         $(".newFileDiv").show();
         
         $(".newFileDiv").css({
            "margin-bottom":"5px"
         });
         
         $(".postTitle").attr("contenteditable","true");
         $(".postContents").attr("contenteditable","true");
         
         $(".postTitle").css({
            "border":"1px solid #FFB300",
            "border-bottom-left-radius": "0px",
            "border-bottom-right-radius": "0px",
            "padding-top":"0px",
            "margin-top":"0px"
            
         });
         $(".postContents").css({
             "border": "1px solid #FFB300",
             "border-top-left-radius": "0px",
             "border-top-right-radius": "0px",
             "padding": "10px 0 5px 12px"
         });
      });
      
      // 파일 삭제 버튼을 눌렀을때
      $(document).on("click", ".fileDelBtn", function() {
          $(this).closest(".file-item").addClass("delete-target").hide();
      });
      
      // 게시글 수정 완료 버튼 클릭 시
      $(".completeBtn").on("click",function(){
          
	   		// 1. 데이터 추출
	   	    let post_title = $(".postTitle").text().trim();
	   	    let post_contents = $(".postContents").html();
	   	    
	   	    // 엔터(\n)를 포함한 실제 텍스트 추출 (innerText 사용)
	   	    let post_titleText = document.querySelector(".postTitle").innerText; 
	   	    let post_text = document.querySelector(".postContents").innerText; 
	
	   	    let titleLimit = 100; // 제목 제한
	   	    let limit = 1000;     // 내용 제한

         
         
          if(post_title == ""){
             Swal.fire({
               icon: "info",
               title: "Wait  !",
               text: "제목을 입력해주세요.",
               iconColor: "#FFB300",
               confirmButtonColor: "#FFB300"
            });
              return;
          }
          if(post_contents == "" || post_contents == "<br>"){
             Swal.fire({
               icon: "info",
               title: "Wait  !",
               text: "내용을 입력해주세요.",
               iconColor: "#FFB300",
               confirmButtonColor: "#FFB300"
            });
              return;
          }
          
          let formData = new FormData();
          formData.append("post_seq", postSeq);
          formData.append("post_title", $(".postTitle").text());
          formData.append("post_contents", $(".postContents").html());
          formData.append("post_category","${category}");
          
          let deleteFiles = [];
          $(".delete-target").each(function() {
              deleteFiles.push($(this).find(".fileName").data("sys"));
          });
          if(deleteFiles.length > 0) {
              formData.append("deleteFiles", deleteFiles);
          }

          let newFiles = $(".newFiles")[0].files;
          for (let i = 0; i < newFiles.length; i++) {
              formData.append("attachments", newFiles[i]);
          }
         	
       		// 3. 제목 글자수 초과 체크
          if (post_titleText.length > titleLimit) {
              let currentTitleLen = post_titleText.length;
              let overTitle = post_titleText.substring(titleLimit, titleLimit + 50); // 제목은 짧으니 50자만
              
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

          // 4. 내용 글자수 초과 체크
          if (post_text.length > limit) {
              let currentLen = post_text.length;
              let overText = post_text.substring(limit, limit + 100); 

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
          
         $.ajax({
            url:"/board/updatePost",
            data:formData,
            processData: false,
              contentType: false,
            type: "post"
         }).done(function(resp){
            if(resp == "fail"){
               Swal.fire({
                        icon: "error",
                        title: "Fail !",
                        text: "신고된 게시물은 수정할 수 없습니다.",
                        iconColor: "#EB0000",
                        confirmButtonColor: "#FFB300"
                    }).then(() => {
                       let originTitle = postTitle.data("originTitle");
                     let originContents = postContents.data("originContents");

                      postTitle.text(originTitle);
                      postContents.html(originContents);
                      
                      $(".file-item").removeClass("delete-target").show();
                      $(".newFiles").val("");
                      
                      $(".fileDelBtn").hide();
                     $(".newFileDiv").hide();
                     
                      $(".completeBtn").css({"display":"none"});
                     $(".cancelBtn").css({"display":"none"});
                     $(".updateBtn").css({"display":"inline"});
                     $(".deleteBtn").css({"display":"inline"});
                     
                     postTitle.removeAttr("contenteditable");
                     postContents.removeAttr("contenteditable");
                     
                     postTitle.css({"border":"none"});
                     postContents.css({"border":"none"});
                    });
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
      
      // 게시글 삭제 버튼 클릭 시
      $(".deleteBtn").on("click",function(){
         
            // 현재 입력된 URL에서 'from' 파라미터가 있는지 확인.
            let urlParams = new URLSearchParams(window.location.search);
            let from = urlParams.get('from');
         	let cPage = urlParams.get('cPage') || 1 // 마이페이지 작성글/관심글 전용 cpage, 페이지 번호가 없으면 기본 1
         	
             let category = "${category}";
             let currentPage = "${currentPage}";
             let sort = "${sort}";
         
             
         Swal.fire({
              title: "정말 삭제하시겠습니까?",
              text: "삭제 후에는 복구할 수 없습니다.",
              icon: "question",
              showCancelButton: true,
              iconColor: "#FFB300",
              confirmButtonColor: "#FFB300",
              cancelButtonColor: "#d9d9d9",
              confirmButtonText: "삭제",
              cancelButtonText: "취소"      
          }).then((result) => {

              if (result.isConfirmed) {
                 $.ajax({
              url: "/board/deletePost",
              data: {post_seq: postSeq},
              type: "post"
          }).done(function(resp){
             if(resp == "fail"){ // 신고된 게시글 일때는 boardController에서 fail을 보내서 삭제X
                Swal.fire({
                        icon: "error",
                        title: "Error !",
                        text: "신고된 게시물은 삭제할 수 없습니다.",
                        iconColor: "#EB0000",
                        confirmButtonColor: "#FFB300"
                    });
             }else if(from == "myPosts"){ // category 받아서 다시 카테고리 목록으로 이동
                 Swal.fire({
                     icon: "success",
                     title: "Success !",
                     text: "삭제되었습니다.",
                     iconColor: "#FFB300",
                     confirmButtonColor: "#FFB300"
                 }).then(() => {
                   location.href = "/members/myPosts?cPage=" + cPage + "&from=myPosts";
                 });
              }else if(from == "myLikes"){ // category 받아서 다시 카테고리 목록으로 이동
                  Swal.fire({
                      icon: "success",
                      title: "Success !",
                      text: "삭제되었습니다.",
                      iconColor: "#FFB300",
                      confirmButtonColor: "#FFB300"
                  }).then(() => {
                    location.href = "/members/myLikes?cPage=" + cPage + "&from=myLikes";
                  });
               }else if(category == "lifeInfo"){ // category 받아서 다시 카테고리 목록으로 이동
                   Swal.fire({
                           icon: "success",
                           title: "Success !",
                           text: "삭제되었습니다.",
                           iconColor: "#FFB300",
                           confirmButtonColor: "#FFB300"
                       }).then(() => {
                          location.href = "/board/lifeInfo?sort=" + sort + "&cPage=" + currentPage;
                       });
                 }else if(category == "talk"){
                   Swal.fire({
                           icon: "success",
                           title: "Success !",
                           text: "삭제되었습니다.",
                           iconColor: "#FFB300",
                           confirmButtonColor: "#FFB300"
                       }).then(() => {
                          location.href = "/board/talk?sort=" + sort + "&cPage=" + currentPage;
                       }); 
                 }else if(category == "food"){
                   Swal.fire({
                           icon: "success",
                           title: "Success !",
                           text: "삭제되었습니다.",
                           iconColor: "#FFB300",
                           confirmButtonColor: "#FFB300"
                       }).then(() => {
                          location.href = "/board/food?sort=" + sort + "&cPage=" + currentPage;
                       }); 
                 }else if(category == "beauty"){
                   Swal.fire({
                           icon: "success",
                           title: "Success !",
                           text: "삭제되었습니다.",
                           iconColor: "#FFB300",
                           confirmButtonColor: "#FFB300"
                       }).then(() => {
                          location.href = "/board/beauty?sort=" + sort + "&cPage=" + currentPage;
                       }); 
                 }else if(category == "all" || category == ""){
                   Swal.fire({
                           icon: "success",
                           title: "Success !",
                           text: "삭제되었습니다.",
                           iconColor: "#FFB300",
                           confirmButtonColor: "#FFB300"
                       }).then(() => {
                          location.href = "/?sort=" + sort;
                       }); 
                 }else {
                location.href = "/";
                 }
          });
        }
     });
  });
          
      
      // 게시글 수정 취소 버튼 클릭 시
      $(".cancelBtn").on("click",function(){
         
         let originTitle = postTitle.data("originTitle");
         let originContents = postContents.data("originContents");

          postTitle.text(originTitle);
          postContents.html(originContents);
          
          $(".file-item").removeClass("delete-target").show();
          $(".newFiles").val("");
          
          $(".fileDelBtn").hide();
         $(".newFileDiv").hide();
         
          $(".completeBtn").css({"display":"none"});
         $(".cancelBtn").css({"display":"none"});
         $(".updateBtn").css({"display":"inline"});
         $(".deleteBtn").css({"display":"inline"});
         
         postTitle.removeAttr("contenteditable");
         postContents.removeAttr("contenteditable");
         
         postTitle.css({"border":"none"});
         postContents.css({"border":"none"});
      });
      
      
      // 파일 눌렀을때 다운로드 
      $(".fileName").on("click",function(){
         let sys_name = $(this).data("sys");
         let ori_name = $(this).data("ori");
         location.href="/attach/download?sys_name="+sys_name+"&ori_name="+ori_name;
      })
      
      // 댓글 목록 출력해오는 ajax -> 이름있는 함수로 만들고 밑에서 익명함수로 최초 실행
      
      function loadReplyList(){
         $.ajax({
            url:"/board/replyList",
            dataType:"json",
            data: { post_seq: postSeq }
         }).done(function(resp){
            $(".replyUpBox, .hr").remove(); // 기존 댓글 목록 비우기,(새로 등록된 것까지 포함해서 다시 그려야 하므로)
            
            for(let i of resp){ // 댓글 for문 돌리면서 뽑기.
                  let replyUpBox = $("<div>").addClass("replyUpBox");
                  
                  let replyProfileBox = $("<div>").addClass("replyProfileBox");
                  
                  let replyProfile = $("<img>").addClass("replyProfile");
                  replyProfile.attr("src","/resources/images/birdprofile.png");
                  replyProfile.css({"width": "80px"});
                  replyProfileBox.append(replyProfile);
                  
                  let replyInfoBox = $("<div>").addClass("replyInfoBox");
                  let replyInfoUp = $("<div>").addClass("replyInfoUp");
                  let writerName = $("<div>").addClass("writerName replyInfo");
                  writerName.css({"color": "#5e361a"});
                  writerName.html(i.mem_nickname);
                  let writeTime = $("<div>").addClass("writeTime replyInfo");
                  writeTime.css({"color": "#5e361a"});
                  writeTime.html(i.reply_date);
                  
                  replyInfoUp.append(writerName, writeTime);
                  
                  if(i.mem_id == loginId){
                     let btnDiv = $("<div>").addClass("btnDiv");
                     let replyEditDiv = $("<div>").addClass("replyEditDiv");
                     replyEditDiv.append(
                        $("<input>").attr("type","button").addClass("upBtn").val("수정"),
                        $("<input>").attr("type","button").addClass("delBtn").val("삭제").attr("data-reply_seq", i.reply_seq)
                     );
                     let replyEditCompleteDiv = $("<div>").addClass("replyEditCompleteDiv");
                     replyEditCompleteDiv.append(
                        $("<input>").attr("type","button").addClass("OBtn").val("완료").attr("data-reply_seq", i.reply_seq),
                        $("<input>").attr("type","button").addClass("XBtn").val("취소")      
                     );
                     btnDiv.append(replyEditDiv, replyEditCompleteDiv);
                     replyInfoUp.append(btnDiv);
                  }else if(i.mem_role == 0){
                     
                  }else{
                     let reportArea = $("<div>").addClass("reportArea");
                     let reportIcon = $("<img>").addClass("reportIcon");
                     reportIcon.attr("src","/resources/images/free-icon-siren1.png");
                     reportIcon.css({
                        "width": "25px",
                        "height": "25px",
                        "margin-bottom": "5px"
                     });
                     let reportSelect = $("<select>").addClass("reportSelect")
                     reportSelect.append(
                        $("<option disabled selected>").html("신고 사유"),
                        $("<option>").addClass("reportOption").html("부적절한 콘텐츠").val("badContents"),
                        $("<option>").addClass("reportOption").html("욕설/비방").val("badWord"),
                        $("<option>").addClass("reportOption").html("광고/스팸").val("AD")
                     );
                     let reportBtn = $("<input>").attr("type","button")
                                          .addClass("reportBtn")
                                          .val("신고하기")
                                          .attr("data-target_id", i.mem_id) // 신고시 controller에 보낼 id
                                          .attr("data-target_seq", i.reply_seq); // 신고 버튼시 사용할 seq 미리 부여
                     
                     reportArea.append(reportIcon, reportSelect, reportBtn);
                     replyInfoUp.append(reportArea);
                  }
                  
                  let replyInfoDown = $("<div>").addClass("replyInfoDown");
                  replyInfoDown.append(
                     $("<div>").addClass("replyContents replyInfo").css({"color":"#5e361a"}).html(i.reply_contents)
                  );
                  
                  replyInfoBox.append(replyInfoUp, replyInfoDown);
                  replyUpBox.append(replyProfileBox, replyInfoBox);
                  
                  let hr = $("<hr>").addClass("hr")
                  $(".replyBox").append(replyUpBox, hr);
            } // for문 종료
         });
      };
         
      // 페이지 로드 시 최초 실행
      $(function() {
          loadReplyList();
      });
      
        // 좋아요 버튼
        $(".postLikeBox").on("click", function () {
            let postLike = $(this);
            let post_seq = postLike.closest(".postBox").data("seq");
            
            // 하트 채워지고 비워지는 토글용 ajax
           $.ajax({
              url : "/like/toggle",
              data : {post_seq : post_seq},
              type : "post"
           }).done(function(likeCheck) {
              if(likeCheck == -1){
                 Swal.fire({
                      icon: "warning",
                      title: "Wait !",
                      text: "로그인 후 이용 가능합니다.",
                      iconColor: "#FFB300",
                      confirmButtonColor: "#FFB300"
                  }).then(() => {
                     location.href = "/members/loginUi";
                  });
                 return;
               };
               
              if (likeCheck == 1 || likeCheck == 0) { // 하트를 누를때마다 css 적용
                  postLike.toggleClass("active"); // active 클래스를 넣었다 뺐다 함 
                  // 서버 처리가 성공하면 화면의 하트 색깔을 변경함
                  
                  // jsp 화면에 보여지는 전체 숫자용 ajax
                  $.ajax({
                     url : "/like/count",
                     data : {post_seq : post_seq},
                     type : "post"
                  }).done(function(count){
                     postLike.find(".likeCount").text(count);
                  });
               }
            });
        });
               
        // 신고 아이콘을 눌렀을 때, 신고 사유가 튀어나오게
        $(document).on("click", ".reportIcon", function (e) {
          e.stopPropagation();
          let reportArea = $(this).closest(".reportArea");
          
          reportArea.find(".reportSelect, .reportBtn").toggle();
      });

      // [댓글 신고하기] 버튼 클릭 시 (동적 요소이므로 document 위임 방식 사용)
      $(document).on("click", ".reportBtn", function() {
         
          let btn = $(this); // 클릭한 버튼(신고하기)
          let target_id = btn.attr("data-target_id"); // 작성자의 id값 가져오기
          let target_seq = btn.attr("data-target_seq"); // 댓글 번호
          let reports_type = 1; // 신고 종류(댓글)
          let report_reason = btn.siblings(".reportSelect").val(); // 선택한 신고 사유 값 저장.
         
          
          if(!report_reason) {
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
                 
                 $.ajax({
                     url: "/report/insert", // 서버의 신고 처리 컨트롤러 주소
                     type: "post",
                     data: {
                        target_id: target_id,
                         target_seq: target_seq,
                         reports_type: reports_type,
                         reports_reason: report_reason
                    }
                 }).done(function(resp) {
                     if(resp == "success"){
                         Swal.fire({
                               icon: "success",
                               title: "Success !",
                               text: "신고가 접수되었습니다.",
                               iconColor: "#FFB300",
                               confirmButtonColor: "#FFB300"
                           }).then(() => {
                           btn.hide();// 신고 후 UI 처리 (선택창 다시 숨기기)
                           btn.siblings(".reportSelect").hide();
                           });
                     } else if(resp == "fail"){
                         Swal.fire({
                               icon: "success",
                               title: "Success !",
                               text: "이미 신고한 댓글입니다.",
                               iconColor: "#FFB300",
                               confirmButtonColor: "#FFB300"
                           }).then(() => {
                           btn.hide();// 신고 후 UI 처리 (선택창 다시 숨기기)
                           btn.siblings(".reportSelect").hide();
                           });
                     } else if(resp == "adminFail"){
                        Swal.fire({
                              icon: "error",
                              title: "Fail !",
                              text: "관리자의 댓글은 신고가 불가합니다.",
                              iconColor: "#EB0000",
                              confirmButtonColor: "#FFB300"
                          }).then(() => {
                           btn.hide();// 신고 후 UI 처리 (선택창 다시 숨기기)
                           btn.siblings(".reportSelect").hide();
                          });
                     }
                 });
                } 
            });
        });
        
        $(".newReply").on("input", function(){
          this.style.height = "auto";              // 초기화
          this.style.height = this.scrollHeight + "px";  // 내용만큼 늘림
      });
        
        
        // 댓글 등록 버튼을 눌렀을 때, ajax
        $(".applyBtn").on("click",function(){
        	let reply = $(".newReply").val();
        	let textarea = $(".newReply").val(""); // 입력창 비우고,
            
            // 완전 초기화
             textarea.css("height", "auto");

            // input 이벤트 강제로 발생시켜서 다시 기본 높이 계산하게 만들기
            textarea.trigger("input");
           
           if(reply.trim() == ""){
              Swal.fire({
               icon: "info",
               title: "Wait  !",
               text: "내용을 입력해주세요.",
               iconColor: "#FFB300",
               confirmButtonColor: "#FFB300"
            });
              return;
           }
           
           $.ajax({
              url:"/reply/insertReply",
              data: {
                 reply_contents: reply,
                    post_seq: postSeq
              },
              type:"post"
           }).done(function(resp){ // 입력 성공시
              $(".newReply").val(""); // 입력창 비우고,
              
              let countElement = $(".commentCount"); // 카운트한 값이 들어있는 div
              let currentCount = parseInt(countElement.text()); // div에 값만 빼와서 남기.
              
              countElement.text(currentCount + 1); // div에 기존값 + 1로 화면에 보여주기용
              
              loadReplyList(); // 댓글 목록 다시 불러오기. -> location.reload() 대신 사용
              
           })
           
        });
        
        // upBtn, delBtn, OBtn, XBtn
        // 댓글 수정 버튼을 눌렀을 때
        $(document).on("click",".upBtn",function(){
           let replyUpBox = $(this).closest(".replyUpBox");
           
           let upBtn = replyUpBox.find(".upBtn").css({"display":"none"});
           let delBtn = replyUpBox.find(".delBtn").css({"display":"none"});
           let OBtn = replyUpBox.find(".OBtn").css({"display":"inline"});
           let XBtn = replyUpBox.find(".XBtn").css({"display":"inline"});
           
           let replyContents = replyUpBox.find(".replyContents");
           replyContents.data("origin", replyContents.html());
           
           replyContents.attr("contenteditable", "true");
        });
        
        $(document).on("keydown", ".replyContents[contenteditable='true']", function(e){
            if(e.key === "Enter"){
                e.preventDefault(); // 기본 동작 막기

                document.execCommand("insertLineBreak"); // 줄바꿈 삽입
            }
        });
        
        // 댓글 수정 취소 버튼을 눌렀을 때
        $(document).on("click",".XBtn",function(){
         let replyUpBox = $(this).closest(".replyUpBox");
         
           let replyContents = replyUpBox.find(".replyContents");
           let origin = replyContents.data("origin");
           
           replyContents.html(origin);
           
           let upBtn = replyUpBox.find(".upBtn").css({"display":"inline"});
           let delBtn = replyUpBox.find(".delBtn").css({"display":"inline"});
           let OBtn = replyUpBox.find(".OBtn").css({"display":"none"});
           let XBtn = replyUpBox.find(".XBtn").css({"display":"none"});

           replyContents.removeAttr("contenteditable");
        });
        
        // 댓글 삭제 버튼을 눌렀을 때
        $(document).on("click",".delBtn",function(){
           
           let btn = $(this);
           let reply_seq = $(this).data("reply_seq");
           
           Swal.fire({
                title: "정말 삭제하시겠습니까?",
                text: "삭제 후에는 복구할 수 없습니다.",
                icon: "question",
                showCancelButton: true,
                iconColor: "#FFB300",
                confirmButtonColor: "#FFB300",
                cancelButtonColor: "#aaa",
                confirmButtonText: "삭제",
                cancelButtonText: "취소"
            }).then((result) => {

                if(result.isConfirmed){
                   $.ajax({
                    url: "/reply/deleteReply",
                    data: {reply_seq : reply_seq},
                    type: "post"
                 }).done(function(resp){
                    
                    if(resp == "fail"){
                       Swal.fire({
                              icon: "error",
                              title: "Fail !",
                              text: "신고된 댓글은 삭제가 불가합니다.",
                              iconColor: "#EB0000",
                              confirmButtonColor: "#FFB300"
                          });
                       return;
                    }else{
                       Swal.fire({
                              icon: "success",
                              title: "Success !",
                              text: "삭제되었습니다.",
                              iconColor: "#FFB300",
                              confirmButtonColor: "#FFB300"
                          }).then(() => {
                             let countElement = $(".commentCount"); // 카운트한 값이 들어있는 div
                          let currentCount = parseInt(countElement.text()); // div에 값만 빼와서 남기.
                          countElement.text(currentCount - 1);
                          
                          loadReplyList();
                       });
                     }
                    });
                 }
           });
          });
        
        // 댓글 수정 완료 버튼을 눌렀을 때
        $(document).on("click",".OBtn",function(){
           
         	let replyUpBox = $(this).closest(".replyUpBox");
           	let reply_seq = $(this).data("reply_seq");
           
	        // 1. 데이터 추출
	        let replyContents = replyUpBox.find(".replyContents");
           
	        // 엔터(\n)를 포함한 실제 텍스트 추출
	        let reply_contents = replyContents.html();
	        let reply_text = replyContents.text().trim();
	        
	        // 댓글 내용 글자수 제한
           	let limit = 300; 

	           if(reply_text == ""){
	              Swal.fire({
	               icon: "info",
	               title: "Wait  !",
	               text: "내용을 입력해주세요.",
	               iconColor: "#FFB300",
	               confirmButtonColor: "#FFB300"
	            });
              return;
        	  }
           if (reply_text.length > limit) {
               let currentTitleLen = reply_text.length;
               let overTitle = reply_text.substring(limit, limit + 50); // 제목은 짧으니 50자만
               
               Swal.fire({
                   icon: "warning",
                   title: "댓글 글자수 초과!",
                   html: "현재 댓글이 <b>" + currentTitleLen + "자</b>입니다. (제한: 300자)<br><br>" +
                         "<div style='color:red; background:#fff1f1; padding:15px; border-radius:5px; text-align:left; font-size:13px; border:1px solid #ffcccc; word-break: break-all;'>" +
                         "<b>내용 뒷부분을 삭제해주세요:</b><br><br>" +
                         "<span style='color:#555;'>... " + overTitle + "</span></div>",
                   iconColor: "#EB0000",
                   confirmButtonColor: "#FFB300"
               });
               return;
           }
           
           $.ajax({
              url: "/reply/updateReply",
              data: {
                 reply_seq : reply_seq,
                 reply_contents : reply_contents
              },
              type: "post"
           }).done(function(resp){
              if(resp == "fail"){
                 Swal.fire({
                        icon: "error",
                        title: "Fail !",
                        text: "신고된 댓글은 수정이 불가합니다.",
                        iconColor: "#EB0000",
                        confirmButtonColor: "#FFB300"
                    }).then(() => {
                     
                       let replyContents = replyUpBox.find(".replyContents");
                       let origin = replyContents.data("origin");
                       
                       replyContents.html(origin);
                       
                       let upBtn = replyUpBox.find(".upBtn").css({"display":"inline"});
                       let delBtn = replyUpBox.find(".delBtn").css({"display":"inline"});
                       let OBtn = replyUpBox.find(".OBtn").css({"display":"none"});
                       let XBtn = replyUpBox.find(".XBtn").css({"display":"none"});

                       replyContents.removeAttr("contenteditable");
                    });
              }else if(resp == "success"){
                 Swal.fire({
                   icon: "success",
                   title: "Success  !",
                   text: "수정되었습니다.",
                   iconColor: "#FFB300",
                   confirmButtonColor: "#FFB300"
                }).then(() => {
                   loadReplyList();
                });
              }
           });
        });
        
        // 뒤로가기 버튼을 눌렀을 때
        $(document).on("click", ".backBtn", function(){
           
            // 현재 입력된 URL에서 'from' 파라미터가 있는지 확인.
            let urlParams = new URLSearchParams(window.location.search);
            let from = urlParams.get('from');
          let cPage = urlParams.get('cPage') || 1 // 마이페이지 작성글/관심글 전용 cpage, 페이지 번호가 없으면 기본 1
           
          let category = "${category}";
          let currentPage = "${currentPage}";
          let sort = "${sort}";
          
         if(from == "myLikes"){
            location.href = "/members/myLikes?cPage=" + cPage + "&from=myLikes";

         }else if(from == "myPosts"){
            location.href = "/members/myPosts?cPage=" + cPage + "&from=myPosts";
            
         }else if(category === "talk"){ // 카테고리 받아서 해당 목록 페이지로 이동
              location.href = "/board/talk?sort=" + sort + "&cPage=" + currentPage;
          }else if(category == "lifeInfo"){
              location.href = "/board/lifeInfo?sort=" + sort + "&cPage=" + currentPage;
          }else if(category == "food"){
             location.href = "/board/food?sort=" + sort + "&cPage=" + currentPage;
          }else if(category == "beauty"){
             location.href = "/board/beauty?sort=" + sort + "&cPage=" + currentPage;
          }else if(category == "all" || category == ""){
             location.href = "/?sort=" + sort;
          }else {
             location.href = "/";
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