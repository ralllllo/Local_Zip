package com.kedu.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.commons.EncryptionUtils;
import com.kedu.dto.AuthDTO;
 
@Repository
public class AuthDAO {
	@Autowired
	private JdbcTemplate jdbc;
	
	// 인증번호 저장
	 public void saveAuth(AuthDTO dto) {
	        String sql = "MERGE INTO email_auth USING DUAL ON (email = ?) " +
	                     "WHEN MATCHED THEN UPDATE SET auth_code = ?, auth_type = ?, is_verified = ?, auth_create_date = SYSDATE " +
	                     "WHEN NOT MATCHED THEN INSERT (email, auth_code, auth_type,is_verified,auth_create_date) VALUES (?, ?, ?, ?, sysdate)";
	        jdbc.update(sql, dto.getEmail(), dto.getAuth_code(), dto.getAuth_type(),dto.getIs_verified(), 
	                                 dto.getEmail(), dto.getAuth_code(), dto.getAuth_type(),dto.getIs_verified());
	    }
	 
	 // 인증번호 일치 확인(5분이내) 1이면 성공
	 public int checkAuth(String email, String auth_code) {
	        String sql = "SELECT COUNT(*) FROM email_auth WHERE email = ? AND auth_code = ? AND auth_create_date >= SYSDATE - (5 / 1440)";
	        return jdbc.queryForObject(sql, Integer.class, email, auth_code);
	 }
	 
	 // 인증 성공시 상태 변경 0->1
	 public void updateVerified(String email) {
		 	String sql = "update email_auth set is_verified=1 where email=?";
		 	jdbc.update(sql,email);
	 }
	 
	 // 회원가입 최종 가입전에 인증 확인
	 public int isVerified(String email) {
		 	String sql = "select count(*) from email_auth where email=? and is_verified=1";
		 	return jdbc.queryForObject(sql, Integer.class,email);
	 }
	 
	 // 아이디 찾기
	 public String findIdByEmail(String email) {
		 	String sql = "select mem_id from members where mem_email=?";
		 	try {
		 	return jdbc.queryForObject(sql,String.class,email);
		 	}catch(Exception e) {
		 		return null;
		 	}
	 }
	 
	 //이메일 존재 여부 확인
	 public int isEmailExists(String email) {
		    String sql = "SELECT COUNT(*) FROM members WHERE mem_EMAIL = ?";
		    return jdbc.queryForObject(sql, Integer.class, email);
	 }
	 
	 public int isIdEmailExists(String id, String email) {
		    String sql = "SELECT COUNT(*) FROM MEMBERS WHERE MEM_ID=? AND MEM_EMAIL = ?";
		    return jdbc.queryForObject(sql, Integer.class,id,email);
	 }
	 
	 //비밀번호 업데이트
	 public int updatePwById(String id,String pw) {
		
		String sql = "update members set mem_password=? where mem_id=?"; 
		return jdbc.update(sql,EncryptionUtils.getSha512(pw),id);
	 }
}