package or.kr.project.mvc.aop;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import or.kr.project.dto.LoggerVO;
import or.kr.project.dto.MemberVO;
import or.kr.project.dto.ProjectDonateVO;
import or.kr.project.dto.ProjectVO;
import or.kr.project.mvc.dao.LogDao;
import or.kr.project.mvc.dao.projectDaoImple;

@Component
@Aspect
public class DonateAdvice {
	@Autowired
	LogDao dao;

	@Autowired
	projectDaoImple pdao;

	@After("execution(* or.kr.project.mvc.controller.*.donateProject*(..))")
	public void logAfter(JoinPoint jp) {
		LoggerVO vo = new LoggerVO();
		Object[] obj = jp.getArgs();
		
		if(obj[0] instanceof ProjectDonateVO) {
			ProjectDonateVO pvo = (ProjectDonateVO)obj[0];
			SecurityContext impl = SecurityContextHolder.getContext(); // 세션에서 spring security 정보를 가져옴
			String implstr = impl.getAuthentication().getName(); // security 정보에서 세션에 담겨있는 로그인 정보 중 ID 가져옴
			MemberVO vo2 = pdao.memname(implstr); // ID를 토대로 회원정보 가져옴 (회원 번호, 회원 이름)
		
			ProjectVO pvo2 = dao.get_Category(pvo.getProjectNo());
		
			vo.setMemberName(vo2.getMemberName());
			vo.setMemberGender(vo2.getMemberGender());
			vo.setMemberAge(vo2.getMemberAge());
			vo.setCategoryNo(pvo2.getCategoryNo());
			vo.setSubCategoryNo(pvo2.getSubCategoryNo());
			vo.setDonateMoney(pvo.getDonateMoney());
			vo.setProjectNo(pvo.getProjectNo());
			dao.insLog(vo);
		}
	}
}
