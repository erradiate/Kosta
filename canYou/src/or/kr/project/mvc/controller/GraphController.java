package or.kr.project.mvc.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
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
	
	//그래프 나타내는 함수 
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/graph")
	public String ageGraph(Model m,ProjectVO vo,HttpServletRequest request) {
		// project 관련한 정보 빼오기
		ProjectVO list = dao2.projectlist(Integer.toString(vo.getProjectNo()));
		String c = dao2.caselone(list.getCategoryNo());
		String sc = dao2.subcaselone(list.getSubCategoryNo());
		m.addAttribute("list", list);
		m.addAttribute("c", c);
		m.addAttribute("sc", sc);

		// project와 연결된 member 정보 가져오기
		MemberVO mem = dao2.memname2(list.getMemberNo());
		m.addAttribute("member", mem);

		//나이별 카테고리 후원 수 
		JSONArray ageArray = new JSONArray();
		Map<String,Integer> hash = new HashMap<>();
		hash.put("projectNo", vo.getProjectNo());
		
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
		
		ageArray.add(ageObject1);
		ageArray.add(ageObject2);
		ageArray.add(ageObject3);
		ageArray.add(ageObject4);
		ageArray.add(ageObject5);

		request.setAttribute("ageArray", ageArray);
		
		
		//최근 3개월 통계 보여주는 그래프
		JSONArray monthArray = new JSONArray();
		List<Integer> hashList = dao.monthGraph(vo);

		JSONObject monthObject1 = new JSONObject();
		monthObject1.put("x", "12월");
		if(hashList.size()==0) {
			monthObject1.put("y", 0);
		}else {
			monthObject1.put("y", hashList.get(0));
		}
		
		JSONObject monthObject2 = new JSONObject();
		monthObject2.put("x", "11월");
		if(hashList.size()==1) {
			monthObject2.put("y", 0);
		}else {
			monthObject2.put("y", hashList.get(1));
		}
		
		JSONObject monthObject3 = new JSONObject();
		monthObject3.put("x", "10월");
		if(hashList.size()==2) {
			monthObject3.put("y", 0);
		}else {
			monthObject3.put("y", hashList.get(2));
		}		
		
		monthArray.add(monthObject1);
		monthArray.add(monthObject2);
		monthArray.add(monthObject3);
		
		request.setAttribute("monthArray", monthArray);
		
		List<HashMap<String, Object>> list2 = dao.countPerGender(vo.getProjectNo());
		// list 가 null일 경우는 후원이 아직 한번도 안된 프로젝트
				if(list2 != null) {
					// 후원한 사람이 전부 여성이거나 남성인 경우
					if(list2.size()==1) {
						String gender = (String)list2.get(0).get("GENDER");
						
						if(gender.equals("남자")) {
							m.addAttribute("Man",100);
							m.addAttribute("Girl",0);
						} else {
							m.addAttribute("Man",0);
							m.addAttribute("Girl",100);
						}
					}
					// 여자 남자 둘다 적어도 한번이상 후원 한 경우
					else if(list2.size()==2) {
						BigDecimal x = (BigDecimal)list2.get(0).get("COUNT");//여자와 남자의 값을 가져옴
						BigDecimal y = (BigDecimal)list2.get(1).get("COUNT");
						int total = x.intValue()+y.intValue();
						
						for (HashMap<String, Object> hashMap : list2) {
							String gender = (String)hashMap.get("GENDER");
							
							if(gender.equals("남자")) {
								System.out.println("남자:"+ ((double)y.intValue()/total)*100);
								m.addAttribute("Man", ((double)y.intValue()/total)*100);
							} else {
								System.out.println("여자:"+(double)(x.intValue()/total)*100);
								m.addAttribute("Girl", ((double)x.intValue()/total)*100);
							}
						}
					}
				} else {
					m.addAttribute("Man", 0);
					m.addAttribute("Girl", 0);
				}
		return "graphpage";
	}
	
	
}
