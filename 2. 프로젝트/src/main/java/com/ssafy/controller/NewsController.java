package com.ssafy.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.domain.pageResult;
import com.ssafy.service.NewsService;

@RestController
public class NewsController {
	private NewsService newsService;
	
	@Autowired
	public void setNewsService(NewsService newsService) {
		this.newsService = newsService;
	}
	
	@GetMapping("/news/default")
	public ResponseEntity<pageResult> getNewsListFirst() throws Exception {
		pageResult pageResult = newsService.getNews(1);
		return new ResponseEntity<pageResult>(pageResult, HttpStatus.OK);
	}
	
	@GetMapping("/news/{pageNum}")
	public ResponseEntity<pageResult> getNewsList(@PathVariable(required = false,name = "pageNum") int pageNum) throws Exception {
		pageResult pageResult = newsService.getNews(pageNum);
		return new ResponseEntity<pageResult>(pageResult, HttpStatus.OK);
	}

	
	
}

