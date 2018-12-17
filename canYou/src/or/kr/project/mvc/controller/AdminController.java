package or.kr.project.mvc.controller;


import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import or.kr.project.dto.MemberVO;
import or.kr.project.dto.ProductVO;
import or.kr.project.dto.ProjectVO;
import or.kr.project.mvc.dao.AdminDaoImple;
import or.kr.project.mvc.dao.projectDaoImple;

@Controller
public class AdminController {
	@Autowired
	private AdminDaoImple dao;
	
	@Autowired
	private projectDaoImple dao2;
	
	@RequestMapping(value="/admin")
	public String amain() {
		return "amain";
	}
	
	@RequestMapping(value="/admin.daegi")
	public ModelAndView daegi() {
		List<HashMap<String, String>> list=dao.wprosel();
		
		ModelAndView m=new ModelAndView();
		m.setViewName("daegi");
		m.addObject("list", list);
		
		return m;
	}
	
	@GetMapping("/admin.wstory")
	public String listView(Model m, String projectNo, HttpServletRequest req) {
		// project 관련한 정보 빼오기
		ProjectVO list = dao2.projectlist(projectNo);
		String c=dao2.caselone(list.getCategoryNo());
		String sc=dao2.subcaselone(list.getSubCategoryNo());
		m.addAttribute("list",list);
		m.addAttribute("c", c);
		m.addAttribute("sc", sc);
		// project와 연결된 member 정보 가져오기
		MemberVO mem=dao2.memname2(list.getMemberNo());
		m.addAttribute("member", mem);
		
		return "storypage2";
	}
	
	@RequestMapping(value="/admin.wproductDetail")
	public String getProductDetail(Model m, HttpServletRequest req, String projectNo) {
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
		
		// project와 연결된 product 가져오기
		List<ProductVO> list2=dao2.prodsel(projectNo);
		m.addAttribute("prodlist", list2);
		
		return "wproductdetailpage";
	}
	
	@RequestMapping(value="/admin.ok")
	public String ok(ProjectVO vo) {
		
		System.out.println(vo.getProjectStep());
		dao.ok(vo);
		
		return "redirect:admin.daegi";
	}
}
