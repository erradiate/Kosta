package or.kr.project.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import or.kr.project.dto.ProjectVO;

@Repository
public class ProjectDaoImple implements ProjectDao {
	@Autowired
	SqlSessionTemplate ss;
	
	@Override
	public List<ProjectVO> showlist() {
		List<ProjectVO> list = ss.selectList("project.getlist");
		return list;
	}
}
