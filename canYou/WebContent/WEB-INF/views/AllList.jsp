<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
#bgy {
	margin: 0 auto;
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

#castyle{
	font-size: 50px;
	font-weight: bold;
	text-align: center;
}

</style>


	<div id="AllList">
	<p id="castyle">[ 모든 프로젝트 ]</p>
		<c:set var="i" value="0" />
		<c:set var="j" value="3" />
		<table id="bgy">
			<thead>
			</thead>

			<tbody >
				<c:forEach var="e" items="${list}" varStatus="status">
					<c:if test="${i%j == 0 }">
						<tr>
					</c:if>
					<td>
						<div class="card">
						<c:choose>
							<c:when test="${e.projectStatus==1 || e.projectStatus==2}">
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
							<c:when test="${e.projectStatus==4 }">
								<div class="endcontainer">
									<a href="story?projectNo=${e.projectNo }">
										<img class="imgmar endpro" src="resources/images/${e.projectMainImage }">
									</a>
									<div class="centered">심사<br>거부</div>
								</div>
							</c:when>
						</c:choose>
						<div class="container">
						<p>프로젝트 명 : ${e.projectName}</p>
						<hr>
						<p>모인 금액 : ${e.projectCurCost}</p>
						<p>남은 날짜 : ${dateList[status.index]}</p>
						</div>
						</div>
					</td>
					<c:if test="${i%j == j-1 }">
					</c:if>
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
											href="AllList?page=
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
												href="AllList?page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }">
												${(pageInfo.currentBlock- 1) * pageInfo.pagesPerBlock + num.count }</a>]
                       </c:forEach>
									</c:when>
									<c:otherwise>
										<c:forEach
											begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}"
											end="${pageInfo.totalPages}" varStatus="num">
                        [<a
												href="AllList?page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }">
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
											href="AllList?page=${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 }">
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
											href="AllList?searchType=${searchType}&searchValue=${searchValue}&page=
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
												href="AllList?searchType=${searchType}&searchValue=${searchValue}&page=
                        ${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }">
												${(pageInfo.currentBlock- 1) * pageInfo.pagesPerBlock + num.count }</a>]
                       </c:forEach>
									</c:when>
									<c:otherwise>
										<c:forEach
											begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}"
											end="${pageInfo.totalPages}" varStatus="num">
                        [<a
												href="AllList?searchType=${searchType}&searchValue=${searchValue}&page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }">
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
											href="AllList?searchType=${searchType}&searchValue=${searchValue}&page=${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 }">
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