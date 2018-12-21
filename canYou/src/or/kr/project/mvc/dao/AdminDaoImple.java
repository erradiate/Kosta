package or.kr.project.mvc.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import or.kr.project.dto.DeniedVO;
import or.kr.project.dto.ProjectVO;
import or.kr.project.dto.SearchVO;

@Repository
public class AdminDaoImple {
	@Autowired
	private SqlSessionTemplate ss;

	// 검토중인 프로젝트 현황
	public List<HashMap> wprosel(SearchVO vo) {
		List<HashMap> list = ss.selectList("admin.wprosel", vo);
		return list;
	}

	// 검토중인 프로젝트 총 개수
	public int wproselCount(SearchVO vo) {
		return ss.selectOne("admin.wproselTotal", vo);

	}

	public void ok(ProjectVO vo) {
		ss.update("admin.ok", vo);
	}

	public void denied(DeniedVO vo) {
		ss.insert("admin.deniedr", vo); // 거절 사유 테이블에 사유 추가
		ss.update("admin.denied", vo);
	}
}
