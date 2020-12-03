package com.ssafy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.mapper.NewsDAO;
import com.ssafy.domain.Criteria;
import com.ssafy.domain.News;
import com.ssafy.domain.Page;
import com.ssafy.domain.pageResult;

@Service
public class NewsServiceImpl implements NewsService {

	// 페이지네이션을 위한 pageService객체 삽입
	private PageService pageService;

	@Autowired
	public void setPageService(PageService pageService) {
		this.pageService = pageService;
	}

	private NewsDAO newsDao;

	@Autowired
	public void setNewsDao(NewsDAO newsDao) {
		this.newsDao = newsDao;
	}

	// 한 페이지에 나타날 개수
	private static final int pageCount = 10;

	// 한페이지의 리스트 수
	private static final int displayRow = 10;

	@Override
	public pageResult getNews(int page) throws Exception {
		int rowCount = newsDao.getTotalCount();

		System.out.println("rowCount: " + rowCount);

		Page pagenation = pageService.getPagination(page, rowCount, displayRow, pageCount);

		Criteria cri = new Criteria(displayRow, pagenation.getOffset());

		System.out.println("pagenation: " + cri.getDisplayRow() + " getOffset: " + cri.getOffset());
		List<News> NewsList = newsDao.getNewsWithPaging(cri);

		pageResult pageResult = new pageResult(pagenation);
		pageResult.setNews(NewsList);

		return pageResult;

	}

}
