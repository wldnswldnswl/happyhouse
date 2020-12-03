package com.ssafy.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.domain.DealReview;
import com.ssafy.service.SignalService;

@RestController
public class SignalController {
	private SignalService signalService;
	
	@Autowired
	public void setSignalService(SignalService signalService) {
		this.signalService = signalService;
	}
	
	@GetMapping("/signal")
	public ResponseEntity<String> setSignals(String id) throws Exception {
		List<DealReview> dealReviews = signalService.getDealReviews(id);
		System.out.println(dealReviews.size());
		return new ResponseEntity<String>(String.valueOf(dealReviews.size()), HttpStatus.OK);
	}
	@GetMapping("/signal/popup")
	public ResponseEntity<List<DealReview>> getSignals(String id) throws Exception {
		List<DealReview> dealReviews = signalService.getDealReviews(id);
		System.out.println(dealReviews);
		return new ResponseEntity<List<DealReview>>(dealReviews, HttpStatus.OK);
	}
	@GetMapping("/signal/dealReview.do")
	public ResponseEntity<Integer> dealReviewPageByModal(String id) throws Exception {
		boolean flag = signalService.update(id);
		System.out.println("update");
		return new ResponseEntity<Integer>(flag? 1:0, HttpStatus.OK);
	}
}
