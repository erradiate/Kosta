package or.kr.project.mvc.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;
import or.kr.project.dto.ProjectDonateVO;
import or.kr.project.mvc.dao.ProjectDaoImple;
import or.kr.project.mvc.service.Service_Transaction;


@Transactional(propagation=Propagation.REQUIRED,
rollbackFor=Exception.class,readOnly = true)
@Service
public class ServiceImple implements Service_Transaction {
	@Autowired
	ProjectDaoImple dao;
	
	@Override
	public void cancle(ProjectDonateVO vo) {
		// 사용자의 돈을 반환 + 선물 갯수 돌려줌
		dao.returnMoney(vo);
		// 후원자 수 감소
		dao.returnFundCnt(vo);
		// 돈 돌려 준 후에 행 삭제
		dao.donateCancle(vo);
	}
	
	@Override
	public void donate(ProjectDonateVO vo, Map<String, Integer> m) {
		dao.donate(vo); // projectDonate 행 추가
		dao.donateMoney(m); // 후원시 멤버가 가지고 있는 금액이 빠져나감
	}

}
