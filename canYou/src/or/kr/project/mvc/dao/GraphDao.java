package or.kr.project.mvc.dao;

import java.util.HashMap;
import java.util.List;

public interface GraphDao {
	public List<HashMap<String, Object>> countPerGender(int projectNo);
}
