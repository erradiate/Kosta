<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="detail.jsp" %>
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
				<td>멤버번호 : ${s.memberNo}</td>
				<td>내용 : ${s.replyContent}</td>
				<td>날짜 : ${s.replyDate}</td>
			</tr>
		</c:forEach>
	</table>
</form>