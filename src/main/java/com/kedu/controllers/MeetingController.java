package com.kedu.controllers;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dao.MeetingDAO;
import com.kedu.dao.MeetingMemberDAO;
import com.kedu.dao.ReportDAO;
import com.kedu.dto.MeetingDTO;
import com.kedu.dto.MeetingMemberDTO;

@Controller
@RequestMapping("/meeting")
public class MeetingController {
	
	@Autowired
	private MeetingDAO dao;
	
	@Autowired
	private MeetingMemberDAO mdao;
	
	@Autowired
	private ReportDAO rdao;
	
	// 모임 신청 폼 출력
	@RequestMapping("/list")
	public String list(Model model, HttpSession session, String category, Integer cpage) throws Exception {
		String loginId = (String)session.getAttribute("loginId"); 
		
		if(loginId == null) { // 로그인을 안한 상태면 로그인 화면으로 보내기
			return "redirect:/members/loginUi";
		}
		
		if(cpage == null) {
	        cpage = 1;
	    }

	    int start = (cpage - 1) * 8 + 1;
	    int end = cpage * 8;
	    
	    List<MeetingDTO> list;
		if(category.equals("all")) {
			list = dao.selectAllByPage(start, end);  // + 게이지바 포함 전체 리스트 출력
		}else {
			list = dao.selectByPage(category, start, end);  // + 게이지바 포함 카테고리별 리스트 출력
		}
		
		List<MeetingMemberDTO> vlist = dao.isApplied(loginId); // 0, 승인 대기 상태 ( 승인대기중 버튼 출력 )
		Set<Integer> appliedSet = new HashSet<>();

		for(MeetingMemberDTO dto : vlist){
			appliedSet.add(dto.getMeet_seq());
		}
		
		List<MeetingMemberDTO> jlist = dao.joinMeet(loginId); // 1, 승인 상태 ( 내 모임으로 이동 버튼 출력 )
		Set<Integer> joinedSet = new HashSet<>();

		for(MeetingMemberDTO dto : jlist){
			joinedSet.add(dto.getMeet_seq());
		}
		
		List<MeetingMemberDTO> clist = dao.companionMeet(loginId); // 2, 거절 상태 ( 참여 신청 버튼 출력 )
		Set<Integer> companionSet = new HashSet<>();

		for(MeetingMemberDTO dto : clist){
			companionSet.add(dto.getMeet_seq());
		}
		
		Map<String, Object> navi = this.getPageNaviAll(category, cpage); // cpage
		
		
		session.setAttribute("admin", mdao.adminCheck(loginId));
		int admin = (Integer)session.getAttribute("admin");
		model.addAttribute("admin", admin);
		
		
	    model.addAttribute("navi", navi);
		model.addAttribute("list", list);
		session.setAttribute("category", category);
		model.addAttribute("category", category);
		model.addAttribute("appliedSet", appliedSet);
		model.addAttribute("joinedSet", joinedSet);
		model.addAttribute("companionSet", companionSet);
		
		session.setAttribute("cPage", cpage);
		model.addAttribute("cPage", cpage);
		return "meeting/meeting";
	}
	
	@RequestMapping("/meetingDetail") // meeting 디테일 jsp로 이동
	public String meetingCreateForm(@RequestParam int seq, String mem_id, Model model, HttpSession session) throws Exception{
		List<MeetingDTO> list = dao.selectBySeq(seq); // currentpeople = meetingMember 참여인원수 포함해서 리스트 출력
		model.addAttribute("meet_seq", seq);
		
		String loginId = (String)session.getAttribute("loginId");
		model.addAttribute("list", list);
			
		mdao.selectByStatus(seq, loginId);
		session.setAttribute("count", mdao.selectByStatus(seq, loginId));  // 내가 신청한 모임
		session.setAttribute("admin", mdao.adminCheck(loginId)); // 관리자 여부 확인
		session.setAttribute("host", mdao.hostCheck(seq, loginId)); // 주최자인지 확인
		
		
		List<MeetingMemberDTO> vlist = dao.isApplied(loginId); // 0, 승인 대기 상태 ( 승인대기중 버튼 출력 )
		Set<Integer> appliedSet = new HashSet<>();

		for(MeetingMemberDTO dto : vlist){
			appliedSet.add(dto.getMeet_seq());
		}
		
		List<MeetingMemberDTO> jlist = dao.joinMeet(loginId); // 1, 승인 상태 ( 내 모임으로 이동 버튼 출력 )
		Set<Integer> joinedSet = new HashSet<>();

		for(MeetingMemberDTO dto : jlist){
			joinedSet.add(dto.getMeet_seq());
		}
		
		String category = (String)session.getAttribute("category");
		model.addAttribute("category", category);
		model.addAttribute("appliedSet", appliedSet);
		model.addAttribute("joinedSet", joinedSet);
		
		return "meeting/meetingDetail";
	}
	
	// 모임 생성 폼 작성
	@RequestMapping("/meetCreate")
	public String meetCreateFrom() throws Exception{
		return "meeting/meetCreate";
	}
	
	// 모임 신청 폼 db에 넣기
	@RequestMapping("/meetGenerate")
	public String meetCreateFrom(MeetingDTO dto, HttpSession session) throws Exception {
		
		String loginId = (String)session.getAttribute("loginId");
		String nickname = (String)session.getAttribute("nickname");
		// 한 id당 모임 3개 이상 생성 금지
		int count = dao.countMeetingByWriter(loginId);
		
		if(count >= 3) {
			session.setAttribute("msg", "over");
			return "redirect:/meeting/list?category=all";
		}
		dto.setMem_id(loginId);
		dto.setMem_nickname(nickname);
		dao.insert(dto);
		
		return "redirect:/meeting/list?category=all";
	}
	
	// 페이지네비게이터
	public Map<String, Object> getPageNaviAll(String category, int cpage) throws Exception{

		int recordCountPerPage = 8;
	    int naviCountPerPage = 10;

	    int recordTotalCount;
	    
	    if(category == null || category.equals("all")) {
	        recordTotalCount = dao.getAllCount(); // 
	    } else {
	    	recordTotalCount = dao.getCategoryCount(category); // 승인대기, 참여중 카테고리 카운트 체크
	    }
	    
	    int pageTotalCount =
	        (recordTotalCount + recordCountPerPage - 1) / recordCountPerPage;

	    if(recordTotalCount == 0){ // 0이면 네비 생성X
	        return new HashMap<>();
	    }

	    if(cpage < 1) cpage = 1;
	    if(cpage > pageTotalCount) cpage = pageTotalCount;

	    int startNavi =
	        ((cpage - 1) / naviCountPerPage) * naviCountPerPage + 1;

	    int endNavi = startNavi + naviCountPerPage - 1;

	    if(endNavi > pageTotalCount) endNavi = pageTotalCount;

	    boolean needPrev = startNavi != 1;
	    boolean needNext = endNavi != pageTotalCount;

	    Map<String, Object> map = new HashMap<>();

	    map.put("cpage", cpage);
	    map.put("startNavi", startNavi);
	    map.put("endNavi", endNavi);
	    map.put("needPrev", needPrev);
	    map.put("needNext", needNext);

	    return map;
	}
	
	// 마이페이지 모임 탭 (신청 관리)
	@RequestMapping("/manageMeeting")
	public String manageMeeting() throws Exception{
		return "myPage/manageMeeting";
	}
	
	// 마이페이지 모임 탭 (참여중인 모임)
	@RequestMapping("/myMeeting")
	public String myMeeting() throws Exception{
	    return "myPage/myMeeting";
	}
	
	// 참여중인 모임 리스트 출력
	@ResponseBody
	@RequestMapping("/myMeetingList")
	public List<MeetingDTO> myMeetingList(HttpSession session, Model model) {

	    String loginId = (String)session.getAttribute("loginId");

	    return dao.selectMyAllMeeting(loginId);
	}
	
	// 참여중인 모임 탭 > 자세히 보기 클릭 시
	@RequestMapping("/myMeetingDetail")
	public String myMeetingDetail(HttpSession session, int seq, Model model) throws Exception{
		
		List<MeetingDTO> list = dao.selectBySeq(seq);
		
		model.addAttribute("list", list);
		
		return "myPage/myMeetingDetail";
	}
	
	// 참여중인 모임 탭 > 자세히 보기 > 수정 완료 버튼 클릭 시
	@RequestMapping("/update")
	public String update(int seq, String meet_detailcontents, String meet_kakaolink, String meet_kakaopw) throws Exception{
		dao.updateMeeting(seq, meet_detailcontents, meet_kakaolink, meet_kakaopw);
		return "redirect:/meeting/myMeetingDetail?seq=" + seq;
	}
	
	@ResponseBody
	@RequestMapping("/updateReportCheck")
	public String updateReportCheck(int target_seq) {
		// 신고된 모임 수정 불가 로직
		int count = rdao.reportUpdateBlock(target_seq);
		if(count > 0) {
			return "fail";
		}
		
		return "success";
	}
	
	// 참여중인 모임 탭 > 모임 삭제 버튼 클릭 시
	@ResponseBody
	@RequestMapping("/deleteMeeting")
	public int deleteMeeting(int seq) {
		
		// 신고된 모임 삭제 불가 로직
		int count = rdao.reportDeleteBlock(seq);
		
		if(count > 0) {
			return -1;
		}
		return dao.deleteMeeting(seq);
	}
	
	@ExceptionHandler(Exception.class)
	   public String exceptionHandler(Exception e) {
	      e.printStackTrace();
	      return "error";
	   }
}