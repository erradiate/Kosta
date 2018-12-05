package or.kosta.mvc.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import or.kosta.dto.DownDTO;
import or.kosta.mvc.dao.DownDao;

@Controller
public class UploadController {
	@Autowired
	DownDao dao;
	
	@GetMapping("/showform")
	public String upform() {
		return "showform";
	}
	
	@RequestMapping(value="/upsave2",method=RequestMethod.POST)
	public ModelAndView save2(@ModelAttribute("dvo")DownDTO vo,
			HttpServletRequest request) {
		System.out.println("vo 객체 참조 값 : "+vo);
		System.out.println("vo 객체 참조 값 : "+vo.getWriter());
		String img_path = "resources\\imgfile";
		String r_path = request.getRealPath("/");
		String oriFn = vo.getMultipartFile().getOriginalFilename();
		StringBuffer path = new StringBuffer();
		path.append(r_path).append(img_path).append("\\");
		path.append(oriFn);
		System.out.println("Path : " + path.toString());
		File f = new File(path.toString());
		try {
			vo.getMultipartFile().transferTo(f);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		vo.setImg(vo.getMultipartFile().getOriginalFilename());
		dao.addDown(vo);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/uplist");
		return mav;
	}
	
	private static final int BUFFER_SIZE = 4096;
	
	@RequestMapping(value = "fileDown")
	public void fileDown(@RequestParam("fileName")String fileName,
			HttpSession session, HttpServletRequest request,
			HttpServletResponse response)throws IOException{
		// applicationContext 객체를 request로 부터 얻어냄
		ServletContext context = request.getServletContext();
		// 업로드된 경로 얻음
		String path = session.getServletContext().getRealPath("/resources/imgfile/"+fileName);
		// 그 경로로 파일 객체를 생성
		File downloadFile = new File(path);
		System.out.println("DownloadFile : " + downloadFile.exists());
		// FileInputStream 스트림으로 읽어옴
		FileInputStream fi = new FileInputStream(downloadFile);
		// 요청 객체로부터 연결될 브라우저의 마임 타입을 얻어냄
		String mimeType = context.getMimeType(path);
		// 만약 마임타입값이 없으면 그냥 디폴트로 스트림으로 연결
		if(mimeType == null) {
			mimeType = "application/octet-stream";
		}
		// 지정된 마임타입 세팅
		response.setContentType(mimeType);
		// 다운로드될 파일의 길이 세팅
		response.setContentLength((int)downloadFile.length());
		// 다운로드 Type을 설정함 
		String headerKey = "Content-Disposition";
		String headerValue =
				String.format("attachment; filename=\"%s\"", 
								downloadFile.getName());
		//위의 다운로드 타입의 정보를 해더로 결정
		response.setHeader(headerKey, headerValue);
		// 브라우저로 부터 스트림을 연결
		OutputStream outStream = response.getOutputStream();
		//버퍼를 끼워서 빠르게 전달 목적
		byte[] buffer = new byte[BUFFER_SIZE];
		// 이제 브라우저로 보내고 , 자원 닫으면 끝
		int bytesRead = -1;
		while((bytesRead = fi.read(buffer)) != -1) {
			outStream.write(buffer,0,bytesRead);
		}
		fi.close();
		outStream.close();
	}
	
	@RequestMapping(value = "/downloadExcel")
	public ModelAndView downloadExcel() {
		List<DownDTO> listBooks = dao.getList();
		return new ModelAndView("excelView","listBooks",listBooks);
	}
	
	
}
