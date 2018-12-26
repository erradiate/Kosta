<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.caname{
		font-size: 30px;
		font-weight: bold;
		color: gray;
	}
	
	.caname:hover{
		cursor: pointer;
	}
	
	.category div a{
		color: gray;
		margin-left:20px;
		font-size: 20px;
	}
	
	#content{
		width:40%;
		margin: 30px auto 0 auto;
	}
	
	#bigtitle{
		font-size: 40px;
		font-weight: bold;
		
		color: black;
		
	}
	
	#bigtitle:hover{
		text-decoration:none;
	}
	
	#list{
		margin-top: 30px;
	}
</style>
<script>
$(document).ready(function(){
	$('.caname').click(function(){
		if(!$(this).next().length){		// 세부 카테고리가 접혀 있을 때 (다음 요소가 없을 때)
			var span=$(this);
			var cn=$(this).prev().val();
			$.ajax({
				url: 'subcaname',
				async:true,
				type:'POST',
				data:{
					categoryNo: cn
				},
				dataType:'text',
				success: function(jqXHR){
					var obj = JSON.parse(jqXHR);
					var option="<div><a href=\"categoryproject?categoryNo="+cn+"\">- 전체</a>";
					$.each(obj,function(index,item){
	                   option=option+"<p><a href=\"categoryproject2?categoryNo="+cn+"&subcategoryNo="+item.subcategoryNo+"\">-"+item.subcategoryName+"</a></p>";
	                   
	                });
					option=option+"</div>"
					span.closest('div').append(option);
				}
			});
		}else{		// 세부 카테고리가 펼쳐져 있을 때 (다음 요소가 있을 때)
			$(this).next().remove();
		}
	});
});
</script>
<div id="content">
	<h1><a id="bigtitle" href="AllList">모든 프로젝트</a></h1>
	<div id="list">
	<c:forEach var="e" items="${list}" varStatus="idx">
	    <div class="category">
	     <input type="hidden" value="${e.categoryNo }"><span class="caname">▶${e.categoryName}</span>
	     </div>
	
	</c:forEach>
	</div>
</div>
