package com.ssafy.service;

import java.sql.SQLException;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.domain.InterestArea;
import com.ssafy.domain.SidoGugunCode;
import com.ssafy.mapper.InterestAreaDAO;

@Service
public class InterestAreaServiceImpl implements InterestAreaService {

	private InterestAreaDAO interestAreaDao;

	@Autowired
	public void setInterestAreaDao(InterestAreaDAO interestAreaDao) {
		this.interestAreaDao = interestAreaDao;
	}

	//관심 지역 삭제
	@Override
	public boolean deleteInterestArea(String ino) throws SQLException {
		return interestAreaDao.delete(ino) > 0;
	}

	// 대표 관심 지역 등록
	@Override
	public boolean registerInterestArea(String userId, String dong_code) throws SQLException {
		return interestAreaDao.insert(userId,dong_code) > 0;
	}

	// 일반 관심 지역 등록
	@Override
	public int insertInterest(String userId, String dong_code) {
		return interestAreaDao.insertInterest(userId, dong_code);
	}

	//관심 지역 목록
	@Override
	public List<InterestArea> selectAllByUserId(String userId) throws Exception {
		return interestAreaDao.selectInterestAll(userId);
	}

	//대표 관심 지역 조회
	@Override
	public InterestArea selectInterestArea(String userId) {
		return interestAreaDao.selectInterestRep(userId);
	}


}
