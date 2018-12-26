<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	#content{
		width:40%;
		margin: 30px auto 0 auto;
	}
	
	h2{
		font-size: 40px;
		font-weight: bold;
		
		color: gray;
	}
	
	#content p a{
		font-size: 20px;
		font-weight: bold;
		
		color: black;
	}
	
	#content p a:hover{
		text-decoration: none;
	}
</style>

<div id="content">
	<fieldset>
	<h2>마이페이지</h2>
	<p><a href="mydonate">내 후원 현황</a></p>
	<p><a href="myProject">내가 만든 프로젝트</a></p>
	<p><a href="editinfo">개인정보 수정</a></p>
	<p><a href="j_spring_security_logout">로그아웃</a></p>
	<p><a href="cash">캐쉬충전</a></p>
	</fieldset>
</div>