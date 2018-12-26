package or.kr.project.mvc.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import or.kr.project.dto.PageVO;
import or.kr.project.dto.ProjectVO;
import or.kr.project.dto.SearchVO;
import or.kr.project.dto.SubCategoryVO;
import or.kr.project.mvc.dao.ProjectDaoImple;

@Controller
public class CategoryController {
	@Autowired
	private ProjectDaoImple dao;
	
	@RequestMapping(value="/subcaname")
	public ResponseEntity<List<SubCategoryVO>> subcaname(int categoryNo) {
		List<SubCategoryVO> l=dao.subcasel(categoryNo);
		
		return new ResponseEntity<>(l, HttpStatus.OK);
	}
	
	//카테고리별 프로젝트 보기(세부)
	@RequestMapping(value="/categoryproject2")
	public String categoryProject(Model m,@RequestParam("categoryNo")String categoryNo,
			@RequestParam("subcategoryNo")String subcategoryNo,
			Integer page, SearchVO svo,Principal principal) {
		
		SubCategoryVO vo=new SubCategoryVO();
		
		vo.setCategoryNo(Integer.parseInt(categoryNo));
		vo.setSubcategoryNo(Integer.parseInt(subcategoryNo));
		
		//카테고리 명 보여줌
		String categoryName = dao.categoryName(Integer.parseInt(categoryNo));
		m.addAttribute("categoryName", categoryName);
		
		//서브카테고리 명 보여줌
		String subCategoryName = dao.subCategoryName(Integer.parseInt(subcategoryNo));
		m.addAttribute("subCategoryName", subCategoryName);
		
		// pageVO의 획득
		int totalRows = dao.getCategoryCount2(vo);
		PageVO pageInfo = makePageVO(page, totalRows);
		  
		// 보여줄 페이지 설정
		svo.setBegin(String.valueOf(pageInfo.getStartRow()));
		svo.setEnd(String.valueOf(pageInfo.getEndRow()));
		
		List<String> dateList = new ArrayList<String>(); //남은 날짜 리스트
		
		//무슨 카테고리인지 전달
		Map<String, String> categoryList = new HashMap<>(); 
		categoryList.put("categoryNo", categoryNo);
		categoryList.put("subcategoryNo", subcategoryNo);
		categoryList.put("begin", String.valueOf(pageInfo.getStartRow()));
		categoryList.put("end", String.valueOf(pageInfo.getEndRow()));
		m.addAttribute("categoryNo", categoryNo);
		
		List<ProjectVO> list = dao.lookCategoryProject2(categoryList); //리스트 얻음	
		m.addAttribute("list", list);
		m.addAttribute("pageInfo", pageInfo); // pageInfo 전달		

		System.out.println("categoryNo : " +categoryNo);
		System.out.println("list size2 : "+list.size());

		if (principal != null) {
			m.addAttribute("principal", principal.getName());
		}
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
		
		//남은 날짜 계산해서 list에 넣어 줌
		for(ProjectVO pvo : list) {
			String sys = format.format(new Date()); //현재 날짜
			
			int idx = pvo.getProjectEndDate().indexOf(" "); 
			String end = pvo.getProjectEndDate().substring(0,idx); //끝나는 날짜

			Date endDate = null;
			Date sysdate = null;
			long diffDays = 0;
			
			try {
				//날짜 계산을 위해 Date형으로 변환
				endDate = format.parse(end);
				sysdate = format.parse(sys);
				
				// 시간차이를 시간,분,초를 곱한 값으로 나누면 하루 단위가 나옴
		        long diff = endDate.getTime() - sysdate.getTime();
		        diffDays = diff / (24 * 60 * 60 * 1000);
		 
		        System.out.println("날짜차이=" + diffDays);
		        
		        //dateList.add(diffDays);
			} catch (ParseException e) {
				e.printStackTrace();
			}

			dateList.add(Integer.toString((int) diffDays)); //리스트에 날짜 차이를 넣음
			
		}
		m.addAttribute("dateList", dateList);
		
		return "categoryproject";
	}
	
	// makePageVO 메소드(페이지를 만들어주는 메소드)
			public PageVO makePageVO(Integer page, int totalRows) {
				  
				  PageVO pageInfo = new PageVO();
				  int rowsPerPage = 9; // 한페이지당 보여줄 목록수 - properties
				  int pagesPerBlock = 5; // 한 블록당 보여줄 페이지 수 - properties
				  if (page == null) page = 0;
				  if(page  == 0) page = 1; //페이지 초기화
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
}
