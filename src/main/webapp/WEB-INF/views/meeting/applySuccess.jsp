<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리동네.zip</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="icon" type="image/png" sizes="512x512" href="/resources/images/pavicon.png">
<style>
.my-swal {
    width: 420px !important;   /* 박스 크기 고정 */
    padding: 15px !important;
}

.my-swal .swal2-title {
   	font-size: 22px;
   	margin: 5px 0;
}

.my-swal .swal2-html-container {
   	font-size: 16px;
   	margin: 5px 0;
}

.my-swal .swal2-actions{
	margin-top: 10px;
}

.my-swal .swal2-icon {
    width: 80px !important;
    height: 80px !important;
    margin: 10px auto;
}

.my-swal .swal2-confirm{
	padding: 8px 18px !important;
}
</style>
</head>
<body>

	<script>
		Swal.fire({
			icon: "success",
			title: "Success  !",
			text: "신청되었습니다.",
			iconColor: "#FFB300",
			confirmButtonColor: "#FFB300",
			customClass: {
	            popup: 'my-swal'
	        }
		}).then(() => {
			window.opener.location.href="/meeting/list?category=all";
			window.close();
		});
	</script>

</body>
</html>