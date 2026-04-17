package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.QaDTO;

@Repository
public class UserQaDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	//db에 저장
	public void insert(QaDTO dto) {
		String sql = "insert into qa (qa_seq, mem_id, qa_title, qa_contents, qa_category, qa_create_date, qa_status) " +
	             "values (qa_seq.nextval, ?, ?, ?, ?, sysdate, ?)";
		jdbc.update(sql,dto.getMem_id(),dto.getQa_title(),dto.getQa_contents(),dto.getQa_category(),dto.getQa_status());
	}
	
	// qa게시글 리스트 뽑기
	public List<QaDTO> getPostList(String mem_id,int start,int end){	
		String sql = "SELECT * FROM (SELECT qa.*, ROW_NUMBER() OVER (ORDER BY qa_create_date DESC) a FROM qa where mem_id = ?) WHERE a BETWEEN ? AND ?";
		return jdbc.query(sql, new BeanPropertyRowMapper<QaDTO>(QaDTO.class),mem_id,start,end);
	}
	
	public int getTotalCount(String mem_id){
		String sql = "select count(*) from qa where mem_id = ?";
		return jdbc.queryForObject(sql,Integer.class,mem_id);
	}
	
	// qa 수정
	public void updateBySeq(int seq, String title, String contents) {
		String sql = "UPDATE QA SET QA_TITLE=?,QA_CONTENTS=? WHERE QA_SEQ=?";
		jdbc.update(sql,title,contents,seq);
	}
	// qa 삭제
	public int deleteBySeq(int seq) {
		String sql = "DELETE FROM QA WHERE QA_SEQ=?";
		return jdbc.update(sql,seq);
	}
}