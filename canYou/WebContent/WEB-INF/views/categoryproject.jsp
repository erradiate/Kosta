<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<style type="text/css">
@font-face {
   font-family: 'titleFont'; /* 폰트 패밀리 이름 주기*/
   src: url('resources/css/NANUMSQUAREEB.TTF'); /*폰트 파일 주소*/
}

#projtitle{
	font-family:'titleFont' !important;
	font-size: 20px;
}

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

#castyle{
	font-size: 50px;
	font-weight: bold;
	text-align: center;
}

#castyle2{
	font-size: 33px;
	font-weight: bold;
	text-align: center;
}

#searchType{
	 width: 200px; /* 원하는 너비설정 */
    padding: .2em .3em; /* 여백으로 높이 설정 */
    font-family: inherit;  /* 폰트 상속 */
    background: url('resources\images\down.png') no-repeat 95% 50%; /* 네이티브 화살표를 커스텀 화살표로 대체 */
    border: 1px solid #999;
    -webkit-appearance: none; /* 네이티브 외형 감추기 */
    -moz-appearance: none;
    appearance: none;
	border-radius: 5px;
}

#searchIndex{
	border: 1px solid #999;
	border-radius: 5px;
}

</style>
	<div id="categoryproject">
		<p id="castyle">[ ${categoryName} ]</p>
		<c:choose>
					<c:when test="${subCategoryName!=null}">
							<p id="castyle2"> ${subCategoryName} </p>
	                    </c:when>
	    </c:choose>
	    	<div align="center">
			<form method="POST" action="search">
				<input type="hidden" name="page" value="1">
				<select name="searchType" id="searchType">
					<option value="1">작성자</option>
					<option value="2">프로젝트명</option>
				</select>&nbsp; <input name="searchValue" id="searchIndex" size="100px"
				pattern=".{2,}"
				title="최소한 2자 이상의 글자가 있어야 합니다."> 
				
				
				<input type="submit" value="검색하기" class="btns">
			</form>
			</div>
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
						<p id="projtitle">${listv.projectName}</p>
						<div class="progress" style="height:5px">
    						<div class="progress-bar" style="width:${listv.projectCurCost/listv.projectCost*100}%;height:10px"></div>
  						</div>
						<p>모인 금액 : ${listv.projectCost}원</p>
						<c:choose>
							<c:when test="${listv.projectStatus==2}">
								<p>남은 날짜 : ${dateList[status.index]}일</p>
							</c:when>
							<c:otherwise>
								<p>마감된 프로젝트입니다.</p>
							</c:otherwise>
						</c:choose>
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