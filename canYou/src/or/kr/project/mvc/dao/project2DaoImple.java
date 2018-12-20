package or.kr.project.mvc.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import or.kr.project.dto.ProductVO;
import or.kr.project.dto.ProjectVO;

@Repository
public class project2DaoImple {
	@Autowired
	private SqlSessionTemplate ss;
	
	public void tproin(ProjectVO vo) {
		ss.insert("project.tproin", vo);
	}
	
	public void tprodin(ProductVO vo) { // ªÛ«∞ insertπÆ
		ss.insert("project.tprodin", vo);
	}
}
