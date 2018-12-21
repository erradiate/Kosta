package or.kr.project.mvc.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import or.kr.project.dto.LoggerVO;
import or.kr.project.dto.ProjectDonateVO;
import or.kr.project.mvc.dao.LogDao;

@Component
@Aspect
public class DonateAdvice {
	@Autowired
	LogDao dao;
	
	@After("execution(* kr.or.project.mvc.controller.ProjectController.)")
	public void logAfter(JoinPoint jp) {
		LoggerVO vo = new LoggerVO();
		vo.setMemberName("조현무");
		vo.setMemberGender("남");
		vo.setMemberAge(25);
		vo.setCategoryNo(1);
		vo.setSubCategoryNo(1);
		vo.setDonateMoney(10000);
		dao.insLog(vo);
		/*Object[] obj = jp.getArgs();
		if(obj[0] instanceof ProjectDonateVO) {
			ProjectDonateVO pvo = (ProjectDonateVO)obj[0];
			
		}*/
			
	}
}
