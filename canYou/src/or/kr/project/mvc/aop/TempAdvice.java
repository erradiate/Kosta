package or.kr.project.mvc.aop;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.aopalliance.intercept.Joinpoint;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import or.kr.project.dto.MemberVO;
import or.kr.project.dto.ProjectVO;
import or.kr.project.mvc.dao.Project2DaoImple;
import or.kr.project.mvc.dao.ProjectDaoImple;

@Component
@Aspect
public class TempAdvice {
	@Autowired
	private ProjectDaoImple dao;
	
	@Autowired
	private Project2DaoImple dao2;
	
	@Before("execution(* or.kr.project.mvc.controller.ProjectController.ProjectUpload(..))")
	public void beforeMethod(JoinPoint jp){
		Object[] fd = jp.getArgs();
		if(fd[0] instanceof Model) {
			SecurityContext impl = SecurityContextHolder.getContext();
			String implstr = impl.getAuthentication().getName();
			MemberVO vo = dao.memname(implstr); // 가져온 ID를 토대로 회원 번호, 이름을 가져온다
			
			int cnt=dao2.tprocnt(vo.getMemberNo());
			List<ProjectVO> vo2=new ArrayList<ProjectVO>();
			
			Model m = (Model)fd[0];
			m.addAttribute("cnt", String.valueOf(cnt));
			
			if(cnt>0) {
				vo2=dao2.tprosel(vo.getMemberNo());
				m.addAttribute("tlist", vo2);
			}
		}
	}
}