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
	font-size: 25px;
	font-weight:bold;
	line-height: 2em;
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

.tdclass2{
	color: black;
	font-size: 18px;
	line-height: 1.5em;
}

</style>
 
<div>
		<fieldset>
			<form action="update" method="POST" >	
			<input type="hidden" id="projectNo" name="projectNo" value="${list.projectNo}">
			<p id="castyle">[ ${c} ]</p>
				<c:choose>
						<c:when test="${sc!=null}">
								<p id="castyle2">${sc}</p>
	                     </c:when>
	            </c:choose>
            
				<h1 style="margin:30px 100px 30px 260px; font-size: 40px; color: black;">프로젝트 이름 : ${list.projectName}</h1>
				<div class="left-box">
				<img id="projectMainImage"
						src="resources/images/${list.projectMainImage }"
						style="margin: 20px 30px 30px 280px; width: 520px; height: 500px;"></div>
			<table style="margin: 50px 30px 120px 60px;">
				<thead></thead>
				<tbody>
						<tr>
							<td class="tdclass2">프로젝트 주최자 </td>
						</tr>
						<tr>
							<td class="tdclass">${member.memberName}</td>
						</tr>
						<tr>
							<td class="tdclass2">목표금액</td>
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
							<td class="tdclass2">프로젝트 마감날짜</td>
						</tr>
						<tr>
							<td class="tdclass">${list.projectEndDate}</td>
						</tr>
						<tr>
							<td class="tdclass2">모인 후원 금액</td>
						</tr>
						<tr>
							<td class="tdclass">${list.projectCurCost}원</td>
						</tr>
						<tr>
							<td class="tdclass2">후원자 수</td>
						</tr>
						<tr>
							<td class="tdclass">${list.projectFundCnt}명</td>
						</tr>
						<tr>
							<td class="tdclass2">프로젝트 등급</td>
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


