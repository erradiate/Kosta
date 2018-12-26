<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

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
	height: 270px;
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

.imgStyle{
	width: 40px;height: 35px;
}

</style>

<div class="menubar">
	<ul>
		<!-- <li><a href="./">Home</a></li> -->
		<!-- 세션이 있으면 :로그아웃, 세션이 없으면 : 로그인  -->
		<li><a href="lookaround">프로젝트 보기</a>
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

			</ul></li>
		<li><a href="ProjectUpload">프로젝트 업로드</a>
		<%
	
			Object sid = session.getAttribute("memberGrant");
		
			if(sid != null){
				request.setAttribute("sidv", sid.toString());
			}
		%>
		
		</li>
		
		<c:choose>
			<c:when test="${pageContext.request.userPrincipal.name!=null }">
					<c:choose>
						<c:when test="${sidv=='1'}">
							<li style="position: absolute; left : 1740px;">
								<a href="admin.daegi">
								<img src="resources/images/${sessionScope.memberImage}" class="imgStyle"></a></li>
						</c:when>
						
						<c:otherwise>
							<c:choose>
									<c:when test="${dealarm>0 }">
										<li style="position: absolute; left : 1550px;">
										<div class="dropdown">
											<button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">
												(${dealarm })
    										</button>
											<div class="dropdown-menu">
												 <c:forEach var="v" items="${delist}">
													<a class="dropdown-item" href="story?projectNo=${v.projectNo }">거절 프로젝트!</a>
 												</c:forEach>
    										</div>
										</div>
										</li>
									</c:when>
								</c:choose>
						
							<li id="cashStyle">${sessionScope.memberCash} 캐시</li>
								<li style="position: absolute; left : 1740px;">
								
								<a href="mypage">
								<img src="resources/images/${sessionScope.memberImage}" class="imgStyle"></a></li>
						</c:otherwise>
					</c:choose>
					
				
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


