package com.ssafy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.domain.Screening;
import com.ssafy.mapper.ScreeningDAO;

@Service
public class ScreeningServiceImpl implements ScreeningService {

	private ScreeningDAO screeningDao;

	@Autowired
	public void setScreeningDao(ScreeningDAO screeningDao) {
		this.screeningDao = screeningDao;
	}

	@Override
	public List<Screening> getScreeninginGugun(String gugun) throws Exception {
		return screeningDao.getScreeningInGugun(gugun);
	}

	@Override
	public List<Screening> getScreeningByName(String screeningName) throws Exception {
		return screeningDao.getScreeningByName(screeningName);
	}

}
