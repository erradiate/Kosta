package or.kr.project.mvc.dao;

import java.util.List;

import or.kr.project.dto.DeniedVO;
import or.kr.project.dto.ProductVO;
import or.kr.project.dto.ProjectVO;

public interface Project2Dao {
	public void tproin(ProjectVO vo);
	public void tprodin(ProductVO vo);
	public int tprocnt(int i);
	public List<ProjectVO> tprosel(int i);
	public ProjectVO seltpro(int i);
	public List<ProductVO> seltprod(int i);
	public void deltpro(int i);
	public List<DeniedVO> selde(int i);
	public int upde(String s);
	public String showreason(String projectNo);
	public void uppro();
}
