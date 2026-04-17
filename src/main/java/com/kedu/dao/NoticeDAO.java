package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.NoticeDTO;

@Repository
public class NoticeDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	//-------------------사용자 영역----------------------------------------
	
	//공지사항 리스트 뽑아오기
	public List<NoticeDTO> getNoticePost(int start, int end){
		String sql = "SELECT * FROM (SELECT NOTICE.*, ROW_NUMBER() OVER (ORDER BY NOTICE_date DESC) a FROM NOTICE) WHERE a BETWEEN ? AND ?";
		return jdbc.query(sql, new BeanPropertyRowMapper<NoticeDTO>(NoticeDTO.class),start,end);
	}
	
	public int getTotalNotice() {
		String sql = "select count(*) from notice";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	//----------------관리자 영역-----------------------
	
	//DB에 공지사항 글 작성
	public void insertNotice(NoticeDTO dto) {
		String sql = "INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,?,?,?,?,sysdate)";
		jdbc.update(sql,dto.getMem_id(),dto.getMem_role(),dto.getNotice_title(),dto.getNotice_content());
	}
	
	//공지사항 수정
	public int updateNotice(int seq, String title, String content) {
		String sql = "UPDATE NOTICE SET NOTICE_TITLE=?,NOTICE_CONTENT=? WHERE NOTICE_SEQ=?";
		return jdbc.update(sql,title,content,seq);
	}
	
	//공지사항 삭제
	public int deleteNoticeBySeq(int seq) {
		String sql = "DELETE FROM NOTICE WHERE NOTICE_SEQ=?";
		return jdbc.update(sql,seq);
	}	
	
	//----------------공통 영역-------------------------
	public NoticeDTO getContents(int notice_seq) {
		String sql = "select * from notice where notice_seq=?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<NoticeDTO>(NoticeDTO.class),notice_seq);
	}
}