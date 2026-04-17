package com.kedu.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dao.BoardDAO;
import com.kedu.dao.PostLikeDAO;

@Controller
@RequestMapping("/like")
public class PostLikeController {

	@Autowired
	private BoardDAO dao;

	@Autowired
	private PostLikeDAO LikeDao;

	@ResponseBody // 좋아요 토글 반영(하트 채우고, 비우고)
	@RequestMapping("/toggle")
	public int likeToggle(int post_seq, HttpSession session) {

		String loginId = (String)session.getAttribute("loginId");
		
		if(loginId == null) { // 비로그인시 하트 누르면 로그인 화면으로 돌려보낼거임.
			return -1;
		}
		try {
			// 이미 좋아요를 눌렀는지 DB에서 확인 (count(*)쿼리)
			int isLike = LikeDao.likeCheck(post_seq, loginId);
			int resultFlag = 0;
		
			if(isLike == 0) { // 좋아요를 누른 적이 없으면, 
				LikeDao.likeInsert(post_seq, loginId);
				resultFlag = 1; // 방금 post_seq에 좋아요를 했다는 뜻.
			}else {
				LikeDao.likeDelete(post_seq, loginId);
				resultFlag = 0; // 방금 post_seq를 삭제했다는 뜻.
			}
			
			int count = LikeDao.likeCount(post_seq); // 현재 총 누른 하트 수
			dao.updateLikeCount(count, post_seq); // 현재 카운트 된 하트를 boardDB로 값 전달
			
			return resultFlag;
			
		}catch(Exception e) {
			e.printStackTrace();
			return -2; //서버 에러
		}
	}

	@ResponseBody // 좋아요 숫자 +-1 반영
	@RequestMapping("/count")
	public int likeCount(int post_seq) {
		
		int count = LikeDao.likeCount(post_seq);
		
		return count;
	}
}