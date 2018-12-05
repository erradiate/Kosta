package or.kr.project.mvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MyTestController {
	// git에 적용될 새로운 코드
	@RequestMapping(value="/test", method=RequestMethod.GET)
	public String myView() {
		return "myView";
	}
}
