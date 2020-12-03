package com.ssafy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ssafy.domain.Criteria;
import com.ssafy.domain.DealReview;

@Repository
@Mapper
public interface DealReviewDAO {
	// 공지사항 목록 불러옴
	List<DealReview> getDealReviews() throws Exception;

	// 관심지역 후기만 불러옴
	List<DealReview> getInterestDealReviews(Map<String,Object> params) throws Exception;
	
	// 공지사항 목록 페이징 처리
	List<DealReview> getDealReviewsWithPaging(Criteria cri) throws Exception;

	// 관심글 페이징 처리
//	List<DealReview> getInterestDealReviewsWithPaging(Criteria cri);
	List<DealReview> getInterestDealReviewsWithPaging(Map<String,Object> params);

	// 게시물의 총 개수
	// 관심지역이 있으면 관심지역에 해당하는 개시글의 개수만 세어준다.
	int getTotalCount(List<String> dong_list) throws Exception;

	// 공지사항 등록
	boolean setDealReview(DealReview review) throws Exception;

	// 공지사항 데이터 불러옴
	DealReview selectDealReview(String idx) throws Exception;

	// 공지사항 수정
	boolean updateDealReview(DealReview review) throws Exception;

	// 공지사항 삭제
	boolean deleteDealReview(String idx) throws Exception;

}
