package com.ssafy.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.ssafy.domain.User;

public interface UserService {

	// 로그인 (사용자 등급 리턴)
	String login(Map<String, String> map) throws SQLException;

	// 회원 등록
	boolean register(User user) throws SQLException;

	// 단일 유저 불러옴
	User getUser(String id) throws SQLException;

	// 회원 수정
	boolean updateUser(User user) throws SQLException;

	// 회원 삭제
	boolean deleteUser(String id) throws SQLException;
	
	// 회원의 대표관심지역 등록
	boolean insertUserInterest(String id, String dongCode,String rep) throws SQLException;

	// 모든 회원 정보 조회
	List<User> getUsers();

	//// 사용자 정보 수정(비밀번호 제외)
	boolean updateUserNotIncludingPwd(User user);

	// 사용자 검색: 이름으로검색
	List<User> getUserByName(String name);

	User getUserCoreInfo(String id);
	
	boolean insertTimetable(String id);

}
