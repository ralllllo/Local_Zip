package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dao.MeetingMemberDAO;
import com.kedu.dto.ManageMeetingDTO;
import com.kedu.dto.MeetingMemberDTO;

@Controller
@RequestMapping("/meetingMember")
public class MeetingMemberController {

	@Autowired
	private MeetingMemberDAO dao;
	
	@RequestMapping("/applyForm")
	public String applyform(int meet_seq, Model model, HttpSession session) throws Exception{
		session.setAttribute("meet_seq", meet_seq);
		model.addAttribute("meet_seq", meet_seq);
		return "meeting/applyForm";
	}
	
	// 한 줄 소개 db에 넣기
	@RequestMapping("/insert")
	public String insert(MeetingMemberDTO dto, HttpSession session) throws Exception {
		session.setAttribute("nickName", dto.getMem_nickname());
		
		String loginId = (String)session.getAttribute("loginId");
		Integer meet_seq = (Integer)session.getAttribute("meet_seq");
		
		dto.setMem_id(loginId);
		dao.insert(dto);
		
		return "meeting/applySuccess";
	}

	// 승인 대기 중인 리스트 출력
	@ResponseBody
	@RequestMapping("/applyList")
	public List<ManageMeetingDTO> applyList(HttpSession session) {

	    String loginId = (String)session.getAttribute("loginId");

	    return dao.selectApplyList(loginId);
	}
	
	// 요청 승인, 거절 처리
	@ResponseBody
	@RequestMapping("/updateStatus")
	public int updateStatus(int seq, int meet_seq, int status) {
		
		int result = dao.updateStatus(seq, status);
	    return result;
	}
	
	// 모임 탈퇴 클릭 시
	@ResponseBody
	@RequestMapping("/outMeeting")
	public int outMeeting(HttpSession session, int seq) throws Exception{
		
		String loginId = (String)session.getAttribute("loginId");
		// 모임 탈퇴
		int count = dao.outMeeting(loginId, seq);
		
		return count;
	}
	
	// 처리 완료된 리스트 출력
	@ResponseBody
	@RequestMapping("/completeList")
	public List<ManageMeetingDTO> completeList(HttpSession session) {
	    String loginId = (String)session.getAttribute("loginId");
	    return dao.selectCompleteList(loginId);
	}
	
	@ExceptionHandler(Exception.class)
	   public String exceptionHandler(Exception e) {
	      e.printStackTrace();
	      return "error";
	   }
}