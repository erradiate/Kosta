package or.kr.project.dto;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ProjectVO {
	private int projectNo;
	private int memberNo;
	private String projectName;
	private int projectCost;
	private String projectStartDate;
	private String projectEndDate;
	private int projectFundCnt;
	private String projectMainImage;
	private String projectStory;
	private String projectStep;
	private int projectStatus;
	private int categoryNo;
	private int projectCurCost;
	private MultipartFile multipartFile;
	private int subCategoryNo;
	private String UDate;

	private List<ProductVO> product;
	
	public List<ProductVO> getProduct() {
		return product;
	}
	public void setProduct(List<ProductVO> product) {
		this.product = product;
	}
	public int getSubCategoryNo() {
		return subCategoryNo;
	}
	public void setSubCategoryNo(int subCategoryNo) {
		this.subCategoryNo = subCategoryNo;
	}
	public String getUDate() {
		return UDate;
	}
	public void setUDate(String uDate) {
		UDate = uDate;
	}
	public MultipartFile getMultipartFile() {
		return multipartFile;
	}
	public void setMultipartFile(MultipartFile multipartFile) {
		this.multipartFile = multipartFile;
	}
	public int getProjectCurCost() {
		return projectCurCost;
	}
	public void setProjectCurCost(int projectCurCost) {
		this.projectCurCost = projectCurCost;
	}
	public int getProjectNo() {
		return projectNo;
	}
	public void setProjectNo(int projectNo) {
		this.projectNo = projectNo;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public int getProjectCost() {
		return projectCost;
	}
	public void setProjectCost(int projectCost) {
		this.projectCost = projectCost;
	}
	public String getProjectStartDate() {
		return projectStartDate;
	}
	public void setProjectStartDate(String projectStartDate) {
		this.projectStartDate = projectStartDate;
	}
	public String getProjectEndDate() {
		return projectEndDate;
	}
	public void setProjectEndDate(String projectEndDate) {
		this.projectEndDate = projectEndDate;
	}
	public int getProjectFundCnt() {
		return projectFundCnt;
	}
	public void setProjectFundCnt(int projectFundCnt) {
		this.projectFundCnt = projectFundCnt;
	}
	public String getProjectMainImage() {
		return projectMainImage;
	}
	public void setProjectMainImage(String projectMainImage) {
		this.projectMainImage = projectMainImage;
	}
	public String getProjectStory() {
		return projectStory;
	}
	public void setProjectStory(String projectStory) {
		this.projectStory = projectStory;
	}
	public String getProjectStep() {
		return projectStep;
	}
	public void setProjectStep(String projectStep) {
		this.projectStep = projectStep;
	}
	public int getProjectStatus() {
		return projectStatus;
	}
	public void setProjectStatus(int projectStatus) {
		this.projectStatus = projectStatus;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	
	
}
