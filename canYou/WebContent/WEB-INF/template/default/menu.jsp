<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<ul>
	<li><a href="./">Home</a></li>
	<!-- 세션이 있으면 :로그아웃, 세션이 없으면 : 로그인  -->

	<c:choose>
		<c:when test="${pageContext.request.userPrincipal.name==null }">
			<li><a href="login">로그인 </a></li>
		</c:when>
		<c:otherwise>
			<li><a href="j_spring_security_logout">로그아웃 </a></li>
		</c:otherwise>
	</c:choose>
	<li><a href="ProjectUpload">프로젝트 업로드</a></li>
	<li><a href="projectlook">프로젝트 둘러보기</a></li>
	<li><a href="mypage">마이 페이지</a></li>

</ul>
<input type="hidden" id="session" value="${sessionScope.logInOut}">

</ul>
