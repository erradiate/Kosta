<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<script type="text/javascript" src="/js/common_function.min.js"></script>
<script>
function fnRetComStatus(){
	var params = {txprDscmNo : $("#txtRegNum").val()};
	$.post( "./proc/procRetStatus.asp", params)
	  .done(function( data ) {
	  	var outRegNum = $("#txtRegNum").val();
		outRegNum = Left(outRegNum,3) + "-" + outRegNum.substring(3,5) + "-" + Right(outRegNum,5); //custom javasciprt left, right function
	  	$("#txtDscmNo").html(outRegNum);		
		$(data).each(function(){
			$("#txtTrtCntn").html($(this).find("map>trtCntn").text());
		 });
	});
}
</script>

<body>
<table width="100%"  border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td>사업자등록번호</td>
    <td><input type="text" id="txtRegNum"/></td>
	<td><button onClick="fnRetComStatus();" style="cursor:pointer;">조회하기</button></td>
  </tr>
</table>
<hr/>
사업자등록상태 조회결과
<table width="100%"  border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td>사업자등록번호</td>
    <td>사업자등록상태</td>
  </tr>
  <tr>
    <td id="txtDscmNo">&nbsp;</td>
    <td id="txtTrtCntn">&nbsp;</td>
  </tr>
</table>

</body>
</html>