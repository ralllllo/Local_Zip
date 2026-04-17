package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.BoardDTO;
import com.kedu.dto.CategoryVisitDTO;

@Repository
public class BoardDAO {

	@Autowired
	private JdbcTemplate jdbc;


	//db에 게시글 등록
	public int insert(BoardDTO dto, String mem_id, String mem_nickname, String mem_dong) throws Exception{
		String sql = "insert into post values(?,?,?,?,?,?,?,?,?,sysdate)";
		return jdbc.update(sql,dto.getPost_seq(), dto.getPost_category(), mem_id, mem_nickname, mem_dong, 
				dto.getPost_hit(),dto.getPost_title(), dto.getPost_contents(), dto.getPost_like());
	}

	
	// 카테고리 별 최신순, 인기순 정렬 후 > 리스트 출력 메서드 ------------------------------
	public List<BoardDTO> list_home_latest(String mem_id) throws Exception{
		String sql = "select p.*, m.mem_nickname, m.mem_dong, m.mem_role, " +
                " (select count(*) FROM reply r WHERE r.post_seq = p.post_seq) as post_hit, " + // 댓글 수
                " (select count(*) FROM post_like l WHERE l.post_seq = p.post_seq) as post_like_count, " + // 전체 좋아요 수
                " (select count(*) FROM post_like l WHERE l.post_seq = p.post_seq AND l.mem_id = ?) as post_like_check " + // 내가 눌렀는지 여부
                " FROM post p "
                + "join members m on p.mem_id = m.mem_id " +
                " order by p.post_date desc";
		return jdbc.query(sql, new BeanPropertyRowMapper<BoardDTO>(BoardDTO.class),mem_id);
	};

	//홈(=전체) 리스트 출력(인기순)
	public List<BoardDTO> list_home_like(String mem_id) throws Exception{
		String sql = "select p.*, m.mem_nickname, m.mem_dong, m.mem_role, " +
                " (select count(*) FROM reply r WHERE r.post_seq = p.post_seq) as post_hit, " + // 댓글 수
                " (select count(*) FROM post_like l WHERE l.post_seq = p.post_seq) as post_like_count, " + // 전체 좋아요 수
                " (select count(*) FROM post_like l WHERE l.post_seq = p.post_seq AND l.mem_id = ?) as post_like_check " + // 내가 눌렀는지 여부
                " FROM post p " +
                " join members m on p.mem_id = m.mem_id " +
                " order by post_like desc";
		return jdbc.query(sql, new BeanPropertyRowMapper<BoardDTO>(BoardDTO.class),mem_id);
	};

	//생활정보 리스트 출력(최신순)
	public List<BoardDTO> list_lifeInfo_latest(int start, int end) throws Exception{
		String sql = "select * from (" 
				   + " select row_number() over(order by p.post_date desc) rn, "
				   + " p.post_seq, "
				   + " p.mem_id, "
				   + " p.post_title, "
				   + " p.post_contents, "
				   + " p.post_date, "
				   + " p.post_like, "
				   + " p.post_hit, "
				   + " m.mem_dong, "
				   + " m.mem_role, "
				   + " m.mem_nickname "
				   + " from post p "
				   + " join members m on p.mem_id = m.mem_id "
				   + " where post_category = 'lifeInfo' "
				   + ") where rn between ? and ?";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<BoardDTO>(BoardDTO.class), start, end);
	}

	//생활정보 리스트 출력(인기순)
	public List<BoardDTO> list_lifeInfo_like(int start, int end) throws Exception{
		String sql = "select * from (" 
				   + " select row_number() over(order by p.post_like desc, p.post_seq desc) rn, "
				   + " p.post_seq, "
				   + " p.mem_id, "
				   + " p.post_title, "
				   + " p.post_contents, "
				   + " p.post_date, "
				   + " p.post_like, "
				   + " p.post_hit, "
				   + " m.mem_dong, "
				   + " m.mem_role, "
				   + " m.mem_nickname "
				   + " from post p "
				   + " join members m on p.mem_id = m.mem_id "
				   + " where post_category = 'lifeInfo' "
				   + ") where rn between ? and ?";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<BoardDTO>(BoardDTO.class), start, end);
	}

	//맛집/카페 리스트 출력(최신순)
	public List<BoardDTO> list_food_latest(int start, int end) throws Exception{
		String sql = "select * from (" 
				   + " select row_number() over(order by p.post_date desc) rn, "
				   + " p.post_seq, "
				   + " p.mem_id, "
				   + " p.post_title, "
				   + " p.post_contents, "
				   + " p.post_date, "
				   + " p.post_like, "
				   + " p.post_hit, "
				   + " m.mem_dong, "
				   + " m.mem_role, "
				   + " m.mem_nickname "
				   + " from post p "
				   + " join members m on p.mem_id = m.mem_id "
				   + " where post_category = 'food' "
				   + ") where rn between ? and ?";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<BoardDTO>(BoardDTO.class), start, end);

	}

	//맛집/카페 리스트 출력(인기순)
	public List<BoardDTO> list_food_like(int start, int end) throws Exception{
		String sql = "select * from (" 
				   + " select row_number() over(order by p.post_like desc, p.post_seq desc) rn, "
				   + " p.post_seq, "
				   + " p.mem_id, "
				   + " p.post_title, "
				   + " p.post_contents, "
				   + " p.post_date, "
				   + " p.post_like, "
				   + " p.post_hit, "
				   + " m.mem_dong, "
				   + " m.mem_role, "
				   + " m.mem_nickname "
				   + " from post p "
				   + " join members m on p.mem_id = m.mem_id "
				   + " where post_category = 'food' "
				   + ") where rn between ? and ?";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<BoardDTO>(BoardDTO.class), start, end);
	}
	
	//고민/이야기 리스트 출력(최신순)
	public List<BoardDTO> list_concern_latest(int start, int end) throws Exception{
		String sql = "select * from (" + " select row_number() over(order by p.post_date desc) rn, "
									   + " p.post_seq, "
									   + " p.mem_id, "
									   + " p.post_title, "
									   + " p.post_contents, "
									   + " p.post_date, "
									   + " p.post_like, "
									   + " p.post_hit, "
									   + " m.mem_dong, "
									   + " m.mem_role, "
									   + " m.mem_nickname "
									   + " from post p "
									   + " join members m on p.mem_id = m.mem_id "
									   + " where post_category = 'talk' "
									   + ") where rn between ? and ?";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<BoardDTO>(BoardDTO.class), start, end);
	}

	//고민/이야기 리스트 출력(인기순)
	public List<BoardDTO> list_concern_like(int start, int end) throws Exception{
		String sql = "select * from (" + " select row_number() over(order by p.post_like desc, p.post_seq desc) rn, "
									   + " p.post_seq, "
									   + " p.mem_id, "
									   + " p.post_title, "
									   + " p.post_contents, "
									   + " p.post_date, "
									   + " p.post_like, "
									   + " p.post_hit, "
									   + " m.mem_dong, "
									   + " m.mem_role, "
									   + " m.mem_nickname "
									   + " from post p "
									   + " join members m on p.mem_id = m.mem_id "
									   + " where post_category = 'talk' "
									   + ") where rn between ? and ?";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<BoardDTO>(BoardDTO.class), start, end);
	}

	//미용/패션 리스트 출력(최신순)
	public List<BoardDTO> list_beauty_latest(int start, int end) throws Exception{
		
		String sql = "select * from (" 
				   + " select row_number() over(order by p.post_date desc) rn, "
				   + " p.post_seq, "
				   + " p.mem_id, "
				   + " p.post_title, "
				   + " p.post_contents, "
				   + " p.post_date, "
				   + " p.post_like, "
				   + " p.post_hit, "
				   + " m.mem_dong, "
				   + " m.mem_role, "
				   + " m.mem_nickname "
				   + " from post p "
				   + " join members m on p.mem_id = m.mem_id "
				   + " where post_category = 'beauty' "
				   + ") where rn between ? and ?";
		return jdbc.query(sql, new BeanPropertyRowMapper<BoardDTO>(BoardDTO.class), start, end);
	}

	//미용/패션 리스트 출력(인기순)
	public List<BoardDTO> list_beauty_like(int start, int end) throws Exception{
		
		String sql = "select * from (" 
				   + " select row_number() over(order by p.post_like desc, p.post_seq desc) rn, "
				   + " p.post_seq, "
				   + " p.mem_id, "
				   + " p.post_title, "
				   + " p.post_contents, "
				   + " p.post_date, "
				   + " p.post_like, "
				   + " p.post_hit, "
				   + " m.mem_dong, "
				   + " m.mem_role, "
				   + " m.mem_nickname "
				   + " from post p "
				   + " join members m on p.mem_id = m.mem_id "
				   + " where post_category = 'beauty' "
				   + ") where rn between ? and ?";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<BoardDTO>(BoardDTO.class), start, end);
	}

	// 좋아요 수, 댓글 수 출력하는 메서드----------------------------------------------

	// **주의: post_hit 컬럼은 현재 댓글 수를 저장하는 용도로 사용 중

	// replyDAO에서 count로 뽑아낸 댓글 수를 board 테이블(post_hit)에 반영
	public int setCommentCount(int count, int post_seq) { 
		String sql = "update post set post_hit = ? where post_seq = ?";
		return jdbc.update(sql, count, post_seq);
	}

	// 좋아요 누른 기록 저장용 메서드(총 합계)
	public int updateLikeCount(int count, int post_seq) {
		String sql = "update post set post_like = ? where post_seq = ?";
		return jdbc.update(sql, count, post_seq);
	};

	//----------------------------------------------------------------------

	//게시글 상세 내용 출력
	public BoardDTO selectByPost_seq(int post_seq) throws Exception{
		String sql = "select p.*, m.mem_nickname, m.mem_dong, " +
                " (select count(*) FROM post_like l WHERE l.post_seq = p.post_seq) as post_like_count " +
                " from post p "
                + "join members m on p.mem_id = m.mem_id "
                + "where p.post_seq = ?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<BoardDTO>(BoardDTO.class), post_seq);
	};

	//게시글 삭제
	public int deletePost(int post_seq) {
		String sql = "delete from post where post_seq = ?";
		return jdbc.update(sql, post_seq);
	}

	//게시글 수정
	public int updatePost(int post_seq, String post_title, String post_contents) {
		String sql = "update post set post_title = ?, post_contents = ? where post_seq = ?";
		return jdbc.update(sql, post_title, post_contents, post_seq);
	}

	public List<CategoryVisitDTO> getCategoryCount(){
		String sql = "select p.post_category as postCategory, "
				+ "p.post_count as count, "
				+ "nvl(v.visit_count, 0) as visitCount "
				+ "from ( "
				+ "select post_category, count(*) as post_count "
				+ "from post "
				+ "group by post_category "
				+ ") p "
				+ "left join ( "
				+ "select post_category, count(distinct mem_id) as visit_count "
				+ "from visit_log "
				+ "where post_category <> 'LOGIN' "
				+ "group by post_category "
				+ ") v "
				+ "on p.post_category = v.post_category";

		return jdbc.query(sql, new BeanPropertyRowMapper<CategoryVisitDTO>(CategoryVisitDTO.class));
	}

	public String getCategoryBySeq(int seq) {
		String sql = "select post_category from post where post_seq = ?";
		return jdbc.queryForObject(sql, String.class, seq);
	}

	//----------------------------------------------------

	//마이페이지 > 내 작성글 모아보기
	public List<BoardDTO> getMyBoards(String mem_id){
		String sql = "select * from post where mem_id = ? order by post_date desc";
		return jdbc.query(sql, new BeanPropertyRowMapper<BoardDTO>(BoardDTO.class), mem_id);
	};

	// 마이페이지 > 내 작성글 수 세기
	public int MyWriteCount(String mem_id) {
		String sql = "select count(*) from post where mem_id = ?";
		return jdbc.queryForObject(sql, Integer.class, mem_id);
	}
	
	// 마이페이지 > 내 관심 게시글 수 세기
	public int MyLikeCount(String mem_id) {
		String sql = "select count(*) from post_like where mem_id = ?";
		return jdbc.queryForObject(sql, Integer.class, mem_id);
	}
	
	// 아래 작성글/관심글은 네비게이터 용도로 만듬. ---------
	
	// 내 작성글 리스트 뽑아오기
	public List<BoardDTO> getPostsNavi(String mem_id,int start, int end){
		String sql = "SELECT * FROM (SELECT post.*, ROW_NUMBER() OVER (ORDER BY post_date DESC) a FROM post where mem_id = ?) WHERE a BETWEEN ? AND ?";
		return jdbc.query(sql, new BeanPropertyRowMapper<BoardDTO>(BoardDTO.class),mem_id,start,end);
	}
	
	// 내 작성글 개수 세기
	public int getTotalPosts(String mem_id) {
		String sql = "select count(*) from post where mem_id = ?";
		return jdbc.queryForObject(sql, Integer.class, mem_id);
	}
	
	// 내 관심글 리스트 뽑아오기
	public List<BoardDTO> getLikesNavi(String mem_id, int start, int end){
		String sql = "SELECT * FROM ( "
	               + " SELECT "
	               + " p.post_seq, "      
	               + " p.mem_id, "
	               + " p.post_category, "        
	               + " p.post_title, "    
	               + " p.post_contents, "
	               + " p.post_date, "
	               + " p.post_like, "
	               + " p.post_hit, "
	               + " m.mem_dong, "
	               + " m.mem_nickname, "
	               + " 1 as post_like_check, " // 하트를 눌렀는지 안눌렀는지 체크하는 코드
	               + " ROW_NUMBER() OVER (ORDER BY l.like_date DESC) a " // 좋아요 누른 순서로 정렬 권장
	               + " FROM post p "
	               + " JOIN post_like l ON p.post_seq = l.post_seq "
	               + " join members m on p.mem_id = m.mem_id "
	               + " WHERE l.mem_id = ? "
	               + " ) WHERE a BETWEEN ? AND ?";
	    return jdbc.query(sql, new BeanPropertyRowMapper<BoardDTO>(BoardDTO.class), mem_id, start, end);
	}
	
	// 내 관심글 개수 세기
	public int getTotalLikes(String mem_id) {
		String sql = "select count(*) from post_like where mem_id = ?";
		return jdbc.queryForObject(sql, Integer.class, mem_id);
	}

	//----------------------------------------------------
	
	// 고민/이야기 네비바(전체 글 수 출력)
	public int getConcernRecordTotalCount() {
		String sql = "select count(*) from post where post_category = 'talk'";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	// 맛집/카페 네비바(전체 글 수 출력)
		public int getFoodRecordTotalCount() {
			String sql = "select count(*) from post where post_category = 'food'";
			return jdbc.queryForObject(sql, Integer.class);
	}
		
	// 생활정보 네비바(전체 글 수 출력)
		public int getlifeInfoRecordTotalCount() {
			String sql = "select count(*) from post where post_category = 'lifeInfo'";
			return jdbc.queryForObject(sql, Integer.class);
	}
		
	// 미용/패션 네비바(전체 글 수 출력)
		public int getbeautyRecordTotalCount() {
			String sql = "select count(*) from post where post_category = 'beauty'";
			return jdbc.queryForObject(sql, Integer.class);
	}

	// 홈에서 제목(포함)으로 검색한 게시글 목록 출력용 메서드
		public List<BoardDTO> searchByTitle(String mem_id, String title, String sort) {
		    
		    // 로그인을 안 했을 때를 대비한 null 처리
		    if (mem_id == null) mem_id = "";

		    // 1. 공통 쿼리 (댓글 수, 좋아요 수, 내 좋아요 여부 포함)
		    // ? 순서: 1번(mem_id), 2번(title)
		    String sql = "SELECT p.*, " +
		                 " (SELECT COUNT(*) FROM reply r WHERE r.post_seq = p.post_seq) AS post_hit, " + 
		                 " (SELECT COUNT(*) FROM post_like l WHERE l.post_seq = p.post_seq) AS post_like_count, " + 
		                 " (SELECT COUNT(*) FROM post_like l WHERE l.post_seq = p.post_seq AND l.mem_id = ?) AS post_like_check " + 
		                 " FROM post p " +
		                 " WHERE p.post_title LIKE ? ";

		    // 2. 정렬 조건만 뒤에 붙이기 (sql = "select..." 로 새로 쓰면 절대 안 됩니다!)
		    if ("like".equals(sort)) {
		        // 인기순 정렬 (이미 계산된 post_like_count 별칭 사용)
		        sql += " ORDER BY post_like_count DESC, p.post_seq DESC";
		    } else {
		        // 최신순 정렬
		        sql += " ORDER BY p.post_date DESC";
		    }

		    // 3. 파라미터 전달 (순서: mem_id -> title)
		    return jdbc.query(sql, new BeanPropertyRowMapper<BoardDTO>(BoardDTO.class), mem_id, "%" + title + "%");
		}

		
		public int getNextval() {
			String sql = "SELECT post_seq.NEXTVAL FROM DUAL";
			return jdbc.queryForObject(sql, Integer.class);
		}
}