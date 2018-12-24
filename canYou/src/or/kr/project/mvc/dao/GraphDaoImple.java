package or.kr.project.mvc.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import or.kr.project.dto.ProjectVO;

@Repository
public class GraphDaoImple implements GraphDao{
	@Autowired
	private SqlSessionTemplate ss;
	
	//나이별 카테고리 후원 수 그래프
	public int categorygraph(Map<String, Integer> hash) {
		return ss.selectOne("graph.categorygraph",hash);
	}
	
	//최근 3개월간 해당 카테고리 후원 수
	public List<Integer> monthGraph(ProjectVO vo){
		return ss.selectList("graph.monthgraph",vo.getCategoryNo());
	}
}
