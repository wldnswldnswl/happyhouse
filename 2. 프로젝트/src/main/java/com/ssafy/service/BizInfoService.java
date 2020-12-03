package com.ssafy.service;

import java.util.List;

import com.ssafy.domain.BizCategory;
import com.ssafy.domain.BizInfo;

public interface BizInfoService {
	
	/** 카테고리 조회 */
	
	// 대분류 조회
	List<BizCategory> getLargeCategory() throws Exception;

	// 중분류 조회
	List<BizCategory> getMidCategory(String large_code) throws Exception;

	// 소분류 조회
	List<BizCategory> getSmallCategory(String mid_code) throws Exception;

	
	/** 조건별 상권 조회 */
	
	// 동코드, 상권코드로 검색
	List<BizInfo> getBizList(String dong_name, String small_code);

	// 동코드로 검색
	List<BizInfo> getBizListByDong(String dong_code);

	// 상권 코드로 검색
	List<BizInfo> getBizListByCategory(String small_code);

}
