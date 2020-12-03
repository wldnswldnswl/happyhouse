package com.ssafy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.domain.Criteria;
import com.ssafy.domain.HouseDeal;
import com.ssafy.domain.HouseInfo;
import com.ssafy.domain.Page;
import com.ssafy.domain.SidoGugunCode;
import com.ssafy.domain.pageResult;
import com.ssafy.mapper.HouseMapDAO;

@Service
public class HouseMapServiceImpl implements HouseMapService {

	// 페이지네이션을 위한 pageService객체 삽입
	private PageService pageService;

	@Autowired
	public void setPageService(PageService pageService) {
		this.pageService = pageService;
	}

	// 한 페이지에 나타날 개수
	private static final int pageCount = 5;

	// 한페이지의 리스트 수
	private static final int displayRow = 5;

	private HouseMapDAO houseMapDao;

	@Autowired
	public void setHouseMapDao(HouseMapDAO houseMapDao) {
		this.houseMapDao = houseMapDao;
	}

	@Override
	public List<SidoGugunCode> getSido() throws Exception {
		System.out.println();
		return houseMapDao.getSido();
	}

	@Override
	public List<SidoGugunCode> getGugunInSido(String sido) throws Exception {
		return houseMapDao.getGugunInSido(sido);
	}

	@Override
	public List<SidoGugunCode> getDongInGugun(String gugun) throws Exception {
		return houseMapDao.getDongInGugun(gugun);
	}

	// 동으로 검색된 데이터의 개수를 리턴
	@Override
	public int getAptInDongCount(String dong) throws Exception {
		return houseMapDao.getAptInDongCount(dong);
	}
	
	@Override
	public List<HouseInfo> getAptInDong(String dong) throws Exception {
		return houseMapDao.getAptInDong(dong);
	}

	// 동으로 검색된 데이터를 페이징 처리해서 리턴
	@Override
	public pageResult getAptInDong(int page, String dong) throws Exception {

		int rowCount = getAptInDongCount(dong);

		Page pagenation = pageService.getPagination(page, rowCount, displayRow, pageCount);

		Criteria cri = new Criteria(displayRow, pagenation.getOffset());

		List<HouseInfo> searchedList = houseMapDao.getAptInDongWithPaging(cri, dong);

		pageResult pageResult = new pageResult(pagenation);
		pageResult.setHouseInfo(searchedList);

		return pageResult;
	}

	// 이름으로 검색된 데이터의 개수를 리턴
	@Override
	public int getAptByNameCount(String aptName) throws Exception {
		return houseMapDao.getAptByNameCount(aptName);
	}
	
	@Override
	public List<HouseInfo> getAptByName(String aptName) throws Exception {
		return houseMapDao.getAptByName(aptName);
	}

	// 이름으로 검색된 데이터를 페이징 처리해서 리턴
	@Override
	public pageResult getAptByName(int page, String name) throws Exception {
		int rowCount = getAptByNameCount(name);

		Page pagenation = pageService.getPagination(page, rowCount, displayRow, pageCount);

		Criteria cri = new Criteria(displayRow, pagenation.getOffset());

		List<HouseInfo> searchedList = houseMapDao.getAptByNameWithPaging(cri, name);
		System.out.println("서비스 탐: " + searchedList);
		pageResult pageResult = new pageResult(pagenation);
		pageResult.setHouseInfo(searchedList);

		return pageResult;
	}

	// 검색한 실거래가 정보의 개수
	@Override
	public int getAptDetail(String aptName, String dong) throws Exception {
		return houseMapDao.getAptDetail(aptName, dong);
	}

	// 이름으로 검색된 데이터를 페이징 처리해서 리턴
	@Override
	public pageResult getAptDetail(int page, String name, String dong) throws Exception {
		int rowCount = getAptDetail(name, dong);

		Page pagenation = pageService.getPagination(page, rowCount, displayRow, pageCount);

		Criteria cri = new Criteria(displayRow, pagenation.getOffset());

		List<HouseDeal> searchedList = houseMapDao.getAptDetailWithPaging(cri, name, dong);
		System.out.println("서비스 탐: " + searchedList);
		pageResult pageResult = new pageResult(pagenation);
		pageResult.setHouseDeal(searchedList);

		return pageResult;
	}

	@Override
	public String getDongNameByCode(String code) throws Exception {
		return houseMapDao.getDongNameByCode(code);
	}

	@Override
	public String getGugunNameByCode(String guguncode) throws Exception {
		return houseMapDao.getGugunNameByCode(guguncode);
	}

	@Override
	public String getDongCodeByName(String name) throws Exception {
		return houseMapDao.getDongCodeByName(name);
	}

	@Override
	public SidoGugunCode getAddress(String dongcode) {
		System.out.println("dongcode: " + dongcode);
		SidoGugunCode result = houseMapDao.getAddress(dongcode);
		result.setGugunCode(dongcode.substring(0, 4));
		result.setSidoCode(dongcode.substring(0, 2));

		return result;
	}

	

	

}
