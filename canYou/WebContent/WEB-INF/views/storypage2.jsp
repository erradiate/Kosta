<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="wdetail.jsp" %>
<!-- Nav tabs storypage.jsp = 프로젝트 스토리 -->
         	<div id="underlinemenu">
         	<ul>
                <li><a class="hoverHolder" href="admin.wstory?projectNo=${list.projectNo}" class="current">프로젝트 스토리</a></li>
                <li><a href="admin.wproductDetail?projectNo=${list.projectNo}">상품 상세</a></li>
                <li><a href="">환불 및 교환</a></li>
            </ul> 
            </div> 
<!-- Nav tabs -->
<!-- 스토리 부분 -->
<div class="divStory">
<p style="margin:3%">${list.projectStory}</p>
</div>