package or.kr.project.mvc.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.authentication.AuthenticationTrustResolverImpl;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import or.kr.project.dto.CategoryVO;
import or.kr.project.dto.MemberVO;
import or.kr.project.dto.PageVO;
import or.kr.project.dto.ProductVO;
import or.kr.project.dto.ProjectDonateVO;
import or.kr.project.dto.ProjectVO;
import or.kr.project.dto.ReplyVO;
import or.kr.project.dto.SearchVO;
import or.kr.project.dto.SubCategoryVO;
import or.kr.project.mvc.dao.projectDaoImple;

@Controller
public class ProjectController {
	@Autowired
	private projectDaoImple dao;

	// 메인페이지 + 인기프로젝트 보여줌
	@RequestMapping(value = "/")
	public String index(HttpServletRequest request, Model model) {
		List<ProjectVO> plist = dao.popularList();
		model.addAttribute("plist", plist);

		List<ProjectVO> nlist = dao.newList();
		model.addAttribute("nlist", nlist);

		List<ProjectVO> dlist = dao.deadlineList();
		model.addAttribute("dlist", dlist);

		return "main";
	}

	@RequestMapping(value = "index")
	public String index2(HttpServletRequest request, Model model) {
		return "main";
	}

	@RequestMapping(value = "/login")
	public String login(HttpServletRequest request, Model model) {
		AuthenticationTrustResolver trustResolver = new AuthenticationTrustResolverImpl();
		if (trustResolver.isAnonymous(SecurityContextHolder.getContext().getAuthentication())) { // 익명 상태에서 로그인 페이지 이동시
			return "login";
		} else { // 로그인 상태에서 로그인 페이지로 이동하려고 할 때 index 페이지로 이동
			return "main";
		}
	}

	@RequestMapping(value = "/denied")
	public String denied() {
		return "denied";
	}

	@RequestMapping(value = "/error404")
	public String error404() {
		return "error404";
	}

	@RequestMapping(value = "/error500")
	public String error500() {
		return "error500";
	}

	@RequestMapping(value = "/mypage")
	public String getDonateList() {
		return "mypage";
	}

	// 개인정보 수정 페이지로 이동 1218
	@RequestMapping(value = "/editinfo")
	public String editInfo(Model m) {
		SecurityContext impl=SecurityContextHolder.getContext();
		String implstr=impl.getAuthentication().getName(); 
		MemberVO vo2=dao.viewmember(implstr);	// 가져온 ID를 토대로 회원 정보를 가져옴
			
		m.addAttribute("list", vo2);
		return "editinfo";
	}

	// 개인정보 수정 하기
		@RequestMapping(value = "/success")
		public String editSuccess(Model m, MemberVO vo, String targetPwd) {
			// 세션에서 로그인 된 ID를 가져오는 작업
			SecurityContext impl = SecurityContextHolder.getContext();
			String implstr = impl.getAuthentication().getName();
			// 끝-------------------
			MemberVO vo2 = dao.memname(implstr); // 가져온 ID를 토대로 회원 번호, 이름을 가져온다
			vo.setMemberNo(vo2.getMemberNo());
			
			HashMap<String, String> h = new HashMap<>();
			h.put("memberNo", String.valueOf(vo.getMemberNo()));
			h.put("memberName", vo.getMemberName());
			h.put("targetPwd", targetPwd);
			h.put("memberPwd", vo.getMemberPwd());
			h.put("memberAddr", vo.getMemberAddr());
			h.put("memberPhone", vo.getMemberPhone());
			h.put("memberEmail", vo.getMemberEmail());
			h.put("memberAge", String.valueOf(vo.getMemberAge()));
			h.put("memberAccount", vo.getMemberAccount());
			
			System.out.println(h.get("targetPwd").equals(""));

			int result=dao.editMyInfo(h);
			
			if (result!=0){
				return "success";
			}else {
				return "redirect:editinfo";
			}
		}

	@RequestMapping(value = "/proupform") // 프로젝트 업로드 폼 페이지
	public ModelAndView proupform(HttpServletRequest request) {
		List<CategoryVO> category = dao.casel(); // 프로젝트 업로드에 필요한 카테고리 목록을 가져옴

		// 세션에서 로그인 된 ID를 가져오는 작업
		SecurityContext impl = SecurityContextHolder.getContext();
		String implstr = impl.getAuthentication().getName();
		// 끝-------------------
		MemberVO vo = dao.memname(implstr); // 가져온 ID를 토대로 회원 번호, 이름을 가져온다
		String name = vo.getMemberName(); // 이름을 name 변수에 저장

		ModelAndView mav = new ModelAndView();
		mav.setViewName("proupform");
		mav.addObject("category", category); // 카테고리 목록 붙임
		mav.addObject("memberName", name); // name을 object로 붙여서 같이 전송
		return mav;
	}

	@RequestMapping(value = "/subcasel") // 서브 카테고리 불러오는 페이지 (json)
	public ResponseEntity<List<SubCategoryVO>> subcasel(int categoryNo) {
		List<SubCategoryVO> l = dao.subcasel(categoryNo);

		return new ResponseEntity<>(l, HttpStatus.OK);
	}

	@RequestMapping(value = "/proup") // 프로젝트 업로드
	public ModelAndView proup(@ModelAttribute("projvo") ProjectVO vo, MultipartFile mfile, String proname,
			String procnt, String proinfo, String procost, HttpServletRequest request) {
		ProductVO prodvo = new ProductVO();
		String[] pname = proname.split(",");
		String[] pcnt = procnt.split(",");
		String[] pinfo = proinfo.split(",");
		String[] pcost = procost.split(",");

		String img_path = "resources\\images";
		String r_path = request.getRealPath("/");
		String oriFn;

		if (mfile == null) {
			oriFn = "null.jpg";
		} else {
			oriFn = mfile.getOriginalFilename();
		}
		StringBuffer path = new StringBuffer();
		path.append(r_path).append(img_path).append("\\");
		path.append(oriFn);

		if (mfile != null) {
			File f = new File(path.toString());
			try {
				mfile.transferTo(f);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}

		/* 로그인 정보를 가져오는 구문 */
		SecurityContext impl = SecurityContextHolder.getContext(); // 세션에서 spring security 정보를 가져옴
		String implstr = impl.getAuthentication().getName(); // security 정보에서 세션에 담겨있는 로그인 정보 중 ID 가져옴
		MemberVO vo2 = dao.memname(implstr); // ID를 토대로 회원정보 가져옴 (회원 번호, 회원 이름)
		vo.setMemberNo(vo2.getMemberNo()); // 프로젝트 테이블에 넣을 회원 번호를 넣음

		vo.setProjectMainImage(oriFn);
		dao.proin(vo); // 프로젝트 업로드

		for (int i = 0; i < pname.length; i++) {

			prodvo.setProductCnt(Integer.parseInt(pcnt[i]));
			prodvo.setProductName(pname[i]);
			prodvo.setProductInfo(pinfo[i]);
			prodvo.setProductCost(Integer.parseInt(pcost[i]));
			prodvo.setProjectNo(vo.getProjectNo());

			dao.prodin(prodvo); // 상품 업로드
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/proupsuccess");
		return mav;
	}

	@RequestMapping(value = "/proupsuccess") // 프로젝트 업로드 성공시
	public ModelAndView proupsuccess() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("proupsuccess");
		return mav;
	}

	@RequestMapping(value = "/imageUpload", method = RequestMethod.POST) // 에디터에서 이미지 업로드
	public void commUpload(HttpServletRequest request, HttpSession session, HttpServletResponse response,
			@RequestParam MultipartFile upload) {
		OutputStream out = null;
		PrintWriter printWriter = null;
		response.setCharacterEncoding("EUC-KR");
		response.setContentType("text/html;charset=EUC-KR");
		try {
			String fileName = upload.getOriginalFilename();
			byte[] bytes = upload.getBytes();
			String path = session.getServletContext().getRealPath("/resources/images");
			String uploadPath = path + "\\" + fileName;// 저장경로
			out = new FileOutputStream(new File(uploadPath));
			out.write(bytes);
			String callback = request.getParameter("CKEditorFuncNum");

			printWriter = response.getWriter();

			String fileUrl = "resources/images/" + fileName;// url경로
			// 파일 업로드를 비동기식으로 연결할 때 Callback을 정의한다.
			// printWriter.println("data:");
			printWriter.println("<script type='text/javascript'>" + "window.parent.CKEDITOR.tools.callFunction("
					+ callback + ",'" + fileUrl + "','이미지를 업로드 하였습니다.'" + ")</script>");
			printWriter.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (out != null) {
					out.close();
				}
				if (printWriter != null) {
					printWriter.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return;
	}

	@PostMapping("/update")
	public String updateView(Model m, HttpServletRequest req, int projectNo) {
		ProjectVO vo3 = new ProjectVO();

		System.out.println("프로젝트 번호 : " + projectNo);

		SecurityContext impl = SecurityContextHolder.getContext(); // 세션에서 spring security 정보를 가져옴
		String implstr = impl.getAuthentication().getName(); // security 정보에서 세션에 담겨있는 로그인 정보 중 ID 가져옴
		MemberVO vo2 = dao.memname(implstr); // ID를 토대로 회원정보 가져옴 (회원 번호, 회원 이름)
		vo3.setMemberNo(vo2.getMemberNo()); // 프로젝트 테이블에 넣을 회원 번호를 넣음
		vo3.setProjectNo(projectNo);
		
		HttpSession s=req.getSession();
		s.setAttribute("projnum", projectNo);		// 프로젝트 세션을 추가

		ProjectVO vo = dao.modifyview(vo3);
		m.addAttribute("project", vo);
		

		return "ProjectModify";
	}

	// 프로젝트 수정
	@PostMapping("/modify")
	public ModelAndView modifyView(@ModelAttribute("projvo") ProjectVO vo, HttpServletRequest request, HttpSession s) {
		// 프로젝트 수정 - 파일업로드
		String img_path = "resources\\images";
		String r_path = request.getRealPath("/");
		String oriFn = vo.getMultipartFile().getOriginalFilename();
		StringBuffer projectMainImage = new StringBuffer();
		projectMainImage.append(r_path).append(img_path).append("\\");
		projectMainImage.append(oriFn);
		File f = new File(projectMainImage.toString());
		System.out.println("projectMainImage : " + projectMainImage);
		try {
			vo.getMultipartFile().transferTo(f);
			vo.setProjectMainImage(vo.getMultipartFile().getOriginalFilename());
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}

		int projnum = Integer.parseInt(String.valueOf(s.getAttribute("projnum"))); // 세션에 저장되어있는 프로젝트 번호를 넣어줌
		vo.setProjectNo(projnum);
		s.removeAttribute("projnum");

		// 프로젝트 모두수정 - 메소드 호출
		dao.modify(vo);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:story?projectNo=" + projnum);
		return mav;
	}

	// 프로젝트 둘러보기
	@RequestMapping("/lookaround")
	public String look(Model m) {
		List<CategoryVO> list = dao.categoryLookAround();

		m.addAttribute("list", list);

		return "lookaround";
	}

	// 모든 프로젝트 보기
	@RequestMapping(value = "/AllList")
	public ModelAndView AllList(Integer page, SearchVO vo, Principal principal) {

		// pageVO의 획득
		int totalRows = dao.getTotalCount();
		PageVO pageInfo = makePageVO(page, totalRows);

		// 보여줄 페이지 설정
		vo.setBegin(String.valueOf(pageInfo.getStartRow()));
		vo.setEnd(String.valueOf(pageInfo.getEndRow()));

		List<ProjectVO> list = dao.projectALLlist(vo);

		System.out.println(list.size());
		ModelAndView mav = new ModelAndView();
		mav.setViewName("AllList");
		mav.addObject("list", list);
		mav.addObject("pageInfo", pageInfo);
		if (principal != null)
			mav.addObject("principal", principal.getName());
		List<String> dateList = new ArrayList<String>();

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

		// 남은 날짜 계산해서 list에 넣어 줌
		for (ProjectVO pvo : list) {
			String sys = format.format(new Date()); // 현재 날짜

			int idx = pvo.getProjectEndDate().indexOf(" ");
			String end = pvo.getProjectEndDate().substring(0, idx); // 끝나는 날짜

			Date endDate = null;
			Date sysdate = null;
			long diffDays = 0;
			try {
				// 날짜 계산을 위해 Date형으로 변환
				endDate = format.parse(end);
				sysdate = format.parse(sys);

				// 시간차이를 시간,분,초를 곱한 값으로 나누면 하루 단위가 나옴
				long diff = endDate.getTime() - sysdate.getTime();
				diffDays = diff / (24 * 60 * 60 * 1000);

				System.out.println("날짜차이=" + diffDays);

			} catch (ParseException e) {
				e.printStackTrace();
			}

			dateList.add(Integer.toString((int) diffDays)); // 리스트에 날짜 차이를 넣음

		}
		mav.addObject("dateList", dateList);

		return mav;
	}

	// 카테고리별 프로젝트 보기
	@RequestMapping(value = "/categoryproject")
	public String categoryProject(Model m, @RequestParam("categoryNo") String categoryNo, Integer page, SearchVO svo,
			Principal principal) {

		// pageVO의 획득
		int totalRows = dao.getCategoryCount(Integer.parseInt(categoryNo));
		PageVO pageInfo = makePageVO(page, totalRows);

		// 보여줄 페이지 설정
		svo.setBegin(String.valueOf(pageInfo.getStartRow()));
		svo.setEnd(String.valueOf(pageInfo.getEndRow()));

		List<String> dateList = new ArrayList<String>(); // 남은 날짜 리스트
		
		String categoryName = dao.categoryName(Integer.parseInt(categoryNo)); //카테고리명 출력을 위해...
		m.addAttribute("categoryName", categoryName);

		// 무슨 카테고리인지 전달
		Map<String, String> categoryList = new HashMap<>();
		categoryList.put("categoryNo", categoryNo);
		categoryList.put("begin", String.valueOf(pageInfo.getStartRow()));
		categoryList.put("end", String.valueOf(pageInfo.getEndRow()));
		m.addAttribute("categoryNo", categoryNo);

		List<ProjectVO> list = dao.lookCategoryProject(categoryList); // 리스트 얻음
		m.addAttribute("list", list);
		m.addAttribute("pageInfo", pageInfo); // pageInfo 전달

		System.out.println("categoryNo : " + categoryNo);
		System.out.println("list size2 : " + list.size());

		if (principal != null) {
			m.addAttribute("principal", principal.getName());
		}

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

		// 남은 날짜 계산해서 list에 넣어 줌
		for (ProjectVO pvo : list) {
			String sys = format.format(new Date()); // 현재 날짜

			int idx = pvo.getProjectEndDate().indexOf(" ");
			String end = pvo.getProjectEndDate().substring(0, idx); // 끝나는 날짜

			Date endDate = null;
			Date sysdate = null;
			long diffDays = 0;

			try {
				// 날짜 계산을 위해 Date형으로 변환
				endDate = format.parse(end);
				sysdate = format.parse(sys);

				// 시간차이를 시간,분,초를 곱한 값으로 나누면 하루 단위가 나옴
				long diff = endDate.getTime() - sysdate.getTime();
				diffDays = diff / (24 * 60 * 60 * 1000);

				System.out.println("날짜차이=" + diffDays);

				// dateList.add(diffDays);
			} catch (ParseException e) {
				e.printStackTrace();
			}

			dateList.add(Integer.toString((int) diffDays)); // 리스트에 날짜 차이를 넣음

		}
		m.addAttribute("dateList", dateList);

		return "categoryproject";
	}

	// makePageVO 메소드(페이지를 만들어주는 메소드)
	public PageVO makePageVO(Integer page, int totalRows) {

		PageVO pageInfo = new PageVO();
		int rowsPerPage = 9; // 한페이지당 보여줄 목록수 - properties
		int pagesPerBlock = 5; // 한 블록당 보여줄 페이지 수 - properties
		if (page == null)
			page = 0;
		if (page == 0)
			page = 1; // 페이지 초기화
		int currentPage = page; // 현재 페이지 값
		int currentBlock = 0; // 현재 블록 초기화
		if (currentPage % pagesPerBlock == 0) { // 현재 블록 초기값
			currentBlock = currentPage / pagesPerBlock;
		} else { // 다음 블록이냐
			currentBlock = currentPage / pagesPerBlock + 1;
		}
		int startRow = (currentPage - 1) * rowsPerPage + 1; // 시작목록값연산
		int endRow = currentPage * rowsPerPage;// 마지막 목록값 연산

		// 전체 데이터 값

		System.out.println("totalRows:" + totalRows);
		// 전체 페이지 구하는 공식
		int totalPages = 0;
		if (totalRows % rowsPerPage == 0) {
			totalPages = totalRows / rowsPerPage;
		} else {
			totalPages = totalRows / rowsPerPage + 1;
		}
		// 전체 블록값을 구하는 공식
		int totalBlocks = 0;
		if (totalPages % pagesPerBlock == 0) {
			totalBlocks = totalPages / pagesPerBlock;
		} else {
			totalBlocks = totalPages / pagesPerBlock + 1;
		}
		// 모든 연산된정보를 PageVO에 저장한다.
		pageInfo.setCurrentPage(currentPage);
		pageInfo.setCurrentBlock(currentBlock);
		pageInfo.setRowsPerPage(rowsPerPage);
		pageInfo.setPagesPerBlock(pagesPerBlock);
		pageInfo.setStartRow(startRow);
		pageInfo.setEndRow(endRow);
		pageInfo.setTotalRows(totalRows);
		pageInfo.setTotalPages(totalPages);
		pageInfo.setTotalBlocks(totalBlocks);

		return pageInfo;
	}

	// 댓글 등록
	@PostMapping("/reply1")
	public String reply1(Model m, ReplyVO vo, HttpSession s) {
		SecurityContext impl = SecurityContextHolder.getContext(); // 세션에서 spring security 정보를 가져옴
		String implstr = impl.getAuthentication().getName(); // security 정보에서 세션에 담겨있는 로그인 정보 중 ID 가져옴
		MemberVO vo2 = dao.memname(implstr); // ID를 토대로 회원정보 가져옴 (회원 번호, 회원 이름)
		vo.setMemberNo(vo2.getMemberNo()); // 프로젝트 테이블에 넣을 회원 번호를 넣음
		vo.setProjectNo(Integer.parseInt((String) s.getAttribute("projnum"))); // 세션에 등록한 projectNumber를 가져옴
		s.removeAttribute("projnum"); // 사용한 session 속성 제거
		System.out.println("reply1 옴");
		dao.replyInsert(vo);

		return "redirect:story?projectNo=" + vo.getProjectNo();
	}

	// 후원할때 들어오는 메소드
	@RequestMapping(value = "/donate")
	public String donateProject(ProjectDonateVO vo) {
		SecurityContext impl = SecurityContextHolder.getContext(); // 세션에서 spring security 정보를 가져옴
		String implstr = impl.getAuthentication().getName(); // security 정보에서 세션에 담겨있는 로그인 정보 중 ID 가져옴
		MemberVO vo2 = dao.memname(implstr); // ID를 토대로 회원정보 가져옴 (회원 번호, 회원 이름)
		int memno = vo2.getMemberNo();

		vo.setMemberNo(memno);
		
		if (vo.getProductNo() != 0) {
			if (vo.getDonateMoney() != 0) {
				vo.setDonateMoney(vo.getDonateMoney() + dao.prodcost(vo.getProductNo()));
			} else {
				vo.setDonateMoney(dao.prodcost(vo.getProductNo()));
			}
		}
		
		// 사용자의 선결제 금액이 프로젝트의 금액보다 낮을 때 이후 작업을 수행 하지 않고 페이지로 보냄
		if(vo2.getMemberCash()-vo.getDonateMoney()<0) {
			return "redirect:/productDetail?projectNo=" + vo.getProjectNo() + "&success=fail";
		}

		dao.donate(vo); // projectDonate 행 추가

		// 돈 차감
		Map<String, Integer> m = new HashMap<>();
		m.put("donateMoney", vo.getDonateMoney());
		m.put("memberNo", memno);

		dao.donateMoney(m);

		return "redirect:/story?projectNo=" + vo.getProjectNo() + "&success=success";
	}

	// 후원 취소
	@RequestMapping(value = "/cancle")
	public String cancle(int donateNo/* 이후에 프로젝트 선택해서 할 경우를 대비해서 */, int productNo) {
		SecurityContext impl = SecurityContextHolder.getContext(); // 세션에서 spring security 정보를 가져옴
		String implstr = impl.getAuthentication().getName(); // security 정보에서 세션에 담겨있는 로그인 정보 중 ID 가져옴
		MemberVO vo2 = dao.memname(implstr); // ID를 토대로 회원정보 가져옴 (회원 번호, 회원 이름)
		int memno = vo2.getMemberNo();

		ProjectDonateVO vo = new ProjectDonateVO();
		vo.setDonateNo(donateNo);
		vo.setMemberNo(memno);
		vo.setProductNo(productNo);
		System.out.println("확인확인" + vo.getDonateNo());

		// 사용자의 돈을 반환 + 선물 갯수 돌려줌
		dao.returnMoney(vo);
		// 후원자 수 감소
		dao.returnFundCnt(vo);
		// 돈 돌려 준 후에 행 삭제
		dao.donateCancle(vo);

		return "redirect:/mydonate"; // 다시 리스트 화면으로
	}

	// 내 후원현황
	@RequestMapping("/mydonate")
	public ModelAndView mydonate(Integer page, SearchVO vo, Principal principal) {
		SecurityContext impl = SecurityContextHolder.getContext(); // 세션에서 spring security 정보를 가져옴
		String implstr = impl.getAuthentication().getName(); // security 정보에서 세션에 담겨있는 로그인 정보 중 ID 가져옴
		MemberVO vo2 = dao.memname(implstr); // ID를 토대로 회원정보 가져옴 (회원 번호, 회원 이름)
		int memno = vo2.getMemberNo();
		vo.setMemberNo(memno);
		// pageVO의 획득vo
		int totalRows = dao.myDonateCount(vo);
		PageVO pageInfo = makePageVO(page, totalRows);

		// 보여줄 페이지 설정
		vo.setBegin(String.valueOf(pageInfo.getStartRow()));
		vo.setEnd(String.valueOf(pageInfo.getEndRow()));

		List<HashMap> list = dao.myDonateProject(vo);
		System.out.println(list.size());
		ModelAndView mav = new ModelAndView();
		mav.setViewName("mydonate");
		mav.addObject("list", list);
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("cno", vo.getProjectStatus());
		if (principal != null)
			mav.addObject("principal", principal.getName());

		return mav;
	}

	// 내가 만든 프로젝트
	@RequestMapping("/myProject")
	public ModelAndView moveMyProject(Integer page, SearchVO vo, Principal principal) {
		SecurityContext impl = SecurityContextHolder.getContext(); // 세션에서 spring security 정보를 가져옴
		String implstr = impl.getAuthentication().getName(); // security 정보에서 세션에 담겨있는 로그인 정보 중 ID 가져옴
		MemberVO vo2 = dao.memname(implstr); // ID를 토대로 회원정보 가져옴 (회원 번호, 회원 이름)
		System.out.println("page 들어온 값 : " + page);
		System.out.println("상태 : " + vo.getProjectStatus());
		int memno = vo2.getMemberNo();
		vo.setMemberNo(memno);
		System.out.println("memno:" + vo.getMemberNo());

		// pageVO의 획득
		int totalRows = dao.myPTotalCount(vo);
		PageVO pageInfo = makePageVO(page, totalRows);

		// 보여줄 페이지 설정
		vo.setBegin(String.valueOf(pageInfo.getStartRow()));
		vo.setEnd(String.valueOf(pageInfo.getEndRow()));

		List<ProjectVO> list = dao.myProjectlist(vo);

		System.out.println(list.size());
		ModelAndView mav = new ModelAndView();
		mav.setViewName("myProject");
		mav.addObject("list", list);
		mav.addObject("cno", vo.getProjectStatus());
		mav.addObject("pageInfo", pageInfo);
		if (principal != null)
			mav.addObject("principal", principal.getName());

		return mav;
	}

	// 프로젝트 보는 기준
	@RequestMapping("/projectlook")
	public String projectLook() {
		return "projectlook";
	}

	// 프로젝트 업로드 폼
	@RequestMapping(value = "/ProjectUpload")
	public ModelAndView ProjectUpload() {
		List<CategoryVO> category = dao.casel(); // 프로젝트 업로드에 필요한 카테고리 목록을 가져옴

		// 세션에서 로그인 된 ID를 가져오는 작업
		SecurityContext impl = SecurityContextHolder.getContext();
		String implstr = impl.getAuthentication().getName();
		// 끝-------------------
		MemberVO vo = dao.memname(implstr); // 가져온 ID를 토대로 회원 번호, 이름을 가져온다
		String name = vo.getMemberName(); // 이름을 name 변수에 저장

		ModelAndView mav = new ModelAndView();
		mav.setViewName("ProjectUpload");
		mav.addObject("category", category); // 카테고리 목록 붙임
		mav.addObject("memberName", name); // name을 object로 붙여서 같이 전송
		return mav;
	}

	// 로그아웃 12/14
	@RequestMapping(value = "/logout")
	public String logout(Model m, HttpServletRequest request) {
		SecurityContextHolder.getContext().getAuthentication().setAuthenticated(false);

		return "main";
	}

	//사업자 등록번호 조회 폼
	@RequestMapping(value = "/licensee")
	public String licensee() {
		return "licensee";
	}

	// 회원가입 성공
	@RequestMapping(value = "/addMember")
	public String addMember(MemberVO vo) {
		dao.addMember(vo);

		return "main";
	}

	// 회원가입 폼으로
	@RequestMapping(value = "/sign")
	public String sign() {
		return "sign";
	}

	// 나이별 후원 카테고리 그래프 보기
	@RequestMapping(value = "/graphpage")
	public String graphPage(Model m) {
		Map<Integer, Integer> map = dao.ageGraph();
		m.addAttribute("map", map);

		return "graphpage";
	}
	
	// 캐쉬충전 폼으로
	@RequestMapping(value = "/cash")
	public ModelAndView cashcharge(MemberVO vo) {
		// 세션에서 로그인 된 ID를 가져오는 작업
		SecurityContext impl = SecurityContextHolder.getContext();
		String implstr = impl.getAuthentication().getName();
		// 끝-------------------
		MemberVO vo2 = dao.memname(implstr); // 가져온 ID를 토대로 회원 번호, 이름을 가져온다
		vo.setMemberNo(vo2.getMemberNo());

		List<MemberVO> list = dao.chargeList(vo);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("cashcharge");
		mav.addObject("list", list);
		return mav;

	}

	// 캐쉬 충전
	@RequestMapping(value = "/cashcharge")
	public String cashcharge(Model m, MemberVO vo) {
		// 세션에서 로그인 된 ID를 가져오는 작업
		SecurityContext impl = SecurityContextHolder.getContext();
		String implstr = impl.getAuthentication().getName();
		// 끝-------------------
		MemberVO vo2 = dao.memname(implstr); // 가져온 ID를 토대로 회원 번호, 이름을 가져온다
		vo.setMemberNo(vo2.getMemberNo());
		System.out.println("돈" + vo.getMemberCash());
		System.out.println("멤버번호" + vo.getMemberNo());
		dao.charge(vo);
		System.out.println("돈" + vo.getMemberCash());
		System.out.println("멤버번호" + vo.getMemberNo());

		return "redirect:/cash";

	}
	
	//아이디 중복 검사
	@RequestMapping(value = "/idcheck")
	@ResponseBody
	public int memberIdCheck(@RequestBody String memberId) {
		memberId = memberId.substring(0, memberId.length()-1);
		int count = dao.memberIdCheck(memberId);
		System.out.println(count);
		return count;
	}
}

