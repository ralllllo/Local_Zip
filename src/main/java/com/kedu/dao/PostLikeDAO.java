package com.kedu.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class PostLikeDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	// 좋아요 여부 확인용 메서드
	// return 값이 1이면 count상승 취소 / 0이면 삽입 실행
	public int likeCheck(int post_seq, String mem_id) {
		String sql = "select count(*) from post_like where post_seq = ? and mem_id = ?";
		return jdbc.queryForObject(sql, Integer.class, post_seq, mem_id);
	};
	
	// 좋아요를 누른적이 없을때, postLike에 insert해줄 메서드
	public int likeInsert(int post_seq, String mem_id) {
		String sql = "insert into post_like values(post_like_seq.nextval,?,?,sysdate)";
		return jdbc.update(sql, post_seq, mem_id);
	};
	
	// 좋아요 누른거 취소하면, postLike에서 delete 진행
	public int likeDelete(int post_seq, String mem_id) {
		String sql = "delete from post_like where post_seq = ? and mem_id = ?";
		return jdbc.update(sql, post_seq, mem_id);
	}
	
	// 게시글 삭제 시 좋아요 카운트 차감 진행
	public int deleteLikeByPostSeq(int post_seq) {
		String sql = "delete from post_like where post_seq = ? ";
		return jdbc.update(sql, post_seq);
	}
	
	// 게시글에 대한 전체 좋아요 수 출력 메서드
	public int likeCount(int post_seq) {
		String sql = "select count(*) from post_like where post_seq = ?";
		return jdbc.queryForObject(sql, Integer.class, post_seq);
	};
}