<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="detail.jsp"%>


<style>
.rday {
	font-size: x-small;
}

.comment {
	border: 1px solid #DFDFDF;
	width: 50%;
	height: 50%;
	margin: 50px auto;
}

.modelbtn {
	text-align: right;
	border-bottom: 2px dashed gray;
	padding-bottom: 4px;
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
		  <c:choose>
                	<c:when test="${pageContext.request.userPrincipal.name!=null }">
                		<li><a href="projectDonateList?projectNo=${list.projectNo}&memberNo=${member.memberNo}">후원자 보기</a></li>
                	</c:when>
                </c:choose>
		<li><a href="">환불 및 교환</a></li>
	</ul>
</div>
<!-- Nav tabs -->

<form method="post" action="reply1">
	<div align="center">
		<table>
			<tr>
				<td><c:choose>
						<c:when test="${pageContext.request.userPrincipal.name==null}">
							<textarea rows="7" cols="80" name="replyContent" disabled>로그인 해주세요</textarea>
						</c:when>
						<c:when test="${pageContext.request.userPrincipal.name!=null}">
							<textarea rows="7" cols="80" name="replyContent"></textarea>
						</c:when>
					</c:choose></td>
				<td><input type="submit" value="작성" class="btns"></td>
			</tr>
		</table>
	</div>

	<!-- 댓글 출력부분 -->

	<table class="comment">

		<c:forEach var="s" items="${replylist}">
			<td><img id="memberImage "
				src="resources/images/${s.mvo_Result.memberImage }"
				style="border: 1px solid; border-radius: 70px; -moz-border-radius: 70px; -khtml-border-radius: 70px; -webkit-border-radius: 70px; width: 35px; height: 35px;">

				${s.mvo_Result.memberName}</td>
			<tr>
				<td class="rday">${s.replyDate}</td>
			</tr>
			<tr>
			<tr>
				<td><div class="cont">${s.replyContent}</div></td>
			</tr>
			<tr>
				<td class="modelbtn"><input type="button" class="mobtn"
					value="수정"> 
					<input type="hidden" class="replyNo" value="${s.replyNo}"> 
					<input type="hidden" id="projectNo"value="${s.projectNo}"> 
					<input type="button" class="delbtn"
					value="삭제"></td>
			</tr>
		</c:forEach>
	</table>
</form>
<script>
	$(function() {
		$('.delbtn').each(
				function(index, item) {
					$(this).click(

							function() {
								console.log();
								var result = confirm('삭제하시겠습니까?');
								if (result) {
									location.href = "commentdelete?replyNo="
											+ $(this).prev().prev().val()
											+ "&projectNo="
											+ $('#projectNo').val();
									console.log($('#projectNo').val());
									console.log($('.replyNo').val());
								}
							});
				});
	});
	$(function() {
		$('.mobtn').click(function() {
			location.href = "communityModify?replyNo="+ $(this).next().val()+ "&projectNo="
			+ $('#projectNo').val();
		});
	});
</script>
