package or.kosta.mvc.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	private static final Logger logger = 
			LoggerFactory.getLogger(HomeController.class);
	@RequestMapping(value="/home")
	public String home(Locale locale, Model model) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		model.addAttribute("serverTime", format.format(new Date()));
		System.out.println("Logger :" + logger.getName());
		System.out.println("Locale :" + locale.getCountry());
		return "haha";
	}
	
	@RequestMapping(value = "/emp/get/{id}")
	public String getEmployee(Locale locale, Model model, @PathVariable("id") int id) {
		logger.info("Welcome user! Requested Emp ID is : " + id);
		Date date = new Date();
		DateFormat dateFormat =
				DateFormat.getDateTimeInstance(
						DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate);
		return "employee";
	}
	
	@RequestMapping(value="/login")
	public String login(HttpServletRequest request, Model model) {
		return "login";
	}
	@RequestMapping(value="/logout")
	public String logout() {
		return "logout";
	}
	@RequestMapping(value="/denied")
	public String denied() {
		return "denied";
	}
}
