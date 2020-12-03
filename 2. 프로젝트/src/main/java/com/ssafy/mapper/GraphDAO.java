package com.ssafy.mapper;

import java.util.List;

import com.ssafy.domain.Graph;

public interface GraphDAO {
	List<Graph> selectHouseDeals(String dong, String AptName) throws Exception;
}
