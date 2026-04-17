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
	top: 100px;
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
	padding-left: 20px;
	font-weight: bold;
	font-size: 50px;
	color: #A66A3F;
	background-color: #F2D3A2;
	border-bottom: 2px solid #A66A3F;
	z-index: 1000;
	display: flex;
	align-items: center;
	gap: 15px;
	justify-content: space-between;
}

.myLikeIcon {
	width: 60px;
	height: 60px;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-top: 5px;
}

.icon {
	width: 60px;
	height: 60px;
	object-fit: contain; /* 이미지 비율 유지 */
	color: #FFB300;
}

.mainTitle {
	margin-right: auto;
	display: flex;
	align-items: center;
}

.leftGroup {
	display: flex;
	align-items: center;
	gap: 15px;
	height: 100%;
}

.backBtn {
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
	height: 30px;
	position: relative;
	top: 10px;
	right: 45px;
	cursor: pointer;
	transition: all 0.3s ease;
}

.backBtn:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #fecc56;
	color: #A66A3F;
}

.backBtn:active{
	transform: translateY(2px);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
	background-color: #ffb300;
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
	margin-top: 50px;
	color: #5e361a;
}

.orderNew {
	display: none;
}

.postBox {
	width: 95%;
	max-width: 1500px;
	min-height: 200px;
	height: auto;
	margin: auto;
	margin-top: 30px;
	border-radius: 10px;
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
}

.postInfoUp, .postInfoDown {
	display: flex;
}

.profileInfo {
	width: auto;
	margin-right: 15px;
	display: flex;
	align-items: center;
	font-size: 14px;
	color: #333;
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

hr {
	width: 97%;
	margin-bottom: 40px;
	border: 1px solid #cdaa69;
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

.writeBtn {
	width: 50px;
	height: 50px;
	right: 30px;
	bottom: 90px;
	cursor: pointer;
	margin-top: 90%;
	border-radius: 50%;
	background-color: #A66A3F;
	border: #fbe5c0;
	color: #fbe5c0;
	font-size: 30px;
	position: fixed;
	align-items: center;
	display: flex;
	justify-content: center;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	transition: all 0.2s ease;
}

.writeBtn:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

.emptyBox {
	width: 100%;
	height: 600px;
	padding: 50px 0;
	font-size: 25px;
	color: #5e361a;
	text-align: center;
}

.swal2-icon.swal2-warning .swal2-icon-content {
	font-size: 50px;
	transform: translateY(5px);
	line-height: 70px;
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
			<div class="leftGroup">
				<div class="myLikeIcon">
					<img src="/resources/images/titleLove.png" class="icon">
				</div>
				<div class="mainTitle">관심 게시글.zip</div>
			</div>
			<div class="backBtnDiv">
				<a href="/members/mypage"> <input class="backBtn" type="button" value="내.zip으로 가기">
				</a>
			</div>
		</div>

		<c:choose>
			<c:when test="${empty likeList}">

				<div class="emptyBox">관심 게시글이 없습니다.</div>

			</c:when>

			<c:otherwise>
				<div class="bodyBox">

					<c:forEach var="i" items="${likeList}">
						<div class="postBox" data-seq="${i.post_seq}" data-writer="${i.mem_id}" data-category="${i.post_category}">

							<div class="postUpBox">

								<div class="postProfile">
									<img class="contentProfile" src="/resources/images/Profile.png" width="60px">
								</div>

								<div class="postInfoBox">
									<div class="postInfoUp">
										<div class="profileName profileInfo" style="color: #5e361a;">${i.mem_nickname}</div>
										<div class="profileLocal profileInfo" style="color: #5e361a;">${i.mem_dong}</div>
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
										<div class="profileTime profileInfo" style="color: #5e361a;">${i.post_date}</div>
									</div>
								</div>

							</div>

							<div class="postMidBox">

								<div class="postTitle">${i.post_title}</div>
								<div class="postContent">${i.post_contents}</div>

							</div>

							<c:if test="${loginId != null}">
								<div class="postDownBox">

									<div class="postLikeBox ${i.post_like_check == 1 ? 'active' : ''}">
										<i class="fa-regular fa-heart fa-xl beforeHeart"></i> <i class="fa-solid fa-heart fa-xl afterHeart"></i>

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

					<div class="pageBox">
						<span class="page"></span>
					</div>

			</c:otherwise>
		</c:choose>

		<div class="bottomBox">
			<a href="/"><i class="navicon fa-solid fa-house fa-2xl" style="color: #A66A3F"></i></a>
			<a href="/map/test"><i class="navicon fa-solid fa-map-location-dot fa-2xl" style="color: #A66A3F"></i></a>
			<a href="/meeting/list?category=all"><i class="navicon fa-solid fa-people-group fa-2xl" style="color: #A66A3F"></i></a>
			<a href="/feedback/feedbackHome"><i class="navicon fa-solid fa-bullhorn fa-2xl" style="color: #A66A3F"></i></a>
			<a href="/members/mypage"><i class="nowNavicon fa-solid fa-user fa-2xl"></i></a>
		</div>

	</div>


	<script>

		$(function() {
			// 1. 게시글 상세 페이지 이동 (통합 제어)		
			
			// 게시글 목록을 눌렀을때, => postDetail.jsp 이동 시.
			$(document).on("click", ".postBox", function(e) {
			    let post_seq = $(this).data("seq");
			    let post_category = $(this).data("category");
			    location.href = "/board/postDetail?post_seq=" + post_seq + "&category=" + post_category + "&cPage=${cPage}&from=myLikes";
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
		   prev.attr("href","/members/myLikes?cPage="+(startNavi-1)); 
		   prev.html("<< ");
		   $(".page").append(prev);
		}
		      
		for(let i = startNavi; i <= endNavi; i++) {
		  let navi = $("<a>");
		  navi.attr("href", "/members/myLikes?cPage="+i);
		  navi.html(i + " ");
		  $(".page").append(navi);
		      
		  if (i === currentPage) {
		       navi.addClass("active");
		   }
		}
		
		if(needNext) {
		   let next = $("<a>");
		   next.attr("href", "/members/myLikes?cPage="+(endNavi+1));
		   next.html(" >>");
		   $(".page").append(next);
		}
		
	</script>

</body>
</html>