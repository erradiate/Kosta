package or.kr.project.mvc.controller;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import or.kr.project.dto.MemberVO;
import or.kr.project.dto.PageVO;
import or.kr.project.dto.ProjectDonateVO;
import or.kr.project.dto.ProjectVO;
import or.kr.project.dto.SearchVO;
import or.kr.project.mvc.dao.projectDaoImple;

@Controller
public class SearchController {
	@Autowired
	private projectDaoImple dao;
	//모든 프로젝트 검색
	@RequestMapping(value="/search")
	public ModelAndView listSearch(int page,String searchType, String searchValue){
		System.out.println("SearchType :"+searchType);
		System.out.println("SearchValue :"+searchValue);
		//------------------------------
        PageVO pageInfo = new PageVO();

		int rowsPerPage = 9;

		int pagesPerBlock = 5;

		int currentPage = page;
	
		int currentBlock = 0;

		if(currentPage % pagesPerBlock == 0){
			currentBlock = currentPage / pagesPerBlock;
		}else{
			currentBlock = currentPage / pagesPerBlock + 1;
		}

		int startRow = (currentPage - 1) * rowsPerPage + 1;
		int endRow = currentPage * rowsPerPage;

		SearchVO svo = new SearchVO();
		svo.setBegin(String.valueOf(startRow));
		svo.setEnd(String.valueOf(endRow));
		svo.setSearchType(searchType);
		svo.setSearchValue(searchValue);
		
		// 전체 레코드 수 
		int totalRows = dao.getTotalCount(svo);
		
		System.out.println("totalRows:"+totalRows);
		int totalPages = 0;
		//전체 페이지를 구하는 공식
		if(totalRows % rowsPerPage == 0){
			totalPages = totalRows / rowsPerPage;
		}else{
			totalPages = totalRows / rowsPerPage + 1;
		}

		// 전체 블록을 구하는 공식
		int totalBlocks = 0;
		if(totalPages % pagesPerBlock == 0){
			totalBlocks = totalPages / pagesPerBlock;
		}else{
			totalBlocks = totalPages / pagesPerBlock + 1;
		}
		// PageVO에 setter로 값을 주입.
		pageInfo.setCurrentPage(currentPage);
		pageInfo.setCurrentBlock(currentBlock);
		pageInfo.setRowsPerPage(rowsPerPage);
		pageInfo.setPagesPerBlock(pagesPerBlock);
		pageInfo.setStartRow(startRow);
		pageInfo.setEndRow(endRow);
		pageInfo.setTotalRows(totalRows);
		pageInfo.setTotalPages(totalPages);
		pageInfo.setTotalBlocks(totalBlocks);
	
		//-------------------------------
		ModelAndView mav = new ModelAndView();
		mav.setViewName("searchproject");
	
		
		List<ProjectVO> list = dao.getListSearch(svo);
		
		mav.addObject("pageInfo",pageInfo);
		mav.addObject("searchType", searchType);
		mav.addObject("searchValue", searchValue);
		mav.addObject("list", list);
		
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
	
	// 내 후원현황 서치
	@RequestMapping(value="/donatesearch")
	public ModelAndView donatelistSearch(int page, String searchValue){
		SecurityContext impl=SecurityContextHolder.getContext();	// 세션에서 spring security 정보를 가져옴
		String implstr=impl.getAuthentication().getName();	// security 정보에서 세션에 담겨있는 로그인 정보 중 ID 가져옴
		MemberVO vo2=dao.memname(implstr);	// ID를 토대로 회원정보 가져옴 (회원 번호, 회원 이름)
		int memno = vo2.getMemberNo();
		System.out.println("SearchValue :"+searchValue);
		//------------------------------
        PageVO pageInfo = new PageVO();

		int rowsPerPage = 9;

		int pagesPerBlock = 5;

		int currentPage = page;
	
		int currentBlock = 0;

		if(currentPage % pagesPerBlock == 0){
			currentBlock = currentPage / pagesPerBlock;
		}else{
			currentBlock = currentPage / pagesPerBlock + 1;
		}

		int startRow = (currentPage - 1) * rowsPerPage + 1;
		int endRow = currentPage * rowsPerPage;

		SearchVO svo = new SearchVO();
		svo.setBegin(String.valueOf(startRow));
		svo.setEnd(String.valueOf(endRow));
		svo.setSearchValue(searchValue);
		svo.setMemberNo(memno);
		
		// 전체 레코드 수 
		int totalRows = dao.donateTotalCount(svo);
		
		System.out.println("totalRows:"+totalRows);
		int totalPages = 0;
		//전체 페이지를 구하는 공식
		if(totalRows % rowsPerPage == 0){
			totalPages = totalRows / rowsPerPage;
		}else{
			totalPages = totalRows / rowsPerPage + 1;
		}

		// 전체 블록을 구하는 공식
		int totalBlocks = 0;
		if(totalPages % pagesPerBlock == 0){
			totalBlocks = totalPages / pagesPerBlock;
		}else{
			totalBlocks = totalPages / pagesPerBlock + 1;
		}
		// PageVO에 setter로 값을 주입.
		pageInfo.setCurrentPage(currentPage);
		pageInfo.setCurrentBlock(currentBlock);
		pageInfo.setRowsPerPage(rowsPerPage);
		pageInfo.setPagesPerBlock(pagesPerBlock);
		pageInfo.setStartRow(startRow);
		pageInfo.setEndRow(endRow);
		pageInfo.setTotalRows(totalRows);
		pageInfo.setTotalPages(totalPages);
		pageInfo.setTotalBlocks(totalBlocks);
	
		//-------------------------------
		ModelAndView mav = new ModelAndView();
		mav.setViewName("donateSearch");
	
		
		List<HashMap> list = dao.donateListSearch(svo);
		mav.addObject("pageInfo",pageInfo);
		mav.addObject("searchValue", searchValue);
		mav.addObject("list", list);
		return mav;
	}
	
	//마이 프로젝트 서치
	@RequestMapping(value="/myprojectearch")
	public ModelAndView myplistSearch(int page, String searchValue){
		SecurityContext impl=SecurityContextHolder.getContext();	// 세션에서 spring security 정보를 가져옴
		String implstr=impl.getAuthentication().getName();	// security 정보에서 세션에 담겨있는 로그인 정보 중 ID 가져옴
		MemberVO vo2=dao.memname(implstr);	// ID를 토대로 회원정보 가져옴 (회원 번호, 회원 이름)
		int memno = vo2.getMemberNo();
		System.out.println("SearchValue :"+searchValue);
		//------------------------------
        PageVO pageInfo = new PageVO();

		int rowsPerPage = 9;

		int pagesPerBlock = 5;

		int currentPage = page;
	
		int currentBlock = 0;

		if(currentPage % pagesPerBlock == 0){
			currentBlock = currentPage / pagesPerBlock;
		}else{
			currentBlock = currentPage / pagesPerBlock + 1;
		}

		int startRow = (currentPage - 1) * rowsPerPage + 1;
		int endRow = currentPage * rowsPerPage;

		SearchVO svo = new SearchVO();
		svo.setBegin(String.valueOf(startRow));
		svo.setEnd(String.valueOf(endRow));
		svo.setSearchValue(searchValue);
		svo.setMemberNo(memno);
		
		// 전체 레코드 수 
		int totalRows = dao.mypsearchTotalCount(svo);
		
		System.out.println("totalRows:"+totalRows);
		int totalPages = 0;
		//전체 페이지를 구하는 공식
		if(totalRows % rowsPerPage == 0){
			totalPages = totalRows / rowsPerPage;
		}else{
			totalPages = totalRows / rowsPerPage + 1;
		}

		// 전체 블록을 구하는 공식
		int totalBlocks = 0;
		if(totalPages % pagesPerBlock == 0){
			totalBlocks = totalPages / pagesPerBlock;
		}else{
			totalBlocks = totalPages / pagesPerBlock + 1;
		}
		// PageVO에 setter로 값을 주입.
		pageInfo.setCurrentPage(currentPage);
		pageInfo.setCurrentBlock(currentBlock);
		pageInfo.setRowsPerPage(rowsPerPage);
		pageInfo.setPagesPerBlock(pagesPerBlock);
		pageInfo.setStartRow(startRow);
		pageInfo.setEndRow(endRow);
		pageInfo.setTotalRows(totalRows);
		pageInfo.setTotalPages(totalPages);
		pageInfo.setTotalBlocks(totalBlocks);
	
		//-------------------------------
		ModelAndView mav = new ModelAndView();
		mav.setViewName("myprojectSearch");
	
		
		List<ProjectVO> list = dao.myprojectListSearch(svo);
		mav.addObject("pageInfo",pageInfo);
		mav.addObject("searchValue", searchValue);
		mav.addObject("list", list);
		return mav;
	}
}
