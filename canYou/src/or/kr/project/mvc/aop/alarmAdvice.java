package or.kr.project.mvc.aop;

import java.util.List;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import or.kr.project.dto.DeniedVO;
import or.kr.project.dto.MemberVO;
import or.kr.project.mvc.dao.project2DaoImple;
import or.kr.project.mvc.dao.projectDaoImple;

@Component
@Aspect
public class alarmAdvice {
	@Autowired
	private projectDaoImple dao;
	
	@Autowired
	private project2DaoImple dao2;
	
	@Before("execution(* or.kr.project.mvc.controller.ProjectController.index(..))")
	public void beforeMethod(JoinPoint jp){
		Object[] fd = jp.getArgs();
		if(fd[1] instanceof Model) {
			SecurityContext impl = SecurityContextHolder.getContext();
			String implstr = impl.getAuthentication().getName();
			if(!implstr.equals("anonymousUser")) {
				MemberVO vo = dao.memname(implstr); // 가져온 ID를 토대로 회원 번호, 이름을 가져온다
				 System.out.println(vo.getMemberNo());
				
				 List<DeniedVO> vo2=dao2.selde(vo.getMemberNo());
				 Model m = (Model)fd[1];
				 if(vo2.size()!=0) {
					 m.addAttribute("dealarm", vo2.size());
					 m.addAttribute("delist", vo2);
				 }else {
					 m.addAttribute("dealarm", 0);
				 }
			}
		}
	}
	
	@Before("execution(* or.kr.project.mvc.controller.DetailController.listView(..))")		// 검토 거부당한 프로젝트를 보면 알람 사라짐
	public void beforeMethod2(JoinPoint jp){
		Object[] fd = jp.getArgs();
		if(fd[0] instanceof Model) {
			String projectNo=(String)fd[1];
			System.out.println(projectNo);
			int result=dao2.upde(projectNo);
			if (result!=0) {
				Model m=(Model)fd[0];
				String reason=dao2.showreason(projectNo);
				m.addAttribute("reason", reason);
			}
		}
	}
}
