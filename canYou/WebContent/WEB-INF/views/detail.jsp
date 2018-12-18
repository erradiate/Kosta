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
			var donateBtn = '<input type="button" value="후원" class="btns dona"/>';
			
			$('#selprod').html($(this).prev().html());
			$('#buyBtn').html(donateBtn);
			$('#selprod').css('border', '1px pink solid');
		});
	});
}); 
</script>



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
			<div align="right">
				<input type="button" id="wordBtn" value="워드로 보기" class="btns">	
				<c:choose>
				<c:when
					test="${pageContext.request.userPrincipal.name eq member.memberId }">
					<input type="submit" id="wBtn" class="btns" value="수정">
				</c:when>
				</c:choose>
				<c:choose>
				<c:when
					test="${pageContext.request.userPrincipal.name eq member.memberId && list.projectStatus==4}">
					<input type="button" id="request" class="btns" value="재검토 요청">
					<script>
						$('#request').click(function(){
							var form=document.createElement("form");
							form.setAttribute("method", "post");
							form.setAttribute("action", "request");
							
							var hiddenField=document.createElement("input");
							hiddenField.setAttribute("type", "hidden");
							hiddenField.setAttribute("name", "projectNo");
							hiddenField.setAttribute("value", ${list.projectNo});
							form.appendChild(hiddenField);
							
							document.body.appendChild(form);
							
							form.submit();
						})
					</script>
				</c:when>
				</c:choose>
				<c:choose>
				<c:when
					test="${pageContext.request.userPrincipal.name eq member.memberId && list.projectStatus==4}">
					<input type="button" id="prodel" class="btns" value="삭제">
					<script>
					$('#prodel').click(function(){
						var form=document.createElement("form");
						form.setAttribute("method", "post");
						form.setAttribute("action", "prodel");
						
						var hiddenField=document.createElement("input");
						hiddenField.setAttribute("type", "hidden");
						hiddenField.setAttribute("name", "projectNo");
						hiddenField.setAttribute("value", ${list.projectNo});
						form.appendChild(hiddenField);
						
						document.body.appendChild(form);
						
						form.submit();
					})
					</script>
				</c:when>
				</c:choose>
			</div>
			
			<br>
<%-- 
			<table>
				<tr>
					<td><input type="button" id="wordBtn" value="워드로 보기"></td>
				</tr>
				<tr>
					<td><a href="story?projectNo=${list.projectNo}">프로젝트 스토리</a></td>
					<td style="padding-left: 30px"><a
						href="productDetail?projectNo=${list.projectNo}">상품 상세</a></td>
					<td style="padding-left: 30px"><a
						href="community?projectNo=${list.projectNo}">커뮤니티</a></td>
					<td style="padding-left: 30px"><a href="">환불 및 교환</a></td>
				</tr>
			</table> --%>
			</form>
			</fieldset>	
		</div>
<script>
	$(function() {
		$('#wordBtn').click(function(){
			location.href="download?projectNo="+$('#projectNo').val();
		});
	});
</script>


