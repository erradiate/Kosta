<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="detail.jsp"%>
<style>
#tv {
	border: 1px solid;
	width: 900px;
	height: 300px;
	margin: auto;
}

.rday {
	font-size: x-small;
}

.cont {
	width: 800px;
	height: 150px;
	border: 1px solid;
	margin: auto;
}
</style>
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
			<td><input type="submit" value="작성"></td>
		</tr>
	</table>
	<!-- 댓글 출력부분 -->
	<table id="tv">
		<c:forEach var="s" items="${replylist}">
			<tr>
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