package com.ssafy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ssafy.domain.InterestArea;
@Repository
@Mapper
public interface InterestAreaDAO {

	// 대표 관심 지역 등록
	int insert(String InteuserId,String dong_code);

	// 일반 관심지역 추가
	int insertInterest(String userId, String dong_code);
	
	// 관심 지역 삭제
	int delete(String ino);

	// 관심 지역 리스트
	List<InterestArea> selectInterestAll(String userid);

	// 대표 관심 지역 조회
	InterestArea selectInterestRep(String userId);

}
