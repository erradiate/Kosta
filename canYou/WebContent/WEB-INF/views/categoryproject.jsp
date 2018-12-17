<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<style type="text/css">
#bgy {
	margin:0 auto;
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

.imgmar{
	margin: 10px 10px 10px 10px;
	width: 280px; 
	height: 240px;
}

</style>

	<c:choose>
		<c:when test="${pageContext.request.userPrincipal.name != null}">
			<c:url var="logoutAction" value="/j_spring_security_logout"></c:url>
	${principal} 
	<form action="${logoutAction}" method="post">
				<input type="submit" value="Logout" class="btns" />
			</form>

		</c:when>
	</c:choose>
	
	<div id="categoryproject">
		<input type="hidden" id="categoryNo" value="${categoryNo}">
		
			<c:set var="i" value="0" />
			<c:set var="j" value="3" />
			<table id="bgy">
			<thead>
			</thead>
			
			<tbody>
				<c:forEach var="listv" items="${list}" varStatus="status">
					<c:if test="${i%j == 0 }">
					<tr>
					</c:if>
					<td>
					<div class="card">
						<c:choose>
							<c:when test="${listv.projectStatus==2}">
								<a href="story?projectNo=${listv.projectNo }">
									<img class="imgmar" src="resources/images/${listv.projectMainImage }">
								</a>
							</c:when>
							<c:when test="${listv.projectStatus==3}">
								<div class="endcontainer">
								<a href="story?projectNo=${listv.projectNo }">
										<img class="imgmar endpro" src="resources/images/${listv.projectMainImage }">
								</a>
								<div class="centered">진행<br>마감</div>
								</div>
							</c:when>
						</c:choose>

						<div class="container">
						<p>프로젝트 명 : ${listv.projectName}</p>
						<p>모인 금액 : ${listv.projectCost}</p>
						<p>남은 날짜 : ${dateList[status.index]}</p>
						</div>
					</div>						
					</td>
					<c:if test="${i%j == j-1 }">
					</tr>
					</c:if>
					<c:set var="i" value="${i+1}" />
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
											href="categoryproject?page=
         ${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock }&categoryNo=${categoryNo}">
											◀</a>
									</c:otherwise>
								</c:choose>

								<%--Page  페이지 구현 --%>
								<c:choose>
									<c:when test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
										<c:forEach begin="1" end="${pageInfo.pagesPerBlock}"
											varStatus="num">
                        [<a
												href="categoryproject?page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }&categoryNo=${categoryNo}">
												${(pageInfo.currentBlock- 1) * pageInfo.pagesPerBlock + num.count }</a>]
                       </c:forEach>
									</c:when>
									<c:otherwise>
										<c:forEach
											begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}"
											end="${pageInfo.totalPages}" varStatus="num">
                        [<a
												href="categoryproject?page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }&categoryNo=${categoryNo}">
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
											href="categoryproject?page=${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 }&categoryNo=${categoryNo}">
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
											href="categoryproject?searchType=${searchType}&searchValue=${searchValue}&page=
         ${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock }&categoryNo=${categoryNo}">
											◀</a>
									</c:otherwise>
								</c:choose>

								<%--Page  페이지 구현 --%>
								<c:choose>
									<c:when test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
										<c:forEach begin="1" end="${pageInfo.pagesPerBlock}"
											varStatus="num">
                        [<a
												href="categoryproject?searchType=${searchType}&searchValue=${searchValue}&page=
                        ${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }&categoryNo=${categoryNo}">
												${(pageInfo.currentBlock- 1) * pageInfo.pagesPerBlock + num.count }</a>]
                       </c:forEach>
									</c:when>
									<c:otherwise>
										<c:forEach
											begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}"
											end="${pageInfo.totalPages}" varStatus="num">
                        [<a
												href="categoryproject?searchType=${searchType}&searchValue=${searchValue}&page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }&categoryNo=${categoryNo}">
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
											href="categoryproject?searchType=${searchType}&searchValue=${searchValue}&page=${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 }&categoryNo=${categoryNo}">
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