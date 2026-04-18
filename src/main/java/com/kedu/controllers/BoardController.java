package com.kedu.controllers;

import java.io.File;
import java.util.List;
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

import com.google.gson.Gson;
import com.kedu.dao.AttachmentDAO;
import com.kedu.dao.BoardDAO;
import com.kedu.dao.MembersDAO;
import com.kedu.dao.PostLikeDAO;
import com.kedu.dao.ReportDAO;
import com.kedu.dao.VisitLogDAO;
import com.kedu.dto.AttachmentDTO;
import com.kedu.dto.BoardDTO;
import com.kedu.dto.ReplyDTO;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private Gson gson;

	@Autowired
	private BoardDAO dao;
	@Autowired
	private VisitLogDAO vdao;
	@Autowired
	private PostLikeDAO likeDao;
	@Autowired
	private AttachmentDAO aDao;
	@Autowired
	private ReportDAO rdao;
	@Autowired
	private MembersDAO mdao;

	@RequestMapping("/write")
	public String write_lifeInfo(HttpSession session) {

		String loginId = (String) session.getAttribute("loginId");

		if (loginId == null) {
			return "redirect:/members/loginUi";
		}

		return "board/write";
	}

		// 모든 글쓰기
	   @RequestMapping("/insert")
	   public String insert(BoardDTO dto, MultipartFile[] files, HttpSession session) throws Exception {

	      int nextval = dao.getNextval();
	      dto.setPost_seq(nextval);
	      String post_category = dto.getPost_category();
	      String savePath = "c:/files";
	      File savePathFile = new File(savePath);

	      if (!savePathFile.exists()) {
	         savePathFile.mkdir();
	      }

	      for (MultipartFile file : files) {
	         if (!file.isEmpty()) {
	            String oriName = file.getOriginalFilename();
	            String sysName = UUID.randomUUID() + "_" + oriName;
	            file.transferTo(new File(savePath + "/" + sysName));
	            aDao.insert(new AttachmentDTO(0, post_category, nextval, oriName, sysName));
	         }
	      }

	      String mem_id = (String) session.getAttribute("loginId");
	      String mem_nickname = (String) session.getAttribute("nickname");
	      String mem_dong = (String) session.getAttribute("dong");
	      dao.insert(dto, mem_id, mem_nickname, mem_dong);
	      if ("lifeInfo".equals(post_category)) {
	         return "redirect:/board/lifeInfo";
	      } else if ("talk".equals(post_category)) {
	         return "redirect:/board/talk";
	      } else if ("food".equals(post_category)) {
	         return "redirect:/board/food";
	      } else if ("beauty".equals(post_category)) {
	         return "redirect:/board/beauty";
	      }

	      return "redirect:/";
	   }


	// 고민/이야기 게시판 리스트 출력
	@RequestMapping("/talk")
	public String concern(String sort, Model model, HttpSession session, Integer cPage) throws Exception {

		// 기본 정렬
		if (sort == null) {
			sort = "latest";
		}

		if (cPage == null || cPage < 1) {
			cPage = 1;
		}
		
		int recordTotalCount = dao.getConcernRecordTotalCount();
		int recordCountPerPage = 10;
		int naviCountPerPage = 10;
		
		int lastPage = (int) Math.ceil(recordTotalCount / (double) recordCountPerPage);
	    if (cPage > lastPage && lastPage > 0) {
	        cPage = lastPage;
	    }
		
		
		int start = (cPage - 1) * recordCountPerPage + 1; 
		int end = cPage * recordCountPerPage;
		
		model.addAttribute("recordTotalCount", recordTotalCount);
		model.addAttribute("recordCountPerPage", recordCountPerPage);
		model.addAttribute("naviCountPerPage", naviCountPerPage);
		session.setAttribute("currentPage", cPage);

		List<BoardDTO> list;

		// 출력을 어떤 종류를 기준으로 할 지 검사
		if ("like".equals(sort)) {
			list = dao.list_concern_like(start, end);
		} else {
			list = dao.list_concern_latest(start, end);
		}

		// 하트 수 확인 시 loginId를 기준으로 체크해야되서 아이디 값 가져옴.
		String loginId = (String) session.getAttribute("loginId");

		LikeStatus(list, loginId); // 하트 수 체크하는 메서드 실행 -> 여기서 set으로 상태(0, 1 ) 담아줌.

		model.addAttribute("list", list);
		model.addAttribute("sort", sort);

		return "board/concern";
	}

	// 생활정보 jsp에 생활정보 카테고리 list만 출력
	@RequestMapping("/lifeInfo")
	public String lifeInfo(String sort, Model model, HttpSession session, Integer cPage) throws Exception {

		// 기본 정렬
		if (sort == null) {
			sort = "latest";
		}
		
		if (cPage == null || cPage < 1) {
			cPage = 1;
		}
		
		int recordTotalCount = dao.getlifeInfoRecordTotalCount();
		int recordCountPerPage = 10;
		int naviCountPerPage = 10;
		
		int lastPage = (int) Math.ceil(recordTotalCount / (double) recordCountPerPage);
		    if (cPage > lastPage && lastPage > 0) {
		        cPage = lastPage;
		    }
		
	    int start = (cPage - 1) * recordCountPerPage + 1; 
		int end = cPage * recordCountPerPage;
		
		model.addAttribute("recordTotalCount", recordTotalCount);
		model.addAttribute("recordCountPerPage", recordCountPerPage);
		model.addAttribute("naviCountPerPage", naviCountPerPage);
		session.setAttribute("currentPage", cPage);
		
		
		
		List<BoardDTO> list;

		// 출력을 어떤 종류를 기준으로 할 지 검사
		if ("like".equals(sort)) {
			list = dao.list_lifeInfo_like(start, end);
		} else {
			list = dao.list_lifeInfo_latest(start, end);
		}

		// 하트 수 확인 시 loginId를 기준으로 체크해야되서 아이디 값 가져옴.
		String loginId = (String) session.getAttribute("loginId");
		
		LikeStatus(list, loginId); // 하트 수 체크하는 메서드 실행 -> 여기서 set으로 상태(0, 1 ) 담아줌.
		
		model.addAttribute("lifeInfo", list);
		model.addAttribute("sort", sort);

		return "board/life-info";
	}

	@RequestMapping("/food")
	public String food(String sort, Model model, HttpSession session, Integer cPage) throws Exception {

		// 기본 정렬
		if (sort == null) {
			sort = "latest";
		}
		
		if (cPage == null || cPage < 1) {
			cPage = 1;
		}
		
		int recordTotalCount = dao.getFoodRecordTotalCount();
		int recordCountPerPage = 10;
		int naviCountPerPage = 10;
		
		int lastPage = (int) Math.ceil(recordTotalCount / (double) recordCountPerPage);
	    if (cPage > lastPage && lastPage > 0) {
	        cPage = lastPage;
	    }
		
	    int start = (cPage - 1) * recordCountPerPage + 1; 
		int end = cPage * recordCountPerPage;
		
		model.addAttribute("recordTotalCount", recordTotalCount);
		model.addAttribute("recordCountPerPage", recordCountPerPage);
		model.addAttribute("naviCountPerPage", naviCountPerPage);
		session.setAttribute("currentPage", cPage);
		
		List<BoardDTO> list;

		// 출력을 어떤 종류를 기준으로 할 지 검사
		if ("like".equals(sort)) {
			list = dao.list_food_like(start, end);
		} else {
			list = dao.list_food_latest(start, end);
		}

		// 하트 수 확인 시 loginId를 기준으로 체크해야되서 아이디 값 가져옴.
		String loginId = (String) session.getAttribute("loginId");

		LikeStatus(list, loginId); // 하트 수 체크하는 메서드 실행 -> 여기서 set으로 상태(0, 1 ) 담아줌.

		model.addAttribute("list", list);
		model.addAttribute("sort", sort);

		return "board/food";
	}

	@RequestMapping("/beauty")
	public String beauty(String sort, Model model, HttpSession session, Integer cPage) throws Exception {

		// 기본 정렬
		if (sort == null) {
			sort = "latest";
		}
		
		if (cPage == null || cPage < 1) {
			cPage = 1;
		}
		
		int recordTotalCount = dao.getbeautyRecordTotalCount();
		int recordCountPerPage = 10;
		int naviCountPerPage = 10;
		
		int lastPage = (int) Math.ceil(recordTotalCount / (double) recordCountPerPage);
	    if (cPage > lastPage && lastPage > 0) {
	        cPage = lastPage;
	    }
		
		int start = (cPage - 1) * recordCountPerPage + 1; 
		int end = cPage * recordCountPerPage;
		
		model.addAttribute("recordTotalCount", recordTotalCount);
		model.addAttribute("recordCountPerPage", recordCountPerPage);
		model.addAttribute("naviCountPerPage", naviCountPerPage);
		session.setAttribute("currentPage", cPage);
		
		List<BoardDTO> list;

		// 출력을 어떤 종류를 기준으로 할 지 검사
		if ("like".equals(sort)) {
			list = dao.list_beauty_like(start, end); // dao에 beauty로 검색하는 것 추가
		} else {
			list = dao.list_beauty_latest(start, end);
		}

		// 하트 수 확인 시 loginId를 기준으로 체크해야되서 아이디 값 가져옴.
		String loginId = (String) session.getAttribute("loginId");

		LikeStatus(list, loginId); // 하트 수 체크하는 메서드 실행 -> 여기서 set으로 상태(0, 1 ) 담아줌.

		model.addAttribute("list", list);
		model.addAttribute("sort", sort);

		return "board/beauty";
	}

	// 게시물 상세보기
	@RequestMapping("/postDetail")
	public String postDetail(Model model, int post_seq, HttpSession session, String category, Integer cPage, String sort) throws Exception {
		
		
		BoardDTO dto = dao.selectByPost_seq(post_seq);
		String loginId = (String) session.getAttribute("loginId");
		
		// 파일리스트 뽑아오기
		List<AttachmentDTO> aList = aDao.getAttachment(post_seq);
		model.addAttribute("fileList", aList);
		
		if (loginId != null) {
			String allCategory = dao.getCategoryBySeq(post_seq);
			vdao.postClickVisit(loginId, allCategory);
		}

		if(cPage == null) {
			cPage = 1;
		}
		
		if(sort == null) {
			sort = "latest";
		}
		
		LikeStatus(dto, loginId); // 하트 수 체크하는 메서드 실행 -> 여기서 set으로 상태(0, 1 ) 담아줌.
		model.addAttribute("loginId", loginId);
		model.addAttribute("dto", dto);
		
		model.addAttribute("category", category);
		model.addAttribute("cPage", cPage);
		model.addAttribute("sort", sort);
		session.setAttribute("category", category);
		return "board/postDetail";
	}

	// 게시글 삭제
	@ResponseBody
	@RequestMapping("/deletePost")
	public String deletePost(int post_seq) {
		
		int count = rdao.reportDeleteBlock(post_seq); // 신고된 게시글 삭제 불가 로직
		if(count > 0) {
			return "fail";
		}
		
		likeDao.deleteLikeByPostSeq(post_seq); // 게시글 삭제 시 관심게시글 카운트 차감
		dao.deletePost(post_seq); 
		
		
		return "success";
	}

	// 게시글 수정
	@ResponseBody
	@RequestMapping("/updatePost")
	public String updatePost(BoardDTO dto,
			@RequestParam(value="deleteFiles", required=false)List<String> deleteFiles,
			MultipartFile[] attachments) throws Exception{
		
		// 신고된 게시글 수정 불가 로직
		int count = rdao.reportUpdateBlock(dto.getPost_seq());
		if(count > 0) {
			return "fail";
		}
		
		//글수정
		dao.updatePost(dto.getPost_seq(), dto.getPost_title(), dto.getPost_contents());
		
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
	            String oriName = file.getOriginalFilename();
				String sysName = UUID.randomUUID() + "_" + oriName;
				file.transferTo(new File(savePath + "/" + sysName));
				aDao.insert(new AttachmentDTO(0, dto.getPost_category(), dto.getPost_seq(), oriName, sysName));
	        }
	    }
		return "success";
	}

	// ajax 댓글 리스트 출력
	@ResponseBody
	@RequestMapping("/replyList")
	public String replyList(int post_seq, Model model) {
		
		// 관리자 댓글에 신고 버튼 안 뜨게 하는 로직 ( 관리자 여부 확인 )
		List<ReplyDTO> list = mdao.memRole(post_seq);
		
		return gson.toJson(list);
	}

	// board에 list를 출력 시,로그인 한 아이디를 기준으로 하트를 눌러놨는지 체크하는 메서드
	private void LikeStatus(List<BoardDTO> list, String loginId) throws Exception{

		if (loginId != null && list != null) { // 로그인 아이디랑 리스트가 null이 아니면
			for (BoardDTO dto : list) { // for문 돌면서 list에서
				int check = likeDao.likeCheck(dto.getPost_seq(), loginId); // 로그인 아이디를 기준으로 하트를 눌렀는지 체크하고,
				dto.setPost_like_check(check); // check의 값이 1 또는 0으로 나온 값을 dto에 set으로 기록.
			}
		}

	};

	// postDetail 페이지,로그인 한 아이디를 기준으로 하트를 눌러놨는지 체크하는 메서드
	private void LikeStatus(BoardDTO dto, String loginId) throws Exception{

		if (loginId != null && dto != null) { // 로그인 아이디랑 리스트가 null이 아니면
			int check = likeDao.likeCheck(dto.getPost_seq(), loginId); // 로그인 아이디를 기준으로 하트를 눌렀는지 체크하고,
			dto.setPost_like_check(check); // check의 값이 1 또는 0으로 나온 값을 dto에 set으로 기록.
		}

	};

	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "error";
	}
}