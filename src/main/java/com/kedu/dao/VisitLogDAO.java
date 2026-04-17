package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.AgeVisitDTO;
import com.kedu.dto.DailyVisitDTO;
import com.kedu.dto.GenderVisitDTO;

@Repository
public class VisitLogDAO {

	@Autowired
	private JdbcTemplate jdbc;
	
	public int existsToday(String mem_id) { // 방문 이력 확인 select
		String sql = "select count(*) from visit_log where mem_id =?";
		return jdbc.queryForObject(sql, Integer.class, mem_id);
	}
	
	public int insertTodayVisit(String mem_id) { // 방문자 통계를 위한 insert
		String sql = "insert into visit_log(visit_seq, mem_id, post_category,"
				+ "mem_gender, mem_ssn, visit_date)"
				+ "select visit_log_seq.nextval, mem_id, 'login', mem_gender, mem_ssn, sysdate "
				+ "from members where mem_id=?";
		return jdbc.update(sql, mem_id);
	}
	
	public int getTodayVisitCount() { // 일별방문자수 id당 1번만 계산
		String sql = "select count(distinct mem_id) from visit_log where trunc(visit_date) = trunc(sysdate)";
        return jdbc.queryForObject(sql, Integer.class);
	}
	
	public List<DailyVisitDTO> getDailyVisitCount(){ // 일별방문자 대시보드 통계
		String sql = "select d.day as day,"
				+ "nvl(v.total_count, 0) as totalCount,"
				+ "nvl(m.new_count, 0) as newCount "
				+ "from (select lpad(level, 2, '0') as day "
				+ "from dual connect by level <= 31) d "
				+ "left join ( select to_char(visit_date, 'DD') as day,"
				+ "count(distinct mem_id) as total_count "
				+ "from visit_log "
				+ "where to_char(visit_date, 'YYYY-MM') = to_char(sysdate, 'YYYY-MM') "
				+ "group by to_char(visit_date, 'DD') "
				+ ") v on d.day = v.day "
				+ "left join ( select to_char(mem_join_date, 'DD') as day,"
				+ "count(*) as new_count "
				+ "from members "
				+ "where to_char(mem_join_date, 'YYYY-MM') = to_char(sysdate, 'YYYY-MM') "
				+ "group by to_char(mem_join_date, 'DD') "
				+ ") m on d.day = m.day order by d.day";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<DailyVisitDTO>(DailyVisitDTO.class));
	}
	
	public List<GenderVisitDTO> getGenderCount(){ // 총 회원 성별 대시보드 통계
		String sql = "select mem_gender as gender,"
				+ "count(*) as count "
				+ "from members "
				+ "group by mem_gender";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<GenderVisitDTO>(GenderVisitDTO.class));
	}
	
	public List<AgeVisitDTO> getAgeCount(){ // 총 회원 연령대별 대시보드 통계
		String sql = "select age_group as ageGroup, count(*) as count "
				+ "from ( select case "
				+ "when age between 10 and 19 then '10대' "
				+ "when age between 20 and 29 then '20대' "
				+ "when age between 30 and 39 then '30대' "
				+ "when age between 40 and 49 then '40대' "
				+ "else '40대 이상' "
				+ "end as age_group "
				+ "from ( select floor(months_between(sysdate, "
				+ "to_date( case "
				+ "when substr(replace(mem_ssn, '-', ''), 7, 1) in ('1', '2') "
				+ "then '19' || substr(replace(mem_ssn, '-', ''), 1, 6) "
				+ "when substr(replace(mem_ssn, '-', ''), 7, 1) in ('3', '4') "
				+ "then '20' || substr(replace(mem_ssn, '-', ''), 1, 6) "
				+ "end, 'yyyymmdd') "
				+ ") / 12) as age "
				+ "from members "
				+ "where mem_ssn is not null "
				+ "and length(replace(mem_ssn, '-', '')) = 13 "
				+ "and substr(replace(mem_ssn, '-', ''), 3, 2) between '01' and '12' "
				+ "and substr(replace(mem_ssn, '-', ''), 5, 2) between '01' and '31' "
				+ "and substr(replace(mem_ssn, '-', ''), 7, 1) in ('1','2','3','4') "
				+ ")) "
				+ "group by age_group "
				+ "order by age_group ";
		
		return jdbc.query(sql, new BeanPropertyRowMapper<AgeVisitDTO>(AgeVisitDTO.class));	
	}
	
	public int postClickVisit(String mem_id, String post_category) {
		String sql = "insert into visit_log(visit_seq, mem_id, post_category, "
				+ "mem_gender, mem_ssn, visit_date) "
				+ "select visit_log_seq.nextval, mem_id, ? , mem_gender, mem_ssn, sysdate "
				+ "from members where mem_id = ?";
		
		return jdbc.update(sql, post_category, mem_id);
	}
}