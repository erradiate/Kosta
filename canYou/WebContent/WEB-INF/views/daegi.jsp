<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.wprolist{
	border: 1px solid gray;
		margin: 10px;
		padding-left:10px;
		padding-right:10px;
		border-radius: 5px;
}
</style>
<div class="container">
	<h1>검토 대기 프로젝트</h1>

	<c:forEach var="e" items="${list}" varStatus="status">
		<div class="wprolist">
			<p>프로젝트 명 : ${e.PROJECTNAME}</p>
			<hr>
			<p>카테고리 분류 : ${e.CATEGORYNAME}</p>
			<p>검토 요청 날짜 : ${e.UDATE}</p>
			<p>시작 날짜 : ${e.PROJECTSTARTDATE}</p>
			<p>종료 날짜 : ${e.PROJECTENDDATE}</p>
			<p><a href="admin.wstory?projectNo=${e.PROJECTNO }">자세히 보기</a></p>
		</div>
	</c:forEach>
</div>