package or.kr.project.mvc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import or.kr.project.dto.SubCategoryVO;
import or.kr.project.mvc.dao.projectDaoImple;

@Controller
public class CategoryController {
	@Autowired
	private projectDaoImple dao;
	
	@RequestMapping(value="/subcaname",produces = "application/text; charset=euc-kr")
	public ResponseEntity<List<SubCategoryVO>> subcaname(String categoryName) {
		List<SubCategoryVO> l=dao.subcaname(categoryName);
		
		System.out.println(categoryName);
		
		return new ResponseEntity<>(l, HttpStatus.OK);
	}
}
