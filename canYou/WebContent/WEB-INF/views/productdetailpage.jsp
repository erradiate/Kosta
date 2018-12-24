<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="detail.jsp" %>
<style>
.left-box2 {
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
.popup {
  position: relative;
  display: inline-block;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

/* The actual popup */
.popup .popuptext {
  visibility: hidden;
  width: 160px;
  background-color: #555;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 8px 0;
  position: absolute;
  z-index: 1;
  bottom: 125%;
  left: 50%;
  margin-left: -80px;
}

/* Popup arrow */
.popup .popuptext::after {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -5px;
  border-width: 5px;
  border-style: solid;
  border-color: #555 transparent transparent transparent;
}

/* Toggle this class - hide and show the popup */
.popup .show {
  visibility: visible;
  -webkit-animation: fadeIn 1s;
  animation: fadeIn 1s;
}

/* Add animation (fade in the popup) */
@-webkit-keyframes fadeIn {
  from {opacity: 0;} 
  to {opacity: 1;}
}

@keyframes fadeIn {
  from {opacity: 0;}
  to {opacity:1 ;} 
}
</style>

<!-- Nav tabs productdetailpage.jsp = 상품상세-->
         	<div id="underlinemenu">
         	<ul>
                <li><a href="story?projectNo=${list.projectNo}" class="current">프로젝트 스토리</a></li>
                <li><a class="hoverHolder" href="productDetail?projectNo=${list.projectNo}">상품 상세</a></li>
                <li><a href="community?projectNo=${list.projectNo}" >커뮤니티</a>
				
                </li> 
                  <li>
                	<a href="graph?projectNo=${list.projectNo}&categoryNo=${list.categoryNo}" >그래프보기</a>
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
<div class="divStory">
	<div class="left-box2">
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
				<c:choose>
					<c:when test="${e2.productCnt>0 && list.projectStatus==2 }">
                		<input style="width: 150px;" id="donadd" type="button"
							value="선물 선택" class="btns">
                	</c:when>
                	<c:when test="${list.projectStatus==1 || list.projectStatus==4  }">
                	</c:when>
                	<c:otherwise>
                		<input style="width: 150px;" id="end" type="button"
							value="마감" class="btns" disabled>
                	</c:otherwise>
                </c:choose>
			</div>
		</c:forEach>
			<div class="popup">
			추가 후원 : <input type="text" name="donateMoney" id="donateMoney">
			<span class="popuptext" id="zero">금액을 입력해 주세요!</span>
			<span class="popuptext" id="illegal">1000원 단위로 입력 해주세요</span>
			</div> <input type="button" class="donateBtn btns" value="추가 후원">
		
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
			<div id="selpay">
				<input type="radio" id="payOption" name="payOption" value="1">선결제<br>
  				<input type="radio" id="payOption" name="payOption" value="2">카드결제<br>
			</div>
			<div id="buyBtn"></div>
		</fieldset>
	</div>
</div>
<%@ include file="recommend.jsp"%>
<!-- 결제가 제대로 되었는지 확인하는 값 -->
<input type="hidden" id="success" value="${success}">
<script>
	$(function() {
		$('.prodview #donadd').each(function(){
			$(this).click(function(e){
				var donateBtn = '<input type="button" value="후원하기" class="btns dona"/>';
				
				$('#selprod').html($(this).prev().html());
				$('#buyBtn').html(donateBtn);
				
				var allCost = Number($('#selprod .productCost').val())+Number($('#donateMoney').val());
					
				$('#allDonate').html('<p style="font-size: 25px; font-weight: bold;">'+allCost+'</p>');
			});
		});

		$('.donateBtn').each(function(index, item) { //추가 후원 선택
			$(this).click(function() {
				// 돈을 아예 입력 안한 경우
				if($('#donateMoney').val()===''){
					var popup = document.getElementById('zero');
					popup.classList.toggle("show");
				} else if($('#donateMoney').val()%1000 != 0){
					var popup = document.getElementById('illegal');
					popup.classList.toggle("show");
				} else{
				var donateBtn = '<input type="button" value="총 구매하기" class="btns dona"/>';
				$('#buyBtn').html(donateBtn);
				console.log($('#selprod .productCost').val());
				
				if($('#selprod .productCost').val()!=undefined){
					var allCost = Number($('#selprod .productCost').val())+Number($('#donateMoney').val());
					console.log(allCost);
				}else{
					var allCost = Number($('#donateMoney').val());
				}
				
				$('#allDonate').html('<p style="font-size: 25px; font-weight: bold;">'+allCost+'</p>');
				
				}
			});
		});
		
		$('#buyBtn').each(function(index, item) { //총 상품 구매
			$(this).click(function() {
				var result = confirm('후원하시겠습니까?');
				console.log($('#payOption:checked').val());
				if (result) {
					if ($('#payOption:checked').val()==1){
						var projectNo = $('#projectNo').val();
						var donateMoney = $('#allDonate').children().text();
						var productNo = $('#selprod #productNo').val();
						
						if(productNo===undefined){
							var vo = {projectNo:projectNo, donateMoney:donateMoney, productNo:0};
						} else{
							var vo = {projectNo:projectNo, donateMoney:donateMoney, productNo:productNo};
						}
						$.ajax({
							type : "POST",
							data : vo,
							dataType : "json",
							url : "donate",
							success : function(data){
								if(data=='1'){
									var con = confirm('후원이 성공적으로 완료됐습니다. 마이페이지로 이동하시겠습니까?');
									if(con){
										location.href='mypage';
									}
								} else{
									alert('잔액이 부족합니다.');
								}
							},
							error : function(){
								location.href="login";
							}
						});	
					}else if ($('#payOption:checked').val()==2){
						var projectNo = $('#projectNo').val();
						var donateMoney = $('#allDonate').children().text();
						var productNo = $('#selprod #productNo').val();
						
						var form=document.createElement("form");
						form.setAttribute("method", "post");
						form.setAttribute("action", "cardpay");
						
						var hiddenField=document.createElement("input");
						hiddenField.setAttribute("type", "hidden");
						hiddenField.setAttribute("name", "projectNo");
						hiddenField.setAttribute("value", projectNo);
						form.appendChild(hiddenField);
						
						var hiddenField2=document.createElement("input");
						hiddenField2.setAttribute("type", "hidden");
						hiddenField2.setAttribute("name", "donateMoney");
						hiddenField2.setAttribute("value", donateMoney);
						form.appendChild(hiddenField2);
						
						if(productNo!=null){
							var hiddenField3=document.createElement("input");
							hiddenField3.setAttribute("type", "hidden");
							hiddenField3.setAttribute("name", "productNo");
							hiddenField3.setAttribute("value", productNo);
							form.appendChild(hiddenField3);
						}
						document.body.appendChild(form);
						
						form.submit();
					}else{
						alert('결제 옵션을 선택해주세요')
					}
				}
			});
		});
		
		if(${list.projectStatus}!=2){
			$('.dona').attr('disabled', true);
		}
});
</script>