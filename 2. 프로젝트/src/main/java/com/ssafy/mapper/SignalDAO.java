package com.ssafy.mapper;

import java.util.List;

import com.ssafy.domain.DealReview;

public interface SignalDAO {
	List<DealReview> getDealReviews(String id) throws Exception;
	int update(String id) throws Exception;
}
