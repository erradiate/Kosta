package or.kr.project.mvc.dao;

import java.util.List;

import or.kr.project.dto.MemberVO;
import or.kr.project.dto.ProductVO;

public interface WordDao {
	public MemberVO getMember_Project(int projectNo);
	public List<ProductVO> getProductList(int productNo);
}
