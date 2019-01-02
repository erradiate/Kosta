
package or.kr.project.mvc.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.authentication.AuthenticationTrustResolverImpl;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import or.kr.project.dto.MemberVO;
import or.kr.project.dto.ProductVO;
import or.kr.project.dto.ProjectVO;
import or.kr.project.dto.ReplyVO;
import or.kr.project.mvc.dao.ProjectDaoImple;

@Controller
// Detail.jsp를 포함하는 각각 jsp를 컨트롤하기 위한 Controller
public class DetailController {
	@Autowired
	ProjectDaoImple dao;

	// 스토리와 관련된 부분이 detail.jsp와 같이 나오는 메소드
	@GetMapping("/story")
	public String listView(Model m, String projectNo, HttpServletRequest req) {
		// project 관련한 정보 빼오기
		ProjectVO list = dao.projectlist(projectNo);
		String c = dao.caselone(list.getCategoryNo());
		String sc = dao.subcaselone(list.getSubCategoryNo());
		// 카테고리별 LIST
		List<ProjectVO> listByCategory = dao.projectlistByCategory(String.valueOf(list.getCategoryNo()));
		m.addAttribute("list", list);
		m.addAttribute("listByCategory", listByCategory);
		m.addAttribute("c", c);
		m.addAttribute("sc", sc);

		// project와 연결된 member 정보 가져오기
		MemberVO mem = dao.memname2(list.getMemberNo());
		m.addAttribute("member", mem);
		return "storypage";
	}

	@RequestMapping(value = "/community")
	public String getReply(Model m, HttpServletRequest req, String projectNo) {

		// project 관련한 정보 빼오기
		ProjectVO list = dao.projectlist(projectNo);
		String c = dao.caselone(list.getCategoryNo());
		String sc = dao.subcaselone(list.getSubCategoryNo());
		// 카테고리별 LIST
		List<ProjectVO> listByCategory = dao.projectlistByCategory(String.valueOf(list.getCategoryNo()));
		m.addAttribute("list", list);
		m.addAttribute("listByCategory", listByCategory);
		m.addAttribute("c", c);
		m.addAttribute("sc", sc);
		// project와 연결된 member 정보 가져오기
		MemberVO mem = dao.memname2(list.getMemberNo());
		m.addAttribute("member", mem);

		// 댓글 정보 가져오기
		List<ReplyVO> replylist = dao.replyList(projectNo);
		// List<ReplyVO> replylist = dao.replyList(projectNo);
		m.addAttribute("replylist", replylist);

		HttpSession s = req.getSession();
		s.setAttribute("projnum", projectNo); // 프로젝트 세션을 추가

		return "communitypage";
	}

	@RequestMapping(value = "/productDetail")
	public String getProductDetail(Model m, HttpServletRequest req, String projectNo, String success) {
		// project 관련한 정보 빼오기
		ProjectVO list = dao.projectlist(projectNo);
		String c = dao.caselone(list.getCategoryNo());
		String sc = dao.subcaselone(list.getSubCategoryNo());
		// 카테고리별 LIST
		List<ProjectVO> listByCategory = dao.projectlistByCategory(String.valueOf(list.getCategoryNo()));
		m.addAttribute("list", list);
		m.addAttribute("listByCategory", listByCategory);
		m.addAttribute("c", c);
		m.addAttribute("sc", sc);

		// project와 연결된 member 정보 가져오기
		MemberVO mem = dao.memname2(list.getMemberNo());
		m.addAttribute("member", mem);

		// project와 연결된 product 가져오기
		List<ProductVO> list2 = dao.prodsel(projectNo);
		m.addAttribute("prodlist", list2);
		m.addAttribute("success", success);

		return "productdetailpage";
	}

	// 내 프로젝트를 후원한 사람 명단 보기
	@RequestMapping(value = "/projectDonateList")
	public String projectDonateList(String projectNo, String memberNo, Model m, HttpServletRequest request) {
		AuthenticationTrustResolver trustResolver = new AuthenticationTrustResolverImpl();
		SecurityContext impl = SecurityContextHolder.getContext(); // 세션에서 spring security 정보를 가져옴
		String implstr = impl.getAuthentication().getName(); // security 정보에서 세션에 담겨있는 로그인 정보 중 ID 가져옴

		// project 관련한 정보 빼오기
		ProjectVO list = dao.projectlist(projectNo);
		String c = dao.caselone(list.getCategoryNo());
		String sc = dao.subcaselone(list.getSubCategoryNo());

		m.addAttribute("list", list);
		m.addAttribute("c", c);
		m.addAttribute("sc", sc);

		// project와 연결된 member 정보 가져오기
		MemberVO mem = dao.memname2(list.getMemberNo());
		m.addAttribute("member", mem);

		MemberVO vo = dao.memname(implstr); // ID를 토대로 회원정보 가져옴 (회원 번호, 회원 이름)

		if (!trustResolver.isAnonymous(SecurityContextHolder.getContext().getAuthentication())) {
			if (vo.getMemberNo() == Integer.parseInt(memberNo)) { // 현재 들어온 회원과 프로젝트 진행하는 사람이 동일하면
				// 후원한 멤버 정보 빼오기
				List<MemberVO> mList = dao.projectDonateList(Integer.parseInt(projectNo));
				m.addAttribute("mList", mList);

			}
			return "mysponsor";

		}
		return "storypage";

	}

	@RequestMapping(value = "/DonateList")
	public ModelAndView downloadExcel(int projectNo, int memberNo) {
		SecurityContext impl = SecurityContextHolder.getContext(); // 세션에서 spring security 정보를 가져옴
		String implstr = impl.getAuthentication().getName(); // security 정보에서 세션에 담겨있는 로그인 정보 중 ID 가져옴
		MemberVO vo2 = dao.memname(implstr); // ID를 토대로 회원정보 가져옴 (회원 번호, 회원 이름)
		int memno = vo2.getMemberNo();

		HashMap<String, String> map = new HashMap<>();
		map.put("projectNo", String.valueOf(projectNo));
		map.put("memberNo", String.valueOf(memno));
		List<MemberVO> excellist = dao.DonateListexcel(map);
		return new ModelAndView("excelView", "excelview", excellist);
		// 뷰이름,모델이름,모델값주소
	}
}