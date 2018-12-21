<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="detail.jsp" %>

<style>
.thStyle2{
	text-align: center;
	font-size: 25px;
	font-weight: bold;
	padding: 10px 20px 10px 20px;
	margin: 20px 30px 20px 30px;
	border:1px solid white;
	background-color: black;
	color: white;
}

tr .thStyle{
	font-size: 17px;
	text-align: center;
	padding: 5px 10px 5px 10px;
	border:1px solid gray;
	font-weight: nomal;
}

</style>

<!-- Nav tabs storypage.jsp = 프로젝트 스토리 -->
         	<div id="underlinemenu">
         	<ul>
                <li><a href="story?projectNo=${list.projectNo}" class="current">프로젝트 스토리</a></li>
                <li><a href="productDetail?projectNo=${list.projectNo}">상품 상세</a></li>
                <li><a href="community?projectNo=${list.projectNo}" >커뮤니티</a></li>
                 <c:choose>
                	<c:when test="${pageContext.request.userPrincipal.name!=null }">
                		<li><a href="projectDonateList?projectNo=${list.projectNo}&memberNo=${member.memberNo}">후원자 보기</a></li>
                	</c:when>
                </c:choose>
                <li><a href="">환불 및 교환</a></li>
            </ul> 
            </div> 
<!-- Nav tabs --> 
<!-- 스토리 부분 -->
<div class="divStory">
	<table id="proInfo">
		<tr>
			<th class="thStyle2">번호</th>
			<th class="thStyle2">아이디</th>
			<th class="thStyle2">이름</th>
			<th class="thStyle2">주소</th>
			<th class="thStyle2">핸드폰 번호</th>
			<th class="thStyle2">이메일</th>
			<th class="thStyle2">성별</th>
			<th class="thStyle2">나이</th>
			<th class="thStyle2">계좌</th>
			<th class="thStyle2">이미지</th>
		</tr>
		<c:forEach var="list" items="${mList}" varStatus="status">
			<tr>
				<th class="thStyle">${status.count}</th>
				<th class="thStyle">${list.memberId}</th>
				<th class="thStyle">${list.memberName}</th>
				<th class="thStyle">${list.memberAddr}</th>
				<th class="thStyle">${list.memberPhone} 번호</th>
				<th class="thStyle">${list.memberEmail}</th>
				<th class="thStyle">${list.memberGender}</th>
				<th class="thStyle">${list.memberAge}</th>
				<th class="thStyle">${list.memberAccount}</th>
				<th class="thStyle"><img id="projectMainImage" src="resources/images/${list.memberImage}" style="width: 50px; height: 50px;"></th>
			</tr>
		</c:forEach>
	</table>
</div>

