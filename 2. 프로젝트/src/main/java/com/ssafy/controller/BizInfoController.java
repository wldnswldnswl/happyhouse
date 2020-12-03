package com.ssafy.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.domain.BizCategory;
import com.ssafy.domain.BizInfo;
import com.ssafy.domain.Screening;
import com.ssafy.service.BizInfoService;

@CrossOrigin(origins = { "*" }, maxAge = 6000)
@RestController
@RequestMapping("/biz")
public class BizInfoController {

	private BizInfoService bizInfoService;

	@Autowired
	public void BizInfoService(BizInfoService bizInfoService) {
		this.bizInfoService = bizInfoService;
	}


	@GetMapping("/large")
	public ResponseEntity<List<BizCategory>> BizLargeCategory() throws Exception {
		return new ResponseEntity<List<BizCategory>>(bizInfoService.getLargeCategory(), HttpStatus.OK);
	}

	@GetMapping("/mid")
	public ResponseEntity<List<BizCategory>> BizMidCategory(@RequestParam("large_code") String large_code) throws Exception {
		return new ResponseEntity<List<BizCategory>>(bizInfoService.getMidCategory(large_code), HttpStatus.OK);
	}
	
	@GetMapping("/small")
	public ResponseEntity<List<BizCategory>> BizSmallCategory(@RequestParam("mid_code") String mid_code) throws Exception {
		System.out.println("검색 코드: "+mid_code);
		System.out.println("small data: "+bizInfoService.getSmallCategory(mid_code));
		return new ResponseEntity<List<BizCategory>>(bizInfoService.getSmallCategory(mid_code), HttpStatus.OK);
	}
	
	
	@GetMapping("/all")
	public ResponseEntity<List<BizInfo>> getBizList(@RequestParam("dong_code") String dong_code, @RequestParam("small_code") String small_code) throws Exception {
		List<BizInfo> result = new ArrayList<BizInfo>();
		System.out.println("dong_code: "+dong_code+" small_code: "+small_code);
		if(dong_code.trim().length() != 0 && small_code.trim().length() != 0) {
			System.out.println("both: dongcode-"+dong_code+" small_code- "+small_code+"길이: "+small_code.trim().length());
			result = bizInfoService.getBizList(dong_code,small_code);
		}else if(dong_code.trim().length() != 0 && small_code.trim().length() == 0) {
			System.out.println("small_code is null");
			result = bizInfoService.getBizListByDong(dong_code);
		}else if(dong_code.trim().length() == 0 && small_code.trim().length() != 0) {
			System.out.println("dong_code is null");
			result = bizInfoService.getBizListByCategory(small_code);
		}
		System.out.println("result: "+result);
		return new ResponseEntity<List<BizInfo>>(result, HttpStatus.OK);
	}

}
