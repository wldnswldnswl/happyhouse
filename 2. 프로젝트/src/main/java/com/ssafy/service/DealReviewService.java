package com.ssafy.service;

import java.util.List;

import com.ssafy.domain.DealReview;
import com.ssafy.domain.SidoGugunCode;
import com.ssafy.domain.pageResult;

public interface DealReviewService {

	boolean registerDealReview(DealReview vo) throws Exception;

	public pageResult getDealReviews(int page) throws Exception;
	
	public pageResult getInterestDealReviews(int page,List<String> dong_list) throws Exception;

	public DealReview getDealReview(String idx) throws Exception;

	public boolean updateDealReview(DealReview DealReview) throws Exception;

	boolean deleteDealReview(String idx) throws Exception;

	public int getTotal() throws Exception;

}
