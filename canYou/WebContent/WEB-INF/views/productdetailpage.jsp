<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="detail.jsp" %>
<!-- Nav tabs productdetailpage.jsp = 상품상세-->
         	<div id="underlinemenu">
         	<ul>
                <li><a href="story?projectNo=${list.projectNo}" class="current">프로젝트 스토리</a></li>
                <li><a class="hoverHolder" href="productDetail?projectNo=${list.projectNo}">상품 상세</a></li>
                <li><a href="community?projectNo=${list.projectNo}" >커뮤니티</a></li>
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
		<input style="width: 150px;" id="donadd" type="button" value="이걸로 후원하기" class="btns">
	</div>
</c:forEach> 
</div>
<div class="divStory"><fieldset><legend style="font-size: 20px; font-weight: bold;">현재 선택중인 선물</legend>
<div id="selprod"></div>
</fieldset>
</div>
추가 후원 :
<input type="text" name="donateMoney" id="donateMoney">

<input type="button" class="donateBtn btns" value="후원" >
<c:choose>
	<c:when
		test="${pageContext.request.userPrincipal.name eq member.memberId }">
		<tr>
			<td colspan="14"><input type="submit" id="wBtn" class="btns" lvalue="수정">
			</td>
		</tr>
	</c:when>
</c:choose>
<script>
	$(function() {
		$('.donateBtn').each(function(index, item) {
			$(this).click(function() {
				var result = confirm('후원하시겠습니까?');

				if (result) {
					var projectNo = $('#projectNo').val();
					var donateMoney = $('#donateMoney').val();
					var productNo = $('#selprod #productNo').val();
					if(productNo===undefined){
						location.href ='donate?projectNo='+projectNo+'&donateMoney='+donateMoney+'&productNo=0';
					} else{
						location.href ='donate?projectNo='+projectNo+'&donateMoney='+donateMoney+'&productNo='+productNo;	
					}
					
				}
			});
		});
	});
</script>