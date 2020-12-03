package com.ssafy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ssafy.domain.Hospital;

@Mapper
public interface HospitalDAO {

	List<Hospital> getHospitalInGugun(String gugun);

	List<Hospital> getHospitalByName(String hospitalName);

}
