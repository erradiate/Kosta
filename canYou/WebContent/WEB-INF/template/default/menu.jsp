<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.menubar li {
	background: #000000;
	font-size: 25px;
}

.menubar li ul {
	background: #000000;
	display: none;
	height: auto;
	padding: 0px;
	margin: 0px;
	border: 0px;
	position: absolute;
	width: 150px;
	z-index: 200;
	height: 340px;
}

.menubar li:hover ul {
	display: block;
}

.listy{
	position: absolute;
	left : 1800px;
}

#listy2{
	position: absolute;
	left : 1700px;
}

#cashStyle{
	position: absolute; left : 1630px; font-size: 16px; font-weight: bold;
	margin-top: 10px;
}

</style>

<div class="menubar">
	<ul>
		<!-- <li><a href="./">Home</a></li> -->
		<!-- 세션이 있으면 :로그아웃, 세션이 없으면 : 로그인  -->
		<li><a href="projectlook">프로젝트 보기</a>
			<ul>
				<li><a href="AllList">모든 프로젝트</a></li>

				<li><a href="categoryproject?categoryNo=1">게임</a></li>
				<li><a href="categoryproject?categoryNo=2">푸드</a></li>
				<li><a href="categoryproject?categoryNo=3">캠패인</a></li>
				<li><a href="categoryproject?categoryNo=4">디자인</a></li>
				<li><a href="categoryproject?categoryNo=5">영화/비디오</a></li>
				<li><a href="categoryproject?categoryNo=6">음악</a></li>
				<li><a href="categoryproject?categoryNo=7">패션</a></li>
				<li><a href="categoryproject?categoryNo=8">테크놀로지</a></li>
				<li><a href="categoryproject?categoryNo=9">기타</a></li>


				<li><a href="">기간 별 보기</a></li>
				<li><a href="graph">통계 별 보기</a></li>
			</ul></li>
		<li><a href="ProjectUpload">프로젝트 업로드</a></li>
		
		<c:choose>
			<c:when test="${pageContext.request.userPrincipal.name!=null }">
				<li id="cashStyle">
					${sessionScope.memberCash} 캐시
				</li>
				<li style="position: absolute; left : 1740px;">
				<a href="mypage">
					<img src="resources/images/${sessionScope.memberImage}" style="width: 40px;height: 35px;"></a></li>
				<!-- <li class="listy2"><a href="mypage">${pageContext.request.userPrincipal.name} 님</a></li> -->
			</c:when>
		</c:choose>
		
		<c:choose>
			<c:when test="${pageContext.request.userPrincipal.name==null }">
				<li class="listy"><a href="login">로그인</a></li>
			</c:when>
			<c:otherwise>
				<li class="listy"><a href="j_spring_security_logout">로그아웃 </a></li>
			</c:otherwise>
		</c:choose>
	</ul>
</div>
