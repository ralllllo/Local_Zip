<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리동네.zip</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
	integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2ad57018f836bb74c10d919e862f189a&libraries=clusterer"></script>
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
	min-height: 100vh;
}

.top-section {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	background-color: #fbe5c0;
	z-index: 1000;
	border-bottom: 2px solid #A66A3F;
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
	margin-left: 10px;
	background-color: #FFB300;
	border-radius: 10px;
	border: 1px solid #FFB300;
	color: #3e5e40;
	height: 30px;
	padding: 0 15px;
	cursor: pointer;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	transition: all 0.2s ease;
}

.nowNavicon {
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	color: #e6a83e;
}

.categoryBtnAll:hover, .navicon:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	background-color: #fecc56;
	color: #A66A3F;
}

.categoryBtnAll:active, .navicon:active {
	transform: translateY(2px);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.categoryBtnAll:first-child {
	margin-left: 25px;
}

.nowBtn {
	background-color: #fecc56;
	color: #A66A3F;
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
	height: 30px;
	border-radius: 10px; /
	border: 1px solid #FFB300;
	align-items: center;
	vertical-align: middle;
	cursor: pointer;
	transition: 0.3s;
}

.categoryBtnAll:active {
	transform: translateY(2px);
}

.mapDiv {
	border: 1px solid #A66A3F;
	margin: 15px auto;
	width: 90%;
	max-width: 1800px;
	height: 380px;
	background-color: #fff;
	display: flex;
	align-items: center;
	justify-content: center;
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
}

.facilityDiv {
	width: 91%;
	max-width: 1800px;
	margin: 0 auto;
	padding-top: 565px;
	padding-bottom: 80px;
}

.facilityAll {
	border: 1px solid #A66A3F;
	margin-left: 14px;
	width: 200px;
	height: 40px;
	margin-top: 20px;
	line-height: 45px;
	padding-left: 10px;
	background-color: #F2D3A2;
	box-sizing: border-box;
	border-radius: 10px;
	border: none;
	color: #5e361a;
}

.facility {
	border: 2px solid #C29F6D90;
	margin: 14px 0 0 14px;
	width: 98%;
	padding: 12px;
	line-height: 1.9;
	background-color: #fbe5c0;
	color: #5e361a;
	box-sizing: border-box;
	border-radius: 10px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
}

.bottomBar {
	gap: 200px;
}

.mapDiv {
	position: relative;
}

.legendBox {
	position: absolute;
	top: 138px;
	left: 30px;
	z-index: 20;
	background-color: rgba(255, 255, 255, 0.95);
	border: 2px solid #A66A3F;
	border-radius: 10px;
	padding: 10px 14px;
	font-size: 14px;
	line-height: 1.8;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
}

.legendItem {
	display: flex;
	align-items: center;
	gap: 8px;
}

.legendDot {
	width: 14px;
	height: 14px;
	border-radius: 50%;
	display: inline-block;
	border: 2px solid white;
	box-shadow: 0 0 4px rgba(0, 0, 0, 0.25);
}

.legendToliet {
	background-color: rgba(255, 120, 219, 1.00);
}

.legendShelter {
	background-color: rgba(3, 192, 0, 1.00);
}

.legendPolice {
	background-color: rgba(133, 161, 249, 1.00);
}

.infoMent {
	color: #286708;
	margin-left: 5px;
}
</style>
</head>

<body>

	<div class="container">
		<div class="top-section">
			<div class="mainTitle">우리 동네 지도.zip</div>
			<div class="categoryDiv">
				<button class="categoryBtnAll">
					<i class="fa-solid fa-house fa-lg"></i> 전체
				</button>
				<button class="categoryBtnAll">
					<i class="fa-solid fa-shield-halved fa-lg"></i> 치안
				</button>
				<button class="categoryBtnAll">
					<i class="fa-solid fa-person-running fa-lg"></i> 대피소
				</button>
				<button class="categoryBtnAll">
					<i class="fa-solid fa-restroom fa-lg"></i> 공중화장실
				</button>
				<div class="infoMent">** 시설 정보 로딩 시간이 필요합니다. 잠시만 기다려주세요 🙏</div>
			</div>

			<div class="mapDiv" id="map">
				<div class="legendBox">
					<div class="legendItem">
						<span class="legendDot legendToliet"></span> 화장실
					</div>
					<div class="legendItem">
						<span class="legendDot legendShelter"></span> 대피소
					</div>
					<div class="legendItem">
						<span class="legendDot legendPolice"></span> 치안
					</div>
				</div>
			</div>
		</div>

		<div class="facilityDiv">
			<div class="facilityAll">
				주변 시설 (<span id="facilityCount">0</span>)
			</div>
			<div id="facilityList"></div>
		</div>


		<div class="bottomBar">
			<a href="/"><i class="navicon fa-solid fa-house fa-2xl" style="color: #A66A3F"></i></a> <a href="/map/test"><i
				class="nowNavicon fa-solid fa-map-location-dot fa-2xl"></i></a> <a href="/meeting/list?category=all"><i
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
			
		    let mapContainer = document.getElementById("map");
		    let mapOption = {
		        center: new kakao.maps.LatLng(37.5665, 126.9780),
		        level: 5
		    };
		
		    let map = new kakao.maps.Map(mapContainer, mapOption);
		
		    let markers = [];
		    let allFacilities = [];
		    
		    let infoWindow = new kakao.maps.InfoWindow({
		        removable: true
		    });
		    
		    let clusterer = new kakao.maps.MarkerClusterer({
		    	map : map,
		    	averageCenter : true,
		    	minLevel : 6
		    })
		    
		    function clearMarkers() {
		        for (let marker of markers) {
		            marker.setMap(null);
		        }
		        markers = [];
		    }
			
		    
		    
		    function renderFacilities(type = "전체") {
		        clearMarkers();
		        clusterer.clear();
		        $("#facilityList").empty();
		
		        let filtered = allFacilities;
		
		        if (type !== "전체") {
		            filtered = allFacilities.filter(item => item.fac_type === type);
		        }
		        
		        filtered = filtered.filter(dto =>
		        	dto.fac_lat && dto.fac_lng && dto.fac_address && dto.fac_address.trim() !== ""		
		        );
			
		        $("#facilityCount").text(filtered.length);
		        let bounds = new kakao.maps.LatLngBounds();
		
		        for (let dto of filtered) {
		            let lat = dto.fac_lat;
		            let lng = dto.fac_lng;
		            let address = dto.fac_address;
			
		            if(!lat || !lng || !address || !address.trim() === "") continue;
		            
		            let markerPosition = new kakao.maps.LatLng(lat, lng);
		            let markerImage = getMarkerImage(dto.fac_type);
		            
		            let marker = new kakao.maps.Marker({
		                position: markerPosition,
		                image: markerImage
		            });
		            
		            marker.dto = dto;
		
		            markers.push(marker);
		            bounds.extend(markerPosition);
		            
		            $("#facilityList").append(
		            	    "<div class='facility'>"
		            	    + dto.fac_name + "<br>"
		            	    + dto.fac_address + "<br>"
		            	    + dto.fac_type
		            	    + "</div>"
		            	);
		            
		            let infoContent =
		                '<div style="padding:10px; font-size:13px; line-height:1.6; color:#222; display:inline-block; white-space:nowrap; z-index:20">'
		                + '<div style="font-weight:bold; margin-bottom:4px;">' + dto.fac_name + '</div>'
		                + '<div>구분 : ' + dto.fac_type + '</div>'
		                + '<div>주소 : ' + dto.fac_address + '</div>'
		                + '</div>';

		            kakao.maps.event.addListener(marker, "click", function () {
		                infoWindow.setContent(infoContent);
		                infoWindow.open(map, marker);
		            });
		        }
		        clusterer.addMarkers(markers);
		
		        if(filtered.length > 0){
		        	map.setBounds(bounds);
		        }
		    }
		
		    $(function () {
		        $.ajax({
		            url: "/map/getFacilities",
		            type: "get"
		        }).done(function (resp) {
		        	
		            allFacilities = resp;
		            renderFacilities("전체");
		        }).fail(function () {
		            alert("시설 데이터를 불러오지 못했습니다.");
		        });
		        
		        $(".categoryDiv").on("click", ".categoryBtnAll", function() {
		            // 1. 모든 버튼에서 활성화 클래스 제거
		            $(".categoryBtnAll").removeClass("nowBtn");
		            
		            // 2. 현재 클릭한 버튼에 활성화 클래스 추가
		            $(this).addClass("nowBtn");
		            
		            // 3. 버튼 텍스트나 인덱스에 따라 시설 렌더링
		            let btnText = $(this).text().trim();
		            
		            if (btnText.includes("전체")) {
		                renderFacilities("전체");
		            } else if (btnText.includes("치안")) {
		                renderFacilities("치안시설");
		            } else if (btnText.includes("대피소")) {
		                renderFacilities("대피소");
		            } else if (btnText.includes("공중화장실")) {
		                renderFacilities("공중화장실");
		            }
		        });
		    });
		    
		    function getMarkerImage(fac_type) {
		        let imageSrc = "";
		        
		        if (fac_type === "치안시설") {
		            imageSrc = "/resources/images/location-dot-solid_2.png";
		        } else if (fac_type === "대피소") {
		            imageSrc = "/resources/images/location-dot-solid_Shelter.png";
		        } else if (fac_type === "공중화장실") {
		            imageSrc = "/resources/images/location-dot-solid_Toliet.png";
		        }

		        if (!imageSrc) return null;

		        let imageSize = new kakao.maps.Size(36, 40);
		        let imageOption = { offset: new kakao.maps.Point(18, 40) };

		        return new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
		    }
	</script>
</body>
</html>