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
import or.kr.project.mvc.dao.ProjectDaoImple;

@Component
@Aspect
public class DonateAdvice {
	@Autowired
	LogDao dao;

	@Autowired
	ProjectDaoImple pdao;

	@After("execution(* or.kr.project.mvc.controller.*.donateProject*(..))")
	public void logAfter(JoinPoint jp) {
		LoggerVO vo = new LoggerVO();
		Object[] obj = jp.getArgs();
		
		if(obj[0] instanceof ProjectDonateVO) {
			ProjectDonateVO pvo = (ProjectDonateVO)obj[0];
			SecurityContext impl = SecurityContextHolder.getContext();
			String implstr = impl.getAuthentication().getName();
			MemberVO vo2 = pdao.memname(implstr);
		
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
