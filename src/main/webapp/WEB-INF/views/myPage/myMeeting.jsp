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
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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

.top-section {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	z-index: 1000;
	border-bottom: 2px solid #A66A3F;
}

.container {
   width: 100%;
   display: grid;
   grid-template-columns:repeat(4, 1fr);
   gap:20px;
   padding: 200px 0 0 0;
   box-sizing: border-box;
   margin-bottom: 200px;
}

.meeting-card {
    width: 300px;
	border: 2px solid #C29F6D90;
    border-radius: 10px;
    background-color: #fbe5c0;
    padding: 35px;
    margin: 20px 0 20px 50px;
	box-shadow: 0 2px 5px rgba(0,0,0,0.3);
}
		
.titleSection{
	display: flex;
	padding-left: 20px;
	font-weight: bold;
	color: #A66A3F;
	border-bottom: 2px solid #A66A3F;
	height: 100px;
	line-height: 100px;
	background-color: #F2D3A2;
	justify-content: space-between; 
    align-items: center;
    padding: 0 20px;
}

.mainTitle {
	font-weight: bold;
	font-size: 50px;
	color: #A66A3F;
}

.backBtnDiv{
 	position: relative;
	top: 20px;
	right : 20px;
}

.bottomBar{
    border: 2px solid #A66A3F;
    background-color: #F2D3A2;
    position: fixed;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 60px;
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
    gap: 200px;
}
	  
 .meetingDetail:hover,
 .deleteBtn:hover,
 .outBtn:hover,
 .myMeetingBtn:hover,
 .manageBtn:hover{
     transform: translateY(-3px);
     box-shadow: 0 6px 15px rgba(0,0,0,0.3);
}
	
 .meetingDetail:active,
 .deleteBtn:active,
 .outBtn:active,
 .myMeetingBtn:active,
 .manageBtn:active,
 .backBtn:active{
     transform: translateY(2px);
     box-shadow: 0 2px 5px rgba(0,0,0,0.2);
}

.meetingDetail, .deleteBtn, .outBtn, .myMeetingBtn, .manageBtn {
	cursor: pointer;
	transition: all 0.2s ease;
}

.card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: bold;
    font-size:20px;
    color: #5e361a;
}

.category, .isLeader {
    display: inline-block;
    line-height : 23px;
    font-size: 12px;
    padding: 3px 8px;
    border-radius: 5px;
    margin-top: 18px;
    margin-bottom: 10px;
    background-color: #FFB300;
    height: 20px;
    color: #286708;
}

.isLeader{
	background-color: #7BB8C9;
	color: #5e361a;
}

.info {
    font-size: 13px;
    color: #555;
    margin-bottom: 20px;
    color: #5e361a;
}

.category {
    display: inline-block;
    line-height : 23px;
    font-size: 12px;
    padding: 3px 8px;
    border-radius: 5px;
    margin-top: 18px;
    margin-bottom: 10px;
    background-color: #FFB300;
    height: 20px;
    color: #286708;
    max-width:120px;
    white-space:nowrap;
    overflow:hidden;
    text-overflow:ellipsis;
}

.desc {
    margin-bottom: 10px;
    color: #5e361a;
   	overflow:hidden;
   	white-space:nowrap;
    overflow:hidden;
    text-overflow:ellipsis;
}

.category-row {
    display:flex;
    align-items:center;
    gap:8px;
    margin-bottom:10px;
}

.card-footer {
    display:flex;
    gap: 8px;
    color: #5e361a;
    font-weight: bold;
    margin-left: 5px;
}

.meetingDetail {
    width: 47%;
    height: 30px;
    background-color: #FFB300;
    border:none;
    border-radius: 10px;
    color: #5e361a;
}

.deleteBtn{
	width: 47%;
    height: 30px;
    background-color: #8B4F1D;
    border:none;
    border-radius: 10px;
    color: #f5f5f5;
}

.outBtn{
	width: 47%;
    height: 30px;
    background-color: #8B4F1D;
    border:none;
    border-radius: 10px;
    color: #f5f5f5;
}

.tagDiv{
	display: flex;
	gap: 7px;
}

.manageMeeting{
	display: flex;
	gap: 20px;
	align-items: center;
	background-color: #fbe5c0;
}

.myMeetingBtn, .manageBtn{
	width: 48%;
    height: 70px;
    border: none;
    color: #5e361a;
    font-weight: bold;
    font-size: x-large;
    border-radius: 10px;
    margin-top: 10px;
	margin-bottom: 10px;
	color: #5e361a;
}

.myMeetingBtn{
	margin-left: 30px;
	background-color: #FFB300;
}

.manageBtn{
 	background-color: #E5D3B3;
}

.backBtn{
	background-color: #ffb300;
	color: #5e361a;
	border: 1px solid #ffb300;
	border-radius: 10px;
	font-weight: bold;
	height: 30px;
	cursor: pointer;
	transition: all 0.3s ease;
}

.backBtn:hover{
	transform: translateY(-3px);
    box-shadow: 0 6px 15px rgba(0,0,0,0.3);
    background-color: #fecc56;
	color: #A66A3F;
}

.emptyMeeting{
	width: 100%;
	height: 600px;
	font-weight: bold;
	font-size: large;
	margin-left: 630px;
	text-align: center;
	color: #5e361a;
}

.title{
    max-width:280px;
    white-space:nowrap;
    overflow:hidden;
    text-overflow:ellipsis;
}
.swal2-icon.swal2-question .swal2-icon-content {
    font-size: 50px;
    transform: translateY(5px);
    line-height: 70px;
}

.navicon:hover {
   transform: translateY(-3px);
   box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

.navicon:active {
   transform: translateY(2px);
   box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
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
		<div class="top-section">
			<div class="titleSection">
				<div class="mainTitle">내 모임.zip</div>
				<div class="backBtnDiv">
					<a href="/members/mypage"><input class="backBtn" type="button" value="내.zip으로 가기"></a>
				</div>
			</div>
			<div class="manageMeeting">
				<input class="myMeetingBtn" type="button" value="참여 중인 모임">
				<input class="manageBtn" type="button" value="신청 관리">
			</div>
		</div>
	</div>
	<div class="bottomBar">
		<a href="/"><i class="navicon fa-solid fa-house fa-2xl" style="color: #A66A3F"></i></a>
		<a href="/map/test"><i class="navicon fa-solid fa-map-location-dot fa-2xl" style="color: #A66A3F"></i></a>
		<a href="/meeting/list?category=all"><i class="navicon fa-solid fa-people-group fa-2xl" style="color: #A66A3F"></i></a>
		<a href="/feedback/feedbackHome"><i class="navicon fa-solid fa-bullhorn fa-2xl" style="color: #A66A3F"></i></a>
		<a href="/members/mypage"><i class="nowNavicon fa-solid fa-user fa-2xl"></i></a>
	</div>
		
	<script>
			let loginId = "${loginId}";
			$(function(){
				$.ajax({
					url:"/meeting/myMeetingList",
					dataType:"json"
				}).done(function(resp){
					if(resp.length == 0){
						let emptyMeeting = $("<div>").addClass("emptyMeeting").text("참여 중인 모임이 없습니다.");
						$(".container").append(emptyMeeting);
					}
					for(let i of resp){
						let meetingCard = $("<div>").addClass("meeting-card").attr("data-seq", i.meet_seq);
						let cardHeader = $("<div>").addClass("card-header")
						let title = $("<div>").addClass("title").text(i.meet_title);
						cardHeader.append(title);
						meetingCard.append(cardHeader);
						
						let tagDiv = $("<div>").addClass("tagDiv");
						let category = $("<div>").addClass("category").text(i.meet_category);
						tagDiv.append(category);
						if(i.mem_id == loginId){
							let isLeader = $("<div>").addClass("isLeader").text("관리자");
							let leaderIcon = $("<i>").addClass("fa-solid fa-crown").css({"color":"rgb(255, 212, 59)"});
							isLeader.prepend(leaderIcon);
							tagDiv.append(isLeader);
						}
						
						let desc = $("<div>").addClass("desc").text(i.meet_introcontents);
						let info = $("<div>").addClass("info");
						let location = $("<div>").addClass("location").text("📍 "+i.mem_address1);
						let count = $("<div>").addClass("count").text("👥 정원 "+i.meet_maxpeople+"명");
						info.append(location, count);
						
						let cardFooter = $("<div>").addClass("card-footer");
						let meetingDetail = $("<button>").attr("type","button").addClass("meetingDetail").text("자세히 보기");
						cardFooter.append(meetingDetail);
						
						if(i.mem_id == loginId){
							let deleteBtn = $("<button>").attr("type","button").addClass("deleteBtn").text("모임 삭제");
							cardFooter.append(deleteBtn);
						}else {
							let outBtn = $("<button>").attr("type","button").addClass("outBtn").text("모임 탈퇴");
							cardFooter.append(outBtn);
						}
						meetingCard.append(tagDiv, desc, info, cardFooter)
						$(".container").append(meetingCard);
					}
				});
			});
			
			// 자세히 보기 클릭 시
			$(document).on("click", ".meetingDetail", function(){
		
			    let seq = $(this).closest(".meeting-card").data("seq");
		
			    location.href = "/meeting/myMeetingDetail?seq=" + seq;
			});
			
			// 신청 관리 탭 클릭 시
			$(document).on("click", ".manageBtn", function(){
				location.href = "/meeting/manageMeeting";
			})
			
			// 모임 삭제 버튼 클릭 시
			$(document).on("click",".deleteBtn",function(){
				let seq = $(this).closest(".meeting-card").data("seq");
				
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
							url:"/meeting/deleteMeeting",
							data:{seq: seq}
						}).done(function(resp){
							if(Number(resp) == -1){
								Swal.fire({
									 icon: "error",
				                     title: "Fail !",
							        text: "신고된 모임은 삭제할 수 없습니다.",
							        confirmButtonColor: "#FFB300"
						        });
								return;
							}
							
							if(Number(resp) == 1){
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
			
			// 모임 탈퇴 버튼 클릭 시
			$(document).on("click",".outBtn",function(){
				let seq = $(this).closest(".meeting-card").data("seq");
				
				 Swal.fire({
				        icon: "question",
				        title: "Wait  !",
				        text: "정말 탈퇴하시겠습니까? 탈퇴 시 되돌릴 수 없습니다.",
				        iconColor: "#FFB300",
				        confirmButtonColor: "#FFB300",
				        showCancelButton: true,
				        confirmButtonText: "탈퇴",
				        cancelButtonText: "취소",
				        cancelButtonColor: "#d9d9d9"
				    }).then((result) => {

				        if(result.isConfirmed){
							$.ajax({
								url:"/meetingMember/outMeeting",
								data:{seq: seq}
							}).done(function(){
								
								Swal.fire({
				                    icon: "success",
				                    title: "Success  !",
				                    text: "탈퇴되었습니다.",
				                    timer: 1200,
				                    iconColor: "#FFB300",
				                    showConfirmButton: false
				                }).then(() => location.reload());
							});
				        }
					});
				});
	</script>
</body>
</html>