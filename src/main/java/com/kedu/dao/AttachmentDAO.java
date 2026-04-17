package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.AttachmentDTO;

@Repository
public class AttachmentDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	//file db에 저장
	public int insert(AttachmentDTO dto) {
		String sql = "INSERT INTO ATTACHMENT VALUES(ATTACHMENT_SEQ.NEXTVAL,?,?,?,?)";
		return jdbc.update(sql,dto.getParent_type(),dto.getParent_seq(),dto.getAttach_oriname(),dto.getAttach_sysname());
	}
	
	//board에서 list 받기
	public List<AttachmentDTO> getAttachment(int seq){
		String sql = "SELECT * FROM ATTACHMENT WHERE PARENT_SEQ=?";
		return jdbc.query(sql, new BeanPropertyRowMapper<AttachmentDTO>(AttachmentDTO.class),seq);
	}
	
	//feedback에서 list 받기
	public List<AttachmentDTO> getAttachmentSuggestion(int seq){
		String sql = "SELECT * FROM ATTACHMENT WHERE PARENT_SEQ=? AND PARENT_TYPE='feedback'";
		return jdbc.query(sql, new BeanPropertyRowMapper<AttachmentDTO>(AttachmentDTO.class),seq);
	}
	
	//파일 삭제
	public void deleteBySysName(String sys_name) {
		String sql = "DELETE FROM ATTACHMENT WHERE ATTACH_SYSNAME=?";
		jdbc.update(sql,sys_name);
	}
}