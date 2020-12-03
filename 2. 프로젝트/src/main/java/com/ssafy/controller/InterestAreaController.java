package com.ssafy.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.domain.InterestArea;
import com.ssafy.domain.SidoGugunCode;
import com.ssafy.service.HouseMapService;
import com.ssafy.service.InterestAreaService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
//insertInterest.do
@RestController
@CrossOrigin(origins = { "*" }, maxAge = 6000)
@Api(value = "Interest Info", description = "관심 정보")
public class InterestAreaController {
		
	
	private InterestAreaService interestAreaService;
	
	@Autowired
	public void setInterestAreaService(InterestAreaService interestAreaService) {
		this.interestAreaService = interestAreaService;
	}
	
	private HouseMapService houseMapService;

	@Autowired
	public void setHouseMapService(HouseMapService houseMapService) {
		this.houseMapService = houseMapService;
	}
	
	@ApiOperation(value = "관심 지역 데이터 삭제")
	@ApiResponses({ @ApiResponse(code = 200, message = "OK !!"),
			@ApiResponse(code = 500, message = "Internal Server Error !!"),
			@ApiResponse(code = 404, message = "Not Found !!") })
	@DeleteMapping("/interestarea/{ino}")
	public ResponseEntity<String> registerInterst(@PathVariable("ino") String ino) throws SQLException
	{
		boolean result = interestAreaService.deleteInterestArea(ino);
		return result==true? new ResponseEntity<String>("success",HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@ApiOperation(value = "대표 관심 지역 조회(showRepInterst): 동코드 조회만 진행, showInterst()랑 다름")
	@ApiResponses({ @ApiResponse(code = 200, message = "OK !!"),
			@ApiResponse(code = 500, message = "Internal Server Error !!"),
			@ApiResponse(code = 404, message = "Not Found !!") })
	@GetMapping("/interestarea/{id}")
	public ResponseEntity<InterestArea> showRepInterst(@PathVariable String id) throws SQLException
	{
		InterestArea rep = interestAreaService.selectInterestArea("id");
		return new ResponseEntity<InterestArea>(rep,HttpStatus.OK);
	}
	
	@ApiOperation(value = "대표,일반 관심 지역 조회(showInterst): 조회 후 텍스트로 변환까지 진행, showRepInterst()랑 다름")
	@ApiResponses({ @ApiResponse(code = 200, message = "OK !!"),
			@ApiResponse(code = 500, message = "Internal Server Error !!"),
			@ApiResponse(code = 404, message = "Not Found !!") })
	@GetMapping("/interestarea/{id}/all")
	public ResponseEntity<List<SidoGugunCode>> showInterst(@PathVariable String id) throws Exception
	{
		List<InterestArea> list = interestAreaService.selectAllByUserId(id);
		List<SidoGugunCode> result = new ArrayList<SidoGugunCode>();
		for (InterestArea cur_area : list) {
			SidoGugunCode address = houseMapService.getAddress(cur_area.getLocalNumber());
			result.add(address);
		}
		System.out.println("관심지역 정보: "+result);
		return new ResponseEntity<List<SidoGugunCode>>(result,HttpStatus.OK);
	}
	
	
	@ApiOperation(value = "관심 지역 추가")
	@ApiResponses({ @ApiResponse(code = 200, message = "OK !!"),
			@ApiResponse(code = 500, message = "Internal Server Error !!"),
			@ApiResponse(code = 404, message = "Not Found !!") })
	@PostMapping("/interestarea/{dongcode}")
	public @ResponseBody boolean addInterest(HttpSession session, @PathVariable String dongcode) throws SQLException
	{
		return interestAreaService.insertInterest((String)session.getAttribute("id"),dongcode) > 0;
	}

}
