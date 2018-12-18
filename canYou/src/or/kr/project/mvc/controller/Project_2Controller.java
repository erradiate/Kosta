package or.kr.project.mvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import or.kr.project.mvc.dao.projectDaoImple;

@Controller
public class Project_2Controller {
	@Autowired
	private projectDaoImple dao;
	
	@RequestMapping(value="/request")
	public String reqeust(int projectNo) {
		dao.request(projectNo);
		
		return "redirect:story?projectNo="+projectNo;
	}
	
	@RequestMapping(value="/prodel")
	public String prodel(int projectNo) {
		dao.prodel(projectNo);
		
		return "redirect:myProject";
	}
}
