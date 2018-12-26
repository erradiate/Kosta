<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<style>
	#info{
		border: 1px solid gray;
		margin: 10px auto 0 auto;
		padding-left:10px;
		padding-right:10px;
		border-radius: 5px;
		width: 60%;
	}
	
	.title{
		borer-bottom: 1px dotted gray;
		color: gray;
		font-weight: bold;
	}
	
	h1{
		font-size: 40px;
		font-weight: bold;
		color: gray;
		margin-top:10px;
	}
	
	input{
		border: 1px solid #999;
		border-radius: 5px;
	}
</style>
<div id="container">
<div align="center">
<h1>개인정보 수정</h1>
</div>
<div id="info">
<form action="success" method="POST">
	<p><span class="title">이름 : </span><input type="text" name="memberName" value="${list.memberName }"></p>
	<p><span class="title">기존 비밀번호 : </span><input type="password" name="targetPwd"></p>
	<p><span class="title">변경할 비밀번호 : </span><input type="password" name="memberPwd"></p>
	<p><span class="title">주소 : </span><label for="addr"></label><input type="text" id="addr"
                                name="memberAddr" size=70 value="${list.memberAddr }" placeholder="주소" required> 
                                <input type="button" onclick="addrSearch()" value="주소 찾기"><br>
                            <span id="MsgId" class="none"></span></p>
	<p><span class="title">휴대폰 번호 : </span><input type="text" name="memberPhone" value="${list.memberPhone }"></p>
	<p><span class="title">이메일 : </span><input type="text" name="memberEmail" value="${list.memberEmail }"></p>
	<p><span class="title">나이 : </span><input type="text" name="memberAge" value="${list.memberAge }"></p>
	<p><span class="title">계좌 : </span><input type="text" name="memberAccount" value="${list.memberAccount }"></p>
	<!--<p><label>프로필 이미지 : </label><input name="mfile" type="file"></p>-->
	
	<p><input type="submit" class="btns" value="수정하기"></p>
	
</form>
</div>

</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function addrSearch() {
    new daum.Postcode(
            {
                oncomplete : function(data) {                      
                    var fullAddr = ''; 
                    var extraAddr = ''; 

                    // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        fullAddr = data.roadAddress;

                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        fullAddr = data.jibunAddress;
                    }

                    // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                    if (data.userSelectedType === 'R') {
                        //법정동명이 있을 경우 추가한다.
                        if (data.bname !== '') {
                            extraAddr += data.bname;
                        }
                        // 건물명이 있을 경우 추가한다.
                        if (data.buildingName !== '') {
                            extraAddr += (extraAddr !== '' ? ', '
                                    + data.buildingName : data.buildingName);
                        }
                        // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                        fullAddr += (extraAddr !== '' ? ' (' + extraAddr
                                + ')' : '');
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('addr').value = fullAddr;

                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById('addr').focus();
                }
            }).open();
}
</script>