package com.ssafy.service;

import com.ssafy.domain.Page;

public interface PageService 
{
	Page getPagination(int page, int rowCount, int displayrow, int pagecount);
}
