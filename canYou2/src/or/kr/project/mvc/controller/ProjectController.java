package or.kr.project.mvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import or.kr.project.mvc.dao.ProjectDao;

@Controller
public class ProjectController {
	@Autowired
	ProjectDao dao;
	
	@RequestMapping(value="/sel")
	public String printList(Model m) {
		System.out.println("여기까지 왔다");
		m.addAttribute("list",dao.showlist());
		return "success";
	}
}
