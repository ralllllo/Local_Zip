package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dao.AttachmentDAO;
import com.kedu.dao.BoardDAO;
import com.kedu.dao.PostLikeDAO;
import com.kedu.dao.ReplyDAO;
import com.kedu.dao.VisitLogDAO;
import com.kedu.dto.AttachmentDTO;
import com.kedu.dto.BoardDTO;
import com.kedu.dto.ReplyDTO;

@Controller
public class HomeController {

	@Autowired
	private BoardDAO dao;
	@Autowired
	private ReplyDAO ReplyDao;
	@Autowired
	private VisitLogDAO vdao;
	@Autowired
	private PostLikeDAO likeDao;
	@Autowired
	private AttachmentDAO aDao;
	
	// 전체 리스트 출력 내용 반영
	@RequestMapping("/")
	public String home(String sort, Model model, HttpSession session, ReplyDTO rdto, BoardDTO post) throws Exception{

		String loginId = (String)session.getAttribute("loginId"); // 하트 수 체크시 필요
		
		// 기본 정렬
		if(sort == null) {
			sort = "latest";
		}
		List<BoardDTO> list;

		// 출력을 어떤 종류를 기준으로 할 지 검사
		// dao에 카테고리 별로 최신순, 인기순 정렬하는 다오 생성하면서, dao 이름 반영
		if ("like".equals(sort)) {
			list = dao.list_home_like(loginId); // join문 전용
		}else {
			list = dao.list_home_latest(loginId);
		}

        // *(좋아요)
        // 하트 수 확인 시 loginId를 기준으로 체크해야되서 아이디 값 가져옴.
        LikeStatus(list, loginId); // 하트 수 체크하는 메서드 실행 -> 여기서 set으로 상태(0, 1 ) 담아줌.
		
		model.addAttribute("list", list);
		model.addAttribute("sort",sort);
		
		return "home";
	}
	
	// ajax용 댓글 수 count
	@ResponseBody // ★중요: JSP 페이지가 아니라 "데이터(숫자)"만 보낸다는 뜻
	@RequestMapping("/board/getCommentCount")
	public int getCommentCount(int post_seq) {
		// DB에서 이 게시글의 진짜 댓글 개수를 가져오기
		int count = ReplyDao.commentCount(post_seq);

		// 혹시 모르니 DB의 post_hit 컬럼도 최신화해줍니다. (선택사항)
		dao.setCommentCount(count, post_seq);

		return count; // count된 숫자만, 댓글 수 전달
	}
	
	// board에 list를 출력 시,로그인 한 아이디를 기준으로 하트를 눌러놨는지 체크하는 메서드
	private void LikeStatus(List<BoardDTO> list, String loginId) throws Exception{
			
		if(loginId != null && list != null) { // 로그인 아이디랑 리스트가 null이 아니면 
			for(BoardDTO dto : list) { // for문 돌면서 list에서 
				int check = likeDao.likeCheck(dto.getPost_seq(), loginId); // 로그인 아이디를 기준으로 하트를 눌렀는지 체크하고,
				dto.setPost_like_check(check); // check의 값이 1 또는 0으로 나온 값을 dto에 set으로 기록.
			}
		}
			
	};

	// 게시물 상세보기
	@RequestMapping("/postDetail")
	public String postDetail(Model model, int post_seq, HttpSession session, String category, String sort) throws Exception{
		
		// 기본 정렬
		if (sort == null) {
			sort = "latest";
		}

		BoardDTO dto = dao.selectByPost_seq(post_seq);

		String loginId = (String)session.getAttribute("loginId");
		
		// 파일리스트 뽑아오기
		List<AttachmentDTO> aList = aDao.getAttachment(post_seq);
		model.addAttribute("fileList", aList);
		
		if(loginId != null) {
			String getCategory = dao.getCategoryBySeq(post_seq);
			vdao.postClickVisit(loginId, getCategory);
		}
		
		if(category == null || category.equals("")) {
			category = dao.getCategoryBySeq(post_seq); // String을 빼고 값만 할당
		}
		
		LikeStatus(dto, loginId); // 하트 수 체크하는 메서드 실행 -> 여기서 set으로 상태(0, 1) 담아줌.
		model.addAttribute("category",category); //  카테고리를 저장해서 사용하는 코드
	    model.addAttribute("dto",dto);
	    
	    model.addAttribute("sort", sort);               // 추가

	    
		return "board/postDetail";
	}
	
	
	@RequestMapping("/searchByTitle")
	public String searchByTitle(String title, String sort, Model model, HttpSession session) throws Exception {
		
	    String loginId = (String)session.getAttribute("loginId");
		
		// 기본 정렬
		if(sort == null) {
			sort = "latest";
		}
	    
	    // 1. DAO 호출 (제목과 정렬 기준을 같이 보냄)
	    List<BoardDTO> searchList = dao.searchByTitle(loginId,title, sort);
	    
	    // 2. 좋아요 상태 및 댓글 수 체크 (기존 로직 유지)
	    LikeStatus(searchList, loginId);
	    
	    // 3. JSP로 데이터 전달
	    model.addAttribute("list", searchList);
	    model.addAttribute("searchKeyword", title); // 검색어 유지용
	    model.addAttribute("sort", sort);           // 정렬 버튼 텍스트 변경용
	    
	    return "home"; 
	}
	
	// postDetail 페이지,로그인 한 아이디를 기준으로 하트를 눌러놨는지 체크하는 메서드
	private void LikeStatus(BoardDTO dto, String loginId) throws Exception{
			
		if(loginId != null && dto != null) { // 로그인 아이디랑 리스트가 null이 아니면 
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