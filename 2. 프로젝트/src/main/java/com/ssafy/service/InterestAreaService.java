package com.ssafy.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.domain.InterestArea;
import com.ssafy.domain.Screening;
import com.ssafy.domain.SidoGugunCode;

public interface InterestAreaService {
	// 관심지역 삭제
	boolean deleteInterestArea(String ino) throws SQLException;
	
	// 대표 관심 지역 등록
	boolean registerInterestArea(String userId, String dong_code) throws SQLException;
	
	// 일반 관심 지역 등록
	int insertInterest(String userId, String dong_code) throws SQLException;
	
	//유저 아이디로 관심 지역 불러오기
	List<InterestArea> selectAllByUserId(String userid) throws Exception;

	//유저 아이디로 대표 관심 지역 불러오기
	InterestArea selectInterestArea(String userid);
		
}
