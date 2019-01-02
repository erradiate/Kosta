package or.kr.project.mvc.aop;


import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import or.kr.project.mvc.dao.Project2DaoImple;

@Component
@Aspect
public class RenewAdvice {
	@Autowired
	private Project2DaoImple dao;
	
	@Before("execution(* or.kr.project.mvc.controller.*.*(..))")
	public void beforeMethod(){
		dao.uppro();
	}
}