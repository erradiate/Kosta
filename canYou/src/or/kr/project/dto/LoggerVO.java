package or.kr.project.dto;

public class LoggerVO {
	int logNo, memberAge, categoryNo, subCategoryNo, donateMoney, projectNo;
	String memberName, memberGender, donateDay;
	
	
	public int getProjectNo() {
		return projectNo;
	}
	public void setProjectNo(int projectNo) {
		this.projectNo = projectNo;
	}
	public int getLogNo() {
		return logNo;
	}
	public void setLogNo(int logNo) {
		this.logNo = logNo;
	}
	public int getMemberAge() {
		return memberAge;
	}
	public void setMemberAge(int memberAge) {
		this.memberAge = memberAge;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public int getSubCategoryNo() {
		return subCategoryNo;
	}
	public void setSubCategoryNo(int subCategoryNo) {
		this.subCategoryNo = subCategoryNo;
	}
	public int getDonateMoney() {
		return donateMoney;
	}
	public void setDonateMoney(int donateMoney) {
		this.donateMoney = donateMoney;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemberGender() {
		return memberGender;
	}
	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}
	public String getDonateDay() {
		return donateDay;
	}
	public void setDonateDay(String donateDay) {
		this.donateDay = donateDay;
	}
}
