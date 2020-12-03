package com.ssafy.service;

import com.ssafy.domain.Notice;
import com.ssafy.domain.pageResult;

public interface NoticeService {

	public pageResult getNotices(int page) throws Exception;

	public Notice getNotice(String idx) throws Exception;

	public boolean registerNotice(Notice notice) throws Exception;

	public boolean updateNotice(Notice notice) throws Exception;

	boolean deleteNotice(String idx) throws Exception;

	public int getTotal() throws Exception;

}
