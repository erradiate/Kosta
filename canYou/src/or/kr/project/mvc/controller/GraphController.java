package or.kr.project.mvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import or.kr.project.mvc.dao.projectDaoImple;

@Controller
public class GraphController {
	@Autowired
	private projectDaoImple dao;
	
	@RequestMapping(value = "/graph")
	public String graphLook() {
		return "graphpage";
	}
}
