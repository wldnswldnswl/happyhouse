package com.ssafy.service;

import java.util.List;

import com.ssafy.domain.Screening;

public interface ScreeningService {
	List<Screening> getScreeninginGugun(String gugun) throws Exception;

	List<Screening> getScreeningByName(String hospitalName) throws Exception;
}