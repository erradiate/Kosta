package or.kr.project.dto;

public class DeniedVO {
	private int deniedNo;
	private int projectNo;
	private String reason;
	private int firstview;
	public int getDeniedNo() {
		return deniedNo;
	}
	public void setDeniedNo(int deniedNo) {
		this.deniedNo = deniedNo;
	}
	public int getProjectNo() {
		return projectNo;
	}
	public void setProjectNo(int projectNo) {
		this.projectNo = projectNo;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public int getFirstview() {
		return firstview;
	}
	public void setFirstview(int firstview) {
		this.firstview = firstview;
	}
}
