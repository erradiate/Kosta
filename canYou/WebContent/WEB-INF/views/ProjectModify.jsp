<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
#tv {
	border: 1px solid black;
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

	<div>
		<fieldset>
			<legend>Project List</legend>
			<form action="modify" method="POST" enctype="multipart/form-data">
				<table>
					<thead></thead>
					<tbody>
						<tr>

							<td>프로젝트 명 : <input type="text" name="projectName"
								value=${project.projectName } required></td>
						</tr>
						<tr>
							<td>프로젝트 이미지 :</td>
							<td><input type="file" name="multipartFile"></td>
						</tr>
						<tr>
							<td>프로젝트 스토리 : <textarea rows="20" cols="20"
									name="projectStory" id="cont">${project.projectStory }</textarea></td>
						</tr>

					</tbody>

					<tfoot>
						<tr>
							<td><input type="submit" id="wBtn" class="btns" value="수정"></td>
						</tr>
					</tfoot>
				</table>
			</form>

		</fieldset>
	</div>

