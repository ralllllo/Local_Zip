<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리동네.zip</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
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
input, button, body {
   font-family: 'GMarketSans', sans-serif;
}

.container {
   position: relative;
   top: 100px;
   width: 100%;
   min-height: 100vh;
   /* 최소 높이 지정 : 브라우저 */
   border: 1px solid black;
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

.categoryBtnBox {
   width: 100%;
   height: 70px;
}

.categoryBtns {
   position: relative;
   top: 20px;
   left: 20px;
   /* 수정: 고정 800px 대신 화면의 90%만 차지하게 */
   width: 90%;
   max-width: 800px;
}

.nowBtn {
   background-color: #fecc56;
   color: #A66A3F;
   transform: translateY(-3px);
   /* 살짝 위로 뜸 */
   box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
   height: 25px;
   border-radius: 10px;
   border: 1px solid #FFB300;
   align-items: center;
   /* 수직 중앙 정렬 */
   vertical-align: middle;
   /* 버튼들끼리 줄이 안 맞을 때를 대비 */
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
   /* 수직 중앙 정렬 */
   vertical-align: middle;
   /* 버튼들끼리 줄이 안 맞을 때를 대비 */
   cursor: pointer;
   transition: 0.3s;
}

.categoryBtn {
   margin-right: 10px;
   height: 30px;
   /* 그림자 효과 */
   box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
   /* 애니메이션 부드럽게 */
   transition: all 0.2s ease;
}

.categoryBtn:hover {
   background-color: #fecc56;
   color: #A66A3F;
   transform: translateY(-3px);
   /* 살짝 위로 뜸 */
   box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

.categoryBtn:active {
   transform: translateY(2px);
   /* 아래로 눌림 */
   box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.bodyBox {
   width: 100%;
   min-height: 100vh;
   /* 최소 높이 지정 : 브라우저 */
   margin-top: -40px;
   color: #5e361a;
}

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

.orderNew {
   display: none;
}

.orderBtn {
   border: none;
   background-color: transparent;
   border-radius: 30%;
   font-size: 15px;
   color: #A66A3F;
   font-size: 15px;
   margin: 10px 0 10px 0;
   transition: all 0.2s ease;
   cursor: pointer;
}

.orderBtn:hover {
   background-color: #fecc56;
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
   cursor: pointer;
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
   min-height: 50px;
   position: relative;
   left: 20px;
   top: 23px;
   flex-grow: 1;
   /* 신고박스 오른쪽으로 딱 붙게 하기 위해 빈공간을 쭉 늘려주는 코드 */
}

.postInfoUp, .postInfoDown {
   display: flex;
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

.reportBtn {
   background-color: #ffb300;
   color: #5e361a;
   border: 1px solid #ffb300;
   border-radius: 10px;
   display: none;
   transition: all 0.2s ease;
   cursor: pointer;
}

.reportBtn:hover {
   transform: translateY(-3px); /* 살짝 위로 뜸 */
   box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
   background-color: #fecc56;
   color: #A66A3F;
}

.reportBtn:active {
   transform: translateY(2px); /* 아래로 눌림 */
   box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.postMidBox {
   width: 100%;
   height: auto;
}

.postTitle {
   margin: auto;
   width: 95%;
   height: 40px;
   font-size: 20px;
   margin-top: 5px;
   line-height: 40px;
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
   text-overflow: ellipsis; /* 넘치는 부분을 ...으로 표시 */
   display: block;
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

/* 기본 상태 : 빨간하트는 숨겨놓고, 빈 하트는 보여주기 */
.beforeHeart {
   display: inline;
}

.afterHeart {
   display: none;
   color: red;
}

/* active 클래스가 붙었을 때의 제어(빨간하트를 보여주고 빈 하트는 숨김.) */
.postLikeBox.active .beforeHeart {
   display: none;
}

.postLikeBox.active .afterHeart {
   display: inline;
}

.navicon:hover {
   transform: translateY(-3px);
   /* 살짝 위로 뜸 */
   box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

.navicon:active {
   transform: translateY(2px);
   /* 아래로 눌림 */
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
   margin-bottom: 40px;
   border: 1px solid #cdaa69;
   ;
}

.pageBox {
   width: 100%;
   text-align: center; /* 가운데 정렬 */
   padding: 20px 0; /* 상하 여백 */
   margin-bottom: 80px; /* 중요: 하단 바에 가려지지 않도록 아래쪽 여백 확보 */
   font-size: 18px;
   color: #A66A3F;
   font-weight: bold;
}

.writeBtn {
   width: 50px;
   height: 50px;
   right: 30px;
   bottom: 90px;
   margin-top: 90%;
   border-radius: 50%;
   background-color: #A66A3F;
   color: rgb(255, 179, 0);
   border: #fbe5c0;
   font-size: 30px;
   position: fixed; /* 버튼 따라다니게 만들기 */
   align-items: center;
   display: flex;
   justify-content: center;
   /* 그림자 효과 */
   box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
   /* 애니메이션 부드럽게 */
   transition: all 0.2s ease;
   cursor: pointer;
}

.writeBtn:hover {
   transform: translateY(-3px); /* 살짝 위로 뜸 */
   box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
   color: #fecc56;
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
.headBox a {
  text-decoration: none; /* 밑줄 제거 */
  color: inherit;        /* 부모 요소의 글자색 상속 (파란색 제거) */
}
</style>
</head>
<body>
<div class="container">

      <div class="headBox"><a href="/">우리 동네.zip</a></div>

      <div class="categoryBtnBox">
         <div class="categoryBtns">
            <a href="/"><button class="categoryBtn topBtn" type="button">
                  <i class="fa-solid fa-house fa-lg"></i> 전체
               </button></a> <a href="/board/lifeInfo"><button class="categoryBtn topBtn" type="button">
                  <i class="fa-regular fa-lightbulb fa-lg"></i> 생활정보
               </button></a>
            <a href="/board/food"><button class="categoryBtn nowBtn" type="button">
               <i class="fa-solid fa-utensils fa-lg"></i> 맛집/카페
            </button></a>
            <a href="/board/talk"><button class="categoryBtn topBtn" type="button">
                  <i class="fa-regular fa-comment-dots fa-lg"></i> 고민/이야기
               </button></a>
            <a href="/board/beauty"><button class="categoryBtn topBtn" type="button">
               <i class="fa-solid fa-shirt fa-lg"></i> 미용/패션
            </button></a>
         </div>
      </div>

      <hr>

      <c:choose>
         <c:when test="${empty list}">

            <div class="emptyBox">등록된 게시글이 없습니다.</div>

         </c:when>

         <c:otherwise>
            <div class="bodyBox">

               <div class="orderBox">
               <!-- 버튼 하나만 쓰고 현재 상태를 클릭하면 반대로 이동 -->
                  <button class="sortBtn orderBtn" type="button">${sort == 'latest' ? '최신순' : '인기순'}</button>
               </div>

               <c:forEach var="i" items="${list}">
                  <div class="postBox" data-seq="${i.post_seq}" data-writer="${i.mem_id}">

                     <div class="postUpBox">

                        <div class="postProfile">
                           <img class="contentProfile" src="/resources/images/Profile.png" width="60px">
                        </div>

                        <div class="postInfoBox">
                           <div class="postInfoUp">
                              <div class="profileName profileInfo" style="color: #5e361a;">${i.mem_nickname}</div>
                              <div class="profileLocal profileInfo" style="color: #5e361a;">${i.mem_dong}</div>
                              <div class="profileCatagory profileInfo">
                                 <button class="topBtn" type="button">맛집/카페</button>
                              </div>
                           </div>

                           <div class="postInfoDown">
                              <div class="profileTime profileInfo" style="color: #5e361a;">${i.post_date}</div>
                           </div>
                        </div>

                        <c:if test="${loginId != null && loginId != i.mem_id && i.mem_role != 0}">
                           <div class="reportArea">
                              <img src="/resources/images/free-icon-siren1.png" class="reportIcon"
                                 style="width: 25px; height: 25px; margin-bottom: 5px"></img> 
                                 <select class="reportSelect" name="reports_reason">
                                    <option value="" disabled selected>신고 사유</option>
                                    <option value="badContents" class="reportOption">부적절한 콘텐츠</option>
                                    <option value="badWord" class="reportOption">욕설/비방</option>
                                    <option value="AD" class="reportOption">광고/스팸</option>
                                 </select> 
                              <input class="reportBtn" type="submit" value="신고하기">
                           </div>
                        </c:if>

                     </div>

                     <div class="postMidBox">

                        <div class="postTitle">${i.post_title}</div>
                          
                        <div class="postContent">${i.post_contents}</div>

                     </div>

                     <c:if test="${loginId != null}">
                        <div class="postDownBox">

                           <div class="postLikeBox ${i.post_like_check == 1 ? 'active' : ''}">
                              <i class="fa-regular fa-heart fa-xl beforeHeart"></i>
                              
                              <i class="fa-solid fa-heart fa-xl afterHeart"></i>

                              <div class="likeCount infoCount">${i.post_like}</div>
                           </div>

                           <div class="postCommentBox">
                              <i class="fa-regular fa-comment fa-xl comment"></i>

                              <div class="commentCount infoCount">${i.post_hit}</div>
                           </div>

                        </div>
                     </c:if>
                  </div>
               </c:forEach>
            </div>

            <div class="pageBox"></div>

         </c:otherwise>
      </c:choose>



      <a href="/board/write"><button class="writeBtn" type="button">
            <i class="fa-solid fa-circle-plus fa-2xl"></i>
         </button></a>


      <div class="bottomBox">
         <a href="/"><i class="nowNavicon fa-solid fa-house fa-2xl"></i></a> <a href="/map/test"><i
            class="navicon fa-solid fa-map-location-dot fa-2xl" style="color: #A66A3F"></i></a> <a href="/meeting/list?category=all"><i
            class="navicon fa-solid fa-people-group fa-2xl" style="color: #A66A3F"></i></a> <a href="/feedback/feedbackHome"><i
            class="navicon fa-solid fa-bullhorn fa-2xl" style="color: #A66A3F"></i></a>
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

   </div>


   <script>

        // 최신순, 인기순 버튼
        $(".orderNew").on("click", function () {
            $(".orderNew").css({ "display": "none" });
            $(".orderPopular").css({ "display": "inline" });
        })

        $(".orderPopular").on("click", function () {
            $(".orderNew").css({ "display": "inline" });
            $(".orderPopular").css({ "display": "none" });
        })
        
        
        // 최신순, 인기순 정렬s
        $(".sortBtn").on("click",function(){
           
           let currentSort = "${sort}";
           
           if(currentSort == "latest"){
              location.href = "/board/food?sort=like";
           }else{
              location.href = "/board/food?sort=latest";
           }
        });
        

      $(function() {
         // 1. 게시글 상세 페이지 이동 (통합 제어)
         // .postBox를 클릭했을 때, 클릭된 요소가 신고/좋아요 관련 요소가 아닐 때만 이동
         $(document).on("click", ".postBox", function(e) {
            // 클릭한 타겟이 신고 아이콘, 신고 선택창, 신고 버튼 내부에 있다면 이동 금지
            if ($(e.target).closest(".reportArea").length > 0) {
               return;
            }

            // 게시글 상세보기 이동 제어
            let loginId = "${loginId}";
            if (loginId === "") {
               Swal.fire({
                    icon: "warning",
                    title: "Wait !",
                    text: "로그인 후 이용해주세요.",
                    iconColor: "#FFB300",
                    confirmButtonColor: "#FFB300"
                }).then((result) => {
                   if (result.isConfirmed) {
                     location.href = "/members/loginUi";
                   }
                });
               return;
            }

            let post_seq = $(this).data("seq");
            location.href = "/board/postDetail?post_seq=" + post_seq + "&category=food";
         });

         // 신고 ---------------------------------------------
         // 신고 아이콘 클릭 시 메뉴 표시
         $(document).on("click", ".reportIcon", function(e) {
            e.stopPropagation(); // 부모인 .postBox로 이벤트가 퍼지는 것을 막음 (중요)

            // 클릭한 아이콘이 속한 그 영역의 메뉴만 토글
            let reportArea = $(this).closest(".reportArea");

            reportArea.find(".reportSelect, .reportBtn").toggle();
         });

         // 신고 사유 선택창 클릭 시 이동 방지
         $(document).on("click", ".reportSelect", function(e) {
            e.stopPropagation(); // 클릭 시 상세페이지 이동 방지
         });

         // 신고 버튼 클릭 (AJAX)
         $(document).on("click", ".reportBtn", function(e) {
            e.stopPropagation(); // 클릭 시 상세페이지 이동 방지

            let card = $(this).closest(".postBox");
            let targetSeq = card.data("seq");
            let targetId = card.data("writer");
            let reportReason = card.find(".reportSelect").val();

            if (!reportReason || reportReason === "신고 사유") {
               Swal.fire({
                  icon: "info",
                  title: "Wait  !",
                  text: "신고 사유를 선택해 주세요.",
                  iconColor: "#FFB300",
                  confirmButtonColor: "#FFB300"
               });
               return;
            }

            $.ajax({
               url : "/report/insert",
               type : "post",
               data : {
                  target_seq : targetSeq,
                  target_id : targetId,
                  reports_type : 0,
                  reports_reason : reportReason
               }
            }).done(function(resp) {
               if (resp == "success") {
                  Swal.fire({
                      icon: "success",
                      title: "Success  !",
                      text: "신고가 접수되었습니다.",
                      iconColor: "#FFB300",
                      confirmButtonColor: "#FFB300"
                   });
                  card.find(".reportSelect, .reportBtn").hide();
               } else {
                  Swal.fire({
                      icon: "info",
                      title: "Already  !",
                      text: "이미 신고한 글 입니다.",
                      iconColor: "#FFB300",
                      confirmButtonColor: "#FFB300"
                   });
                  card.find(".reportSelect, .reportBtn").hide();
               }
            }).fail(function() {
               Swal.fire({
                  icon: "error",
                  title: "Error  !",
                  text: "에러 발생",
                  iconColor: "#EB0000",
                  confirmButtonColor: "#FFB300"
               });
            });
         });

         // 댓글 수 갱신
         $(".postBox").each(function() {
            let postBox = $(this);
            let post_seq = postBox.data("seq");
            $.ajax({
               url : "/board/getCommentCount",
               data : {
                  post_seq : post_seq
               },
               type : "get"
            }).done(function(count) {
               postBox.find(".commentCount").text(count);
            });
         });
      });

      // 좋아요 버튼을 눌렀을 때,
      $(".postLikeBox").on("click", function(e) {
         e.stopPropagation(); // 상세페이지 이동 방지
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
                }).then((result) => {
                   if (result.isConfirmed) {
                     location.href = "/members/loginUi";
                   }
                });
               return;
            }

            if (likeCheck == 1 || likeCheck == 0) { // 하트를 누를때마다 css 적용
               postLike.toggleClass("active"); // active 클래스를 넣었다 뺐다 함 
               // 서버 처리가 성공하면 화면의 하트 색깔을 토글(변경)함.
               
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
      
      // 하단 네비게이션 바 구현
        $(document).ready(function(){
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
           let sort = "${sort}";
           navi.attr("href", "/board/food?sort=" + sort + "&cPage=" + i);
           navi.html(i + " ");
           
           if(i == currentPage) {
              navi.addClass("active");
           }
           
           $(".pageBox").append(navi);
        }
    }); 
   </script>
</body>
</html>