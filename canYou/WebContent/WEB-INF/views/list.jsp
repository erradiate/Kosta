<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

</head>
<body>
	<div>
		<fieldset>
			<legend>Project List</legend>
			<form method="POST" action="modify">
			<table>
				<thead></thead>
				<tbody>
						<tr>
							<td>프로젝트 명 : <input type="text" name="projectName"></td>
						</tr>
						<tr>
							<td>목표금액 : <input type="text" name="projectCost"></td>
						</tr>

						<tr>
							<td>이미지 업로드 : <input name="projectMainImage" id="projectMainImage" type="text"></td>
						</tr>
						<tr>
							<td>프로젝트 스토리 : <input type="text" name="projectStory"></td>
						</tr>				
				</tbody>
				
				<tfoot>
					<tr>
						<td>
						<input type="submit" id="wBtn" value="수정">
					</td>
					</tr>
				</tfoot>
			</table>
			</form>
		</fieldset>
	</div>