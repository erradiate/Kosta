<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
table {
	margin: 0 auto;
}
#community{
	margin: 0 auto;
}
p{
	font-size: large;
}
td{
	align-items: center;
}
</style>
<div class="comment" align="center">
	<!-- 이전 페이지에서 받아온 값을 안보이게 히든으로 넣어 둠 -->
	<input type="hidden" id="projectNo" name="projectNo" value="${list.projectNo}">
	<input type="hidden" id="replyNo" name="replyNo" value="${list.replyNo}">
	
	<div id="community">
		<p><strong>커뮤니티 수정</strong></p>
	</div>
	<form>
		<table>
			<tr>
				<td>댓글 수정</td>
			</tr>
			<tr>
				 <td><textarea rows="25" cols="100" id="replyContent" name="replyContent">${list.replyContent}</textarea>
			</tr>
			<tr>
				<td><!-- <input type="submit" class="btns" value="수정">  -->
				<input onclick="checkValue()" class="btns" value="수정"> 
				<input type="hidden" name="projectNo" value="${list.projectNo}"> 
				<input type="hidden" name="replyNo" value="${list.replyNo}"></td>
			</tr>
		</table>
	</form>
</div>
<script type="text/javascript">
function checkValue(){
 	var param = JSON.stringify({
 		"projectNo" : $('#projectNo').val(),
		"replyNo" : $('#replyNo').val(),
		"replyContent" : $('#replyContent').val()
 	});
	$.ajax({
		url: 'commentmodify',
		type:'POST',
		data: param,
		dataType:'json',
		contentType : "application/json; charset=UTF-8",
		success: function(ret){
	
		    window.opener.document.location.reload(); 
            opener.updateForm = null;
            self.close();
		},
		error:function(request,status,error){
	        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       }
		
	});
}
</script>
