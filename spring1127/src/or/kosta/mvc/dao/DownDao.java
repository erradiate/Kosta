package or.kosta.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import or.kosta.dto.DownDTO;
import or.kosta.excel.ExcelBuilder;

@Repository
public class DownDao {
	@Autowired
	SqlSessionTemplate ss;
	
	public List<DownDTO> getList(){
		List<DownDTO> list = ss.selectList("down.getlist");
		return list;
	}
	
	public void addDown(DownDTO vo) {
		ss.insert("down.adddown",vo);
	}
	
}
