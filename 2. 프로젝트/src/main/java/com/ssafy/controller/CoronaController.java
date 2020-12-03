package com.ssafy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.domain.Hospital;
import com.ssafy.domain.Screening;
import com.ssafy.service.HospitalService;
import com.ssafy.service.HouseMapService;
import com.ssafy.service.ScreeningService;

import io.swagger.annotations.Api;

@CrossOrigin(origins = { "*" }, maxAge = 6000)
@RestController
@Api(value = "Hospital Info", description = "병원 정보")
public class CoronaController {

	private HospitalService hospitalService;

	@Autowired
	public void setHospitalService(HospitalService hospitalService) {
		this.hospitalService = hospitalService;
	}

	private HouseMapService houseMapService;

	@Autowired
	public void setHouseMapService(HouseMapService houseMapService) {
		this.houseMapService = houseMapService;
	}

	private ScreeningService screeningService;

	@Autowired
	public void setScreeningService(ScreeningService screeningService) {
		this.screeningService = screeningService;
	}

	@GetMapping("/hospital/{gucode}")
	public ResponseEntity<List<Hospital>> getHospitalInfo(@PathVariable("gucode") String guCode) throws Exception {
		String gugun = (String) houseMapService.getGugunNameByCode(guCode);
		System.out.println("hospital: " + gugun);
		return new ResponseEntity<List<Hospital>>(hospitalService.getHospitalInGugun(gugun), HttpStatus.OK);
	}

	@GetMapping("/screening/{gucode}")
	public ResponseEntity<List<Screening>> getScreeingInfo(@PathVariable("gucode") String guCode) throws Exception {
		String gugun = (String) houseMapService.getGugunNameByCode(guCode);

		return new ResponseEntity<List<Screening>>(screeningService.getScreeninginGugun(gugun), HttpStatus.OK);
	}

}
