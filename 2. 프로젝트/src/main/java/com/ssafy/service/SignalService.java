package com.ssafy.service;

import java.util.List;

import com.ssafy.domain.DealReview;

public interface SignalService {

	List<DealReview> getDealReviews(String id) throws Exception;
	public boolean update(String id) throws Exception;
}