<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="wdetail.jsp" %>
<!-- Nav tabs productdetailpage.jsp = 상품상세-->
         	<div id="underlinemenu">
         	<ul>
                <li><a href="admin.wstory?projectNo=${list.projectNo}" class="current">프로젝트 스토리</a></li>
                <li><a class="hoverHolder" href="admin.wproductDetail?projectNo=${list.projectNo}">상품 상세</a></li>
                <li><a href="">환불 및 교환</a></li>
            </ul> 
            </div> 
<!-- Nav tabs -->
<div class="divStory">
<c:forEach var="e2" items="${prodlist}">
	<div class="prodview">
		<div>
			<input type="hidden" name="productNo" id="productNo"
				value="${e2.productNo }">
			<p>${e2.productCost }원이상 구매 시</p>
			<h2>${e2.productName }</h2>
			<p>${e2.productInfo }</p>
			<p>${e2.productCnt }개남음</p>
		</div>
	</div>
</c:forEach> 
</div>
