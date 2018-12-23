<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<style>

</style>

<form action="categorygraph" method="POST" >	
	<div class="selectbox"> 
		<select name="age"> 
			<option selected>나이대 선택</option> 
			<option value="10">10대</option> 
			<option value="20">20대</option> 
			<option value="30">30대</option> 
			<option value="40">40대</option> 
			<option value="50">50대 이상</option> 
		</select> 
	</div>
	<input type="submit" value="선택">
</form>