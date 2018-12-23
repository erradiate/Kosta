package or.kr.project.mvc.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import or.kr.project.mvc.dao.GraphDaoImple;
import or.kr.project.mvc.dao.projectDaoImple;

@Controller
public class GraphController {
	@Autowired
	private GraphDaoImple dao;
	
	@RequestMapping(value = "/graph")
	public String graphLook() {
		return "graphpage";
	}
	
	//나이별 카테고리 후원 수
	/*
	@RequestMapping(value = "/categorygraph")
	public String ageGraph(Model m,String age) {
		Map<String,Integer> hash = new HashMap<>();
		int startAge=0;
		int endAge=0;

		switch (Integer.parseInt(age)) {
			case 10:
				startAge=10;
				endAge=19;
				break;
	
			case 20:
				startAge=20;
				endAge=29;
				break;
				
			case 30:
				startAge=30;
				endAge=39;
				break;
			case 40:
				startAge=40;
				endAge=49;
				break;
				
			case 50:
				startAge=50;
				endAge=89;
				break;
	
			default:
				break;
		}
		
		hash.put("startAge",startAge);
		hash.put("endAge", endAge);
		
		Map<Object, Object> map = dao.categorygraph(hash);
		m.addAttribute("map", map); //카테고리명, 후원자 수 map으로 전달
		System.out.println("categoryName : "+map.get("categoryName"));
		System.out.println("count : "+map.get("count"));
		
		return "categorygraph";
	}
	*/
}
