package com.ssafy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.domain.DealReview;
import com.ssafy.mapper.SignalDAO;

@Service
public class SignalServiceImpl implements SignalService {
	private SignalDAO signalDao;
	
	@Autowired
	public void setSignalDao(SignalDAO signalDao) {
		this.signalDao = signalDao;
	}
	
	@Override
	public List<DealReview> getDealReviews(String id) throws Exception {
		return signalDao.getDealReviews(id);
	}
	@Override
	public boolean update(String id) throws Exception {
		return signalDao.update(id) > 0;
	}
}
