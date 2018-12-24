<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="detail.jsp" %>
<script src='https://d3js.org/d3.v4.min.js'></script>
<style> 
svg { border: 1px solid;
	margin: 10px 100px 10px 80px;
 } 
.bar { fill: skyblue; } 
.bar:hover { fill: blue; } 
.text { fill: white; font-weight:bold; } 
svg text{
	font-size: 20px;
	font-weight: bolder;
}
#pStyle{
	float: left;
   width: 50%;
	text-align: center;
	font-size: 30px;
	font-weight: bold;
	margin-top: 40px;
}
#pStyle2{
	float: left;
   width: 50%;
	text-align: center;
	font-size: 30px;
	font-weight: bold;
	margin-top: 40px;
}

.sgv{
	float: left;
   width: 50%;
}

.sgv2{
	float: right;
   width: 50%;
}
</style> 
<input type="hidden" id="teen" value="">

<!-- Nav tabs storypage.jsp = 프로젝트 스토리 -->
         	<div id="underlinemenu">
         	<ul>
                <li><a href="story?projectNo=${list.projectNo}" class="current">프로젝트 스토리</a></li>
                <li><a href="productDetail?projectNo=${list.projectNo}">상품 상세</a></li>
                <li><a href="community?projectNo=${list.projectNo}" >커뮤니티
                	<input type="hidden" id="projectNo" value="${list.projectNo}">
                	<input type="hidden" id="memberId" value="${member.memberId}">
                	<input type="hidden" id="userPrincipalName" value="${pageContext.request.userPrincipal.name}">
                </a>
              
                </li> 
                <li>
                	<a href="graph?projectNo=${list.projectNo}&categoryNo=${list.categoryNo}" class="hoverHolder" >그래프보기</a>
                </li>
                 <c:choose>
					<c:when test="${pageContext.request.userPrincipal.name!=null }">
                		<li><a href="projectDonateList?projectNo=${list.projectNo}&memberNo=${member.memberNo}" >후원자 보기</a></li>
                	</c:when>
                </c:choose>
            </ul> 
            </div> 
<!-- Nav tabs --> 
<!-- 스토리 부분 -->
<div class="divStory">
	<p id="pStyle">이 프로젝트를 후원한 나이대 별 현황</p>
	<p id="pStyle2">최근 3개월간 이 카테고리 후원 현황</p>
<svg class="svg" width="650" height="400"></svg> 
<svg class="svg2" width="650" height="400"></svg> 

<script> 

var aj = eval('<%=request.getAttribute("ageArray")%>');

var dataset = [{x:aj[0].x, y:aj[0].y }, {x:aj[1].x, y:aj[1].y}, {x:aj[2].x, y:aj[2].y}, 
	{x:aj[3].x, y:aj[3].y}, {x:aj[4].x, y:aj[4].y}];

	var svg = d3.select(".svg");
	
	var width  = parseInt(svg.style("width"), 10)-40;
	var height = parseInt(svg.style("height"), 10)-30;
	
	var svgG = svg.append("g")                                              
   				.attr("transform", "translate(30, 5)");

	var yScale = d3.scaleLinear()                                           
				    .domain([0, d3.max(dataset, function(d){ return d.y; })])
				    .range([height, 0]);  

	var xScale = d3.scaleBand()                                  
		.domain(dataset.map(function(d) { return d.x;} ))
		.range([0, width]).padding(0.2);
		
	svg.selectAll("rect")
		.data(dataset)
		.enter().append("rect")
		.attr("class", "bar")
		.attr("height", function(d, i) {return height-yScale(d.y)})
		.attr("width", xScale.bandwidth())                         
		.attr("x", function(d, i) {return xScale(d.x)})
		.attr("y", function(d, i) {return yScale(d.y)});
	
	svg.selectAll("text")
		.data(dataset)
		.enter().append("text")
		.text(function(d) {return d.y})
		.attr("class", "text")
		.attr("x", function(d, i) {return xScale(d.x)+xScale.bandwidth()/2})
		.style("text-anchor", "middle")
		.attr("y", function(d, i) {return yScale(d.y) + 15});
		
	svgG.append("g")
		.attr("transform", "translate(10,10)")
	    .call(d3.axisLeft(yScale).ticks(5)); //y축은 axisLeft로 좌측에 축을 그림
		
	svg.append("g")                                                      
	    .attr("transform", "translate(0," + (height) + ")")
	    .call(d3.axisBottom(xScale)); //x축은 axisBottom로 축을 그림

</script>

<script>
var mj = eval('<%=request.getAttribute("monthArray")%>');

var data = [{x:mj[0].x, y:mj[0].y }, {x:mj[1].x, y:mj[1].y}, {x:mj[2].x, y:mj[2].y}, ];

	var svg2 = d3.select(".svg2");
	
	var width  = parseInt(svg2.style("width"), 10)-40;
	var height = parseInt(svg2.style("height"), 10)-30;
	
	var svgG2 = svg2.append("g")                                              
   				.attr("transform", "translate(30, 5)");

	var yScale = d3.scaleLinear()                                           
				    .domain([0, d3.max(data, function(d){ return d.y; })])
				    .range([height, 0]);  

	var xScale = d3.scaleBand()                                  
		.domain(data.map(function(d) { return d.x;} ))
		.range([0, width]).padding(0.2);
		
	svg2.selectAll("rect")
		.data(data)
		.enter().append("rect")
		.attr("class", "bar")
		.attr("height", function(d, i) {return height-yScale(d.y)})
		.attr("width", xScale.bandwidth())                         
		.attr("x", function(d, i) {return xScale(d.x)})
		.attr("y", function(d, i) {return yScale(d.y)});
	
	svg2.selectAll("text")
		.data(data)
		.enter().append("text")
		.text(function(d) {return d.y})
		.attr("class", "text")
		.attr("x", function(d, i) {return xScale(d.x)+xScale.bandwidth()/2})
		.style("text-anchor", "middle")
		.attr("y", function(d, i) {return yScale(d.y) + 15});
		
	svgG2.append("g")
		.attr("transform", "translate(10,10)")
	    .call(d3.axisLeft(yScale).ticks(5)); //y축은 axisLeft로 좌측에 축을 그림
		
	svg2.append("g")                                                      
	    .attr("transform", "translate(0," + (height) + ")")
	    .call(d3.axisBottom(xScale)); //x축은 axisBottom로 축을 그림

</script>

</div>

