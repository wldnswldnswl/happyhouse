package com.ssafy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.ssafy.domain.Criteria;
import com.ssafy.domain.Notice;

@Repository
@Mapper
public interface NoticeDAO {
	// 공지사항 목록 불러옴
	List<Notice> getNotices() throws Exception;

	// 공지사항 목록 페이징 처리
	List<Notice> getNoticesWithPaging(Criteria cri) throws Exception;

	// 게시물의 총 개수
	int getTotalCount() throws Exception;

	// 공지사항 등록
	boolean setNotice(Notice notice) throws Exception;

	// 공지사항 데이터 불러옴
	Notice selectNotice(String idx) throws Exception;

	// 공지사항 수정
	boolean updateNotice(Notice notice) throws Exception;

	// 공지사항 삭제
	boolean deleteNotice(String idx) throws Exception;
}
