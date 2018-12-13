<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>myProject.jsp</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style type="text/css">
#t1 {
	text-align: center;
	margin: 0 auto;
	border-spacing: 40px;
	/* border-collapse: separate; */
}

.t2 {
	border: 3px double black;
	padding: 0px;
	width: 280px;
	height: 260px;
}
</style>
</head>
<body>
	<div id="myProjectList">
		
			<c:set var="i" value="0" />
			<c:set var="j" value="3" />
			<table id="t1">
			<thead></thead>
				<tbody>
					<c:forEach var="e" items="${list}">
						<c:if test="${i%j == 0 }">
							<tr>
						</c:if>
						<td class="t2">
							<div id="">
								<a href="list?num=${e.projectNo }"> <img
									id="projectMainImage"
									src="resources/images/${e.projectMainImage }"
									style="margin: 0px 0px 0px 0px; width: 100%; height: 240px;">
								</a>
							</div>
							<p id="">프로젝트 명 : ${e.projectName}</p>
							<hr>
							<p id="">프로젝트 등급 : ${e.projectStep}</p>
							<p id="">진행여부 : ${e.projectStatus}</p>
							<p id="">목표금액 : ${e.projectCost}</p>
							<p id="">프로젝트 시작날짜 : ${e.projectStartDate}</p>
							<p id="">프로젝트 마감날짜 : ${e.projectEndDate}</p>
							<p id="">후원자 수 : ${e.projectFundCnt}</p>
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
												href="myProject?page=
         ${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock }">
												◀</a>
										</c:otherwise>
									</c:choose>

									<%--Page  페이지 구현 --%>
									<c:choose>
										<c:when
											test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
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
										<c:when
											test="${pageInfo.currentBlock eq pageInfo.totalBlocks}">
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
										<c:when
											test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
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
										<c:when
											test="${pageInfo.currentBlock eq pageInfo.totalBlocks}">
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
</body>
</html>

