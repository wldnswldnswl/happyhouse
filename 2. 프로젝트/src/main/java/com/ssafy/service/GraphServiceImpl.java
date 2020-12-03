package com.ssafy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.domain.Graph;
import com.ssafy.mapper.GraphDAO;

@Service
public class GraphServiceImpl implements GraphService {
	private GraphDAO graphDao;
	
	@Autowired
	public void setGraphDao(GraphDAO graphDao) {
		this.graphDao = graphDao;
	}
	
	@Override
	public List<Graph> selectHouseDeals(String dong, String AptName) throws Exception{
		return graphDao.selectHouseDeals(dong, AptName);
	}
}
