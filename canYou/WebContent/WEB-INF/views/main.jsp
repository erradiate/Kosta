<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="resources/js/myplugin.js"></script>

<style>
.subject {
	color: black;
	font-size: 18px;
	line-height: 4em;
	font-weight: bold;
}

.proimg {
	margin: 5px 35px 10px 0px;
	width: 180px;
	height: 140px;
}

ul {
  list-style: none;
}

.slider {
  width: 100%;
  height: 200px;
  margin: 0 auto;
  position: relative;
  overflow: hidden;
  display:inline;
  float:left;
}

.slider .panel {
  width: 100%;
  height: 100%;
  position: relative;
} 

.slider .panel li {
  top: 0px;
  left: 0px;
  display: none;
}

.prev {
  width: 30px;
  height: 30px;
  margin-top: -15px;
}

.next {
  width: 30px;
  height: 30px;
  margin-top: -15px;
}

</style>

<div>
	<img src="resources/images/1.jpg" id="g"
		style="margin: 0px 30px 30px 0px; width: 100%; height: 550px;">
</div>
<nav style="margin: 0 auto; padding:0% 5% 0% 5%;
width: 80%;">
<table>
		<tr>
			<td colspan="3">
			<div class="subject">인기 프로젝트</div>
			</td>
		</tr>
		
		<tr>
			<td>
				<button class="prev">&lt</button>
			</td>
			<c:set var="i" value="0"/>
			<td>
			<div class="slider">
				<ul id="panel1" class="panel">
				<c:forEach var="plist" items="${plist}">
				<c:if test="${i%4==0}">
					<c:set var="j" value="${i+3}"/>
					<c:if test="${i==0}">
						<li class="on">
						<div style="white-space: nowrap;">
					</c:if>
					<c:if test="${i!=0}">
						<li>
						<div style="white-space: nowrap;">
					</c:if>
				</c:if>
					<a href="story?projectNo=${plist.projectNo}">
					<img src="resources/images/${plist.projectMainImage}" class="proimg"></a>
				<c:if test="${i==j}">
					</div>
					</li>
				</c:if>
				<c:set var="i" value="${i+1}"/>
				</c:forEach>
				</ul>
			</div>
			</td>
			
			<td>
				<button class="next">&gt</button>
			</td>
		</tr>

		<tr>
			<td colspan="3">
				<div class="subject">새로운 프로젝트</div>
			</td>
		</tr>
		
		<tr>
			<td>
				<button class="prev">&lt</button>	
			</td>
			<c:set var="i" value="0"/>
			<td>
			<div class="slider">
				<ul id="panel2" class="panel">
				<c:forEach var="nlist" items="${nlist}">
				<c:if test="${i%4==0}">
					<c:set var="j" value="${i+3}"/>
					<c:if test="${i==0}">
						<li class="on">
						<div style="white-space: nowrap;">
					</c:if>
					<c:if test="${i!=0}">
						<li>
						<div style="white-space: nowrap;">
					</c:if>
				</c:if>
					<a href="story?projectNo=${nlist.projectNo}">
					<img src="resources/images/${nlist.projectMainImage}" class="proimg"></a>
				<c:if test="${i==j}">
					</div>
					</li>
				</c:if>
				<c:set var="i" value="${i+1}"/>
				</c:forEach>
				</ul>
			</div>
			</td>
			<td>
				<button class="next">&gt</button>
			</td>
		</tr>
		
		<tr>
			<td colspan="3">
			<div class="subject">마감 임박 프로젝트</div>
			</td>
		</tr>
		<tr>
			<td>
				<button class="prev">&lt</button>	
			</td>
			<c:set var="i" value="0"/>
			<td>
			<div class="slider">
				<ul id="panel3" class="panel">
				<c:forEach var="dlist" items="${dlist}">
				<c:if test="${i%4==0}">
					<c:set var="j" value="${i+3}"/>
					<c:if test="${i==0}">
						<li class="on">
						<div style="white-space: nowrap;">
					</c:if>
					<c:if test="${i!=0}">
						<li>
						<div style="white-space: nowrap;">
					</c:if>
				</c:if>
					<a href="story?projectNo=${dlist.projectNo}">
					<img src="resources/images/${dlist.projectMainImage}" class="proimg"></a>
				<c:if test="${i==j}">
					</div>
					</li>
				</c:if>
				<c:set var="i" value="${i+1}"/>
				</c:forEach>
				</ul>
			</div>
			</td>
			<td>
				<button class="next">&gt</button>
			</td>
		</tr>
</table>
</nav>

<div style="float: left; width: 50%">
	<img src="resources/images/11.jpg"
		style="margin: 80px 30px 30px 180px; width: 600px; height: 160px;">
</div>
<div style="float: right; width: 50%">
	<img src="resources/images/22.jpg" class="rightimg"
		style="margin: 80px 30px 30px 180px; width: 600px; height: 160px;">
</div>

<script>

$(document).ready(function(){
	$('#g').myPluginFn();
	var i = $(".panel li .on").index()+1;
	var j = $("#panel2 li .on").index()+1;
	var k = $("#panel3 li .on").index()+1;
	console.log(i+" "+j+" "+k);
	console.log($("#panel1 li").length);
	console.log($("#panel2 li").length);
	console.log($("#panel3 li").length);
	//좌우 버튼 연동 //
	showSlide();
	showSlide2();
	showSlide3();
	  $(".prev").click(function() {
		if($(this).parent().next().children('div').children('ul').attr('id')==="panel1"){
			console.log('맞다');
			if (i == 0) {
			      i =  $("#panel1 li").length - 1;
			    } else {
			      i = i - 1;
			    }
			showSlide();
		}
		if($(this).parent().next().children('div').children('ul').attr('id')==="panel2"){
			console.log('맞다2');
			if (j == 0) {
			      j =  $("#panel2 li").length - 1;
			    } else {
			      j = j - 1;
			    }
			showSlide2();
		}
		if($(this).parent().next().children('div').children('ul').attr('id')==="panel3"){
			console.log('맞다3');
			if (k == 0) {
			      k =  $("#panel3 li").length - 1;
			    } else {
			      k = k - 1;
			    }
			showSlide3();
		}
		//console.log($(this).parent().next().children('div').children('ul').attr('id'));
	    
	  });

	  $(".next").click(function() {
		if($(this).parent().prev().children('div').children('ul').attr('id')==="panel1"){
	    	if (i == $("#panel1 li").length-1) {
	      		i = 0;
	    	} else {
	      		i = i + 1;
	    	}
	    	showSlide();
		}
		if($(this).parent().prev().children('div').children('ul').attr('id')==="panel2"){
	    	if (j == $("#panel2 li").length-1) {
	      		j = 0;
	    	} else {
	      		j = j + 1;
	    	}
	    	showSlide2();
		}
		if($(this).parent().prev().children('div').children('ul').attr('id')==="panel3"){
	    	if (k == $("#panel3 li").length-1) {
	      		k = 0;
	    	} else {
	      		k = k + 1;
	    	}
	    	showSlide3();
		}
	  });
	  
	  function showSlide() {
		    $("#panel1 li").stop(true, true).fadeOut();
		    $("#panel1 li").eq(i).stop(true, true).fadeIn();
	  }
	  
	  function showSlide2() {
		    $("#panel2 li").stop(true, true).fadeOut();
		    $("#panel2 li").eq(j).stop(true, true).fadeIn();
	  }
	  
	  function showSlide3() {
		  	$("#panel3 li").stop(true, true).fadeOut();
		    $("#panel3 li").eq(k).stop(true, true).fadeIn();
	  }
});

</script>