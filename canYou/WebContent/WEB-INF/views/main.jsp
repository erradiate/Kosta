<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="resources/js/myplugin.js"></script>

<style>
.subject {
	color: black;
	font-size: 18px;
	line-height: 4em;
	font-weight: bold;
}

.proimg {
	margin: 5px 35px 10px 70px;
	width: 180px;
	height: 140px;
}

div.scrollmenu {
	background-color: white;
	overflow: auto;
	white-space: nowrap;
	width: 1200px;
}

div.scrollmenu a {
	display: inline-block;
	color: black;
	text-align: center;
	padding: 14px;
	text-decoration: none;
}

div.scrollmenu a:hover {
	background-color: #777;
}

</style>

<div>
	<img src="resources/images/1.jpg" id="g"
		style="margin: 0px 30px 30px 0px; width: 100%; height: 550px;">
</div>
<nav style="margin: 0 auto; padding:0% 5% 0% 5%;
width: 80%;">
<table>
	<thead>
		<tr>
			<div class="subject">인기 프로젝트</div>
		</tr>
		<tr>
			<div class="scrollmenu">
				<c:forEach var="plist" items="${plist}">
				<a href="story?projectNo=${plist.projectNo}">
					<img src="resources/images/${plist.projectMainImage}" class="proimg"></a>
				</c:forEach>
			</div>
		</tr>

		<tr>
			<div class="subject">새로운 프로젝트</div>
		</tr>
		<tr>
			<div class="scrollmenu">
				<c:forEach var="nlist" items="${nlist}">
				<a href="story?projectNo=${nlist.projectNo}">
					<img src="resources/images/${nlist.projectMainImage}" class="proimg"></a>
				</c:forEach> 
			</div>
		</tr>

		<tr>
			<div class="subject">마감 임박 프로젝트</div>
		</tr>
		<tr>
			<div class="scrollmenu">
				<c:forEach var="dlist" items="${dlist}">
				<a href="story?projectNo=${dlist.projectNo}">
					<img src="resources/images/${dlist.projectMainImage}" class="proimg"></a>
				</c:forEach>
			</div>
		</tr>
	</thead>
</table>
</nav>

<div style="float: left; width: 50%">
	<img src="resources/images/11.jpg"
		style="margin: 80px 30px 30px 180px; width: 600px; height: 160px;">
</div>
<div style="float: right; width: 50%">
	<img src="resources/images/22.jpg" class="rightimg"
		style="margin: 80px 30px 30px 180px; width: 600px; height: 160px;">
</div>

<script>

$(document).ready(function(){
	$('#g').myPluginFn();
})

</script>