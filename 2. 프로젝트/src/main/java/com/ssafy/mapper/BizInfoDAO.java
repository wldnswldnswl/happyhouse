package com.ssafy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.domain.BizCategory;
import com.ssafy.domain.BizInfo;


@Mapper
public interface BizInfoDAO {

	List<BizCategory> getLarge();

	List<BizCategory> getMidInLarge(String large_code);

	List<BizCategory> getSmallInMid(String mid_code);

	List<BizInfo> getBizList(@Param("dong_code") String dong_code, @Param("small_code") String small_code);

	List<BizInfo> getBizListByDong(String dong_name);

	List<BizInfo> getBizListByCategory(String small_code);

}
