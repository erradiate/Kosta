package or.kr.project.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import or.kr.project.dto.DeniedVO;
import or.kr.project.dto.ProductVO;
import or.kr.project.dto.ProjectVO;

@Repository
public class Project2DaoImple implements Project2Dao{
	@Autowired
	private SqlSessionTemplate ss;
	
	// 임시저장 프로젝트 insert
	@Override
	public void tproin(ProjectVO vo) {
		ss.insert("tempproject.tproin", vo);
	}
	
	// 임시저장 상품 insert
	@Override
	public void tprodin(ProductVO vo) {
		ss.insert("tempproject.tprodin", vo);
	}
	
	// 해당 회원의 임시 저장 프로젝트가 몇개인지 가져옴 (i : 회원번호)
	@Override
	public int tprocnt(int i) {
		return ss.selectOne("tempproject.tprocnt", i);
	}
	
	// 임시 프로젝트 목록 가져올 때
	@Override
	public List<ProjectVO> tprosel(int i) {
		return ss.selectList("tempproject.tprosel", i);
	}
	
	@Override
	public ProjectVO seltpro(int i) {				// 선택한 임시 프로젝트 가져오기
		return ss.selectOne("tempproject.tproselOne", i);
	}
	
	@Override
	public List<ProductVO> seltprod(int i) {				// 선택한 임시 프로젝트 가져오기
		return ss.selectList("tempproject.tprodsel", i);
	}
	
	// 선택한 임시 프로젝트 삭제
	@Override
	public void deltpro(int i) {
		ss.delete("tempproject.tproddel", i);	
		ss.delete("tempproject.tprodel", i);
	}
	
	@Override
	public List<DeniedVO> selde(int i){
		return ss.selectList("project2.selde", i);
	}
	
	@Override
	public int upde(String s) {
		return ss.update("project2.upde", s);
	}

	@Override
	public String showreason(String projectNo) {
		return ss.selectOne("project2.showreason", projectNo);
	}
}
