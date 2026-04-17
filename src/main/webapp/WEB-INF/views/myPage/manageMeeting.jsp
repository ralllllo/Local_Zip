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
	margin-bottom: 200px;
}

.top-section {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	z-index: 1000;
	border-bottom: 2px solid #A66A3F;
}

.mainTitle {
	font-weight: bold;
	font-size: 50px;
	color: #A66A3F;
}

.titleSection{
	display:flex;
	width: 100%;
	border-bottom: 2px solid #A66A3F;
	background-color: #F2D3A2;
	height: 100px;
	line-height: 100px;
	padding: 0 20px;
}

.backBtnDiv{
    position: relative;
	left: 1484px;
	top: 18px;
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
.manageBtn:hover,
.acceptBtn:hover,
.rejectBtn:hover{
    transform: translateY(-3px); /* 살짝 위로 뜸 */
    box-shadow: 0 6px 15px rgba(0,0,0,0.3);
}

.meetingDetail:active,
.deleteBtn:active,
.outBtn:active,
.myMeetingBtn:active,
.manageBtn:active,
.acceptBtn:active,
.rejectBtn:active,
.backBtn:active{
    transform: translateY(2px); /* 아래로 눌림 */
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
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
	transform: translateY(-3px); /* 살짝 위로 뜸 */
    box-shadow: 0 6px 15px rgba(0,0,0,0.3);
    background-color: #fecc56;
 	color: #A66A3F;
}

.meetingDetail, .deleteBtn, .outBtn, .myMeetingBtn, .manageBtn, .acceptBtn, .rejectBtn {
    cursor: pointer;
	transition: all 0.2s ease;
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
	background-color: #E5D3B3;
}

.manageBtn{
 	background-color: #FFB300;
}

.emptyMeeting{
	font-weight: bold;
	font-size: large;
	text-align: center;
}

.meetingListDiv{
	margin-top: 230px;
	font-weight: 500;
	color: #5e361a;
}

.completeMeeting{
	font-weight: 500;
	color: #5e361a;
	margin-top: 20px;
}

.acceptBtn, .rejectBtn{
	color: #5e361a;
	width: 40%;
    height: 35px;
    border:none;
    border-radius: 10px;
    font-size: large;
    color: #f5f5f5;
}

.acceptBtn{
	margin-left: 155px;
	margin-right: 10px;
    background-color: #7BB8C9;
}

.rejectBtn{
    background-color: #FF000080;
}

.acceptedBtn, .rejectedBtn{
	color: #5e361a;
    height: 35px;
    border:none;
    border-radius: 10px;
    font-size: large;
    color: #f5f5f5;
    width: 80%;
    cursor: not-allowed;
}

.acceptedBtn{
	background-color: #7BB8C9;
	margin-left: 150px;
}

.rejectedBtn{
	background-color: #FF000080;
	margin-left: 150px;
}

.completeComments{
	font-weight: bold;
	font-size: large;
	text-align: center;
	background-color: #F2D3A2;
	margin-top: 50px;
	color: #5e361a;
	box-shadow: 0 6px 15px rgba(0,0,0,0.3);
}

.meeting-card, .completeMeeting-card{
	width: 80%;
	margin-left: 185px;
	padding-bottom: 20px;
	margin-top: 20px;
	border-radius: 10px;
	box-shadow: 0 6px 15px rgba(0,0,0,0.3);
}

.nickname, .com_nickname{
	margin-top: 5px;
	min-height: 50px;
	font-weight: bold;
	font-size: x-large;
	background-color: #F2D3A2;
	padding-left: 20px;
	padding-top: 20px;
}

.title, .com_title{
	min-height: 40px;
	font-weight: bold;
	font-size: large;
	padding-left: 20px;
	margin-top: 7px;
}

.info, .com_info{
	min-height: 40px;
	font-size: large;
	padding-left: 20px;
}

.btnDiv, .comBtnDiv{
	margin-top: 20px;
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

		<div class="meetingListDiv"></div>
		<div class="completeComments">처리 완료</div>
		<div class="completeMeeting"></div>
	</div>
	<div class="bottomBar">
		<a href="/"><i class="navicon fa-solid fa-house fa-2xl" style="color: #A66A3F"></i></a>
		<a href="/map/test"><i class="navicon fa-solid fa-map-location-dot fa-2xl" style="color: #A66A3F"></i></a>
		<a href="/meeting/list?category=all"><i class="navicon fa-solid fa-people-group fa-2xl" style="color: #A66A3F"></i></a>
		<a href="/feedback/feedbackHome"><i class="navicon fa-solid fa-bullhorn fa-2xl" style="color: #A66A3F"></i></a>
		<a href="/members/mypage"><i class="nowNavicon fa-solid fa-user fa-2xl"></i></a>
	</div>
	
	<script>
		$(document).on("click", ".myMeetingBtn", function(){
		    location.href = "/meeting/myMeeting";
		});
		
		// 승인 대기중인 리스트 출력
		$(function(){
		    $.ajax({
		        url:"/meetingMember/applyList",
		        dataType:"json"
		    }).done(function(resp){
				if(resp.length == 0){
					let emptyMeeting = $("<div>").addClass("emptyMeeting").text("승인 대기 중인 모임이 없습니다.");
					$(".meetingListDiv").append(emptyMeeting);
				}
		        for(let i of resp){
					
		            let meetingCard = $("<div>").addClass("meeting-card").attr("data-seq", i.meetmem_seq).attr("data-meet_seq", i.meet_seq);
		
		            let btnDiv = $("<div>").addClass("btnDiv");
		
		            let acceptBtn = $("<button>").attr("type","button").addClass("acceptBtn").text(" 승인");
		            let check = $("<i>").addClass("fa-solid fa-circle-check fa-lg").css({"color":"#f5f5f5"});
		            acceptBtn.prepend(check);
		
		            let rejectBtn = $("<button>").attr("type","button").addClass("rejectBtn").text(" 거절");
		            let xmark = $("<i>").addClass("fa-solid fa-circle-xmark fa-lg").css({"color":"#f5f5f5"});
		            rejectBtn.prepend(xmark);
		
		            btnDiv.append(acceptBtn, rejectBtn);
		
		            meetingCard.append(
		                $("<div>").addClass("nickname").text(i.mem_nickname),
		                $("<div>").addClass("title").text(i.meet_title),
		                $("<div>").addClass("info").text(i.meetmem_contents),
		                btnDiv
		            );
		
		            $(".meetingListDiv").append(meetingCard);
		        }
		    });
		});
		
		// 승인 버튼 클릭 시
		$(document).on("click", ".acceptBtn", function(){
			
			let card = $(this).closest(".meeting-card");
			let seq = card.data("seq");
			let meetSeq = card.data("meet_seq");
			
			Swal.fire({
		        icon: "question",
		        title: "Wait !",
		        text: "신청을 승인하시겠습니까?",
		        iconColor: "#FFB300",
		        confirmButtonColor: "#FFB300",
		        showCancelButton: true,
		        confirmButtonText: "승인",
		        cancelButtonText: "취소",
		        cancelButtonColor: "#d9d9d9"
		    }).then((result) => {

		        if(result.isConfirmed){
			    	
					$.ajax({
				        url:"/meetingMember/updateStatus",
				        data:{
				        	seq: seq,
				        	meet_seq: meetSeq,
				        	status: 1
				        }
				    }).done(function(){
				        	location.reload();
				    });
				}
		    });
		});
			
		// 거절 버튼 클릭 시
		$(document).on("click", ".rejectBtn", function(){
			
			let card = $(this).closest(".meeting-card");
			let seq = card.data("seq");
			let meetSeq = card.data("meet_seq");
			
			Swal.fire({
		        icon: "question",
		        title: "Wait !",
		        text: "신청을 거절하시겠습니까?",
		        iconColor: "#FFB300",
		        confirmButtonColor: "#FFB300",
		        showCancelButton: true,
		        confirmButtonText: "거절",
		        cancelButtonText: "취소",
		        cancelButtonColor: "#d9d9d9"
		    }).then((result) => {

		        if(result.isConfirmed){
			
				    $.ajax({
				        url:"/meetingMember/updateStatus",
				        data:{
				        	seq: seq,
				        	meet_seq: meetSeq,
				        	status: 2
				        }
				    }).done(function(){
				        location.reload();
				    });
				}
		    });
		});
		
		// 처리된 리스트 출력
		$(function(){
			
			$.ajax({
				url:"/meetingMember/completeList",
				type:"post",
				dataType:"json"
			}).done(function(resp){
				if(resp.length == 0){
					let emptyMeeting = $("<div>").addClass("emptyMeeting").text("처리 완료된 모임이 없습니다.");
					$(".completeMeeting").append(emptyMeeting);
				}
				for(let i of resp){
					let completeMeetingCard = $("<div>").addClass("completeMeeting-card")
					let comBtnDiv = $("<div>").addClass("comBtnDiv")
					
					if(i.meetmem_status == 1){
						let acceptedBtn = $("<button>").attr("type","button").addClass("acceptedBtn").html(" 승인됨");
						let check = $("<i>").addClass("fa-solid fa-circle-check fa-lg").css({"color":"#f5f5f5"});
						acceptedBtn.prepend(check);
						comBtnDiv.append(acceptedBtn);
					}else if(i.meetmem_status == 2){
						let rejectedBtn = $("<button>").attr("type","button").addClass("rejectedBtn").html(" 거절됨");
						let xmark = $("<i>").addClass("fa-solid fa-circle-xmark fa-lg").css({"color":"#f5f5f5"});
						rejectedBtn.prepend(xmark);
						comBtnDiv.append(rejectedBtn);
					}
					
					completeMeetingCard.append(
						$("<div>").addClass("com_nickname").text(i.mem_nickname),
						$("<div>").addClass("com_title").text(i.meet_title),
						$("<div>").addClass("com_info").text(i.meetmem_contents),
						comBtnDiv
					);
					
					$(".completeMeeting").append(completeMeetingCard);
				}
			});
		});
	</script>
</body>
</html>