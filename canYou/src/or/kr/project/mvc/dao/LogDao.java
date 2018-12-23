package or.kr.project.mvc.dao;

import or.kr.project.dto.LoggerVO;
import or.kr.project.dto.ProjectVO;

public interface LogDao {
	public void insLog(LoggerVO vo);
	public ProjectVO get_Category(int projectNo);
}
