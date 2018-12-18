<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
	<h1>캐쉬 충전소</h1>
</div>
<div class="cash" align="center">
	<form action="cashcharge" method="POST">
		<c:forEach var="e" items="${list}" varStatus="status">
			<p>
				<input type="text" name="memberName" value="${e.memberName }"
					readonly="readonly"><label>님</label>
			</p>
			<p>
				<label>현재 금액 : </label><input type="text" name="currentmemberCash"
					value="${e.memberCash }" readonly="readonly">
			</p>
			<p>
				<label>충전 금액 : </label><input type="text" name="memberCash">
			</p>
			<p>
				<input type="submit" class="btns" value="충전하기">
			</p>
		</c:forEach>
	</form>
</div>