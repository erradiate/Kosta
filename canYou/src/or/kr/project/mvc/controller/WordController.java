package or.kr.project.mvc.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import or.kr.project.dto.MemberVO;
import or.kr.project.mvc.dao.WordDao;
import or.kr.project.mvc.dao.projectDao;
import or.kr.project.word.WordBuilder;

@Controller
public class WordController {
	private WordBuilder wb;
	
	@Autowired
	private WordDao dao;
	
	public WordController() {
		wb = new WordBuilder();
	}
	
	@RequestMapping(value="/download")
	public String downloadWord(int projectNo,HttpServletRequest req, 
			HttpServletResponse resp, HttpSession session) throws Exception {
		MemberVO vo = dao.getMember_Project(projectNo);
		wb.wordCD(vo,req, resp, session);
		// resp가 commit 될때 까지 대기하는 코드
		while(true) {
			if(resp.isCommitted()) {
				return "redirect:list?num="+projectNo;
			} else {
				continue;
			}
		}
	}
}
