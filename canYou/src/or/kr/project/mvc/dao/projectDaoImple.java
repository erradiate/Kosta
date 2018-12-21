package or.kr.project.mvc.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import or.kr.project.dto.CategoryVO;
import or.kr.project.dto.MemberVO;
import or.kr.project.dto.ProductVO;
import or.kr.project.dto.ProjectDonateVO;
import or.kr.project.dto.ProjectVO;
import or.kr.project.dto.ReplyVO;
import or.kr.project.dto.SearchVO;
import or.kr.project.dto.SubCategoryVO;

@Repository
public class projectDaoImple implements projectDao {
	@Autowired
	private SqlSessionTemplate ss;

	public List<CategoryVO> casel() {
		return ss.selectList("project.casel"); // 카테고리 이름 가져오는 sql문
	}

	public List<SubCategoryVO> subcasel(int i) {
		return ss.selectList("project.subcasel", i);
	}

	public MemberVO memname(String s) { // 회원이 누구인지 가져오기 위한 sql문(회원 아이디로 가져옴)
		return ss.selectOne("project.memname", s);
	}

	public MemberVO memname2(int i) {
		return ss.selectOne("project.memname2", i); // 회원이 누구인지 가져오기 위한 sql문 (회원 번호로 가져옴)
	}

	public void proin(ProjectVO vo) { // 프로젝트 insert문
		ss.insert("project.proin", vo);
	}

	public void prodin(ProductVO vo) { // 상품 insert문
		ss.insert("project.prodin", vo);
	}

	public List<ProductVO> prodsel(String s) { // 상품 select문
		return ss.selectList("project.prodsel", s);
	}

	public ProjectVO modifyview(ProjectVO vo) {
		return ss.selectOne("project.modifyview", vo);
	}

	public void modify(ProjectVO vo) {
		ss.update("project.modify", vo);
	}

	public String caselone(int i) {
		return ss.selectOne("project.caselone", i);
	}

	public String subcaselone(int i) {
		return ss.selectOne("project.subcaselone", i);
	}

	public int prodcost(int i) {
		return ss.selectOne("project.prodcost", i);
	}

	// 프로젝트에 후원하는 메소드 1 (돈 차감)
	public void donateMoney(Map<String, Integer> m) {
		ss.update("project.donateMoney", m);
		// System.out.println("donateNo : "+m);
	}

	// 프로젝트에 후원을 하는 메소드2
	public void donate(ProjectDonateVO vo) {
		ss.insert("project.donate", vo); // 후원
		ss.update("project.prodput", vo); // 상품을 빼냄

		ss.update("project.projectFundCnt", vo); // 프로젝트의 카운트 수를 하나 늘림
		ss.update("project.projectCurCost", vo); // 프로젝트의 모인 금액을 올림

	}

	// 마이페이지 - 후원현황
	public List<HashMap> myDonateProject(SearchVO vo) {
		System.out.println("들어온 넘버 값:" + vo);
		List<HashMap> list = ss.selectList("paging.mydonate", vo);
		return list;
	}

	// 투자한 프로젝트 총 개수
	public int myDonateCount(SearchVO vo) {
		return ss.selectOne("paging.mydonateTotal", vo);

	}

	// 후원 취소1 (돈 반환 + 선물 반환) 1219 수정
	public void returnMoney(ProjectDonateVO vo) {
		Map<String, Integer> m = new HashMap<>();

		// 돈을 반환하기 위해 취소할 프로젝트에 투자한 돈을 가져옴
		int total = ss.selectOne("project.mydonatelist", vo);
		vo.setDonateMoney(total);

		m.put("donateMoney", total);
		m.put("memberNo", vo.getMemberNo());
		System.out.println("productno : " + vo.getProductNo());
		ss.update("project.pmoneyminus", vo); // 프로젝트의 돈을 뺌
		ss.update("project.returnMoney", m); // 반환해서 회원의 돈으로 추가시켜줌
		ss.update("project.prodout", vo); // 상품 돌려 줌
	}

	// 프로젝트 후원자 감소 + 후원금 차감
	public void returnFundCnt(ProjectDonateVO vo) {
		ss.update("project.returnFundCnt", vo); // 프로젝트의 카운트 수를 하나 줄임
	}

	// 후원 취소2 (행 삭제)
	public void donateCancle(ProjectDonateVO vo) {
		ss.delete("project.cancle", vo); // 후원 취소
	}

	public ProjectVO projectlist(String num) {
		return ss.selectOne("project.list", num);
	}

	public List<CategoryVO> categoryLookAround() {
		return ss.selectList("project.lookaround");
	}

	// 프로젝트 댓글 등록

	public void replyInsert(ReplyVO vo) {
		ss.insert("project.replyInsert", vo);
	}

	// 댓글 리스트 보여줌

	public List<ReplyVO> replyList(String i) {
		return ss.selectList("project.replyList", i);

	}

	// 모든 프로젝트 둘러보기 -페이징 처리
	public List<ProjectVO> projectALLlist(SearchVO vo) {
		return ss.selectList("paging.AllList", vo);
	}

	// 모든 프로젝트 총 개수
	public int getTotalCount() {
		return ss.selectOne("paging.listTotal");

	}

	// 마이페이지 - 내가만든 프로젝트 리스트
	public List<ProjectVO> myProjectlist(SearchVO vo) {
		System.out.println("begin : " + vo.getBegin());
		System.out.println("End : " + vo.getEnd());
		return ss.selectList("paging.myProjectlist", vo);
	}

	// 마이페이지 - 내가만든 프로젝트 리스트 총개 수
	public int myPTotalCount(SearchVO vo) {
		return ss.selectOne("paging.myPlistTotal", vo);
	}

	// 마이페이지-개인정보 수정 1218 수정
	public int editMyInfo(HashMap<String, String> vo) {
		return ss.update("project.editinfo", vo);
	}

	// 카테고리별 프로젝트의 수 구하기
	public int getCategoryCount(int categoryNo) {
		return ss.selectOne("paging.listCategory", categoryNo);
	}

	// 카테고리별 프로젝트 보기
	public List<ProjectVO> lookCategoryProject(Map<String, String> categoryList) {
		System.out.println("-----------------------------");
		System.out.println(categoryList.get("categoryNo"));
		System.out.println(categoryList.get("begin"));
		System.out.println(categoryList.get("end"));
		System.out.println("-----------------------------");

		List<ProjectVO> list = ss.selectList("paging.paginglist", categoryList);
		System.out.println("list size : " + list.size());

		return list;
	}

	// 1214 추가
	// 카테고리별 프로젝트의 수 구하기 (+서브 카테고리 12/14 김다솜 추가)
	public int getCategoryCount2(SubCategoryVO vo) {
		return ss.selectOne("paging.listCategory2", vo);
	}

	// 카테고리별 프로젝트 보기 + 서브 카테고리
	public List<ProjectVO> lookCategoryProject2(Map<String, String> categoryList) {
		System.out.println("-----------------------------");
		System.out.println(categoryList.get("categoryNo"));
		System.out.println(categoryList.get("begin"));
		System.out.println(categoryList.get("end"));
		System.out.println("-----------------------------");

		List<ProjectVO> list = ss.selectList("paging.paginglist2", categoryList);
		System.out.println("list size : " + list.size());

		return list;
	}

	// 1214 추가 끝
	public List<SubCategoryVO> subcaname(String categoryName) {
		return ss.selectList("project.subcaname", categoryName);
	}

	// 인기 프로젝트 보기
	public List<ProjectVO> popularList() {
		return ss.selectList("project.popularList");
	}

	// 새로운 프로젝트 보기
	public List<ProjectVO> newList() {
		return ss.selectList("project.newList");
	}

	// 마감임박 프로젝트 보기
	public List<ProjectVO> deadlineList() {
		return ss.selectList("project.deadlineList");
	}

	// 모든 프로젝트 서치
	public List<ProjectVO> getListSearch(SearchVO svo) {
		return ss.selectList("search.aplsearch", svo);
	}

	// 모든 프로젝스 서치 총 개수
	public int getTotalCount(SearchVO svo) {
		return ss.selectOne("search.aplcount", svo);
	}

	// 내 후원현황 서치
	public List<HashMap> donateListSearch(SearchVO svo) {
		List<HashMap> list = ss.selectList("search.mdlsearch", svo);
		return list;
	}

	// 내 후원현황 서치 총 개수
	public int donateTotalCount(SearchVO vo) {
		return ss.selectOne("search.mdlcount", vo);
	}

	// 내가 만든 프로젝트 서치
	public List<ProjectVO> myprojectListSearch(SearchVO svo) {
		return ss.selectList("search.mypsearch", svo);
	}

	// 내가 만든 프로젝트 서치 총 개수
	public int mypsearchTotalCount(SearchVO vo) {
		return ss.selectOne("search.mypcount", vo);
	}

	// 회원가입
	public void addMember(MemberVO vo) {
		ss.insert("project.addMember", vo);
	}

	// 나이별 후원 카테고리 그래프 보기
	public Map<Integer, Integer> ageGraph() {
		Map<Integer, Integer> map = (Map<Integer, Integer>) ss.selectList("graph.ageGraph");

		return map;
	}

	// 회원정보 가져오기 1218
	public MemberVO viewmember(String s) {
		return ss.selectOne("project.viewmember", s);
	}


	// 재검토 요청 1221
	public void request(int i) {
		ss.update("project.request", i);
		ss.delete("project2.delreason", i);
	}

	// 검토거부당한 프로젝트 삭제 1221
	public void prodel(int i) {
		ss.delete("project2.delreason", i); // 프로젝트 거절 사유 삭제
		ss.delete("project.proddel", i); // 프로젝트에 관련된 상품부터 삭제
		ss.delete("project.prodel", i); // 프로젝트 삭제
	}

	// 캐쉬 충전소 - 캐쉬 충전
	public void charge(MemberVO vo) {
		ss.update("project.cashcharge", vo);
	}

	// 캐쉬 충전소 리스트
	public List<MemberVO> chargeList(MemberVO vo) {
		return ss.selectList("project.cashlist", vo);
	}

	// 아이디 중복 검사
	public int memberIdCheck(String memberId) {
		return ss.selectOne("project.memberIdCheck", memberId);
	}

	// 카테고리 명 출력
	public String categoryName(int categoryNo) {
		return ss.selectOne("project.categoryName", categoryNo);
	}

	// 서브카테고리 명 출력
	public String subCategoryName(int SubCategoryNo) {
		return ss.selectOne("project.subCategoryName", SubCategoryNo);
	}

	// 헤더에 사용자의 정보 출력 (이미지, 캐시)
	public MemberVO userInfo(String memberId) {
		return ss.selectOne("project.userInfo", memberId);
	}

	// 자기 프로젝트에 후원한 사람 명단 보기
	public List<MemberVO> projectDonateList(int projectNo) {
		return ss.selectList("project.projectDonateList", projectNo);
	}

	// 댓글 수정
	public int comupdate(HashMap<String, String> vo) {
		int ret = ss.update("project.commodify", vo);
		return ret;
	}

	// 댓글 수정 팝업
	public ReplyVO compopup(HashMap<String, String> vo) {
		return ss.selectOne("project.commodi", vo);
	}

	// 댓글 삭제
	public void comdelete(ReplyVO vo) {
		ss.delete("project.comdelete", vo);
	}

	// 상세보기 - 관심별 리스트보기
	public List<ProjectVO> projectlistByCategory(String category) {
		System.out.println("category : " + category);
		return ss.selectList("project.listByCategory", category);
	}

}
