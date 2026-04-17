package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dao.AdminQaDAO;
import com.kedu.dao.BoardDAO;
import com.kedu.dao.MembersDAO;
import com.kedu.dao.NoticeDAO;
import com.kedu.dao.VisitLogDAO;
import com.kedu.dto.BlackListDTO;
import com.kedu.dto.NoticeDTO;
import com.kedu.dto.QaDTO;
import com.kedu.dto.ReportDTO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminQaDAO dao;
	
	@Autowired
	private VisitLogDAO vdao;
	
	@Autowired
	private BoardDAO bdao;
	
	@Autowired
	private NoticeDAO nDao;
	
	@Autowired
	private MembersDAO mdao;
	
	
	@RequestMapping("/adminPage")
	public String test(HttpSession session, Model model) throws Exception{
		int qaCount = dao.qaCount();
		int memberCount = dao.activityMemberCount();
		
		session.setAttribute("qaCount", qaCount);
		session.setAttribute("memberCount", memberCount);
		model.addAttribute("todayVisitCount", vdao.getTodayVisitCount()); // 일별방문자수
		model.addAttribute("dailyCount", vdao.getDailyVisitCount()); // 기존회원,신규회원 방문수
		model.addAttribute("genderCount", vdao.getGenderCount()); // 성별 도넛차트 통계
		model.addAttribute("ageCount", vdao.getAgeCount()); // 연령대별 도넛차트 통계
		model.addAttribute("categoryCount", bdao.getCategoryCount());
		
		model.addAttribute("menu", "dashboard");
		return "admin/admin";
	}
	
	@RequestMapping("/adminQA") // 고객지원 페이지 진입
	public String adminQA(String status, int cpage, Model model, HttpSession session) throws Exception{
		
		int recordCountPerPage = 10;
	    int start = cpage * recordCountPerPage - (recordCountPerPage - 1);
	    int end = cpage * recordCountPerPage;

	    List<QaDTO> list;
	    int recordTotalCount;

	    int qaCount = dao.qaCount();
	    int qaDoneCount = dao.qaDoneCount();
	    int qaAllCount = dao.qaAllCount();

	    if("0".equals(status)){ // qa 답변대기 목록
	        list = dao.selectByAdminAnswerWait(start, end);
	        recordTotalCount = qaCount;

	    } else if("1".equals(status)){ // qa 답변완료 목록
	        list = dao.selectByAdminAnswerFinish(start, end);
	        recordTotalCount = qaDoneCount;

	    } else { // qa 전체 목록
	        list = dao.selectAllCount(start, end);
	        recordTotalCount = qaAllCount;
	    }
	    
		model.addAttribute("menu" , "qa");
	    model.addAttribute("list", list);
	    
	    model.addAttribute("qaCount", qaCount);
	    model.addAttribute("qaDoneCount", qaDoneCount);
	    model.addAttribute("qaAllCount", qaAllCount);

	    model.addAttribute("recordTotalCount", recordTotalCount);
	    model.addAttribute("recordCountPerPage", 10);
	    model.addAttribute("naviCountPerPage", 10);
	    model.addAttribute("currentPage", cpage);
	    model.addAttribute("status", status);
	    
	    session.setAttribute("currentPage", cpage);
	    session.setAttribute("status", status);
	    
	    return "admin/adminQ&A";
	}
	
	@RequestMapping("/answer")
	public String answer(QaDTO dto, int qa_seq, HttpSession session,int cpage,String status) throws Exception{
		
		String adminId = (String) session.getAttribute("loginId");
	    
	    dto.setMem_admin_id(adminId);
	    dao.updateReply(dto, qa_seq);
		return "redirect:/admin/adminQA?cpage=" + cpage + "&status=" + status;
	}
	
	@ResponseBody
	@RequestMapping("/answerReset")
	public String answerReset(int qa_seq) {
		
		dao.answerResetBySeq(qa_seq);
		
		return "redirect:/admin/adminQ&A";
	}
	
	@ResponseBody
	@RequestMapping("/answerUpdate")
	public String answerUpdate(String admin_answer, int qa_seq) {
		
		dao.answerUpdateBySeq(admin_answer, qa_seq);
		
		return "redirect:/admin/adminQ&A?seq=" + qa_seq;
	}
	
	//공지사항 글쓰기로 가기
	@RequestMapping("/toNoticeWrite")
	public String toWrite() throws Exception{
		return "/notice/noticeWrite";
	}
	
	//공지사항(관리자 버전)으로 가기
	@RequestMapping("/toAdminNotice")
	public String toAdminNotice(Model model,int cPage) throws Exception{
		
		//list 가져오기
		int start = (cPage-1)*10+1;
		int end = cPage*10;
		List<NoticeDTO> list = nDao.getNoticePost(start, end);
		
		//총 게시글 갯수 가져오기
		
		int totalCount = nDao.getTotalNotice();
		
		
		model.addAttribute("list",list);
		model.addAttribute("menu", "notice");
		model.addAttribute("cPage",cPage);
		model.addAttribute("totalCount",totalCount);
		return "/admin/adminNotice";
		
	}
	
	//공지사항 글쓰기 DB에 저장
	@PostMapping("/insertNotice")
	public String insertNotice(HttpSession session,@RequestParam("post_title")String title,
								@RequestParam("post_contents")String contents) throws Exception{
		String id =(String)session.getAttribute("loginId");
		int role = (Integer)session.getAttribute("role");
		nDao.insertNotice(new NoticeDTO(0,id,role,title,contents,"0"));
		
		return "redirect:/admin/toAdminNotice?cPage=1";
	}
	
	//공지사항 글 수정
	@PostMapping("/updateNotice")
	@ResponseBody
	public String updateNotice(@RequestParam("notice_title")String title, 
			@RequestParam("notice_content")String content, @RequestParam("seq")int seq) {
		
		int result = nDao.updateNotice(seq,title,content);
		if(result>0) {
			return "success";
		}
		return "fail";
	}
	
	//공지사항 글 삭제
	@PostMapping("/deleteNotice")
	@ResponseBody
	public String deleteNotice(@RequestParam("notice_seq")int seq) {
		
		int result = nDao.deleteNoticeBySeq(seq);
		if(result>0) {
			return "success";
		}
		return "fail";
	}
	
	// 신고관리 페이지로 이동
	@RequestMapping("/adminBlackList")
	public String adminBlackList(String status, Model model, int cpage, HttpSession session) throws Exception{
		model.addAttribute("menu", "report");
		List<ReportDTO> list = dao.selectGetPage(cpage * 10 - 9, cpage * 10);
		// 전체 신고목록 개수 카운트
		int allCount = dao.reportAllCount();
		// 처리완료 신고목록 개수 카운트
		int handleCount = dao.reportHandleCount();
		// 미처리 신고목록 개수 카운트
		int count = dao.reportCount();
		// 페이지
		int start = cpage * 10 - 9;
		int end = cpage * 10;
		
		// 처리상태 jsp에서 숫자 출력
		model.addAttribute("allCount", allCount);
		model.addAttribute("handleCount", handleCount);
		model.addAttribute("count", count);
		model.addAttribute("status",status);
		List<ReportDTO> dto;
		int recordTotalCount;
		
		if("3".equals(status)) { // 처리완료건들 출력 ( 3 : 블랙리스트 처리 완료 / 5: 블랙리스트 해제 처리 완료 )
			dto = dao.selectReportContentsByStatusHandle(start,end);
			recordTotalCount = handleCount;
		}else if("4".equals(status)) { // 미처리건들 출력
			int reportStatus = Integer.parseInt(status);
			dto = dao.selectReportContentsByStatus(reportStatus, start, end);
			recordTotalCount = count;
		}else{ // 전체
			dto = dao.selectReportContents(start, end);
			recordTotalCount = allCount;
		}
		
		// 페이지 시작
		model.addAttribute("list", list);
		model.addAttribute("recordCountPerPage", 10);
		model.addAttribute("naviCountPerPage", 10);
		model.addAttribute("recordTotalCount", recordTotalCount);
		model.addAttribute("currentPage", cpage);
		// 페이지 끝
		
		model.addAttribute("dto", dto);
		session.setAttribute("cpage", cpage);
		return "/admin/adminBlackList";
	}
	
	// 블랙리스트 등록 로직
	@ResponseBody
	@RequestMapping("/blackOn")
	public String blackOn(int mem_status, String target_id, String black_option, int day, int reports_status, int target_seq) {
		
		int banDays;
			if(day == -1) {
				banDays = 99999;
			}else {
				banDays = day;
			}
			
		int result = mdao.getRole(target_id);
		
		if(result == 0) {
			return "fail";
		}
		// 블랙리스트 테이블에 해당 유저가 있는지 먼저 검사
		List<BlackListDTO> list = dao.selectById(target_id);
		
		// blackList table 정지시작/종료일수 업데이트
		if(list == null || list.isEmpty()) {
			// members table mem_status 업데이트
			dao.updateMemberStatus(mem_status, target_id);
			dao.insertBlackList(target_id, black_option, banDays);
		}else{
			dao.updateBlackEndDate(banDays, target_id);
		}
		// 블랙리스트 등록 시 reports 테이블 status 업데이트
		dao.updateReportsStatus(reports_status, target_id, target_seq);
		return "success";
	}
	
	// 블랙리스트 해제
	@ResponseBody
	@RequestMapping("/blackOff")
	public String blackOff(int mem_status, int reports_status, String target_id) {
		
		dao.deleteMembersStatus(mem_status, target_id); // 블랙리스트 해제 (membersTable status 업데이트) 로직
		dao.deleteBlackList(target_id); // 블랙리스트 정지시작/종료일수 비우기 (blackList Table) 로직
		dao.updateReportStatus(reports_status, target_id); // 블랙리스트 처리된 건을 해제하는 로직 (해제 -> 해제완료 버튼 구현)
		
		return "success";
	}
	
	// 신고 반려
	@ResponseBody
	@RequestMapping("/reportReject")
	public String reportReject(int reports_seq) {
		
		dao.reportReject(reports_seq);
		
		return "success";
	}
	
	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "error";
	}
}