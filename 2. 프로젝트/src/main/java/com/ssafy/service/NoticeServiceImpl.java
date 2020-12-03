package com.ssafy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.domain.Criteria;
import com.ssafy.domain.Notice;
import com.ssafy.domain.Page;
import com.ssafy.domain.pageResult;
import com.ssafy.mapper.NoticeDAO;

@Service
public class NoticeServiceImpl implements NoticeService {

	// 페이지네이션을 위한 pageService객체 삽입
	private PageService pageService;

	@Autowired
	public void setPageService(PageService pageService) {
		this.pageService = pageService;
	}

	private NoticeDAO noticeDao;

	@Autowired
	public void setNoticeDao(NoticeDAO noticeDao) {
		this.noticeDao = noticeDao;
	}

	// 한 페이지에 나타날 개수
	private static final int pageCount = 5;

	// 한페이지의 리스트 수
	private static final int displayRow = 5;

	@Override
	public pageResult getNotices(int page) throws Exception {
		int rowCount = noticeDao.getTotalCount();

		Page pagenation = pageService.getPagination(page, rowCount, displayRow, pageCount);

		Criteria cri = new Criteria(displayRow, pagenation.getOffset());

		System.out.println("pagenation: " + cri.getDisplayRow() + " getOffset: " + cri.getOffset());
		List<Notice> NoticeList = noticeDao.getNoticesWithPaging(cri);

		pageResult pageResult = new pageResult(pagenation);
		pageResult.setNotice(NoticeList);

		return pageResult;
	}

	@Override
	public Notice getNotice(String idx) throws Exception {
		return noticeDao.selectNotice(idx);
	}

	@Override
	public boolean registerNotice(Notice notice) throws Exception {
		return noticeDao.setNotice(notice);
	}

	@Override
	public boolean updateNotice(Notice notice) throws Exception {
		return noticeDao.updateNotice(notice);
	}

	@Override
	public boolean deleteNotice(String idx) throws Exception {
		return noticeDao.deleteNotice(idx);
	}

	@Override
	public int getTotal() throws Exception {
		return noticeDao.getTotalCount();
	}

}
