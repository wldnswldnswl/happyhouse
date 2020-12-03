package com.ssafy.service;

import java.util.List;

import com.ssafy.domain.Graph;

public interface GraphService {

	List<Graph> selectHouseDeals(String dong, String AptName) throws Exception;

}