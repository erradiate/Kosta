package or.kr.project.mvc.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import or.kr.project.dto.LoggerVO;
import or.kr.project.dto.ProjectVO;

@Repository
public class LogDaoImple implements LogDao {
	@Autowired
	private SqlSessionTemplate ss;
	
	@Override
	public void insLog(LoggerVO vo) {
		ss.insert("log.logins",vo);
	}
	@Override
	public ProjectVO get_Category(int projectNo) {
		ProjectVO vo = ss.selectOne("log.getLogCategory",projectNo);
		return vo;
	}
}
