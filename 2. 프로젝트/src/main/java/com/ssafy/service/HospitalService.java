package com.ssafy.service;

import java.util.List;

import com.ssafy.domain.Hospital;

public interface HospitalService {
	List<Hospital> getHospitalInGugun(String gugun) throws Exception;

	List<Hospital> getHospitalByName(String hospitalName) throws Exception;
}
