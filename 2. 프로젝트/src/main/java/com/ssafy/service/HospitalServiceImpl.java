package com.ssafy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.domain.Hospital;
import com.ssafy.mapper.HospitalDAO;

@Service
public class HospitalServiceImpl implements HospitalService {

	private HospitalDAO hospitalDao;

	@Autowired
	public void setHospitalDao(HospitalDAO hospitalDao) {
		this.hospitalDao = hospitalDao;
	}

	@Override
	public List<Hospital> getHospitalInGugun(String gugun) throws Exception {
		System.out.println("!!");
		return hospitalDao.getHospitalInGugun(gugun);
	}

	@Override
	public List<Hospital> getHospitalByName(String hospitalName) throws Exception {
		return hospitalDao.getHospitalByName(hospitalName);
	}
}
