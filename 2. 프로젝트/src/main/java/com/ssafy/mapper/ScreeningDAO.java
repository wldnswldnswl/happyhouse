package com.ssafy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ssafy.domain.Screening;

@Repository
@Mapper
public interface ScreeningDAO {
	List<Screening> getScreeningInGugun(String gugun);

	List<Screening> getScreeningByName(String screeningName);
}
