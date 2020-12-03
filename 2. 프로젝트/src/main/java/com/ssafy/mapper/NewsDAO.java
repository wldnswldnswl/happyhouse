package com.ssafy.mapper;

import java.util.List;

import com.ssafy.domain.Criteria;
import com.ssafy.domain.News;

public interface NewsDAO {

	List<News> getNewsWithPaging(Criteria cri) throws Exception;
	int getTotalCount() throws Exception;

}