package or.kr.project.mvc.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import or.kr.project.dto.DeniedVO;
import or.kr.project.dto.ProjectVO;

@Repository
public class AdminDaoImple {
	@Autowired
	private SqlSessionTemplate ss;
	
	public List<HashMap<String, String>> wprosel(){
		return ss.selectList("admin.wprosel");
	}

	public void ok(ProjectVO vo) {
		ss.update("admin.ok", vo);
	}

	public void denied(DeniedVO vo) {
		ss.insert("admin.deniedr", vo); // 거절 사유 테이블에 사유 추가
		ss.update("admin.denied", vo);
	}
}
