package or.kr.project.excel;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import or.kr.project.dto.MemberVO;


@SuppressWarnings("deprecation")
public class ExcelBuilder extends AbstractExcelView{

	@Override
	protected void buildExcelDocument(Map<String,Object> model,
				HSSFWorkbook workbook, HttpServletRequest request,
				HttpServletResponse response) throws Exception{
		
		List<MemberVO> excelview = (List<MemberVO>) model.get("excelview");
		//poi문법
		HSSFSheet sheet = workbook.createSheet("후원자 명단"); //엑셀 시트 생성
		sheet.setDefaultColumnWidth(30);
		CellStyle style = workbook.createCellStyle();
		Font font = workbook.createFont();
		font.setFontName("Arial");
		style.setFillForegroundColor(HSSFColor.BLACK.index);
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setColor(HSSFColor.WHITE.index);
		font.setFontHeightInPoints((short)14);
		style.setFont(font);
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); // 세로 가운데 절렬
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		
		HSSFRow header = sheet.createRow(0); // 행 생성
		header.setHeight((short)700);
		short width = 150;
		//엑셀의 셀 타이틀
		String[] str = {"아이디","이름","주소","폰","이메일","성별","나이","계좌"};
		for(int i=0; i< str.length; i++) {
			header.createCell(i).setCellValue(str[i]); // 열생성
			header.getCell(i).setCellStyle(style);
		}
			int rowCount = 1;
			for(MemberVO aBook : excelview) {
				HSSFRow aRow = sheet.createRow(rowCount++);
				aRow.createCell(0).setCellValue(aBook.getMemberId()); //셀에 값입력
				aRow.createCell(1).setCellValue(aBook.getMemberName());
				aRow.createCell(2).setCellValue(aBook.getMemberAddr());
				aRow.createCell(3).setCellValue(aBook.getMemberPhone());
				aRow.createCell(4).setCellValue(aBook.getMemberEmail());
				aRow.createCell(5).setCellValue(aBook.getMemberGender());
				aRow.createCell(6).setCellValue(aBook.getMemberAge());
				aRow.createCell(7).setCellValue(aBook.getMemberAccount());
				aRow.setRowStyle(style);
			}
			response.setContentType("Application/Msexcel");
			response.setHeader("Content-Disposition", "attachment); filename=donate_exce.xls;");
	}
}
