package com.ssafy.service;

import org.springframework.stereotype.Service;

import com.ssafy.domain.Page;

@Service
public class PageServiceImpl implements PageService {

	@Override
	public Page getPagination(int page, int rowCount, int displayrow, int pagecount) {
		
		int startPage,endPage,lastPage,offset;

		startPage = (page - 1) / pagecount * pagecount + 1;

		endPage = startPage + pagecount - 1;

		offset = (page - 1) * displayrow;

		lastPage = (rowCount / displayrow) + 1;

		if (rowCount % displayrow == 0) {
			lastPage--;
		}

		if (endPage > lastPage) {
			endPage = lastPage;
		}

		return new Page(startPage,endPage,page,lastPage,pagecount,rowCount,displayrow,offset);
	}

}
