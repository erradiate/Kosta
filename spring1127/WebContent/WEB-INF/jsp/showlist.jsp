<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="content">
		<p>여기는 메인 컨텐츠</p>
		<div>
			<fieldset>
				<legend></legend>
				<table>
					<thead>
					<tr>
						<td>번호</td>
						<td>이미지</td>
						<td>작성자</td>
						<td>날짜</td>
						<td>down</td>
					</tr>
					</thead>
					<tbody>
						<c:forEach var="listv" items="${list }">
							<tr>
								<td>${listv.num }</td>
								<td>${listv.img }</td>
								<td>${listv.writer }</td>
								<td>${listv.rdate }</td>
								<td><a href="fileDown?fileName=${listv.img}" style="color:black"
								>down</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
					<tr><td colspan="5">
						<input type="button" id="btn1" value="writer">
					</td></tr>
					<tr><td colspan="5">
						<a href="downloadExcel" style="color:black">download Excel</a>
					</td></tr>
					</tfoot>
				</table>
			</fieldset>
		</div>
	</div>
</div>