package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.commons.EncryptionUtils;
import com.kedu.dto.MembersDTO;
import com.kedu.dto.ReplyDTO;

@Repository
public class MembersDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	// 회원가입
	public int insert(MembersDTO dto) {
		String sql = "insert into members values(?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate,?)";
		return jdbc.update(sql, dto.getMem_id(),EncryptionUtils.getSha512(dto.getMem_password()),dto.getMem_nickname(),
				dto.getMem_name(), dto.getMem_ssn(), dto.getMem_gender(), dto.getMem_phone(), dto.getMem_email(),
				dto.getMem_zip_code(), dto.getMem_address1(), dto.getMem_address2(),dto.getMem_dong(), 1, 0);
	}
	
	// 아이디 중복체크
	public int duplCheck(String mem_id) {
		String sql = "select count(*) from members where mem_id = ?";
		return jdbc.queryForObject(sql, Integer.class, mem_id);
	}
	
	// 회원 정보 모두 출력
	public MembersDTO selectAll(String mem_id) {
		String sql = "select * from members where mem_id = ?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<MembersDTO>(MembersDTO.class),mem_id);
	}
	
	// 로그인, 닉네임 출력, 로그인 alert 기능 구현
	public int login(String mem_id, String mem_password) {
		
		String id = "select count(*) from members where mem_id = ?";
		Integer idCount = jdbc.queryForObject(id, Integer.class, mem_id); // Integer(객체)로 써야 null 값도 확인 가능
		
		if(idCount == 0){
			return -1; // id가 db에 있는지 확인(없으면 -1 반환)
		}
		
		String pw = "select count(*) from members where mem_id = ? and mem_password = ?";
		Integer pwCount = jdbc.queryForObject(pw, Integer.class, mem_id, EncryptionUtils.getSha512(mem_password));
		
		
		// 관리자계정용 로그인
		String admin = "select count(*) from members where mem_id = ? and mem_password = ? and mem_role = 0";
		Integer adminCount = jdbc.queryForObject(admin, Integer.class, mem_id, EncryptionUtils.getSha512(mem_password));
		
		// 탈퇴 회원 검사 로직
		String deleteMem = "select count(*) from members where mem_id =? and mem_status = 1";
		Integer deleteMemCount = jdbc.queryForObject(deleteMem, Integer.class, mem_id);
		
		if(adminCount > 0) {
			return 2;
		}
			
		if(deleteMemCount > 0) { // 탈퇴회원 검사 로직 status 1인 계정
			return 3;
		}else if(pwCount > 0) {
			return 1; // id, pw , status 0인 계정 있음(로그인 성공)
		}else {
			return 0; // id는 있고, pw 없음
		}
		
		
	}
	
	public int getRole(String id) {
		String role = "select mem_role from members where mem_id=?";
		return jdbc.queryForObject(role, Integer.class, id);
	}
	
	public List<ReplyDTO> memRole(int post_seq) {
		String sql = "select r.*, m.mem_role, m.mem_nickname "
				+ "from reply r join members m on r.mem_id = m.mem_id "
				+ "where post_seq = ? order by r.reply_date";
		return jdbc.query(sql, new BeanPropertyRowMapper<ReplyDTO>(ReplyDTO.class), post_seq);
	}
	
	
	// 홈 화면에서 닉네임 조회 후 띄우기
	public String nickname(String mem_id) { // DB에서 mem_id 기준으로 조회
		String sql = "select mem_nickname from members where mem_id = ?";
		return jdbc.queryForObject(sql, String.class, mem_id);
	}
	
	public String address(String mem_id) { // DB에서 mem_id를 기준으로 주소 조회
		String sql ="select mem_dong from members where mem_id = ?";
		return jdbc.queryForObject(sql, String.class, mem_id);
	}
	
	public int updateById(MembersDTO dto, String mem_id) {
		String sql = "update members set mem_nickname =?, mem_phone =?, mem_zip_code=?, mem_address1=?, mem_address2=?, mem_dong=? where mem_id=?";
		return jdbc.update(sql, dto.getMem_nickname(), dto.getMem_phone(), dto.getMem_zip_code(), dto.getMem_address1(), dto.getMem_address2(), dto.getMem_dong(), mem_id);
	}
	
	// 회원 탈퇴
	public int deleteById(String mem_id) {
		String sql = "delete from members where mem_id = ?";
		return jdbc.update(sql, mem_id);
	}
	
	// 마이페이지 모임 개수 출력
	public int meetingCount(String loginId) {
		String sql = 
				"select count(distinct m.meet_seq) " +
				"from meeting m left join meeting_member mm on m.meet_seq = mm.meet_seq " +
				"where (mm.mem_id = ? and mm.meetmem_status = 1 and m.meet_status in (0,1)) " +
				"or (m.mem_id = ? and m.meet_status in (0,1))";
		return jdbc.queryForObject(sql, Integer.class, loginId, loginId);
	}
	
	// 블랙리스트 로그인 제한 로직
	public MembersDTO blackListLoginCheck(String mem_id, String mem_password) {
		String sql = "select m.*, "
				+ "TO_CHAR(b.end_date, 'YYYY-MM-DD HH24:MI:SS') AS end_date "
				+ "from members m "
				+ "left join blackList b on m.mem_id = b.mem_id "
				+ "where m.mem_id = ? and m.mem_password = ?";
		try {
			return jdbc.queryForObject(sql, new BeanPropertyRowMapper<MembersDTO>(MembersDTO.class),mem_id,EncryptionUtils.getSha512(mem_password));
		}catch(Exception e) {
			return null;
		}
	}
	
	public int updateMemberStatus(String mem_id) { // 블랙리스트 기간 만료시 (membersTable status 업데이트) 로직
		String sql = "update members set mem_status =3 where mem_id =? ";
		return jdbc.update(sql, mem_id);
	}
}