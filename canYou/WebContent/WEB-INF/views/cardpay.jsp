<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<style>
	#content{
		margin-top : 10px;
		margin-left:auto;
		margin-right:auto;
		width: 40%;
	}
	
	#content > h1{
		font-weight: bold;
		font-size:35px;
		margin-bottom:10px;
		color: gray;
		text-align: center;
	}
	
	#cardform{
		border: 1px solid gray;
		padding-left:20px;
		padding-right:10px;
		border-radius: 5px;
	}
	
	#pay{
		margin-left:80%;
	}
	
	.title{
		borer-bottom: 1px dotted gray;
		color: gray;
		font-weight: bold;
	}
	
	.pupinput{
		border: 1px solid #999;
		border-radius: 5px;
	}
	
	.category{
		 width: 100px; /* 원하는 너비설정 */
	    padding: .2em .3em; /* 여백으로 높이 설정 */
	    font-family: inherit;  /* 폰트 상속 */
	    background: url('resources\images\down.png') no-repeat 95% 50%; /* 네이티브 화살표를 커스텀 화살표로 대체 */
	    border: 1px solid #999;
	    -webkit-appearance: none; /* 네이티브 외형 감추기 */
	    -moz-appearance: none;
	    appearance: none;
		border-radius: 5px;
		text-align:right;
		margin-right:5px;
	}
</style>
<script>
$(document).ready(function(){
	
});
</script>
<div id="content">
	<h1>카드 결제</h1>		
	<div id="cardform">
		<form action="donate2" method="post">
			<p><span class="title">카드 번호 : </span><input type="text" class="pupinput"></p>
			<p><span class="title">카드 유효 기간 : 
			<select class="category" id="categoryNo" name="categoryNo" required>
				<option>1</option>
				<option>2</option>
				<option>3</option>
				<option>4</option>
				<option>5</option>
				<option>6</option>
				<option>7</option>
				<option>8</option>
				<option>9</option>
				<option>10</option>
				<option>11</option>
				<option>12</option>
			</select>월 
			
			<input type="text" class="pupinput">년</span></p>
			<p><span class="title">카드 비밀번호 : </span><input type="password" size="2" class="pupinput">**</p>
			<p><span class="title">소유주 생년월일 : </span><input type="text" class="pupinput"></p>
			<p><input type="submit" id="pay" class="btns" value="결제"></p>
		</form>
	</div>
</div>