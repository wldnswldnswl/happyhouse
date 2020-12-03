package com.ssafy.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.domain.Criteria;
import com.ssafy.domain.DealReview;
import com.ssafy.domain.Page;
import com.ssafy.domain.pageResult;
import com.ssafy.mapper.DealReviewDAO;

@Service
public class DealReviewServiceImpl implements DealReviewService {

	private DealReviewDAO reviewDao;

	@Autowired
	public void setDealReviewDao(DealReviewDAO reviewDao) {
		this.reviewDao = reviewDao;
	}
	
	@Override
	public boolean registerDealReview(DealReview vo) throws Exception {
		return reviewDao.setDealReview(vo);
	}

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

	@Override
	public pageResult getDealReviews(int page) throws Exception {
		int rowCount = reviewDao.getTotalCount(null);//전체 게시글 조회 (파라미터 null - 관심지역이 없다는 뜻)

		Page pagenation = pageService.getPagination(page, rowCount, displayRow, pageCount);

		Criteria cri = new Criteria(displayRow, pagenation.getOffset());
		System.out.println("DDD: "+rowCount);
		System.out.println("pagenation: " + cri.getDisplayRow() + " getOffset: " + cri.getOffset());
		List<DealReview> DealReviewList = reviewDao.getDealReviewsWithPaging(cri);

		pageResult pageResult = new pageResult(pagenation);
		pageResult.setReview(DealReviewList);

		return pageResult;
	}

	@Override
	//관심 게시글만 조회
	public pageResult getInterestDealReviews(int page,List<String> dong_list) throws Exception {
		System.out.println("null: "+dong_list);
		int rowCount = reviewDao.getTotalCount(dong_list);
		
		
		System.out.println("관심rowCount: "+rowCount);
		Page pagenation = pageService.getPagination(page, rowCount, displayRow, pageCount);

		Map<String,Object> params = new HashMap<String,Object>();
		Criteria cri = new Criteria(displayRow, pagenation.getOffset());
		System.out.println("관심 pagenation: " + cri.getDisplayRow() + " getOffset: " + cri.getOffset());
		
		params.put("page",cri);
		params.put("dong_list",dong_list);
	
		//최종 쿼리 결과
		List<DealReview> DealReviewList = reviewDao.getInterestDealReviewsWithPaging(params);
		pageResult pageResult = new pageResult(pagenation);
		pageResult.setReview(DealReviewList);

		return pageResult;
	}

	
	@Override
	public DealReview getDealReview(String idx) throws Exception {
		return reviewDao.selectDealReview(idx);
	}

	@Override
	public boolean updateDealReview(DealReview DealReview) throws Exception {
		return reviewDao.updateDealReview(DealReview);
	}

	@Override
	public boolean deleteDealReview(String idx) throws Exception {
		return reviewDao.deleteDealReview(idx);
	}

	@Override
	public int getTotal() throws Exception {
		return reviewDao.getTotalCount(null);//전체 게시글 조회
	}


}
