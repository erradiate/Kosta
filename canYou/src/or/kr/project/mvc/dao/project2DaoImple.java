package or.kr.project.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import or.kr.project.dto.ProductVO;
import or.kr.project.dto.ProjectVO;

@Repository
public class project2DaoImple {
	@Autowired
	private SqlSessionTemplate ss;
	
	public void tproin(ProjectVO vo) {		// 임시저장 프로젝트 insert
		ss.insert("tempproject.tproin", vo);
	}
	
	public void tprodin(ProductVO vo) { // 임시저장 상품 insert문
		ss.insert("tempproject.tprodin", vo);
	}
	
	public int tprocnt(int i) {		// 해당 회원의 임시 저장 프로젝트가 몇개인지 가져옴 (i : 회원번호)
		return ss.selectOne("tempproject.tprocnt", i);
	}
	
	public List<ProjectVO> tprosel(int i){				// 임시 프로젝트 목록 가져올 때
		return ss.selectList("tempproject.tprosel", i);
	}
	
	public ProjectVO seltpro(int i) {				// 선택한 임시 프로젝트 가져오기
		return ss.selectOne("tempproject.tproselOne", i);
	}
	
	public List<ProductVO> seltprod(int i) {				// 선택한 임시 프로젝트 가져오기
		return ss.selectList("tempproject.tprodsel", i);
	}
}
