package com.ssafy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.domain.HouseDeal;
import com.ssafy.domain.HouseInfo;
import com.ssafy.domain.SidoGugunCode;
import com.ssafy.domain.pageResult;
import com.ssafy.service.HospitalService;
import com.ssafy.service.HouseMapService;
import com.ssafy.service.ScreeningService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;

@CrossOrigin(origins = { "*" }, maxAge = 6000)
@RestController
@Api(value = "getAddressCode", description = "주소지에 관련된 코드를 얻어옴")
public class localAddressController {

	private HouseMapService houseMapService;

	@Autowired
	public void setHouseMapService(HouseMapService houseMapService) {
		this.houseMapService = houseMapService;
	}

	private HospitalService hospitalService;

	@Autowired
	public void setHospitalService(HospitalService hospitalService) {
		this.hospitalService = hospitalService;
	}

	private ScreeningService screeningService;

	@Autowired
	public void setScreeningService(ScreeningService screeningService) {
		this.screeningService = screeningService;
	}

	@ApiOperation(value = "act:시도,구군,동  / code: 코드")
	@ApiResponses({ @ApiResponse(code = 200, message = "OK !!"),
			@ApiResponse(code = 500, message = "Internal Server Error !!"),
			@ApiResponse(code = 404, message = "Not Found !!") })
	@GetMapping("/localcode/{act}/{code}")
	public ResponseEntity<List<SidoGugunCode>> getLocalCode(@PathVariable("act") String act,
			@PathVariable("code") String code) throws Exception {

		if ("sido".equals(act)) {
			return new ResponseEntity<List<SidoGugunCode>>(houseMapService.getSido(), HttpStatus.OK);
		} else if ("gugun".equals(act)) {
			return new ResponseEntity<List<SidoGugunCode>>(houseMapService.getGugunInSido(code), HttpStatus.OK);
		} else if ("dong".equals(act)) {
			return new ResponseEntity<List<SidoGugunCode>>(houseMapService.getDongInGugun(code), HttpStatus.OK);
		}

		return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@ApiOperation(value = "act:동 or 이름으로 검색  / code: 동 or 이름")
	@GetMapping("/aptinfo/{act}/{code}/{pageNum}")
	public ResponseEntity getAptInfo(@PathVariable("act") String act,
			@PathVariable("code") String code,@PathVariable("pageNum") int pageNum) throws Exception {

		if ("dong".equals(act)) {
			String dongName = houseMapService.getDongNameByCode(code);
			pageResult pageResult = houseMapService.getAptInDong(pageNum, dongName);
			return new ResponseEntity<pageResult>(pageResult, HttpStatus.OK);
		} else if ("name".equals(act)) {
			System.out.println("컨트롤러 들어옴: "+code);
			pageResult pageResult = houseMapService.getAptByName(pageNum,code);
			System.out.println(pageResult);
			return new ResponseEntity<pageResult>(pageResult, HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@ApiOperation(value = "act:동 or 이름으로 검색  / code: 동 or 이름")
	@GetMapping("/aptinfo/{act}/{code}")
	public ResponseEntity<List<HouseInfo>> getAptInfo(@PathVariable("act") String act,
			@PathVariable("code") String code) throws Exception {

		if ("dong".equals(act)) {
			String dongName = houseMapService.getDongNameByCode(code);
			return new ResponseEntity<List<HouseInfo>>(houseMapService.getAptInDong(dongName), HttpStatus.OK);
		} else if ("name".equals(act)) {
			System.out.println("컨트롤러 들어옴: "+code);
			return new ResponseEntity<List<HouseInfo>>(houseMapService.getAptByName(code), HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@ApiOperation(value = "aptname:아파트 이름  / dongcode: 동 이름")
	@GetMapping("/aptdeal/{aptname}/{dongcode}/{pageNum}")
	public ResponseEntity getAptDeal(@PathVariable("aptname") String aptname,
			@PathVariable("dongcode") String dongcode,@PathVariable("pageNum") int pageNum) throws Exception {
		pageResult pageResult = houseMapService.getAptDetail(pageNum, aptname, dongcode);
		return  new ResponseEntity<pageResult>(pageResult, HttpStatus.OK);
				
	}
}