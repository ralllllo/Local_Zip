
package com.kedu.controllers;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kedu.dao.AttachmentDAO;
import com.kedu.dao.FeedBackDAO;
import com.kedu.dao.FeedBack_reactionDAO;
import com.kedu.dao.ReportDAO;
import com.kedu.dto.AttachmentDTO;
import com.kedu.dto.FeedBackDTO;
import com.kedu.dto.FeedBack_reactionDTO;
import com.kedu.dto.ReportDTO;

@Controller
@RequestMapping("/feedback")
public class FeedBackController {

	@Autowired
	private FeedBackDAO dao;

	@Autowired
	private ReportDAO reportdao;

	@Autowired
	private FeedBack_reactionDAO reactiondao;

	@Autowired
	private FeedBackDAO feedbackdao;

	@Autowired
	private AttachmentDAO aDao;

	// 건의사항 작성글 출력
	@RequestMapping("/feedbackHome")
	public String feedbackHome(Model model, HttpSession session, Integer cPage) throws Exception {

		// 홈에서 비회원일 경우, 로그인 페이지로 보냄
		String loginId = (String) session.getAttribute("loginId");

		if (loginId == null) {
			return "redirect:/members/loginUi";
		}

		if (cPage == null) {
			cPage = 1;
		}

		List<FeedBackDTO> list = feedbackdao.list(loginId, cPage * 10 - 9, cPage * 10);
		// 좋아요, 싫어요 수 for문 돌려서 dto에 저장
		for(FeedBackDTO dto : list){
		    dto.setSuggestion_like(reactiondao.like(dto.getSuggestion_seq()));
		    dto.setSuggestion_unlike(reactiondao.unlike(dto.getSuggestion_seq()));
		}
		
		Map<Integer, List<AttachmentDTO>> imageMap = new HashMap<>();
		for(FeedBackDTO dto:list) {
			List<AttachmentDTO> files = aDao.getAttachmentSuggestion(dto.getSuggestion_seq());
			if (files != null && files.size() > 0) { // 데이터가 있을 때만 Map에 추가
		        imageMap.put(dto.getSuggestion_seq(), files);
		    }
		}
		
		model.addAttribute("imageMap",imageMap);
		model.addAttribute("list", list);
		int recordTotalCount = dao.getRecordTotalCount();

		model.addAttribute("recordTotalCount", recordTotalCount);

		model.addAttribute("naviCountPerPage", 10);
		model.addAttribute("recordCountPerPage", 10);
		model.addAttribute("currentPage", cPage);
		session.setAttribute("cPage", cPage);
		
		List<FeedBack_reactionDTO> myReaction = reactiondao.selectMyReaction(loginId); // 내 반응 목록 list
		
		
		model.addAttribute("myReaction", myReaction);

		return "feedback/feedbackHome";
	}

	@RequestMapping("/feedbackWrite")
	public String feedbackWrite() throws Exception{
		return "feedback/feedbackWrite";
	}

	// 건의사항 작성 db 입력
	@RequestMapping("/feedbackInsert")
	public String feedbackWrite(FeedBackDTO dto, HttpSession session, MultipartFile[] files) throws Exception {

		// 유효성 검사
		if (dto.getSuggestion_title().trim().equals("")) {
			return "redirect:/feedback/feedbackWrite";	
		}
			
		int nextval = dao.getNextval();
		dto.setSuggestion_seq(nextval);

		String savePath = "c:/files";
		File savePathFile = new File(savePath);
		if (!savePathFile.exists()) {
			savePathFile.mkdir();
		}
		if (files != null) {
			for (MultipartFile file : files) {
				if (file.isEmpty())
					continue;

				String contentType = file.getContentType();
				String fileName = file.getOriginalFilename().toLowerCase();

				boolean isImage = (contentType != null && contentType.startsWith("image/"))
						|| (fileName.endsWith(".jpg") || fileName.endsWith(".png") || fileName.endsWith(".gif")
								|| fileName.endsWith(".webp"));
				if (isImage) {
					String oriName = file.getOriginalFilename();
					String sysName = UUID.randomUUID() + "_" + oriName;
					file.transferTo(new File(savePath + "/" + sysName));
					aDao.insert(new AttachmentDTO(0, "feedback", nextval, oriName, sysName));
				}
			}
		}

		String nickname = (String) session.getAttribute("nickname");
		String dong = (String) session.getAttribute("dong");
		String loginId = (String) session.getAttribute("loginId");

		dto.setMem_nickname(nickname);
		dto.setMem_dong(dong);
		dto.setMem_id(loginId);

		dao.insert(dto);

		return "redirect:/feedback/feedbackHome";
	}
	
	// 현재 반응 확인 메서드
	@ResponseBody
	@RequestMapping("/selectReaction")
	public String selectReaction(Integer suggestion_seq, HttpSession session) throws Exception {

	    String loginId = (String) session.getAttribute("loginId");

	    if(loginId == null) {
	        return "login";
	    }

	    String reaction = reactiondao.selectReaction(loginId, suggestion_seq);

	    if(reaction == null) {
	        return "none";
	    }
	    return reaction;
	}
	
	// 좋아요 처리 메서드
	@ResponseBody
	@RequestMapping("/like")
	public String like(Integer suggestion_seq, HttpSession session) throws Exception {

	    String loginId = (String) session.getAttribute("loginId");

	    if(loginId == null) {
	        return "loginUi";
	    }

	    String reaction = reactiondao.selectReaction(loginId, suggestion_seq);

	    if(reaction == null) {
	        reactiondao.insert(loginId, suggestion_seq, "LIKE");
	        return "insertLike";
	    } 
	    else if(reaction.equals("UNLIKE")) {
	        reactiondao.update(loginId, suggestion_seq, "LIKE");
	        return "updateLike";
	    } 
	    else if(reaction.equals("LIKE")) {
	        return "alreadyLike";
	    }
	    return "fail";
		}
	
	// 좋아요 수 조회 메서드
	@ResponseBody
	@RequestMapping("/likeCount")
	public int likeCount(Integer suggestion_seq) throws Exception {
	    return reactiondao.like(suggestion_seq);
	}
	
	// 싫어요 수 조회 메서드
	@ResponseBody
	@RequestMapping("/unlikeCount")
	public int unlikeCount(Integer suggestion_seq) throws Exception {
	    return reactiondao.unlike(suggestion_seq);
	}
	
	// 싫어요 처리 메서드
	@ResponseBody
	@RequestMapping("/unlike")
	public String unlike(Integer suggestion_seq, HttpSession session) throws Exception {

	    String loginId = (String) session.getAttribute("loginId");

	    if(loginId == null) {
	        return "login";
	    }

	    String reaction = reactiondao.selectReaction(loginId, suggestion_seq);

	    if(reaction == null) {
	        reactiondao.insert(loginId, suggestion_seq, "UNLIKE");
	        return "insertUnlike";
	    } 
	    else if(reaction.equals("LIKE")) {
	        reactiondao.update(loginId, suggestion_seq, "UNLIKE");
	        return "updateUnlike";
	    } 
	    else if(reaction.equals("UNLIKE")) {
	        return "alreadyUnlike";
	    }

	    return "fail";
	}

	// 신고
	@ResponseBody
	@RequestMapping("/report/insert")
	public String report(ReportDTO dto, HttpSession session) {

		String loginId = (String) session.getAttribute("loginId");

		dto.setMem_id(loginId);
		reportdao.reportInsert(dto);

		return "success";
	}

	// 게시글 삭제
	@ResponseBody
	@RequestMapping("/delete")
	public String delete(int suggestion_seq, HttpSession session) {

		String loginId = (String) session.getAttribute("loginId");
		
		FeedBackDTO dto = dao.selectBySeq(suggestion_seq);
		// 신고된 게시글 삭제 불가 로직
		int count = reportdao.reportDeleteBlock(suggestion_seq);
		if(count > 0) {
			return "adminFail";
		}
		
		if (dto != null && loginId.equals(dto.getMem_id())) {

			dao.delete(suggestion_seq);
			return "successDel";
		} else {
			return "fail";
		}
	}

	// 게시글 수정
	@ResponseBody
	@RequestMapping("/update")
	public String update(FeedBackDTO dto, HttpSession session,
			@RequestParam(value="deleteFiles", required=false)List<String> deleteFiles,
			MultipartFile[] attachments)throws Exception {

		String loginId = (String) session.getAttribute("loginId");
		
		// 신고된 게시글 수정 불가 로직
		int count = reportdao.reportUpdateBlock(dto.getSuggestion_seq());
		if(count > 0) {
			return "adminFail";
		}
		
		FeedBackDTO updateDto = dao.selectBySeq(dto.getSuggestion_seq());
		if (!loginId.equals(updateDto.getMem_id())) {
			return "fail";
		}

		dao.udpate(dto);

		String savePath = "c:/files";
        File savePathFile = new File(savePath);
        if (!savePathFile.exists()) {
            savePathFile.mkdir();
        }
		//파일 삭제
		if (deleteFiles != null && !deleteFiles.isEmpty()) {
	        for (String sysName : deleteFiles) {
	            aDao.deleteBySysName(sysName);
	            File target = new File(savePath + "/" + sysName);
	            if(target.exists()) {
	            	target.delete();
	            }
	        }
	    }
		//새 파일 업로드
		if (attachments != null) {
	        for (MultipartFile file : attachments) {
	            if (file.isEmpty()) {
	            	continue;
	            }
	            String contentType = file.getContentType();
				String fileName = file.getOriginalFilename().toLowerCase();

				boolean isImage = (contentType != null && contentType.startsWith("image/"))
						|| (fileName.endsWith(".jpg") || fileName.endsWith(".png") || fileName.endsWith(".gif")
								|| fileName.endsWith(".webp"));
				if (isImage) {
					String oriName = file.getOriginalFilename();
					String sysName = UUID.randomUUID() + "_" + oriName;
					file.transferTo(new File(savePath + "/" + sysName));
					aDao.insert(new AttachmentDTO(0, "feedback", dto.getSuggestion_seq(), oriName, sysName));
				}
	        }
	    }
		
		return "success";
	}
	
	@ExceptionHandler(Exception.class)
	   public String exceptionHandler(Exception e) {
	      e.printStackTrace();
	      return "error";
	   }
}