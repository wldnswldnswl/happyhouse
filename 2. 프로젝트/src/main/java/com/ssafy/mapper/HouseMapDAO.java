package com.ssafy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.ssafy.domain.Criteria;
import com.ssafy.domain.HouseDeal;
import com.ssafy.domain.HouseInfo;
import com.ssafy.domain.SidoGugunCode;

@Repository
@Mapper
public interface HouseMapDAO {
	List<SidoGugunCode> getSido();

	List<SidoGugunCode> getGugunInSido(String sido);

	List<SidoGugunCode> getDongInGugun(String gugun);

	//아파트 정보 동으로 검색
	int getAptInDongCount(String dong);
	
	List<HouseInfo> getAptInDong(String dong);	
	
	List<HouseInfo> getAptInDongWithPaging(@Param("cri")Criteria cri,@Param("dong")String dong) ;

	//아파트 정보 이름으로 검색
	int getAptByNameCount(String name);
	
	List<HouseInfo> getAptByName(String name);
	
	List<HouseInfo> getAptByNameWithPaging(@Param("cri")Criteria cri,@Param("aptName")String aptName);
	
	
	
	//아파트 실거래 정보 검색
	int getAptDetail(String aptName, String dong);
	
	List<HouseDeal> getAptDetailWithPaging(@Param("cri")Criteria cri,@Param("aptName") String aptName, @Param("dong") String dong);
	
	//동 코드로 구군 이름 검색
	String getGugunNameByCode(String dongcode);
	
	//동 이름으로 동 코드 검색
	String getDongCodeByName(String name);

	//동이름 동 코드로 검색
	String getDongNameByCode(String code);

	// 주소(시,군,구 정보 가져오기)
	SidoGugunCode getAddress(String dongcode);
}
