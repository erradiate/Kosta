<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<script src="../../js/member/member.js?ver=1"></script>
<link href="../../css/member/member.css?ver=1" type="text/css" rel="stylesheet">

<style>
.main{ margin: 0 auto;
    width: 40%;
}

.main h3{ margin: 60px auto;
text-align: center; font-size: 2em;
font-weight: bold; }

fieldset{
    border: none;
}

fieldset > div{ 
    position: relative;
    margin-bottom: 10px;
}

.none{
    display: none;
}


.error{ 
    font-size: 0.8em;
    position: absolute;
    width: auto;
    top: 18px; right: 10px;
    text-align: right;
    color: red;
}

.vaild{
    font-size: 0.8em;
    position: absolute;
    width: 150px;
    top: 18px; right: 10px;
    text-align: right;
    color: forestgreen;
}

input[type=text], select, input[type=password], input[type=email] {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

input[type=submit],input[type=boutton] {
    width: 100%;
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px auto;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

input[type=submit]:hover,input[type=boutton]:hover {
    background-color: #45a049;
}

#wrap_gender{
    border-radius: 4px;
    border: 1px solid #ccc;
    display: flex;
}

.gender{
    display: block;
    height: 100%; width: 50%;
    border-right: 1px solid #ccc;
}

.no_line{
    border-right:none;
}

.gender > label {
    display: block;
    /*width: 100%; height: 100%;*/
    padding: 10px 0;
    text-align: center;
    font-size: 0.8em;
    color: #666;
}

input[type=radio]{
   display: none;
}

.gender_act{
    display: inline-block;
    height: 100%; width: 50%;
    background-color: #45a049;
    color:#fff;
}

.gender_act > label {
    display: inline-block;
    width: 100%; height: 100%;
    padding: 10px 0;
    text-align: center;
    font-size: 0.8em;
    color: #fff;
}

</style>

    <div class="container">
        <div class="header">
            <div class="logo"></div>
        </div>
        <div class="main">
            <h3>회원가입</h3>
            <div>
                <form action="addMember" method="POST">
                    <fieldset>
                    	<div>
                            <label for="id"></label> <input type="text" id="id"
                                name="memberId" placeholder="ID" required> 
                            <span id="MsgId" class="none"></span>
                        </div>
                        <div>
                            <label for="pwd"></label> <input type="password" id="pwd"
                                name="memberPwd" placeholder="비밀번호" onblur="ck_pwd()" required> 
                            <span id="MsgPw" class="none">유효성체크</span>
                        </div>  
                         <div>   
                            <label for="pwd_ck"></label> <input type="password" id="pwd_ck"
                             placeholder="비밀번호 확인" onblur="ck_pwd2()" required>
                             <span id="MsgPwck" class="none">유효성체크</span>
                        </div>   
                        <div>    
                            <label for="name"></label> <input type="text" id="name"
                        name="memberName" placeholder="이름" onblur="ck_name()" required> 
                            <span id="MsgName" class="none">유효성체크</span>
                        </div>     
  
                        <div>
                            <label for="email"></label> <input type="email" id="email"
                                name="memberEmail" placeholder="이메일 ( ex@codepen.com)" onblur="ck_email()" required> 
                            <span id="MsgId" class="none"></span>
                        </div>
                        <div>
                            <label for="addr"></label> <input type="text" id="addr"
                                name="memberAddr" placeholder="주소" onblur="ck_email()" required> 
                                <input type="button" onclick="addrSearch()" value="주소 찾기"><br>
                            <span id="MsgId" class="none"></span>
                        </div>
                    
                        <div>
                            <label for="tel"></label> <input type="text" id="tel"
                                name="memberPhone" placeholder="휴대폰 번호" onblur="ck_email()" required> 
                            <span id="MsgId" class="none"></span>
                        </div>
                        <div>
                            <label for="account"></label> <input type="text" id="account"
                                name="memberAccount" placeholder="계좌번호" onblur="ck_email()" required> 
                            <span id="MsgId" class="none"></span>
                        </div>

					<div>
						<input class="upload-name" value="파일선택" disabled="disabled">
						<label for="mfile">프로필 이미지</label> <input type="file" id="mfile"
							name="memberImage" class="upload-hidden" required>
							<p><img id="memberImage"></p>
					</div>
					
					<div> 
						 <label for="gender"></label> <input type="text" id="memberGender"
                                name="memberGender" placeholder="성별" onblur="ck_email()" required> 
                            <span id="MsgId" class="none"></span>
					
					
					<!--
                            <span id="wrap_man" class="gender">
                            <input type="radio" id="man" name="memberGender" onclick="ck_gender()"> <label for="man"> 남자 </label>
                            </span>
                            <span id="wrap_woman" class="gender no_line">
                            <input type="radio" id="woman" name="memberGender" onclick="ck_gender()"> <label for="woman" onclick="ck_gender()"> 여자 </label>
                            </span>
                              -->
                         </div> 
                        <span id="MsgGender" class="none">유효성체크</span>
                        <div> 
                            <label for="age"></label> <input type="text" id="age"
                                name="memberAge" placeholder="나이" onblur="ck_email()" required> 
                            <span id="MsgId" class="none"></span>
                        </div>

                        <input type="submit" value="Submit">
                    </fieldset>
                </form>
            </div>
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
    
    
    function readURL(input) {
    	
        if (input.files && input.files[0]) {
            var reader = new FileReader();
     		
            $('.upload-name').val(input.files[0].name);
            reader.onload = function (e) {
                $('#memberImage').attr('src', e.target.result);   
            }
            reader.readAsDataURL(input.files[0]);
        }
        $('#memberImage').show();
    }
     
    $("#mfile").change(function(){
        readURL(this);
    });
    
    function ck_email(){
        var email = document.getElementById("email")
        var MsgId = document.getElementById("MsgId")
        var isEmail = /([\w\-]+\@[\w\-]+\.[\w\-]+)/

        if(!isEmail.test(email.value)){
            MsgId.style.display="block";
            MsgId.className='error'
            MsgId.innerHTML="이메일 형식을 확인하세요"
            email.focus()
            return false;
        } else{
            MsgId.className='vaild'
            MsgId.innerHTML="ok"
        }   
}

function ck_pwd(){
        var pwd = document.getElementById("pwd")
        var MsgPw = document.getElementById("MsgPw")
        var isPwd = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,20}$/
        
        if(!isPwd.test(pwd.value)){
            MsgPw.style.display="block";
            MsgPw.className='error'
            MsgPw.innerHTML="숫자포함 최소 6자리 이상"
            pwd.focus()
            return false;
        } else{
            MsgPw.className='vaild'
            MsgPw.innerHTML="ok"
        }   
}


function ck_pwd2(){
        var pwd_ck = document.getElementById("pwd_ck")
        var pwd = document.getElementById("pwd").value
        var MsgPwck = document.getElementById("MsgPwck")
        
        if(pwd_ck.value!=pwd){
            MsgPwck.style.display="block";
            MsgPwck.className='error'
            MsgPwck.innerHTML="비밀번호가 일치하지 않습니다."
            pwd_ck.focus()
            return false;
        } else{
            MsgPwck.className='vaild'
            MsgPwck.innerHTML="ok"
        }   
}


function ck_name(){
        var name = document.getElementById("name")
        var MsgName = document.getElementById("MsgName")
        
        if(name.value==''){
            MsgName.style.display="block";
            MsgName.className='error'
            MsgName.innerHTML="2자 이상 입력하세요."
            name.focus()
            return false;
        } else{
            MsgName.className='vaild'
            MsgName.innerHTML="ok"
        }   
}


function ck_gender(){
    var wrap_gender = document.getElementById("wrap_gender")
    var man = document.getElementById("man")
    var woman = document.getElementById("woman")
    var MsgGender = document.getElementById("MsgGender")

    
    if(man.checked){
        document.getElementById("wrap_man").className='gender_act';
        document.getElementById("wrap_woman").className='gender';
    }
    
    if(woman.checked){
        document.getElementById("wrap_woman").className='gender_act';
        document.getElementById("wrap_man").className='gender';
    }

}
</script>
