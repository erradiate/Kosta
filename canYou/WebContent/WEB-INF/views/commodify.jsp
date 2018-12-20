<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
	<h1>커뮤니티수정</h1>
</div>
<style>
table {
	margin: "0 auto";
}

h1 {
	align-self: center;
}
</style>
<div class="comment" align="center">
	<!-- 이전 페이지에서 받아온 값을 안보이게 히든으로 넣어 둠 -->
	<input type="hidden" name="projectNo" value="${list.projectNo}">
	<input type="hidden" name="replyNo" value="${list.replyNo}">
	<form action="commentmodify" method="POST">
		<table>
			<tr>
				<td><h1>댓글 수정</h1></td>
			</tr>
			<tr>
				<td><textarea rows="50" cols="200" name="replyContent"></textarea></td>
			</tr>
			<tr>
				<td><input type="submit" value="수정"> <input
					type="hidden" name="projectNo" value="${list.projectNo}"> 
					<input type="hidden" name="replyNo" value="${list.replyNo}"></td>
			</tr>
		</table>
	</form>
</div>
