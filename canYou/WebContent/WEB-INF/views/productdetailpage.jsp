<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="detail.jsp" %>
<style>
.left-box {
   float: left;
   width: 50%;
}
 
.right-box {
   float: right;
   width: 50%;
}

#p{
	font-size: 25px;
	font-weight: bold;
}
</style>

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
	<div class="left-box">
		<c:forEach var="e2" items="${prodlist}">
			<div class="prodview">
				<div>
					<input type="hidden" name="productNo" id="productNo" value="${e2.productNo }">
					<input type="hidden" class="productCost" value="${e2.productCost}">
					<p>${e2.productCost }원이상구매 시</p>
					<h2>${e2.productName }</h2>
					<p>${e2.productInfo }</p>
					<p>${e2.productCnt }개남음</p>
				</div>
				<input style="width: 150px;" id="donadd" type="button"
					value="상품 선택" class="btns">
				
			</div>
		</c:forEach>
		추가 후원 : <input type="text" name="donateMoney" id="donateMoney">
		<input type="button" class="donateBtn btns" value="후원 선택">
	</div>
</div>

<div class="right-box">
	<div class="divStory">
		<fieldset>
			<legend style="font-size: 20px; font-weight: bold;">현재 선택중인 선물</legend>
			<hr>
			<div id="selprod"></div>
			<hr>
			<p id="p">총 후원 금액 : </p><div id="allDonate"></div>
			<div id="buyBtn"></div>
		</fieldset>
	</div>
</div>

<!-- 결제가 제대로 되었는지 확인하는 값 -->
<input type="hidden" id="success" value="${success}">
<script>
	$(function() {
		if($('#success').val()==='fail'){
			alert('잔액이 부족합니다.');
		}
		
		$('.prodview #donadd').each(function(){
			$(this).click(function(e){
				var donateBtn = '<input type="button" value="총 구매하기" class="btns dona"/>';
				
				$('#selprod').html($(this).prev().html());
				$('#buyBtn').html(donateBtn);
				//$('#selprod').css('border', '1px solid black');
				
				var allCost = Number($('#selprod .productCost').val());
				//var allCost = $(this).next().val();
				console.log($('#selprod .productCost').val());
					
				$('#allDonate').html('<p style="font-size: 25px; font-weight: bold;">'+allCost+'</p>');
			});
		});

		$('.donateBtn').each(function(index, item) { //추가 후원 선택
			$(this).click(function() {
				var projectNo = $('#projectNo').val();
				var productNo = $('#selprod #productNo').val();
				var allCost = Number($('#donateMoney').val())+Number($('#selprod .productCost').val());
				console.log(allCost);
				$('#allDonate').html('<p style="font-size: 25px; font-weight: bold;">'+allCost+'</p>');
			});
		});
		
		$('#buyBtn').each(function(index, item) { //총 상품 구매
			$(this).click(function() {
				var result = confirm('후원하시겠습니까?');

				if (result) {
					var projectNo = $('#projectNo').val();
					var donateMoney = $('#donateMoney').val();
					var productNo = $('#selprod #productNo').val();
				
					if(productNo===undefined){ //추가 후원만 했을 경우
						location.href ='donate?projectNo='+projectNo+'&donateMoney='+donateMoney+'&productNo=0';
					} else{ //상품구매, 추가 후원 둘 다 했을 경우
						location.href ='donate?projectNo='+projectNo+'&donateMoney='+donateMoney+'&productNo='+productNo;	
					} 
				}
			});
		});
		
		if(${list.projectStatus}!=2){
			$('.dona').attr('disabled', true);
		}
});
</script>