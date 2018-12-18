<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
#t1 {
	text-align: center;
	margin: 0 auto;
	border-spacing: 40px;
}
.imgmar{
	margin: 10px 10px 10px 10px;
	width: 280px; 
	height: 240px;
}
.card {
  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
  transition: 0.3s;
  width: auto;
  height: auto;
  margin-left: 30px;
  margin-top: 20px;
}

.card:hover {
  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.7);
}

.container {
  padding-top: 3px;
  padding-bottom: 3px;
}

</style>
<div id="mydonateList">
	<h1 style="font-size: 20px">내가 만든 프로젝트</h1>
	<br>
	<div style="float: left; width: 50%;">
	<select id="exam"  style="width:320px">
	<option value="1">검토중</option>
	<option value="2">진행중</option>
	<option value="3">후원마감</option>
	<option value="3">검토반려</option>
	</select>
	</div>
	<div align="right">
		<form method="POST" action="myprojectearch">
			<input type="hidden" name="page" value="1"> 
				<input name="searchValue"
				id="searchIndex" size="80px" pattern=".{2,}"
				title="최소한 2자 이상의 글자가 있어야 합니다."> <input type="submit"
				value="검색하기" class="btns">
		</form>
	</div>
	<br>
	<br>
	<c:set var="i" value="0" />
	<c:set var="j" value="3" />
	<table id="t1">
		<thead></thead>
		<tbody>
			<c:forEach var="e" items="${list}">
				<c:if test="${i%j == 0 }">
					<tr>
				</c:if>
				<td>
				<div class="card">
						<c:choose>
							<c:when test="${e.projectStatus==1}">
								<div class="endcontainer">
								<a href="story?projectNo=${e.projectNo }">
									<img class="imgmar endpro" src="resources/images/${e.projectMainImage }">
								</a>
								<div class="centered">검토중</div>
								</div>
							</c:when>
							<c:when test="${e.projectStatus==2}">
								<a href="story?projectNo=${e.projectNo }">
									<img class="imgmar" src="resources/images/${e.projectMainImage }">
								</a>
							</c:when>
							<c:when test="${e.projectStatus==3}">
								<div class="endcontainer">
								<a href="story?projectNo=${e.projectNo }">
										<img class="imgmar endpro" src="resources/images/${e.projectMainImage }">
								</a>
								<div class="centered">진행<br>마감</div>
								</div>
							</c:when>
							<c:when test="${e.projectStatus==4}">
								<div class="endcontainer">
								<a href="story?projectNo=${e.projectNo }">
									<img class="imgmar endpro" src="resources/images/${e.projectMainImage }">
								</a>
								<div class="centered">검토<br>거부</div>
								</div>
							</c:when>
						</c:choose>
					<div class="container">
							<p id="">프로젝트 명 : ${e.projectName}</p>
							<hr>
							<p id="">프로젝트 등급 : ${e.projectStep}</p>
							<p id="">진행여부 : 
							<c:choose>
							<c:when test="${e.projectStatus==1}">
								검토중
							</c:when>
							<c:when test="${e.projectStatus==2}">
								진행중
							</c:when>
							<c:when test="${e.projectStatus==3}">
								진행 마감
							</c:when>
							<c:when test="${e.projectStatus==4}">
								심사 거부
							</c:when>
						</c:choose>
							</p>
							<p id="">목표금액 : ${e.projectCost}</p>
							<p id="">프로젝트 시작날짜 : ${e.projectStartDate}</p>
							<p id="">프로젝트 마감날짜 : ${e.projectEndDate}</p>
							<p id="">후원자 수 : ${e.projectFundCnt}</p>
					</div>
				</div>
				</td>
				<c:set var="i" value="${i+1 }" />

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
										href="myProject?page=
         ${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock }">
										◀</a>
								</c:otherwise>
							</c:choose>

							<%--Page  페이지 구현 --%>
							<c:choose>
								<c:when test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
									<c:forEach begin="1" end="${pageInfo.pagesPerBlock}"
										varStatus="num">
                        [<a
											href="myProject?page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }">
											${(pageInfo.currentBlock- 1) * pageInfo.pagesPerBlock + num.count }</a>]
                       </c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach
										begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}"
										end="${pageInfo.totalPages}" varStatus="num">
                        [<a
											href="myProject?page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }">
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
										href="myProject?page=${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 }">
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
										href="myProject?searchType=${searchType}&searchValue=${searchValue}&page=
         ${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock }">
										◀</a>
								</c:otherwise>
							</c:choose>

							<%--Page  페이지 구현 --%>
							<c:choose>
								<c:when test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
									<c:forEach begin="1" end="${pageInfo.pagesPerBlock}"
										varStatus="num">
                        [<a
											href="myProject?searchType=${searchType}&searchValue=${searchValue}&page=
                        ${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }">
											${(pageInfo.currentBlock- 1) * pageInfo.pagesPerBlock + num.count }</a>]
                       </c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach
										begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}"
										end="${pageInfo.totalPages}" varStatus="num">
                        [<a
											href="myProject?searchType=${searchType}&searchValue=${searchValue}&page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }">
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
										href="myProject?searchType=${searchType}&searchValue=${searchValue}&page=${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 }">
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

