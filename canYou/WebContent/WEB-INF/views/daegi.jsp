<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.wprolist {
	border: 1px solid gray;
	margin: 10px;
	padding-left: 10px;
	padding-right: 10px;
	border-radius: 5px;
}

#t1 {
	text-align: center;
	margin: 0 auto;
	border-spacing: 40px;
}

.dayday {
	text-align: center;
	margin-top: 50px;
}
.daybtn{
text-align: center;
margin-top: 50px;
}
</style>
<div class="daybtn">
<input type="hidden" id="day" value="${day }">
<input type="button" id="day0" class="btns" value="모두보기">
<input type="button" id="day1" class="btns" value="오늘">
<input type="button" id="day2" class="btns" value="하루전">
<input type="button" id="day3" class="btns" value="이틀전">
<input type="button" id="day4" class="btns" value="마감임박">
</div>
<div class="container">
	<h1 style="font-size: 30px">
		<strong>검토 대기 프로젝트</strong>
	</h1>
	<table id="t1">
		<thead></thead>
		<tbody>
			<c:forEach var="e" items="${list}" varStatus="status">
				<div class="wprolist">
					<p>프로젝트 명 : ${e.PROJECTNAME}</p>
					<hr>
					<p>카테고리 분류 : ${e.CATEGORYNAME}</p>
					<p>검토 요청 날짜 : ${e.UDATE}</p>
					<p>시작 날짜 : ${e.PROJECTSTARTDATE}</p>
					<p>종료 날짜 : ${e.PROJECTENDDATE}</p>
					<p>
						<a href="admin.wstory?projectNo=${e.PROJECTNO }">자세히 보기</a>
					</p>
				</div>
			</c:forEach>
		</tbody>
		<tfoot>

			<!-- 페이징 -->

			<tr>
				<td colspan="6" style="text-align: center">
					<%--Page 이전 페이지 구현 --%> <c:choose>
						<c:when test="${searchType == null}">
							<c:choose>
								<c:when test="${pageInfo.currentBlock eq 1}">
                    ◀
                           </c:when>
								<c:otherwise>
									<a
										href="admin.daegi?page=
         ${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock }&day=${day}">
										◀</a>
								</c:otherwise>
							</c:choose>

							<%--Page  페이지 구현 --%>
							<c:choose>
								<c:when test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
									<c:forEach begin="1" end="${pageInfo.pagesPerBlock}"
										varStatus="num">
                        [<a
											href="admin.daegi?page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }&day=${day}">
											${(pageInfo.currentBlock- 1) * pageInfo.pagesPerBlock + num.count }</a>]
                       </c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach
										begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}"
										end="${pageInfo.totalPages}" varStatus="num">
                        [<a
											href="admin.daegi?page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }&day=${day}">
											${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>]
                    </c:forEach>
								</c:otherwise>
							</c:choose>


							<%--Page 다음 페이지 구현 --%>
							<c:choose>
								<c:when test="${pageInfo.currentBlock eq pageInfo.totalBlocks}">
               ▶
                </c:when>
								<c:otherwise>
									<a
										href="admin.daegi?page=${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 }&day=${day}&day=${day}">
										▶</a>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>

							<c:choose>
								<c:when test="${pageInfo.currentBlock eq 1}">
                    ◀◀
                           </c:when>
								<c:otherwise>
									<a
										href="admin.daegi?searchType=${searchType}&searchValue=${searchValue}&page=
         ${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock }&day=${day}">
										◀</a>
								</c:otherwise>
							</c:choose>

							<%--Page  페이지 구현 --%>
							<c:choose>
								<c:when test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
									<c:forEach begin="1" end="${pageInfo.pagesPerBlock}"
										varStatus="num">
                        [<a
											href="admin.daegi?searchType=${searchType}&searchValue=${searchValue}&page=
                        ${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }&day=${day}">
											${(pageInfo.currentBlock- 1) * pageInfo.pagesPerBlock + num.count }</a>]
                       </c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach
										begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}"
										end="${pageInfo.totalPages}" varStatus="num">
                        [<a
											href="admin.daegi?searchType=${searchType}&searchValue=${searchValue}&page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }&day=${day}">
											${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>]
                    </c:forEach>
								</c:otherwise>
							</c:choose>


							<%--Page 다음 페이지 구현 --%>
							<c:choose>
								<c:when test="${pageInfo.currentBlock eq pageInfo.totalBlocks}">
               ▶▶
               						 </c:when>
								<c:otherwise>
									<a
										href="admin.daegi?searchType=${searchType}&searchValue=${searchValue}&page=${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 }&day=${day}">
										▶</a>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</tfoot>
	</table>
</div>
<script>
$(document).ready(function(){
	$('#day0').click(function(){
		location.href='admin.daegi?day=0';
	})
	$('#day1').click(function(){
		location.href='admin.daegi?day=1';
	})
	$('#day2').click(function(){
		location.href='admin.daegi?day=2';
	})
	$('#day3').click(function(){
		location.href='admin.daegi?day=3';
	})
	$('#day4').click(function(){
		location.href='admin.daegi?day=4';
	})
});
</script>


