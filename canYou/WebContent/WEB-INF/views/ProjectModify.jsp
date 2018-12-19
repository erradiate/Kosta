<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
#tv {
	border: 1px solid black;
}

#prouptitle{
		font-weight: bold;
		font-size:35px;
		margin-bottom:10px;
		color: gray;
		text-align: center;
}

#modifyform{
	border: 1px solid gray;
	margin: 10px;
	padding-top:10px;
	padding-left:10px;
	padding-right:10px;
	border-radius: 5px;
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

#projectMainImage{
	width: 300px;
	border: 1px dotted #999;
	border-radius: 5px;
}

.filebox input[type="file"] {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    overflow: hidden;
	clip:rect(0,0,0,0);
    border: 0;
}

.filebox label {
    display: inline-block;
    padding: .5em .75em;
    color: #999;
    font-size: inherit;
    line-height: normal;
    vertical-align: middle;
    background-color: #fdfdfd;
    cursor: pointer;
    border: 1px solid #ebebeb;
    border-bottom-color: #e2e2e2;
    border-radius: .25em;
    margin-bottom: 0
}

/* named upload */
.filebox .upload-name {
    display: inline-block;
    padding: .5em .75em;
    font-size: inherit;
    font-family: inherit;
    line-height: normal;
    vertical-align: middle;
    background-color: #f5f5f5;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
}

.filebox.bs3-primary label {
  color: #fff;
    background-color: #337ab7;
    border-color: #2e6da4;
}
</style>
<meta charset="EUC-KR">
<title>projectModify.jsp</title>

<script>
	$(document).ready(function() {
		CKEDITOR.replace('cont', {
			height : '500px',
			filebrowserImageUploadUrl : 'imageUpload'
		})
	});
</script>
<div id="modifyform">
	<h1 id="prouptitle">프로젝트 수정</h1>
	<form action="modify" method="POST" enctype="multipart/form-data">
		<p><span class="title">프로젝트 명 : </span><input type="text" name="projectName" class="pupinput" value=${project.projectName } required></p>
								
		<div class="filebox preview-image">
		<p><span class="title">프로젝트 대표 이미지 : </span>
		<input class="upload-name" value="파일선택" disabled="disabled">
		<label for="mfile">업로드</label> 
		<input type="file" id="mfile" name="multipartFile" class="upload-hidden"></p>
		<p><img id="projectMainImage"></p>
		
		</div>
		<p><span class="title">프로젝트 스토리 : </span></p>
		<p><textarea rows="20" cols="20" name="projectStory" id="cont">${project.projectStory }</textarea></p>
				
		<p><input type="submit" id="wBtn" class="btns" value="수정"></p>
	</form>
</div>

<script>
$('#projectMainImage').hide();

function readURL(input) {
	
    if (input.files && input.files[0]) {
        var reader = new FileReader();
 		
        $('.upload-name').val(input.files[0].name);
        reader.onload = function (e) {
            $('#projectMainImage').attr('src', e.target.result);
            
           
        }
 
        reader.readAsDataURL(input.files[0]);
       
    }
   
    $('#projectMainImage').show();
}
 
$("#mfile").change(function(){
    readURL(this);
});
</script>