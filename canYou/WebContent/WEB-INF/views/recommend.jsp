<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<script src="resources/js/myplugin.js"></script>
<style>
.subject {
	color: black;
	font-size: 18px;
	line-height: 4em;
	font-weight: bold;
}

.proimg {
	margin: 5px 35px 10px 0px;
	width: 400px;
	height: 250px;
}

ul {
	list-style: none;
}

.slider {
	width: 100%;
	height: 285px;
	margin: 0 auto;
	position: relative;
	overflow: hidden;
	display: inline;
	float: left;
}

.slider .panel {
	width: 100%;
	height: 100%;
	position: relative;
}

.slider .panel li {
	top: 0px;
	left: 0px;
	display: none;
}

.prev {
	width: 10px;
	height: 10px;
	margin-top: -15px;
	border: 2px solid #ffffff;
	border-top: 30px solid #ffffff;
	border-bottom: 30px solid #ffffff;
	border-right: 25px solid #dcdcdc;
	background-color: #ffffff;
}

.next {
	width: 10px;
	height: 10px;
	margin-top: -15px;
	border: 2px solid #ffffff;
	border-top: 30px solid #ffffff;
	border-bottom: 30px solid #ffffff;
	border-left: 25px solid #dcdcdc;
	background-color: #ffffff;
}

.imge {
	text-align: center;
}
</style>
<table>
	<tr>
		<td colspan="3">
			<div class="subject">관심별 프로젝트</div>
		</td>
	</tr>

	<tr>
		<td>
			<button class="prev"></button>
		</td>
		<c:set var="i" value="0" />
		<td>
			<div class="slider">
				<ul id="panel1" class="panel">
					<c:forEach var="plist" items="${listByCategory}">
						<c:if test="${i%4==0}">
							<c:set var="j" value="${i+3}" />
							<c:if test="${i==0}">
								<li class="on">
									<div
										style="white-space: nowrap; display: flex; justify-content: space-between;">
							</c:if>
							<c:if test="${i!=0}">
								<li>
									<div
										style="white-space: nowrap; display: flex; justify-content: space-between;">
							</c:if>
						</c:if>
						<div class="imge">
							<a href="story?projectNo=${plist.projectNo}"> <img
								src="resources/images/${plist.projectMainImage}" class="proimg"
								align="middle" style="display: block;"> <span>${plist.projectName}</span>
							</a>
						</div>
						<c:if test="${i==j}">
			</div>
			</li> </c:if> <c:set var="i" value="${i+1}" /> </c:forEach>
			</ul>
			</div>
		</td>

		<td>
			<button class="next"></button>
		</td>
	</tr>
</table>

<script>
	$(document).ready(
			function() {
				$('#g').myPluginFn();
				var i = $(".panel li .on").index() + 1;

				console.log(i);
				console.log($("#panel1 li").length);

				//좌우 버튼 연동 //
				showSlide();

				$(".prev").click(
						function() {
							if ($(this).parent().next().children('div')
									.children('ul').attr('id') === "panel1") {
								console.log('맞다');
								if (i == 0) {
									i = $("#panel1 li").length - 1;
								} else {
									i = i - 1;
								}
								showSlide();
							}

						});

				$(".next").click(
						function() {
							if ($(this).parent().prev().children('div')
									.children('ul').attr('id') === "panel1") {
								if (i == $("#panel1 li").length - 1) {
									i = 0;
								} else {
									i = i + 1;
								}
								showSlide();
							}

						});

				function showSlide() {
					$("#panel1 li").stop(true, true).fadeOut();
					$("#panel1 li").eq(i).stop(true, true).fadeIn();
				}

			});
</script>
