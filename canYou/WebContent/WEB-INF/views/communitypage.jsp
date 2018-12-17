<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="detail.jsp"%>


<style>

.rday {
	font-size: x-small;
}

.cont {
	width: 800px;
	height: 150px;
	border: 1px solid #DFDFDF;
	margin: auto;
}
</style>
<!-- Nav tabs communitypage = 커뮤니티 -->
<div id="underlinemenu">
	<ul>
		<li><a href="story?projectNo=${list.projectNo}" class="current">프로젝트
				스토리</a></li>
		<li><a href="productDetail?projectNo=${list.projectNo}">상품 상세</a></li>
		<li><a class="hoverHolder"
			href="community?projectNo=${list.projectNo}">커뮤니티</a></li>
		<li><a href="">환불 및 교환</a></li>
	</ul>
</div>
<!-- Nav tabs -->

<form method="post" action="reply1">
	<table>
		<tr>
			<td><c:choose>
					<c:when test="${pageContext.request.userPrincipal.name==null}">
						<textarea rows="3" cols="30" name="replyContent" disabled>로그인 해주세요</textarea>
					</c:when>
					<c:when test="${pageContext.request.userPrincipal.name!=null}">
						<textarea rows="3" cols="30" name="replyContent"></textarea>
					</c:when>
				</c:choose></td>
			<td><input type="submit" value="작성"  class="btns"></td>
		</tr>
	</table>

	<!-- 댓글 출력부분 -->
	
	<table class="divStory">

		<c:forEach var="s" items="${replylist}">
			<td><img id="memberImage "
				src="resources/images/${s.mvo_Result.memberImage }"
				style="border: 1px solid; border-radius: 70px; -moz-border-radius: 70px; -khtml-border-radius: 70px; -webkit-border-radius: 70px; width: 35px; height: 35px;">

				${s.mvo_Result.memberName}</td>
			<tr>
				<td class="rday">${s.replyDate}</td>
			</tr>
			<tr>
				<td><div class="cont">${s.replyContent}</div></td>
			</tr>
		</c:forEach>
	</table>
</form>
