package com.ssafy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.domain.BizCategory;
import com.ssafy.domain.BizInfo;
import com.ssafy.mapper.BizInfoDAO;

@Service
public class BizInfoServiceImpl implements BizInfoService {

	private BizInfoDAO bizInfoDao;

	@Autowired
	public void setBizInfoDao(BizInfoDAO bizInfoDao) {
		this.bizInfoDao = bizInfoDao;
	}

	@Override
	public List<BizCategory> getLargeCategory() throws Exception {
		return bizInfoDao.getLarge();
	}

	@Override
	public List<BizCategory> getMidCategory(String large_code) throws Exception {
		return bizInfoDao.getMidInLarge(large_code);
	}

	@Override
	public List<BizCategory> getSmallCategory(String mid_code) throws Exception {
		return bizInfoDao.getSmallInMid(mid_code);
	}

	@Override
	public List<BizInfo> getBizList(String dong_name, String small_code) {
		return bizInfoDao.getBizList(dong_name, small_code);
	}

	@Override
	public List<BizInfo> getBizListByDong(String dong_code) {
		return bizInfoDao.getBizListByDong(dong_code);
	}

	@Override
	public List<BizInfo> getBizListByCategory(String small_code) {
		return bizInfoDao.getBizListByCategory(small_code);
	}

}
