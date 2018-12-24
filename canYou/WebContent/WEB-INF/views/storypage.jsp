<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="detail.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Nav tabs storypage.jsp = 프로젝트 스토리 -->
         	<div id="underlinemenu">
         	<ul>
                <li><a class="hoverHolder" href="story?projectNo=${list.projectNo}" class="current">프로젝트 스토리</a></li>
                <li><a href="productDetail?projectNo=${list.projectNo}">상품 상세</a></li>
                <li><a href="community?projectNo=${list.projectNo}" >커뮤니티</a>
                
                </li>
                  <li>
                	<a href="graph?projectNo=${list.projectNo}" >그래프보기</a>
                </li>
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
<p style="margin:3%">${list.projectStory}</p>
</div>
<%@ include file="recommend.jsp"%>
<script>

</script>