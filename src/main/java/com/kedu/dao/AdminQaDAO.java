package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.BlackListDTO;
import com.kedu.dto.QaDTO;
import com.kedu.dto.ReportDTO;

@Repository
public class AdminQaDAO {
	
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public List<QaDTO> selectById() {
		String sql = "select * from qa order by qa_create_date";
		return jdbc.query(sql, new BeanPropertyRowMapper<QaDTO>(QaDTO.class));
	}
	
	public int updateReply(QaDTO dto, int seq) { // 댓글 작성 로직
		String sql = "update qa set admin_answer =?, admin_answer_date = sysdate, qa_status = 1, mem_admin_id=? where qa_seq =?";
		return jdbc.update(sql, dto.getAdmin_answer(), dto.getMem_admin_id(), seq);
	}
	
	public int answerResetBySeq(int qa_seq) {
		String sql = "update qa set admin_answer = null, qa_status = 0 where qa_seq = ? ";
		return jdbc.update(sql, qa_seq);
	}
	
	public int answerUpdateBySeq(String admin_answer, int qa_seq) {
		String sql = "update qa set admin_answer =? , admin_answer_date = sysdate where qa_seq = ?";
		return jdbc.update(sql, admin_answer, qa_seq);
	}
	
	public int qaAllCount() {
		String sql = "select count(*) from qa";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	public int qaCount() {
		String sql = "select count(*) from qa where qa_status = 0";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	public int qaDoneCount() {
		String sql = "select count(*) from qa where qa_status = 1";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	public List<QaDTO> selectAll(){
		String sql = "select * from qa order by qa_create_date desc";
		return jdbc.query(sql, new BeanPropertyRowMapper<QaDTO>(QaDTO.class));
	}
	
	public List<QaDTO> selectByStatus(int status){
		String sql = "select * from qa where qa_status = ? order by qa_create_date";
		return jdbc.query(sql, new BeanPropertyRowMapper<QaDTO>(QaDTO.class), status);
	}
	
	public int getAllCount() {
		String sql = "select count(*) from qa";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	public int getCountByStatus(int status) {
		String sql = "select count(*) from qa where qa_status =?";
		return jdbc.queryForObject(sql, Integer.class, status);
	}
	
	public int activityMemberCount() {
		String sql = "select count(*) from members where mem_role = 1";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	public List<QaDTO> selectAllCount(int start, int end){ // 전체 cpage
		String sql = "select * from ("
				+ "    select row_number() over(order by qa_create_date desc) rnum, q.* "
				+ "    from qa q"
				+ ") where rnum between ? and ?";

		return jdbc.query(sql, new BeanPropertyRowMapper<QaDTO>(QaDTO.class), start, end);
	}

	public List<QaDTO> selectByAdminAnswerWait(int start, int end){ // qa 답변대기 목록 출력
		String sql = "select * from ("
				+ "    select row_number() over(order by qa_create_date) rnum, q.* "
				+ "    from qa q where qa_status = 0"
				+ ") where rnum between ? and ?";

		return jdbc.query(sql, new BeanPropertyRowMapper<QaDTO>(QaDTO.class), start, end);
	}
	
	public List<QaDTO> selectByAdminAnswerFinish(int start, int end){ // qa 답변완료 목록 출력
		String sql = "select * from ("
				+ "    select row_number() over(order by qa_create_date desc) rnum, q.* "
				+ "    from qa q where qa_status = 1"
				+ ") where rnum between ? and ?";

		return jdbc.query(sql, new BeanPropertyRowMapper<QaDTO>(QaDTO.class),start, end);
	}

	public List<ReportDTO> selectReportAll(){ // 신고 목록 출력 메서드
		String sql = "select * from reports";
		return jdbc.query(sql, new BeanPropertyRowMapper<ReportDTO>(ReportDTO.class));
	}
	
	public List<ReportDTO> selectReportContents(int start, int end){ // 신고된 대상(게시글/댓글/목록) + 내용 출력 메서드 (전체)
		String sql = "select * from( "
				+ "select row_number() over(order by r.reports_date desc) as rn, "
				+ "r.mem_id, r.target_id, r.reports_date, r.reports_type, r.reports_reason, r.target_seq, r.reports_status, r.reports_seq, "
				+ "coalesce(p.post_contents, reply.reply_contents, m.meet_introcontents, suggestion_contents, '원문 삭제됨(번호:' || r.target_seq || ')') as target_content, "
				+ "case "
				+ "when r.reports_type = 0 then '게시글' when r.reports_type = 1 then '댓글' when r.reports_type = 2 then '모임' else '동네건의' end as target_type_name "
				+ "from reports r "
				+ "left join post p on r.target_seq = p.post_seq and r.reports_type = 0 "
				+ "left join reply on r.target_seq = reply.reply_seq and r.reports_type = 1 "
				+ "left join meeting m on r.target_seq = m.meet_seq and r.reports_type = 2 "
				+ "left join suggestion s on r.target_seq = s.suggestion_seq and r.reports_type = 3 "
				+ ") where rn between ? and ? ";
		return jdbc.query(sql, new BeanPropertyRowMapper<ReportDTO>(ReportDTO.class), start, end);
	}
	
	public List<ReportDTO> selectReportContentsByStatus(int status, int start, int end){ // 신고된 대상(게시글/댓글/목록) + 내용 출력 메서드 (미처리건들 출력)
		String sql = "select * from( "
				+ "select row_number() over(order by r.reports_date) as rn, "
				+ "r.mem_id, r.target_id, r.reports_date, r.reports_type, r.reports_reason, r.target_seq,  r.reports_status, r.reports_seq, "
				+ "coalesce(p.post_contents, reply.reply_contents, m.meet_introcontents, suggestion_contents, '원문 삭제됨(번호:' || r.target_seq || ')') as target_content, "
				+ "case "
				+ "when r.reports_type = 0 then '게시글' when r.reports_type = 1 then '댓글' when r.reports_type = 2 then '모임' else '동네건의' end as target_type_name "
				+ "from reports r "
				+ "left join post p on r.target_seq = p.post_seq and r.reports_type = 0 "
				+ "left join reply on r.target_seq = reply.reply_seq and r.reports_type = 1 "
				+ "left join meeting m on r.target_seq = m.meet_seq and r.reports_type = 2 "
				+ "left join suggestion s on r.target_seq = s.suggestion_seq and r.reports_type = 3 "
				+ "where r.reports_status = ? "
				+ ") where rn between ? and ? ";
		return jdbc.query(sql, new BeanPropertyRowMapper<ReportDTO>(ReportDTO.class),status, start, end);
	}
	
	public List<ReportDTO> selectReportContentsByStatusHandle(int start, int end){ // 신고된 대상(게시글/댓글/목록) + 내용 출력 메서드 (처리완료건들 출력)
		String sql = "select * from( "
				+ "select row_number() over(order by r.reports_status) as rn, "
				+ "r.mem_id, r.target_id, r.reports_date, r.reports_type, r.reports_reason, r.target_seq,  r.reports_status, r.reports_seq, "
				+ "coalesce(p.post_contents, reply.reply_contents, m.meet_introcontents, suggestion_contents, '원문 삭제됨(번호:' || r.target_seq || ')') as target_content, "
				+ "case "
				+ "when r.reports_type = 0 then '게시글' when r.reports_type = 1 then '댓글' when r.reports_type = 2 then '모임' else '동네건의' end as target_type_name "
				+ "from reports r "
				+ "left join post p on r.target_seq = p.post_seq and r.reports_type = 0 "
				+ "left join reply on r.target_seq = reply.reply_seq and r.reports_type = 1 "
				+ "left join meeting m on r.target_seq = m.meet_seq and r.reports_type = 2 "
				+ "left join suggestion s on r.target_seq = s.suggestion_seq and r.reports_type = 3 "
				+ "where r.reports_status in (3,5) "
				+ ") where rn between ? and ? ";
		return jdbc.query(sql, new BeanPropertyRowMapper<ReportDTO>(ReportDTO.class), start, end);
	}
	
	public int reportAllCount() { // 전체 신고목록 개수 카운트
		String sql = "select count(*) from reports";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	public int reportHandleCount() { // 처리완료 신고목록 개수 카운트 ( 3 : 블랙리스트 처리 완료 / 5: 블랙리스트 해제 처리 완료 )
		String sql = "select count(*) from reports where reports_status in (3 , 5)";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	public int reportCount() { // 미처리 신고목록 개수 카운트
		String sql = "select count(*) from reports where reports_status = 4 ";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	public int updateMemberStatus(int mem_status, String target_id) { // 블랙리스트 등록 (membersTable status 업데이트) 로직
		String sql = "update members set mem_status =? where mem_id =? ";
		return jdbc.update(sql, mem_status, target_id);
	}
	
	public int insertBlackList(String targer_id, String black_option, int day) { // 블랙리스트 정지시작/종료일수 (blackList Table 업데이트) 로직
		String sql = "insert into blackList (black_seq, mem_id, black_option, start_date, end_date) "
				+ "values(blackList_seq.nextval, ? , ? , sysdate, sysdate + ?)";
		return jdbc.update(sql, targer_id, black_option, day);
	}
	
	// 블랙리스트 기간 연장 1.) 블랙리스트 테이블에 해당 유저가 있는지 먼저 검사 ( 없으면 null 반환 )
	public List<BlackListDTO> selectById(String mem_id) {
		String sql = "select * from blackList where mem_id =? ";
		return jdbc.query(sql, new BeanPropertyRowMapper<BlackListDTO>(BlackListDTO.class),mem_id);
	}
	
	// 블랙리스트 기간 연장 2.) 이미 블랙리스트 처리가 되어있는 mem_id에 또 신고가 들어왔을 때, 블랙리스트 기간을 연장시키는 로직
	public int updateBlackEndDate(int day, String mem_id) {
		String sql = "update blackList set end_date = end_date + ? where mem_id = ?";
		return jdbc.update(sql , day, mem_id);
	}
	
	public int updateReportsStatus(int reports_type, String target_id, int target_seq) { // 블랙리스트 등록 시 reports 테이블 status 업데이트
		String sql = "update reports set reports_status =? where target_id = ? and target_seq = ? ";
		return jdbc.update(sql, reports_type, target_id, target_seq);
	}
	
	public int deleteMembersStatus(int mem_status, String target_id) { // 블랙리스트 해제 (membersTable status 업데이트) 로직
		String sql = "update members set mem_status = ? where mem_id =? ";
		return jdbc.update(sql, mem_status, target_id);
	}
	
	public int deleteBlackList(String target_id) { // 블랙리스트 정지시작/종료일수 비우기 (blackList Table) 로직
		String sql = "delete from blackList where mem_id = ? ";
		return jdbc.update(sql, target_id);
	}
	
	public int updateReportStatus(int reports_status, String target_id) { // 블랙리스트 처리된 건을 해제하는 로직 (해제 -> 해제완료 버튼 구현)
		String sql = "update reports set reports_status = ? where target_id = ?";
		return jdbc.update(sql, reports_status, target_id);
	}
	
	public int reportReject(int reports_seq) { // 신고 반려 처리 로직
		String sql = "delete from reports where reports_seq = ?";
		return jdbc.update(sql, reports_seq);
	}
	
	public List<ReportDTO> selectGetPage(int start, int end){ // cpage
		String sql = "select * from(select reports.*, row_number() over(order by reports_date desc) num from reports) where num between ? and ? ";
		return jdbc.query(sql, new BeanPropertyRowMapper<ReportDTO>(ReportDTO.class),start,end);
	}
}