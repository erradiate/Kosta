package or.kosta.mvc.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import or.kosta.dto.DownDTO;
import or.kosta.mvc.dao.DownDao;

@Controller
public class DefaultController {
	@Autowired
	DownDao dao;
	
	@RequestMapping("/")
	public String defaultView(){
		return "index";
	}

	@RequestMapping(value="/uplist")
	public String myDefaultView(Model m){
		List<DownDTO> list = dao.getList();
		m.addAttribute("list",list);
		return "showlist";
	}
}
