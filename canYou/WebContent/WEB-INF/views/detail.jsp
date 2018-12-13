<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
#tv {
    border: 1px solid black;
}
.left-box {
  float: left;
  width: 60%;
}
.right-box {
  float: right;
  width: 40%;
}
td{	
	color: black;	
}
.tdclass{
	color: black;
	font-size: 20px;
	line-height: 2em;
}


</style>
<script>
$(document).ready(function(){
	$('.prodview #donadd').each(function(){
		$(this).click(function(e){
			//console.log($(this).prev().html());
			$('#selprod').html($(this).prev().html());
			$('#selprod').css('border', '1px pink solid');
		});
	});
}); 
</script>
</head>

<div>
		<fieldset>
			<legend>Project</legend>
			<form action="update" method="POST" >	
			<input type="hidden" id="projectNo" name="projectNo" value="${list.projectNo}">
				<h1 style="margin:30px 100px 30px 260px; font-size: 40px; color: black;">프로젝트 이름 : ${list.projectName}</h1>
				<div class="left-box">
				<img id="projectMainImage"
						src="resources/images/${list.projectMainImage }"
						style="margin: 20px 30px 30px 40px; width: 420px; height: 420px;"></div>
			<table style="margin: 50px 30px 120px 60px;">
				<thead></thead>
				<tbody>
						<tr>
							<td>프로젝트 주최자 </td>
						</tr>
						<tr>
							<td class="tdclass">${member.memberName}</td>
						</tr>
						<!--
						<tr>
							<td>카테고리 이름 : <b>[${c}]</b>
							<c:choose>
								<c:when test="${sc!=null}">
									-${sc}
                            	</c:when>
                            </c:choose>
							</td>
						</tr>
						  -->
						<tr>
							<td>목표금액</td>
						</tr>
						<tr>
							<td class="tdclass">${list.projectCost}원</td>
						</tr>
						<!--
						<tr>
							<td>프로젝트 시작날짜 : ${list.projectStartDate}</td>
						</tr>
						  -->
						<tr>
							<td>프로젝트 마감날짜</td>
						</tr>
						<tr>
							<td class="tdclass">${list.projectEndDate}</td>
						</tr>
						<tr>
							<td>모인 후원 금액</td>
						</tr>
						<tr>
							<td class="tdclass">${list.projectCurCost}원</td>
						</tr>
						<tr>
							<td>후원자 수</td>
						</tr>
						<tr>
							<td class="tdclass">${list.projectFundCnt}명</td>
						</tr>
						<tr>
							<td>프로젝트 등급</td>
						</tr>	
						<tr>
							<td class="tdclass">${list.projectStep}</td>
						</tr>
				</tbody>
			</table>	
			
				<p><a href="storypage">프로젝트 스토리</a> ${list.projectStory}</p>
				<p><a href="productdetailpage">상품 상세</a></p>
				<p><a href="communitypage">커뮤니티</a></p>
				<p><a href="">환불 및 교환</a></p>
						
				<c:forEach var="e2" items="${prodlist}">
					<div class="prodview" style="border:1px solid gold;">
						<div>
											<input type="hidden" name="productNo" id="productNo" value="${e2.productNo }">
											<p>${e2.productCost }원 이상 구매 시</p>
											<h2>${e2.productName }</h2>
											<p>${e2.productInfo }</p>
											<p>${e2.productCnt }개 남음</p>
										</div>
									<input id="donadd" type="button" value="이걸로 후원하기">
									</div>
				</c:forEach>
						
								<h2>현재 선택중인 선물</h2>
								<div id="selprod">
									
								</div>
						
							추가 후원 : <input type="text" name="donateMoney" id="donateMoney">
					
						<input type="button" class="donateBtn" value="후원">

				<c:choose>
					<c:when test="${pageContext.request.userPrincipal.name eq member.memberId }">
					<tr>
						<td colspan="14">
						<input type="submit" id="wBtn" value="수정">
						</td>
					</tr>
					</c:when>
				</c:choose>	
			</form>
			
			<form method="post" action="reply1">
			<table>
				<tr>
					<td>
					<c:choose>
						<c:when test="${pageContext.request.userPrincipal.name==null}">
							<textarea rows="3" cols="30" name="replyContent" disabled>로그인 해주세요</textarea>
						</c:when>
						<c:when test="${pageContext.request.userPrincipal.name!=null}">
							<textarea rows="3" cols="30" name="replyContent"></textarea>
						</c:when>
					</c:choose>
					</td>
					<td><input type="submit" value="작성"></td>
				</tr>
				<tr>
					<td><input type="button" id="wordBtn" value="워드로 보기"></td>
				</tr>
			</table>
		</form>
		</fieldset>
		<table id= "tv">
		
			<c:forEach var="s" items="${replylist}">
			
				<tr>
					<td>멤버번호 : ${s.memberNo}</td>	
					<td>내용 : ${s.replyContent}</td>
					<td>날짜 : ${s.replyDate}</td>
				</tr>
				
			</c:forEach>

		</table> 
	</div>

<script>
	$(function() {
		$('#wordBtn').click(function(){
			location.href="download?projectNo="+$('#projectNo').val();
		});
		$('.donateBtn').each(function(index, item) {
			$(this).click(function() {
				var result = confirm('후원하시겠습니까?');

				if (result) {
					var projectNo = $('#projectNo').val();
					var donateMoney = $('#donateMoney').val();
					var productNo = $('#selprod #productNo').val();
					
					
					//console.log("projectNo : "+projectNo+"/ donateMoney : "+donateMoney+"/ productNo:" + productNo);
					
					location.href ='donate?projectNo='+projectNo+'&donateMoney='+donateMoney+'&productNo='+productNo;
				}
			});
		});
	});
</script>

