package or.kr.project.mvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import or.kr.project.mvc.dao.AdminDaoImple;

@Controller
public class AdminController {
	@Autowired
	private AdminDaoImple dao;
	
	@RequestMapping(value = "/admin")
	public String graphLook() {
		return "amain";
	}
}
