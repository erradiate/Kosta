<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<<<<<<< HEAD
<script>
$(document).ready(function(){
	$('.caname').click(function(){
		console.log($(this).html());
		$.ajax({
			url: 'subcaname',
			async:true,
			type:'POST',
			data:{
				categoryName: $(this).html()
			},
			dataType:'text',
			success: function(jqXHR){
				console.log(jqXHR)
				var obj = JSON.parse(jqXHR);
=======
>>>>>>> branch 'master' of https://github.com/erradiate/Kosta

				$.each(obj,function(index,item){
                   var option=$("<div>"+item.subcategoryName+"</div>");
                   $(this).closest('div').append("whit");
                });
			}
		})
	});
});
</script>
<h1><a href="AllList">모든 프로젝트</a></h1>
<h2>카테고리 별 보기</h2>

<c:forEach var="e" items="${list}" varStatus="idx">
<<<<<<< HEAD
    <div class="category"> ▶<span class="caname">${e.categoryName}</span></div>
      <!-- <a href="categoryproject?categoryNo=${idx.index+1}">▶${e.categoryName}</a>-->
</c:forEach>
=======
      <tr>
         <td>
         <a href="categoryproject?categoryNo=${idx.index+1}">▶${e.categoryName}</a>
         </td>
      </tr>
   </c:forEach>
  </table>
>>>>>>> branch 'master' of https://github.com/erradiate/Kosta
