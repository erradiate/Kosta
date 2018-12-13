<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <title>Learn D3 in 5 minutes</title>
</head>

<script src='https://d3js.org/d3.v3.min.js'></script>
<style>
	svg{
		width: :320px;
		height: 240px;
		border: 1px solid black;
	}
	
	.bar {
	    fill: skyblue;
	}
	.bar:hover {
	    fill: blue;
	}

	.text { fill: blue; font-weight:bold; }
</style>
<body>
<svg width="600" height="500"></svg> 
<script>
	var data = [{x:'A', y:9}, {x:'B', y:19}, {x:'C', y:29}, 
		{x:'D', y:39}, {x:'E', y:29}, {x:'F', y:19}, {x:'G', y:9}];

	var svg = d3.select("svg");
	
	svg.selectAll("rect") //chart안에 모든 div를 선택
			  .data(data) //위에서 정의된 데이터([4,8,15,16,23,42])를 selection.data()를 사용하여 bar에 넣어 줌. 이로써 bar는 6개의 데이터를 가짐  
			  //6개의 데이터를 가지고 있지만, 표현할 수 있는 rect가 아직 정의되어 있지 않음
			  //따라서 아래와 같이 enter().append("rect")를 사용해서 6개의 데이터를 표현할 수 있는 rect 6개를 생성
			  .enter().append("rect")
			  .attr("class", "bar")
	          .attr("width",70)
	          .attr("height", function(d,i){return d.y*5})
	          .attr("x", function(d, i) {return (75 * i)}) 
	          .attr("y", function(d, i) {return (250 -d.y*5)}); //d = data[i]

	svg.selectAll("text") 
		.data(data)
		.enter().append("text")
		.text(function(d) {return d.y})
		.attr("class", "text")
		.attr("x", function(d, i) {return (75 * i)+25}) 
	    .attr("y", function(d, i) {return (250 -d.y*5)});

</script>
</body>
</html>