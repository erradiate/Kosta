package or.kr.project.mvc.service;

import java.util.Map;

import or.kr.project.dto.ProjectDonateVO;

public interface Service_Transaction {
	public void cancle(ProjectDonateVO vo);
	public void donate(ProjectDonateVO vo, Map<String, Integer> m);
}
