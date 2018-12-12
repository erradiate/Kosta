package or.kosta.excel;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import or.kosta.dto.DownDTO;
import or.kosta.mvc.dao.DownDao;

public class ExcelBuilder extends AbstractExcelView{
	// excelView 뷰를 찾으면, 이것을 현재클래스 ExcelBuilder 가
	// AbsractExcelView 를 상속했기 때문에 이것은 뷰이다.
	// DispatcherServlet -> [view]jsp (model) : forward
	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		//HSSF - 마이크로 소프트의 엑셀 전용 클래스
		// DispatcherServlet 에 의해서 Model을 받습니다.
		// ${listBooks}
		List<DownDTO> listBooks = (List<DownDTO>)model.get("listBooks");
		//poi 문법
		HSSFSheet sheet = workbook.createSheet("Show Books");
		sheet.setDefaultColumnWidth(30);
		CellStyle style = workbook.createCellStyle();
		Font font = workbook.createFont();
		style.setFont(font);
		HSSFRow header = sheet.createRow(0);
		// 엑셀의 셀 타이틀
		String [] str= {"number", "writer", "rdate", "img"};
		for(int i=0;i<str.length;i++) {
			header.createCell(i).setCellValue(str[i]);
			header.getCell(i).setCellStyle(style);
		}
		
		int rowCount = 1;
		// 셀의 내용을 채움
		for (DownDTO aBook : listBooks) {
			HSSFRow aRow = sheet.createRow(rowCount++);
			aRow.createCell(0).setCellValue(aBook.getNum());
			aRow.createCell(1).setCellValue(aBook.getWriter());
			aRow.createCell(2).setCellValue(aBook.getRdate());
			aRow.createCell(3).setCellValue(aBook.getImg());
		}
		response.setContentType("Application/Msexcel");
		response.setHeader("Content-Disposition",
				"attachment; filename=tboard_exce.xls");
	}
}
