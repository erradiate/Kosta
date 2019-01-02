package or.kr.project.mvc.dao;

import java.util.HashMap;
import java.util.List;

import or.kr.project.dto.DeniedVO;
import or.kr.project.dto.ProjectVO;
import or.kr.project.dto.SearchVO;

public interface AdminDao {
	public List<HashMap> wprosel(SearchVO vo);
	public int wproselCount(SearchVO vo);
	public void ok(ProjectVO vo);
	public void denied(DeniedVO vo);
}
