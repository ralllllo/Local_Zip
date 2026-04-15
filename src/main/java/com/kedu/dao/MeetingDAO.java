package com.kedu.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.MeetingDTO;

@Repository
public class MeetingDAO {
	
	@Autowired
	private JdbcTemplate jdbc;

	// 모임 생성 폼 db에 넣기
	public int insert(MeetingDTO dto) throws Exception {
		
		String sql = "insert into meeting values(meeting_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate, ?)";
		
		return jdbc.update(sql, dto.getMem_id(), dto.getMem_nickname() , dto.getMeet_title(), dto.getMeet_category(), dto.getMeet_introcontents(),
				dto.getMeet_detailcontents(), dto.getMeet_maxpeople(), dto.getMeet_currentpeople(), dto.getMem_address1(),
				dto.getMeet_kakaolink(), dto.getMeet_kakaopw(), dto.getMeet_status(), dto.getMeet_allpeople());
	}
	
	// 모임 생성 폼 조회
	public List<MeetingDTO> selectAll() throws Exception {
		
		String sql = "select meeting.*, (select nvl(count(*), 0) from meeting_member "
				+ "where meeting_member.meet_seq = meeting.meet_seq) as meet_currentpeople "
				+ "from meeting order by meeting.meet_seq desc ";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<MeetingDTO>(MeetingDTO.class));
	}
	
	public List<MeetingDTO> selectBySeq(int seq) throws Exception {  // currentpeople = meetingMember 참여인원수 포함해서 리스트 출력
		
		String sql = "select m.*, "
				+ "(select count(*) from meeting_member mm where mm.meet_seq = m.meet_seq and mm.meetmem_status = 1) meet_currentpeople "
				+ "from meeting m where meet_seq = ? ";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<MeetingDTO>(MeetingDTO.class), seq);
	}
	
	public List<MeetingDTO> selectAllByPage(int start, int end) { // + 게이지바 포함 전체 리스트 출력
		String sql = "select * from (select row_number() over(order by m.meet_seq desc) rn, "
				+ "m.mem_id, m.meet_seq, m.mem_nickname, m.meet_title, m.meet_category, "
				+ "m.meet_introcontents, m.meet_maxpeople, m.mem_address1, "
				+ "(select count(*) from meeting_member mm where mm.meet_seq = m.meet_seq and mm.meetmem_status = 1) as meet_currentpeople "
				+ "from meeting m "
				+ "where m.meet_status in (0,1)) where rn between ? and ?";
		return jdbc.query(sql, new BeanPropertyRowMapper<MeetingDTO>(MeetingDTO.class), start, end);
	}
	
	public List<MeetingDTO> selectByPage(String category, int start, int end){ // + 게이지바 포함 카테고리별 리스트 출력
		String sql = "select * from (select row_number() over(order by m.meet_seq desc) rn, "
				+ "m.mem_id, m.meet_seq, m.mem_nickname, m.meet_title, m.meet_category, "
				+ "m.meet_introcontents, m.meet_maxpeople, m.mem_address1, "
				+ "(select count(*) from meeting_member mm where mm.meet_seq = m.meet_seq and mm.meetmem_status = 1) as meet_currentpeople "
				+ "from meeting m "
				+ "where m.meet_category =? and m.meet_status in (0,1)) where rn between ? and ? ";
		return jdbc.query(sql, new BeanPropertyRowMapper<MeetingDTO>(MeetingDTO.class), category, start, end);
	}
	
	public int getAllCount() { // 전체 승인대기, 참여중 카운트 체크
		String sql = "select count(*) from meeting where meet_status in (0,1)";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	public int getCategoryCount(String category) { // 카테고리별 승인대기, 참여중 카운트 체크
		String sql = "select count(*) from meeting where meet_category = ? and meet_status in (0,1)";
		return jdbc.queryForObject(sql, Integer.class, category);
	}
	
	public int countMeetingByWriter(String loginId, int status) { // 모임 3개 생성 제한
		String sql = "select count(*) from meeting where mem_id = ? and meet_status = ?";
		return jdbc.queryForObject(sql, Integer.class, loginId, status);
	}
	
	public List<Map<String, Object>> isApplied(String loginId) { // 0, 승인 대기 상태
		String sql = "select meet_seq from meeting_member where mem_id = ? and meetmem_status = 0";
		return jdbc.queryForList(sql, loginId);
	}
	
	public List<Map<String, Object>> joinMeet(String loginId){ // 1, 승인 상태
		String sql = "select meet_seq from meeting_member where mem_id = ? and meetmem_status = 1";
		return jdbc.queryForList(sql, loginId);
	}
	
	public List<Map<String, Object>> companionMeet(String loginId){ // 2, 거절 상태
		String sql = "select meet_seq from meeting_member where mem_id = ? and meetmem_status = 2";
		return jdbc.queryForList(sql, loginId);
	}
	
	public int deleteMeeting(int meet_seq) {
		String sql = "delete from meeting where meet_seq = ?";
		return jdbc.update(sql, meet_seq);
	}
	
	// 참여중인 모임 리스트 뽑기
	public List<MeetingDTO> selectMyAllMeeting(String loginId) {

	    String sql =
	        "select distinct " +
	        " m.meet_seq, " +
	        " m.mem_id, " +
	        " m.meet_title, " +
	        " m.meet_category, " +
	        " m.meet_introcontents, " +
	        " m.mem_address1, " +
	        " m.meet_maxpeople " +
	        "from meeting m " +
	        "left join meeting_member mm " +
	        "on m.meet_seq = mm.meet_seq " +
	        "where (mm.mem_id = ? and mm.meetmem_status = 1 and m.meet_status in (0,1)) " +
	        "or (m.mem_id = ? and m.meet_status in (0,1))";

	    return jdbc.query(sql,new BeanPropertyRowMapper<MeetingDTO>(MeetingDTO.class),loginId, loginId);
	}
	
	// 참여중인 모임 탭에서 자세히보기 > 정보 수정완료 버튼 클릭 시
	public int updateMeeting(int seq, String meet_detailcontents, String meet_kakaolink, String meet_kakaopw) {
		
		String sql = "update meeting set meet_detailcontents = ?, meet_kakaolink = ?, meet_kakaopw = ? where meet_seq = ?";
		
		return jdbc.update(sql, meet_detailcontents, meet_kakaolink, meet_kakaopw, seq);
	}
	
	// 참여중인 모임 탭에서 모임 삭제 버튼 클릭 시
	public int deleteMeeting(int meet_seq, int status) {

	    String sql = "update meeting set meet_status = ? where meet_seq = ?";

	    return jdbc.update(sql, status, meet_seq);
	}
}
