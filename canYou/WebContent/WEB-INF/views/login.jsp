<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
	#loginWrap {
		width: 500px;
		margin: 40px auto 0 auto;
		
	}
	#loginWrap table{
		width: 100%; 
		border: 1px dotted #9900ff;
	}
	
	#loginWrap table td{
		margin-top:10px;
	}
	
	#loginWrap table thead{
		background-color: #b9b9ff;
	}
	
	.title{
		borer-bottom: 1px dotted gray;
		color: gray;
		font-weight: bold;
	}
	
	#member{
		margin-top:5px;
		font-weight: bold;
	}
</style>


<div id="loginWrap">
	<c:url var="loginUrl" value="/j_spring_security_check"></c:url>
	<form action="${loginUrl }" method="POST">
		<table>
			<tr>
				<td class="title">User ID :</td>
				<td><input type="text" name="username"/></td>
				<td rowspan="2"><input name="submit" class="btns" type="submit" value="login"/></td>
			</tr>
			<tr>
				<td class="title">Password :</td>
				<td><input type="password" name="password"/></td>
			</tr>
		</table>
		<div id="member">회원이 아니신가요? <a href="sign">회원가입</a></div>
	</form>
</div>

