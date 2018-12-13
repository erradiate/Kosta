package or.kr.project.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import or.kr.project.dto.MemberVO;
import or.kr.project.dto.ProductVO;
import or.kr.project.dto.ProjectVO;

@Repository
public class WordDaoImple implements WordDao{
	@Autowired
	private SqlSessionTemplate ss;
	
	@Override
	public MemberVO getMember_Project(int projectNo) {
		MemberVO vo = ss.selectOne("word.wordInfo",projectNo);
		return vo;
	}

	@Override
	public List<ProductVO> getProductList(int productNo) {
		// TODO Auto-generated method stub
		return null;
	}
	
}