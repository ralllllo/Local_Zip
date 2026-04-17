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
	min-width: 1000px; 
}

body{
	margin: 0 auto;
	overflow-x: auto;
}

button, body, div, input {
	font-family: 'GMarketSans', sans-serif;
}

.container {
	position : relative;
	z-index: 2;
	width: 100%;
	min-height: 100vh;
	min-width: 1000px; 
	background-color: #fbe5c0;
}

.headBox {
	width: 100%;
	height: 100px;
	padding-left: 20px;
	font-weight: bold;
	font-size: 50px;
	color: #A66A3F;
	background-color: #F2D3A2;
	border-bottom: 2px solid #A66A3F;
	line-height: 100px;
	z-index: 1000;
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

.writeDetail {
	margin: 50px auto;
	min-width: 900px;
	width: 900px;
	height: auto;
	border-radius: 10px;
	background-color: #fbe5c0;
	padding: 35px;
	margin-top: 50px;
	background-color: #F2D3A2;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

.titleDiv, .categoryDiv, .fileDiv, .locationDiv, .TextDiv {
	padding: 10px;
	border-bottom: 1px dotted #A66A3F;
}

.TextDetail {
	min-height: 300px;
	border: 1px solid #A66A3F;
	background-color: #fbe5c0;
	width: 100%;
	height: auto;
	top: 30px;
	left: 0;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	z-index: 10;
	font-family: 'GMarketSans';
	border-radius: 5px;
	color: #A66A3F;
	font-size: 15px;
	padding: 2px;
	outline: none;
	resize: none;
	white-space: pre-wrap;
}

.fileDetail {
	width: 70%;
	padding-left: 3px;
	border-radius: 8px;
}

.openChatLinkDiv, .openChatPwDiv {
	padding: 10px;
}

.TextTitle {
	font-weight: bold;
	font-size: 23px;
	color: #5e361a;
	border: none;
	padding-left: 2px;
}

.title, .category, .file, .location, .openChatLink, .openChatPw {
	font-weight: bold;
	font-size: 23px;
	color: #5e361a;
}

.inputLink, .inputPw {
	padding: 5px;
	background-color: #fbe5c0;
	border-radius: 10px;
	border: none;
	font-size: 15px;
	width: 400px;
	word-break: break-all;
	white-space: normal;
}

.openChatWrapper {
	display: flex;
	gap: 300px;
}

.openChatPwDiv {
	padding-left: 50px;
}

.bottomBtn {
	display: flex;
	justify-content: center;
	gap: 20px;
	margin-top: 20px;
	margin-bottom: 10px;
}

.requestBtn, .backBtn {
	cursor: pointer;
	transition: all 0.2s ease;
	width: 350px;
	height: 40px;
	background-color: #FFB300;
	border: none;
	border-radius: 10px;
	color: #5e361a;
	font-size: 17px;
	font-weight: bold;
	
}

.bottomBtn a {
	display: block;
}

.requestBtn:hover, .backBtn:hover {
    background-color: #fecc56;
  	color: #A66A3F;
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

.requestBtn:active, .backBtn:active {
	transform: translateY(2px);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.report {
	width: 200px;
	height: 32px;
	top: 30px;
	left: 0;
	width: 150px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	z-index: 10;
	font-family: 'GMarketSans';
	border: 1px solid #A66A3F;
	border-radius: 5px;
	background-color: #F2D3A2;
	color: #A66A3F;
	font-size: 15px;
	padding: 2px;
	outline: none;
}

.inputBox {
	border: 1px solid #A66A3F;
	background-color: #fbe5c0;
	width: 100%;
	height: 35px;
	top: 30px;
	left: 0;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	z-index: 10;
	font-family: 'GMarketSans';
	border-radius: 5px;
	color: #A66A3F;
	font-size: 15px;
	padding: 2px;
	outline: none;
}

.leftImg, .rightImg{
	position: absolute;
	width: 450px;
	height: 170px;
	z-index: -1;
	pointer-events: none;
	bottom: 0;
}

.leftImg{
    left: 0;
}

.rightImg{
	right: 0;
}

.swal2-icon.swal2-info .swal2-icon-content {
    font-size: 50px;
    transform: translateY(5px);
    line-height: 70px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="headBox">건의사항 작성</div>

		<form action="/feedback/feedbackInsert" method="post" class="frm" enctype="multipart/form-data">
			<div class="writeDetail">
				<div class="titleDiv">
					<div class="title">제목</div>
					<div class="titleContent">
						<input name="suggestion_title" class="inputBox" maxlength="100" type="text" style="border: #fbe5c0" placeholder="제목을 입력해주세요">
					</div>	
				</div>
	
				<div class="fileDiv">
					<div class="file">
						첨부파일 <i class="fa-solid fa-file-circle-plus fa-sm"></i>
					</div>
					<div class="fileDetail">
						<input class="fileBtn" type="file" name="files" accept="image/*" multiple>
					</div>
				</div>
	
				<div class="TextDiv">
					<div class="TextTitle">내용</div>
					<textarea id="contents" name="suggestion_contents" class="TextDetail" type="text" placeholder="내용을 작성해주세요" maxlength="1000" style="border: #fbe5c0"></textarea>
				</div>
	
			</div>
				<div class="bottomBtn">
					<button id="writeBtn" class="requestBtn" type="submit">작성 완료</button>
					<a href="/feedback/feedbackHome"><button class="backBtn" type="button">뒤로가기</button></a>
				</div>
		</form>
		<img class="leftImg" src="/resources/images/왼쪽 모서리 풀.png">
    	<img class="rightImg" src="/resources/images/오른쪽 모서리 풀.png">
	</div>
	<script>
		//파일이 비어있거나 잘못된 파일형식을 올렸을때 alert
		$(".fileBtn").on("change", function() {
	    let file = this.files[0];	

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
		// 제목, 내용 빈칸 일시, alert 띄움
		$(".frm").on("submit", function(e){
			e.preventDefault(); // 기본 제출 막기
			
			if($(".inputBox").val() == "") {
				Swal.fire({
					icon: "info",
					title: "Wait  !",
					text: "제목을 입력해주세요",
					iconColor: "#FFB300",
					confirmButtonColor: "#FFB300"
				});
				$(".inputBox").focus();
				return false;
			}
			else if($(".TextDetail").val() == "") {
				Swal.fire({
					icon: "info",
					title: "Wait  !",
					text: "내용을 입력해주세요",
					iconColor: "#FFB300",
					confirmButtonColor: "#FFB300"
				});
				$(".TextDetail").focus();
				return false;
			}
			Swal.fire({
				icon: "success",
				title: "Success  !",
				text: "글이 등록되었습니다.",
				iconColor: "#FFB300",
				confirmButtonColor: "#FFB300"
			}).then(() => {
				$(".frm")[0].submit();
			});
		});
	</script>

</body>
</html>