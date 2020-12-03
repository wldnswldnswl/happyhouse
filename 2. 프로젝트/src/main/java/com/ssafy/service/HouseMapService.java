package com.ssafy.service;

import java.util.List;

import com.ssafy.domain.HouseDeal;
import com.ssafy.domain.HouseInfo;
import com.ssafy.domain.SidoGugunCode;
import com.ssafy.domain.pageResult;

public interface HouseMapService {

	List<SidoGugunCode> getSido() throws Exception;

	List<SidoGugunCode> getGugunInSido(String sido) throws Exception;

	List<SidoGugunCode> getDongInGugun(String gugun) throws Exception;

	
	//아파트 정보 동으로 불러오기
	List<HouseInfo> getAptInDong(String dong) throws Exception;
	int getAptInDongCount(String dong) throws Exception;
	pageResult getAptInDong(int page,String dong) throws Exception;

	//아파트 정보 아파트 이름으로 불러오기
	List<HouseInfo> getAptByName(String aptName) throws Exception;
	int getAptByNameCount(String aptName) throws Exception;
	pageResult getAptByName(int page,String name) throws Exception;
	
	//아파트 실거래가 불러오기
	int getAptDetail(String aptName, String dong) throws Exception;
	pageResult getAptDetail(int page,String name,String dong) throws Exception;
	
	// 동코드로 모든 시,군,구 이름/코드 조회
	SidoGugunCode getAddress(String dongcode);
	
	String getDongNameByCode(String code) throws Exception;
	
	String getDongCodeByName(String name) throws Exception;

	String getGugunNameByCode(String guguncode) throws Exception;
}
