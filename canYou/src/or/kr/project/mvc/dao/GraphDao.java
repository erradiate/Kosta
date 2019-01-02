package or.kr.project.mvc.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import or.kr.project.dto.ProjectVO;

public interface GraphDao {
	public List<HashMap<String, Object>> countPerGender(int projectNo);
	public int categorygraph(Map<String, Integer> hash);
	public List<Integer> monthGraph(ProjectVO vo);
}
