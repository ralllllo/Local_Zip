package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.SafetyFacilityDTO;

@Repository
public class SafetyFacilityDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public int insert(SafetyFacilityDTO dto) {
		String sql = "insert into safety_facility values(safety_facility_seq.nextval,?,?,?,?,?,?,?,sysdate)";
	
		return jdbc.update(sql, dto.getFac_type(), dto.getFac_name(), dto.getFac_address(), dto.getFac_numaddress()
				,dto.getFac_gu(), dto.getFac_lat(), dto.getFac_lng());
	}
	
	public int deleteByType(String facType) {
		String sql = "delete from safety_facility where fac_type = ?";
		
		return jdbc.update(sql, facType);
	}
	
	public List<SafetyFacilityDTO> selectPoliceWithoutCoords() {
        String sql = "select * from safety_facility "
                   + "where fac_type = ? and fac_lat = 0 and fac_lng = 0";
        return jdbc.query(sql,
                new BeanPropertyRowMapper<>(SafetyFacilityDTO.class),
                "치안시설");
    }

    public int updateLatLngBySeq(double fac_lat, double fac_lng, int fac_seq) {
        String sql = "update safety_facility set fac_lat = ?, fac_lng = ? where fac_seq = ?";
        return jdbc.update(sql, fac_lat, fac_lng, fac_seq);
    }
    
    public List<SafetyFacilityDTO> selectAll(){
    	String sql = "select * from safety_facility";
    	return jdbc.query(sql, new BeanPropertyRowMapper<SafetyFacilityDTO>(SafetyFacilityDTO.class));
    }
}