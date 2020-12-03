package com.ssafy.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.domain.User;
import com.ssafy.mapper.UserDAO;

@Service
public class UserServiceImpl implements UserService {

	private UserDAO userDao;

	@Autowired
	public void setUserDao(UserDAO userDao) {
		this.userDao = userDao;
	}

	// 로그인
	@Override
	public String login(Map<String, String> map) throws SQLException {
		return userDao.selectUser(map);
	}

	// 회원가입
	@Override
	public boolean register(User user) throws SQLException {

		// 이미 해당 아이디가 존재하는 경우
		if (getUser(user.getId()) != null) throw new RuntimeException("아이디가 중복되었습니다.");

		// 아이디가 존재하지 않아 올바르게 회원가입이 되는 경우
		return userDao.insert(user) > 0;
	}

	// 단일 유저 정보 불러오기
	@Override
	public User getUser(String id) throws SQLException {
		return userDao.selectById(id);
	}

	@Override
	public boolean insertUserInterest(String id, String dongCode, String rep) throws SQLException {
		System.out.println("insertUserInterest: "+dongCode);
		return userDao.insertInterest(id, dongCode,rep); //rep (1: 대표지역, 0: 그 외 관심지역)
	}

	// 회원 정보 수정
	@Override
	public boolean updateUser(User user) throws SQLException {
		return userDao.update(user)>0;
	}

	// 회원 삭제 (회원 상태 0-> -1)
	@Override
	public boolean deleteUser(String id) throws SQLException {
		return userDao.delete(id) > 0;
	}

	@Override
	public List<User> getUsers() {
		return userDao.selectUsers();
	}

	// 사용자 정보 수정(비밀번호 제외)
	@Override
	public boolean updateUserNotIncludingPwd(User user) {
		return userDao.updateNotIncludingPwd(user)>0;
	}

	// 사용자 검색: 이름으로검색
	@Override
	public List<User> getUserByName(String name) {
		return userDao.selectByName(name);
	}

	@Override
	public User getUserCoreInfo(String id) {
		return userDao.selectByIdCoreInfo(id);
	}
	
	@Override
	public boolean insertTimetable(String id) {
		return userDao.insertTimetable(id);
	}
}
