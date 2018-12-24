package or.kr.project.mvc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.util.JSONPObject;

import or.kr.project.dto.MemberVO;
import or.kr.project.dto.ProjectVO;
import or.kr.project.mvc.dao.GraphDaoImple;
import or.kr.project.mvc.dao.projectDaoImple;


@Controller
public class GraphController {
	@Autowired
	private GraphDaoImple dao;
	@Autowired
	private projectDaoImple dao2;
	
	/*
	@RequestMapping(value = "/graph")
	public String graphLook() {
		return "graphpage";
	}
	*/
	
	//나이별 카테고리 후원 수
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/graph")
	public String ageGraph(Model m,String projectNo,HttpServletRequest request) {
		// project 관련한 정보 빼오기
		ProjectVO list = dao2.projectlist(projectNo);
		String c = dao2.caselone(list.getCategoryNo());
		String sc = dao2.subcaselone(list.getSubCategoryNo());
		m.addAttribute("list", list);
		m.addAttribute("c", c);
		m.addAttribute("sc", sc);

		// project와 연결된 member 정보 가져오기
		MemberVO mem = dao2.memname2(list.getMemberNo());
		m.addAttribute("member", mem);

		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		
		Map<String,Integer> hash = new HashMap<>();
		hash.put("projectNo", Integer.parseInt(projectNo));
		
		JSONObject ageObject1 = new JSONObject();
		hash.put("startAge", 10);
		hash.put("endAge", 19);
		ageObject1.put("x", "10대");
		int count1 = dao.categorygraph(hash);
		System.out.println("count1 : "+count1);
		ageObject1.put("y", count1);
		
		JSONObject ageObject2 = new JSONObject();
		hash.put("startAge", 20);
		hash.put("endAge", 29);
		ageObject2.put("x", "20대");
		int count2 = dao.categorygraph(hash);
		ageObject2.put("y", count2);
		
		JSONObject ageObject3 = new JSONObject();
		hash.put("startAge", 30);
		hash.put("endAge", 39);
		ageObject3.put("x", "30대");
		int count3 = dao.categorygraph(hash);
		ageObject3.put("y", count3);
		
		JSONObject ageObject4 = new JSONObject();
		hash.put("startAge", 40);
		hash.put("endAge", 49);
		ageObject4.put("x", "40대");
		int count4 = dao.categorygraph(hash);
		ageObject4.put("y", count4);
		
		JSONObject ageObject5 = new JSONObject();
		hash.put("startAge", 50);
		hash.put("endAge", 89);
		ageObject5.put("x", "50대 이상");
		int count5 = dao.categorygraph(hash);
		ageObject5.put("y", count5);
		
		jsonArray.add(ageObject1);
		jsonArray.add(ageObject2);
		jsonArray.add(ageObject3);
		jsonArray.add(ageObject4);
		jsonArray.add(ageObject5);
		
		//jsonObject.put("graph", jsonArray);
		request.setAttribute("jsonArray", jsonArray);
		
		return "graphpage";
	}
	
}
