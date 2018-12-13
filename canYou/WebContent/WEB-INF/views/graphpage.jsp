<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <title>Learn D3 in 5 minutes</title>
</head>
<script src='https://d3js.org/d3.v4.min.js'></script>
<style> 
svg { border: 1px solid; } 
.bar { fill: skyblue; } 
.bar:hover { fill: blue; } 
.text { fill: white; font-weight:bold; } 
</style> 

<body>
<svg width="800" height="500"></svg> 

<script> 
var dataset = [{x:'A', y:9 }, {x:'B', y:19}, {x:'C', y:29}, {x:'D', y:39}, 
    {x:'E', y:29}, {x:'F', y:19}, {x:'G', y:9 }, {x:'H', y:29 }];

	var svg = d3.select("svg");
	
	var width  = parseInt(svg.style("width"), 10)-30;
	var height = parseInt(svg.style("height"), 10)-20;
	
	var svgG = svg.append("g")                                              
   				.attr("transform", "translate(10, 0)");

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
		.attr("transform", "translate(10,0)")
	    .call(d3.axisLeft(yScale).ticks(5)); //y축은 axisLeft로 좌측에 축을 그림
		
	svg.append("g")                                                      
	    .attr("transform", "translate(0," + (height) + ")")
	    .call(d3.axisBottom(xScale)); //x축은 axisBottom로 축을 그림

</script>

</body>
</html>