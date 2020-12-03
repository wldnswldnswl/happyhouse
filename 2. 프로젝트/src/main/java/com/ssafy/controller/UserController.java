
package com.ssafy.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.domain.InterestArea;
import com.ssafy.domain.SidoGugunCode;
import com.ssafy.domain.User;
import com.ssafy.service.HouseMapService;
import com.ssafy.service.InterestAreaService;
import com.ssafy.service.UserService;
import com.ssafy.util.GMailSender;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;

@RequestMapping("/user")
@Controller
public class UserController {

	private UserService userService;

	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	private HouseMapService houseMapService;

	@Autowired
	public void setHouseMapService(HouseMapService houseMapService) {
		this.houseMapService = houseMapService;
	}

	private InterestAreaService interestService;

	@Autowired
	public void setIntrestAreaService(InterestAreaService interestService) {
		this.interestService = interestService;
	}

	@GetMapping("/login.do")
	public String login(String id, String pwd, Model model, HttpSession session) throws SQLException {
		// 일단 아이디 혹은 비밀번호가 입력되었는지 확인
		System.out.println("로그인이 되려고 합니다!!");
		// 아이디가 입력되지 않는 경우
		if (id == null || id.trim().length() == 0) {
			model.addAttribute("errorMsg", "아이디를 입력하세요");
			return "login";
		}

		// 비밀 번호가 입력되지 않는 경우
		else if (pwd == null || pwd.trim().length() == 0) {
			model.addAttribute("errorMsg", "비밀번호를 입력하세요");
			return "login";
		}

		// 아이디, 비밀 번호 일치여부 판별
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pwd", pwd);

		String user_state = userService.login(map);

		if (user_state == null || user_state.trim().length() == 0 || user_state.equals("-1")) {// 로그인 실패
			model.addAttribute("errorMsg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return "login";
		} else { // 로그인 성공
			session.setAttribute("id", id); // 로그인 상태정보 유지
			System.out.println("user_state: " + user_state);
			session.setAttribute("user_state", Integer.parseInt(user_state)); // 로그인 상태정보 유지
			return "redirect:/";
		}
	}

	// 로그 아웃
	@GetMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	// 회원가입
	@PostMapping("register/{state}")
	public String registerUser(User user, @PathVariable("state") String state, Model model, HttpServletRequest request)
			throws Exception {
		request.setCharacterEncoding("utf-8");
		String dong_code = request.getParameter("dong");
		
		boolean result = userService.register(user);
		if (result) {
			System.out.println("회원가입 성공");
			userService.insertUserInterest(user.getId(), dong_code, "1");// 1:대표 관심지역
			userService.insertTimetable(user.getId());
			if (state.equals("member")) // 본인이 가입
				return "redirect:/"; // 메인
			else if (state.equals("admin")) // 관리자가 추가
				System.out.println("관리자가 추가");
			return "redirect:/userlist.do"; // 사용자 관리 페이지
		} else {
			System.out.println("회원가입 실패");
			model.addAttribute("errorMsg", "회원가입에 실패하였습니다.");
			return "registerForm";

		}
	}

	// 로그인 후 메인 페이지 이동
	@GetMapping("/loginForm.do")
	public String loginForm() {
		return "/";
	}

	// 회원가입 후 메인 페이지 이동
	@PostMapping("/registerForm.do")
	public String registerForm() {
		return "/";
	}

	// 비밀번호 찾기 (구현중)
	@ApiOperation(value = "email: 비밀번호를 찾을 사용자 이메일")
	@ApiResponses({ @ApiResponse(code = 200, message = "OK !!"),
			@ApiResponse(code = 500, message = "Internal Server Error !!"),
			@ApiResponse(code = 404, message = "Not Found !!") })
	@GetMapping("/findPwd")
	public @ResponseBody Map<String,String> findPwd(String email, String id) throws Exception {
		User user = userService.getUser(id);// fullname 한명만: 동명이인 처리 x
		Map<String,String> map = new HashMap<String, String>();

		if(email.equals(user.getEmail()) && id.equals(user.getId())) {//정보 일치하면 임시 비밀번호 전송
			// send mail
			GMailSender gMailSender = new GMailSender("happy.woongshouse@gmail.com", "zhzxzztbzpzzncvz"); // ssafyadmin!
			String pwd = gMailSender.getEmailCode();
			gMailSender.sendMail("HappyHouse 임시비밀번호 메일입니다.", user.getId() + "의 임시 비밀번호 : " + gMailSender.getEmailCode(),
					email);
			
			// change password
			user.setPwd(pwd);
			userService.updateUser(user);

			map.put("id",user.getId());
			map.put("email",user.getEmail());
		}else {
			map.put("errorMsg","정보가 일치하지 않습니다.");
		}
		
		return map;
	}

	// 세션 종료
	@GetMapping("/destroy.do")
	public String destroy(HttpSession session) throws Exception {
		session.invalidate();
		return "redirect:/";
	}

	// 내 정보 출력
	@GetMapping("/info")
	public ResponseEntity<?> getMyInfo(String id) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		SidoGugunCode address =  new SidoGugunCode("","","설정 안함");

		// 1. 사용자 정보, 관심지역 조회
		User user = userService.getUser(id);// 사용자 정보 조회(관심 지역 조인된 결과)
		
		//예외) 사용자에게 대표관심지역, 일반관심지역 모두 없는 경우 사용자 정보를 조회할 수 없으므로 => 지역 제외한 정보 불러오기
		if(user == null) { 
			result.put("user",userService.getUserCoreInfo(id)); //지역을 제외한 정보 불러오기
			System.out.println("관심지역 없음");
		}
		else {
			result.put("user", user);
			// 2. 대표 관심지역 설정
			String dong_code = user.getInterest();
			if(dong_code != null && user.getInterst_state().equals("1")) 
				address = houseMapService.getAddress(dong_code);
				
		}

		result.put("address", address);
		return new ResponseEntity<Map<String, Object>>(result, HttpStatus.OK);
		// return new ResponseEntity<User>(user, HttpStatus.OK);
	}

	// 내 정보 수정
	@PutMapping("/info/{state}")
	public ResponseEntity<User> modifyMyInfo(User user, @PathVariable("state") String state) throws Exception {
		boolean result = false;
		switch (state) {
		case "admin":
			result = userService.updateUserNotIncludingPwd(user);// 사용자 정보 수정(비밀번호 제외)
			break;
		case "member":
			result = userService.updateUser(user);// 사용자 정보 수정
			break;

		}
		if (result)
			user = userService.getUser(user.getId());
		return new ResponseEntity<User>(user, HttpStatus.OK);
	}

	// 탈퇴(user_state -1로 변경)
	@PostMapping("/info")
	public ResponseEntity<String> deleteMyInfo(String id) throws Exception {
		System.out.println("delete params:" + id);
		boolean result = userService.deleteUser(id);// 사용자 정보 수정(삭제)
		return result == true ? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// 관리자메뉴: 전체 사용자 출력
	/*
	 * @GetMapping("/all") public String userList(Model model) throws Exception{
	 * List<User> userList = userService.getUsers();
	 * model.addAttribute("userList",userList); return "/05_userlist/userlist"; }
	 */

	@GetMapping("/all")
	public ResponseEntity<List<HashMap<String, Object>>> userList() throws Exception {
		System.out.println("모든 사용자의 정보를 조회합니다.");
		List<HashMap<String, Object>> result = new ArrayList();
		List<User> userList = userService.getUsers();
		HashMap<String, Object> data;

		// 각 user의 관심지역 정보도 차례로 저장
		for (User user : userList) {
			data = new HashMap<String, Object>();

			// 사용자 아이디로 관심지역 테이블 조회
			InterestArea area = interestService.selectInterestArea(user.getId());
			System.out.println("현재 사용자의 관심정보: "+area);
			SidoGugunCode address = new SidoGugunCode();
			if(area == null || area.getState().equals("0")) {//관심지역이 아예 없거나, 일반 관심 지역인 경우
				System.out.println("관심지ㅕㅇㄱ null");
				address.setSidoName("");
				address.setGugunName("");
				address.setDongName("설정 안함");
			}else {
				System.out.println("있는 경우");
				address = houseMapService.getAddress(area.getLocalNumber());// 사용자의 대표 관심 지역 조회
			}
			System.out.println("address: "+address);
			data.put("user", user);
			data.put("address", address);

			result.add(data);
		}
		System.out.println("result: "+result);

		return new ResponseEntity<List<HashMap<String, Object>>>(result, HttpStatus.OK);
	}

	// 사용자 검색: 이름으로 검색
	@GetMapping("/search")
	public ResponseEntity<List<HashMap<String, Object>>> search(String name, Model model) throws Exception {
		List<HashMap<String, Object>> result = new ArrayList();
		List<User> userList = userService.getUserByName(name);// 사용자 검색: 이름으로 검색
		HashMap<String, Object> data;
		
		// 각 user의 관심지역 정보도 차례로 저장
		for (User user : userList) {
			// 사용자 아이디로 관심지역 테이블 조회
			data = new HashMap<String, Object>();
			System.out.println("user: "+user);
			InterestArea area = interestService.selectInterestArea(user.getId());
			SidoGugunCode address = houseMapService.getAddress(user.getInterest());// 사용자의 대표 관심 지역 조회

			if(area == null || area.getState().equals("0")) {//관심지역이 아예 없거나, 일반 관심 지역인 경우
				System.out.println("관심지ㅕㅇㄱ null");
				address.setSidoName("");
				address.setGugunName("");
				address.setDongName("설정 안함");
			}else {
				System.out.println("있는 경우");
				address = houseMapService.getAddress(area.getLocalNumber());// 사용자의 대표 관심 지역 조회
			}
			System.out.println("address: "+address);
			data.put("user", user);
			data.put("address", address);

			result.add(data);
		}

		return new ResponseEntity<List<HashMap<String, Object>>>(result, HttpStatus.OK);
	}

}
