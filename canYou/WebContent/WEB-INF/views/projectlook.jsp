<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<style>
	#searchType{
		 width: 200px; /* 원하는 너비설정 */
	    padding: .2em .3em; /* 여백으로 높이 설정 */
	    font-family: inherit;  /* 폰트 상속 */
	    background: url('resources\images\down.png') no-repeat 95% 50%; /* 네이티브 화살표를 커스텀 화살표로 대체 */
	    border: 1px solid #999;
	    -webkit-appearance: none; /* 네이티브 외형 감추기 */
	    -moz-appearance: none;
	    appearance: none;
		border-radius: 5px;
	}
	
	#searchIndex{
		border: 1px solid #999;
		border-radius: 5px;
	}
</style>
<div align="center">
	<h1>프로젝트 둘러보기</h1>
	<form method="POST" action="search">
		<input type="hidden" name="page" value="1">
		<select name="searchType" id="searchType">
			<option value="1">작성자</option>
			<option value="2">프로젝트명</option>
		</select>&nbsp; <input name="searchValue" id="searchIndex" size="100px"
		pattern=".{2,}"
		title="최소한 2자 이상의 글자가 있어야 합니다."> 
		
		
		<input type="submit" value="검색하기" class="btns">
	</form>
	<table>
		<tr align="center">
			<td style="padding-top: 30px"><h3>
					<a href="lookaround">모든 프로젝트 보기</a>
				</h3></td>
			<td style="padding-top: 30px"><h3>
					<a href="">기간별 둘러보기</a>
				</h3></td>
			<td style="padding-top: 30px"><h3>
					<a href="graph">통계별 둘러보기</a>
				</h3></td>
		</tr>
		<tr align="center">
			<td><img src="resources/images/category.PNG"
				style="margin: 60px 10px 10px 10px; width: 250px; height: 300px;"></td>
			<td><img src="resources/images/12cal.jpg"
				style="margin: 60px 10px 10px 10px; width: 250px; height: 300px;"></td>
			<td><img src="resources/images/graph1.png"
				style="margin: 60px 10px 10px 10px; width: 250px; height: 300px;"></td>
		</tr>
	</table>
</div>
<script>

</script>