package or.kr.project.word;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Nullable;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hwpf.converter.AbstractWordConverter;
import org.apache.poi.hwpf.usermodel.Paragraph;
import org.apache.poi.util.Units;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.apache.poi.xwpf.usermodel.XWPFTableCell.XWPFVertAlign;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTblWidth;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STMerge;

import or.kr.project.dto.MemberVO;
import or.kr.project.dto.ProductVO;
import or.kr.project.dto.ProjectDonateVO;
import or.kr.project.dto.ProjectVO;

public class WordBuilder{
	int row;
	public static String profileImg;
	public static String projectImg;
	
	// 주석 부분 vo 해야함
	public void wordCD(MemberVO vo, HttpServletRequest req, 
			HttpServletResponse resp, HttpSession session) throws Exception {
		// 문서를 만들기전 초기화 작업.
		row = 0;
		
		List<ProductVO> list = vo.getProject().getProduct();
		
		// 이미지 삽입 작업을 위한 밑 준비
		profileImg = vo.getMemberImage();
		projectImg = vo.getProject().getProjectMainImage();
		
		// jsp로 되어있는 내용을 워드에 작성하기 위해 바꿈
		HashMap<String, Object> map = jsp_To_Word(vo.getProject().getProjectStory());
		String[] projectStory = (String[])map.get("story"); 
		ArrayList<String> image = (ArrayList<String>)map.get("image");
		
		// 빈 문서 만들기
		XWPFDocument document = new XWPFDocument();

		// Table 생성 문서 내에서의 position은 0
		XWPFTable table = document.createTable(16,3);
		
		// table의 크기를 setting하기 위한 설정들
		table.setWidth(7*1440);
		table.getCTTbl().addNewTblGrid().addNewGridCol().setW(BigInteger.valueOf(5*1440));
		
		// 0번행 크기 설정 0번행 크기는 가장 위의 설정이므로 밑의 행은 모두 이 설정을 따름
		CTTblWidth tblWidth = table.getRow(0).getCell(0).getCTTc().addNewTcPr().addNewTcW();
		tblWidth.setW(BigInteger.valueOf(7*1440));
		
		// 셀병합 수직, 수평
		// 첫번째 행 수평적 셀 병합
		mergeCellHorizontally(table, 0, 0, 2);
		// 두번째 행 수평적 셀 병합
		mergeCellHorizontally(table, 1, 0, 2);
		// 여덟번째 행 수평적 셀 병합
		mergeCellHorizontally(table, 7, 0, 2);
		// 열네번째행 수평적 셀 병합
		mergeCellHorizontally(table, 13, 0, 2);
		// 열다섯번째 행 수평적 셀 병합
		mergeCellHorizontally(table, 14, 0, 2);
		
		// Table 첫번째 행
		XWPFTableRow firstRow = table.getRow(row++); //0
		firstRow.getCell(0).setColor("3366FF");
		firstRow.getCell(0).setVerticalAlignment(XWPFVertAlign.CENTER);

		XWPFParagraph paragraph = firstRow.getCell(0).getParagraphs().get(0);
		paragraph.setAlignment(ParagraphAlignment.CENTER);
		
		XWPFRun paragraphRunOne = paragraph.createRun();
		paragraphRunOne.setBold(true);
		paragraphRunOne.setFontSize(16);
		paragraphRunOne.setText("프로젝트 보고서");

		// Table 두번째 행
		XWPFTableRow secondRow = table.getRow(row++); //1
		secondRow.getCell(0).setVerticalAlignment(XWPFVertAlign.CENTER);
		
		paragraph = secondRow.getCell(0).getParagraphs().get(0);
		paragraph.setAlignment(ParagraphAlignment.CENTER);
		
		paragraphRunOne = paragraph.createRun();
		paragraphRunOne.setBold(true);
		paragraphRunOne.setFontSize(11);
		paragraphRunOne.setText("진행자 정보");
		
		// Table 세번째 행
		XWPFTableRow thirdRow = table.getRow(row++); //2
		
		// 이미지 넣기
		paragraph = thirdRow.getCell(0).getParagraphs().get(0);
		paragraphRunOne = paragraph.createRun();
		FileInputStream fis = new FileInputStream(
				session.getServletContext().getRealPath("/resources/images")+"\\"+profileImg);
		paragraphRunOne.addPicture(fis, 
				XWPFDocument.PICTURE_TYPE_JPEG, profileImg,
				Units.toEMU(150), Units.toEMU(170));
		fis.close();
		
		thirdRow.getCell(1).setText("진행자 이름");
		thirdRow.getCell(2).setText(vo.getMemberName());
		
		XWPFTableRow fourthRow = table.getRow(row++); //3
		fourthRow.getCell(1).setText("진행자 전화번호");
		fourthRow.getCell(2).setText(vo.getMemberPhone());
		
		XWPFTableRow fifthRow = table.getRow(row++); //4
		fifthRow.getCell(1).setText("진행자 이메일");
		fifthRow.getCell(2).setText(vo.getMemberEmail());
		
		XWPFTableRow sixthRow = table.getRow(row++); //5
		sixthRow.getCell(1).setText("진행자 성별");
		sixthRow.getCell(2).setText(vo.getMemberGender());
		
		XWPFTableRow seventhRow = table.getRow(row++); //6
		seventhRow.getCell(1).setText("진행자 나이");
		seventhRow.getCell(2).setText(Integer.toString(vo.getMemberAge()));
		
		// 프로필 이미지 부분 셀을 합쳐서 하나로
		mergeCellVertically(table, 0, 2, row-1);
		
		for(int i=2;i<=row-1;i++) {
			table.getRow(i).getCell(1).setColor("6699FF");
		}
		
		// 프로젝트 정보 부분
		XWPFTableRow eighthRow = table.getRow(row++); //7
		eighthRow.getCell(0).setVerticalAlignment(XWPFVertAlign.CENTER);
		
		paragraph = eighthRow.getCell(0).getParagraphs().get(0);
		paragraph.setAlignment(ParagraphAlignment.CENTER);
		
		paragraphRunOne = paragraph.createRun();
		paragraphRunOne.setBold(true);
		paragraphRunOne.setFontSize(11);
		paragraphRunOne.setText("프로젝트 정보");
		
		XWPFTableRow ninethRow = table.getRow(row++); //8
		
		//이미지 넣기
		paragraph = ninethRow.getCell(0).getParagraphs().get(0);
		paragraphRunOne = paragraph.createRun();
		fis = new FileInputStream(
				session.getServletContext().getRealPath("/resources/images")+"\\"+projectImg);
		paragraphRunOne.addPicture(fis, 
				XWPFDocument.PICTURE_TYPE_JPEG, projectImg,
				Units.toEMU(170), Units.toEMU(150));
		fis.close();
		
		ninethRow.getCell(1).setText("프로젝트 등급");
		ninethRow.getCell(2).setText(vo.getProject().getProjectStep());
		
		XWPFTableRow tenRow = table.getRow(row++); //9
		tenRow.getCell(1).setText("프로젝트 이름");
		tenRow.getCell(2).setText(vo.getProject().getProjectName());
		
		XWPFTableRow elevenRow = table.getRow(row++); //10
		elevenRow.getCell(1).setText("프로젝트 시작 날짜");
		elevenRow.getCell(2).setText(vo.getProject().getProjectStartDate());
		
		XWPFTableRow twelveRow = table.getRow(row++); //11
		twelveRow.getCell(1).setText("프로젝트 마감 날짜");
		twelveRow.getCell(2).setText(vo.getProject().getProjectEndDate());
		
		XWPFTableRow thirteenRow = table.getRow(row++); //12
		thirteenRow.getCell(1).setText("프로젝트 목표 금액");
		thirteenRow.getCell(2).setText(Integer.toString(vo.getProject().getProjectCost()));
		
		// 프로젝트 프로필 이미지 병합 부분
		mergeCellVertically(table, 0, 8, row-1);
		
		for(int i=8;i<=row-1;i++) {
			table.getRow(i).getCell(1).setColor("6699FF");
		}
		
		// 프로젝트 상세정보, 스토리
		XWPFTableRow fourteenRow = table.getRow(row++); //13
		fourteenRow.getCell(0).setVerticalAlignment(XWPFVertAlign.CENTER);
		
		paragraph = fourteenRow.getCell(0).getParagraphs().get(0);
		paragraph.setAlignment(ParagraphAlignment.CENTER);
		
		paragraphRunOne = paragraph.createRun();
		paragraphRunOne.setBold(true);
		paragraphRunOne.setFontSize(11);
		paragraphRunOne.setText("프로젝트 상세정보 및 스토리");
		
		XWPFTableRow fifteenRow = table.getRow(row++); //14
		
		paragraph = fifteenRow.getCell(0).getParagraphs().get(0);
		paragraph.setAlignment(ParagraphAlignment.LEFT);
		
		paragraphRunOne = paragraph.createRun();
		paragraphRunOne.setFontSize(10);
		// img 배열을 같이 돌리기 위한 변수
		int cnt=0;
		for(String str : projectStory) {
			if(str.equals("!ime")) {
				fis = new FileInputStream(
						session.getServletContext().getRealPath("/resources/images")+"\\"+image.get(cnt));
				paragraphRunOne.addPicture(fis, 
						XWPFDocument.PICTURE_TYPE_JPEG, image.get(cnt++), Units.toEMU(200), Units.toEMU(150));
				paragraphRunOne.addBreak();
			} else {
				paragraphRunOne.setText(str);
				paragraphRunOne.addBreak();
			}
		}		
				
		// 상품 상세 설명
		XWPFTableRow sixteenRow = table.getRow(row++); //15
		sixteenRow.getCell(0).setVerticalAlignment(XWPFVertAlign.CENTER);
		
		paragraph = sixteenRow.getCell(0).getParagraphs().get(0);
		paragraph.setAlignment(ParagraphAlignment.CENTER);
		
		paragraphRunOne = paragraph.createRun();
		paragraphRunOne.setBold(true);
		paragraphRunOne.setFontSize(11);
		paragraphRunOne.setText("프로젝트 상품");
		
		mergeCellHorizontally(table, row-1, 0, 2);
		
		//16
		for (ProductVO productVO : list) {
			// 상품 설명행 만들기
			create_Product_Row(table, paragraph, paragraphRunOne, productVO);
		}
		
		// 파일 전송을 위한 마임타입과 헤더 설정
		resp.setContentType("Application/Msword");
		resp.setHeader("Content-Disposition",
				"attachment; filename="+"ProjectPlan.docx");
		
		// 요청한 브라우저와의 아웃풋 스트림 연결
		OutputStream outStream = resp.getOutputStream();
		document.write(outStream);
		outStream.close();
		
	}
	//세로 부분의 셀을 합치는 함수
		private static void mergeCellVertically(XWPFTable table, int col, int fromRow, int toRow){
		    for(int rowIndex = fromRow; rowIndex <= toRow; rowIndex++){
		        XWPFTableCell cell = table.getRow(rowIndex).getCell(col);
		        if(rowIndex == fromRow){
		        	// 합치기 시작하는 처음 세로셀은 RESTART로 설정
		            cell.getCTTc().addNewTcPr().addNewVMerge().setVal(STMerge.RESTART);
		        }else{
		        	// 합치기 시작하는 처음 세로셀은 CONTINUE로 설정
		            cell.getCTTc().addNewTcPr().addNewVMerge().setVal(STMerge.CONTINUE);
		        }
		    }
		}
		
		//가로 부분의 셀을 합치는 함수
		private static void mergeCellHorizontally(XWPFTable table, int row, int fromCol, int toCol){
		    for(int colIndex = fromCol; colIndex <= toCol; colIndex++){
		        XWPFTableCell cell = table.getRow(row).getCell(colIndex);
		        if(colIndex == fromCol){
		            // 합치기 시작하는 처음 가로셀은 RESTART로 설정
		            cell.getCTTc().addNewTcPr().addNewHMerge().setVal(STMerge.RESTART);
		        }else{
		        	// 합쳐지는 가로 셀은 CONTINUE로 설정
		            cell.getCTTc().addNewTcPr().addNewHMerge().setVal(STMerge.CONTINUE);
		        }
		    }
		}
		
		private void create_Product_Row(XWPFTable table, XWPFParagraph paragraph, 
				XWPFRun paragraphRunOne, ProductVO productVO) {
			// row = 16
			// 상품 설명 행 제목행
			XWPFTableRow list_Row = table.createRow();
			
			paragraph = list_Row.getCell(0).getParagraphs().get(0);
			paragraph.setAlignment(ParagraphAlignment.CENTER);
			paragraphRunOne = paragraph.createRun();
			paragraphRunOne.setFontSize(10);
			paragraphRunOne.setText(productVO.getProductName()); // 1열 완료
			
			mergeCellHorizontally(table, row++, 0, 2);
			
			// 상품 설명 행 1행
			list_Row = table.createRow();
			list_Row.getCell(0).setVerticalAlignment(XWPFVertAlign.CENTER);
			
			paragraph = list_Row.getCell(0).getParagraphs().get(0);
			paragraph.setAlignment(ParagraphAlignment.CENTER);
			paragraphRunOne = paragraph.createRun();
			paragraphRunOne.setFontSize(10);
			paragraphRunOne.setText("상품 개수"); // 1열 완료
			
			paragraph = list_Row.getCell(1).getParagraphs().get(0);
			paragraph.setAlignment(ParagraphAlignment.CENTER);
			paragraphRunOne = paragraph.createRun();
			paragraphRunOne.setFontSize(10);
			paragraphRunOne.setText(Integer.toString(productVO.getProductCnt())); // 2열 완료
			
			mergeCellHorizontally(table, row++, 1, 2);
			
			// 상품 설명 행 2행
			list_Row = table.createRow();
			paragraph = list_Row.getCell(0).getParagraphs().get(0);
			paragraph.setAlignment(ParagraphAlignment.CENTER);
			paragraphRunOne = paragraph.createRun();
			paragraphRunOne.setFontSize(10);
			paragraphRunOne.setText("상품 명"); // 1열 완료
			
			paragraph = list_Row.getCell(1).getParagraphs().get(0);
			paragraph.setAlignment(ParagraphAlignment.CENTER);
			paragraphRunOne = paragraph.createRun();
			paragraphRunOne.setFontSize(10);
			paragraphRunOne.setText(productVO.getProductName()); // 2열 완료
			
			mergeCellHorizontally(table, row++, 1, 2);
			
			// 상품 설명 행 3행
			list_Row = table.createRow();
			paragraph = list_Row.getCell(0).getParagraphs().get(0);
			paragraph.setAlignment(ParagraphAlignment.CENTER);
			paragraphRunOne = paragraph.createRun();
			paragraphRunOne.setFontSize(10);
			paragraphRunOne.setText("상품 설명"); // 1열 완료
			
			paragraph = list_Row.getCell(1).getParagraphs().get(0);
			paragraph.setAlignment(ParagraphAlignment.CENTER);
			paragraphRunOne = paragraph.createRun();
			paragraphRunOne.setFontSize(10);
			paragraphRunOne.setText(productVO.getProductInfo()); // 2열 완료
			
			mergeCellHorizontally(table, row++, 1, 2);
			
			// 상품 설명 행 4행
			list_Row = table.createRow();
			paragraph = list_Row.getCell(0).getParagraphs().get(0);
			paragraph.setAlignment(ParagraphAlignment.CENTER);
			paragraphRunOne = paragraph.createRun();
			paragraphRunOne.setFontSize(10);
			paragraphRunOne.setText("상품 가격"); // 1열 완료
			
			paragraph = list_Row.getCell(1).getParagraphs().get(0);
			paragraph.setAlignment(ParagraphAlignment.CENTER);
			paragraphRunOne = paragraph.createRun();
			paragraphRunOne.setFontSize(10);
			paragraphRunOne.setText(Integer.toString(productVO.getProductCost())); // 2열 완료
			
			mergeCellHorizontally(table, row++, 1, 2);
		}
		
		private HashMap<String, Object> jsp_To_Word(String contents) {
			// 이미지를 저장하기 위한 list
			HashMap<String , Object> map = new HashMap<String, Object>();
			ArrayList<String> image = new ArrayList<>();
			
			String[] stx = contents.split("\r\n\r\n");
			// 시작점, 끝점의 p 태그 삭제
			for(int i=0;i<stx.length;i++) {
				if(stx[i]=="") {
					System.out.println("빔");
					continue;
				}
				if(i==stx.length-1) {
					stx[i] = stx[i].substring(3,stx[i].length()-6);
				} else {
					stx[i] = stx[i].substring(3,stx[i].length()-4);
				}
				System.out.println("stx["+i+"] : "+ stx[i]);
			}
			
			for(int i=0;i<stx.length;i++) {
				//이미지 태그 (이미지) 가지고 있을 경우
				if(stx[i].contains("<img")) {
					image.add(stx[i].substring(stx[i].indexOf("resources/images/")+17, stx[i].indexOf("\"", stx[i].indexOf("resources/images/")+17)));
					stx[i]="!ime";
				} else
					continue;
			}
			map.put("story", stx); map.put("image", image);
			return map;
		}
}


