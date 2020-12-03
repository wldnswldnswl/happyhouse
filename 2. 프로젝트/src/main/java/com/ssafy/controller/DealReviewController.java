package com.ssafy.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.domain.DealReview;
import com.ssafy.domain.InterestArea;
import com.ssafy.domain.SidoGugunCode;
import com.ssafy.domain.pageResult;
import com.ssafy.service.DealReviewService;
import com.ssafy.service.HouseMapService;
import com.ssafy.service.InterestAreaService;

@RestController
@CrossOrigin(origins = { "*" }, maxAge = 6000)
//@Api(value = "게시물 CRUD", description = "게시물에 관련된 등록/수정/삭제/출력")
public class DealReviewController {

	private DealReviewService reviewService;

	@Autowired
	public void setDealReviewService(DealReviewService reviewService) {
		this.reviewService = reviewService;
	}

	private InterestAreaService interestService;

	@Autowired
	public void setInterestAreaService(InterestAreaService interestService) {
		this.interestService = interestService;
	}
	
	private HouseMapService houseMapService;
	
	@Autowired
	public void setHouseMapService(HouseMapService houseMapService) {
		this.houseMapService = houseMapService;
	}
	
	//게시물 등록
	@PostMapping("/dealReview/new")
	public ResponseEntity<String> registDealReview(@RequestBody DealReview vo) throws Exception {
		boolean result = reviewService.registerDealReview(vo);
		return result == true ? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//자료형 바뀜
	// get 유형1: 전체 게시글 출력
	@GetMapping("/dealReview/board/{pageNum}")
	public ResponseEntity<pageResult> getDealReview(@PathVariable(required = false,name = "pageNum") int pageNum) throws Exception {
		pageResult pageResult = reviewService.getDealReviews(pageNum);
		return new ResponseEntity<pageResult>(pageResult, HttpStatus.OK);
	}
	
	// get 유형2: 관심 게시글 출력
	@GetMapping("/dealReview/interest/{pageNum}")
	public ResponseEntity<pageResult> getInterestDealReview(@PathVariable(required = false,name = "pageNum") int pageNum,HttpSession session) throws Exception {
		String id = (String) session.getAttribute("id");
		List<InterestArea> areas = interestService.selectAllByUserId(id);
		List<String> dong_list = new ArrayList<String>();
		
		// 사용자의 관심 동코드 모음 (쿼리 파라미터로 넘길 값)
		for (InterestArea area: areas) {
			dong_list.add(area.getLocalNumber());
		}
		System.out.println("dong_list: "+dong_list);
		pageResult pageResult = reviewService.getInterestDealReviews(pageNum,dong_list);
		return new ResponseEntity<pageResult>(pageResult, HttpStatus.OK);
	}

	//특정 게시물 출력
	@GetMapping("/dealReview/{idx}")
	public ResponseEntity<DealReview> getDealReview(@PathVariable("idx") String idx) throws Exception {
		return new ResponseEntity<DealReview>(reviewService.getDealReview(idx), HttpStatus.OK);
	}

	//게시물 수정
	@PutMapping("/dealReview/{idx}")
	public ResponseEntity<String> updateDealReview(@PathVariable("idx") String idx, @RequestBody DealReview vo)
			throws Exception {
		boolean result = reviewService.updateDealReview(vo);
		return result == true ? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	//게시물 삭제
	@Transactional
	@DeleteMapping("/dealReview/{idx}")
	public ResponseEntity<String> deleteDealReview(@PathVariable("idx") String idx) throws Exception {
		boolean result = reviewService.deleteDealReview(idx);
		return result == true ? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//동코드를 문자열로 변환
	@GetMapping("/local/{dong_code}")
	public ResponseEntity<String> getLocalName(@PathVariable("dong_code") String dong_code)
			throws Exception {
		SidoGugunCode sgcode = houseMapService.getAddress(dong_code);
		System.out.println("sgcode:"+sgcode);
		return new ResponseEntity<String>(sgcode.getSidoName()+" "+sgcode.getGugunName()+" "+sgcode.getDongName(), HttpStatus.OK);
	}
}
