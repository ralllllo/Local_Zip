package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.FeedBack_reactionDTO;

@Repository
public class FeedBack_reactionDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	// 현재 사용자가 이 글에 어떤 반응을 했는지 조회
	public String selectReaction(String mem_id, int suggestion_seq) throws Exception {
		
		String sql = "select reaction_type from suggestion_reaction where mem_id = ? and suggestion_seq = ?";
		
		try {
			return jdbc.queryForObject(sql, String.class, mem_id, suggestion_seq);
		} catch (Exception e) {
			return null;
		}
	}
	
	   // 좋아요 갯수
	   public int like(int suggestion_seq) throws Exception {
	      
	      String sql = "select count(*) from suggestion_reaction where suggestion_seq = ? and reaction_type = 'LIKE'";
	      
	      return jdbc.queryForObject(sql, Integer.class, suggestion_seq);
	   }
	   
	   
	   // 싫어요 갯수
	   public int unlike(int suggestion_seq) throws Exception {
	      
	      String sql = "select count(*) from suggestion_reaction where suggestion_seq = ? and reaction_type = 'UNLIKE'";
	      
	      return jdbc.queryForObject(sql, Integer.class, suggestion_seq);
	   }
	   
	
	// 처음 반응 insert
	public int insert(String mem_id, int suggestion_seq, String reaction_type) throws Exception {
		
		String sql = "insert into suggestion_reaction values(suggestion_reaction_seq.nextval, ?, ?, ?, sysdate)";
		
		return jdbc.update(sql, mem_id, suggestion_seq, reaction_type);
	}
	
	// 반응 수정 update
	public int update(String mem_id, int suggestion_seq, String reaction_type) throws Exception {
		
		String sql = "update suggestion_reaction set reaction_type = ? where mem_id = ? and suggestion_seq = ?";
		
		return jdbc.update(sql, reaction_type, mem_id, suggestion_seq);
	}
	
	// 반응 삭제 delete
	public int delete(String mem_id, int suggestion_seq) throws Exception {
		
		String sql = "delete from suggestion_reaction where mem_id = ? and suggestion_seq = ?";
		
		return jdbc.update(sql, mem_id, suggestion_seq);
	}
	
	// 내가 눌렀던 반응 목록
	public List<FeedBack_reactionDTO> selectMyReaction(String mem_id) {
		
		String sql = "select * from suggestion_reaction where mem_id = ?";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<FeedBack_reactionDTO>(FeedBack_reactionDTO.class), mem_id);
	}
}