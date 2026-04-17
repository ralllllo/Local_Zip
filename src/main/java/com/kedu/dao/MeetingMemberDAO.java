package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.ManageMeetingDTO;
import com.kedu.dto.MeetingMemberDTO;

@Repository
public class MeetingMemberDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	// 신청자 정보 db에 넣기
	public int insert(MeetingMemberDTO dto) throws Exception {
		
		String sql = "insert into meeting_member values(meeting_member_seq.nextval, ?, ?, ?, ?, ?, sysdate)";
		
		return jdbc.update(sql, dto.getMem_id(), dto.getMem_nickname() , dto.getMeet_seq(), dto.getMeetmem_contents(), dto.getMeetmem_status());
	}
	
	public int selectByStatus(int meet_seq, String mem_id) { // 내가 신청한 모임
		String sql = "select count(*) from meeting_member where meet_seq = ? and mem_id =? and meetmem_status = 1";
		return jdbc.queryForObject(sql, Integer.class ,meet_seq, mem_id);
	}
	
	public int adminCheck(String mem_id) { // 관리자 여부 확인
		String sql = "select count(*) from members where mem_id =? and mem_role = 0";
		return jdbc.queryForObject(sql, Integer.class, mem_id);
	}
	
	public int hostCheck(int meet_seq, String mem_id) { // 주최자인지 확인
		String sql = "select count(*) from meeting where meet_seq = ? and mem_id = ?";
		return jdbc.queryForObject(sql, Integer.class, meet_seq, mem_id);
	}
	// 승인 대기 중인 리스트 출력
	public List<ManageMeetingDTO> selectApplyList(String loginId) {

	    String sql =
	        "select " +
	        " m.meet_seq, " +
	        " m.meet_title, " +
	        " mm.meetmem_seq, " +
	        " mm.mem_id, " +
	        " mm.mem_nickname, " +
	        " mm.meetmem_contents, " +
	        " mm.meetmem_status " +
	        "from meeting m " +
	        "join meeting_member mm " +
	        "on m.meet_seq = mm.meet_seq " +
	        "where m.mem_id = ? and mm.meetmem_status = 0";

	    return jdbc.query(sql,new BeanPropertyRowMapper<ManageMeetingDTO>(ManageMeetingDTO.class),loginId);
	}
	
	// 요청 승인/거절 시 처리
	public int updateStatus(int meetmem_seq, int status) {

	    String sql = "update meeting_member set meetmem_status = ? where meetmem_seq = ?";

	    return jdbc.update(sql, status, meetmem_seq);
	}
	
	// 모임 탈퇴 시 처리
	public int outMeeting(String loginId, int seq) {
		
		String sql = "delete from meeting_member where mem_id = ? and meet_seq = ?";
		
		return jdbc.update(sql, loginId, seq);
	}
	
	// 승인 요청 처리 완료된 리스트 출력
	public List<ManageMeetingDTO> selectCompleteList(String loginId) {

	    String sql =
	        "select " +
	        " m.meet_seq, " +
	        " m.meet_title, " +
	        " mm.meetmem_seq, " +
	        " mm.mem_id, " +
	        " mm.mem_nickname, " +
	        " mm.meetmem_contents, " +
	        " mm.meetmem_status " +
	        "from meeting m " +
	        "join meeting_member mm " +
	        "on m.meet_seq = mm.meet_seq " +
	        "where m.mem_id = ? and mm.meetmem_status in (1,2)";

	    return jdbc.query(sql,new BeanPropertyRowMapper<ManageMeetingDTO>(ManageMeetingDTO.class),loginId);
	}
}