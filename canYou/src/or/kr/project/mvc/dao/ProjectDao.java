package or.kr.project.mvc.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import or.kr.project.dto.CategoryVO;
import or.kr.project.dto.MemberVO;
import or.kr.project.dto.ProductVO;
import or.kr.project.dto.ProjectDonateVO;
import or.kr.project.dto.ProjectVO;
import or.kr.project.dto.ReplyVO;
import or.kr.project.dto.SearchVO;
import or.kr.project.dto.SubCategoryVO;

/**
 * <pre>
 * <b>ProjectDao 인터페이스</b>
 * </pre>
 * @author 전윤지
 * @version ver.1.0
 * @since jdk.1.8
 *
 */

public interface ProjectDao {
	public List<CategoryVO> casel();
	public List<SubCategoryVO> subcasel(int i);
	public MemberVO memname(String s);
	public MemberVO memname2(int i);
	public void proin(ProjectVO vo);
	public void prodin(ProductVO vo);
	public List<ProductVO> prodsel(String s);
	public ProjectVO modifyview(ProjectVO vo);
	public void modify(ProjectVO vo);
	public String caselone(int i);
	public String subcaselone(int i);
	public int prodcost(int i);
	public void donateMoney(Map<String, Integer> m);
	public void donate(ProjectDonateVO vo);
	public List<HashMap> myDonateProject(SearchVO vo);
	public int myDonateCount(SearchVO vo);
	public void returnMoney(ProjectDonateVO vo);
	public void returnFundCnt(ProjectDonateVO vo);
	public void donateCancle(ProjectDonateVO vo);
	public ProjectVO projectlist(String num);
	public List<CategoryVO> categoryLookAround();
	public void replyInsert(ReplyVO vo);
	public List<ReplyVO> replyList(String i);
	public List<ProjectVO> projectALLlist(SearchVO vo);
	public int getTotalCount();
	public List<ProjectVO> myProjectlist(SearchVO vo);
	public int myPTotalCount(SearchVO vo);
	public int editMyInfo(HashMap<String, String> vo);
	public int getCategoryCount(int categoryNo);
	public List<ProjectVO> lookCategoryProject(Map<String, String> categoryList);
	public int getCategoryCount2(SubCategoryVO vo);
	public List<ProjectVO> lookCategoryProject2(Map<String, String> categoryList);
	public List<SubCategoryVO> subcaname(String categoryName);
	public List<ProjectVO> popularList();
	public List<ProjectVO> newList();
	public List<ProjectVO> deadlineList();
	public List<ProjectVO> getListSearch(SearchVO svo);
	public int getTotalCount(SearchVO svo);
	public List<HashMap> donateListSearch(SearchVO svo);
	public int donateTotalCount(SearchVO vo);
	public int mypsearchTotalCount(SearchVO vo);
	public List<ProjectVO> myprojectListSearch(SearchVO svo);
	public void addMember(MemberVO vo);
	public Map<Integer, Integer> ageGraph();
	public MemberVO viewmember(String s);
	public void request(int i);
	public void prodel(int i);
	public void charge(MemberVO vo);
	public MemberVO chargeList(int memberNo);
	public int memberIdCheck(String memberId);
	public String categoryName(int categoryNo);
	public String subCategoryName(int SubCategoryNo);
	public MemberVO userInfo(String memberId);
	public List<MemberVO> projectDonateList(int projectNo);
	public List<MemberVO> DonateListexcel(HashMap<String, String> vo);
	public int comupdate(HashMap<String, String> vo);
	public ReplyVO compopup(HashMap<String, String> vo);
	public void comdelete(ReplyVO vo);
	public List<ProjectVO> projectlistByCategory(String category);
}
