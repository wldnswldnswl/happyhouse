package com.ssafy.service;

import com.ssafy.domain.pageResult;

public interface NewsService {

	pageResult getNews(int page) throws Exception;
}