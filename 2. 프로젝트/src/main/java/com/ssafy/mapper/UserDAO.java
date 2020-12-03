package com.ssafy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.ssafy.domain.User;

@Mapper
public interface UserDAO {

	// 로그인 할 때
	String selectUser(Map<String, String> map);

	// 회원 정보 조회
	User selectById(String id);
	
	// 회원 정보 조회: 지역 정보 제외
	User selectByIdCoreInfo(String id); 

	// 회원 가입할 때
	int insert(User user);

	// 회원 정보 수정
	int update(User user);

	// 회원 정보 수정 (비밀번호 제외)
	int updateNotIncludingPwd(User user);

	// 회원 정보삭제, 회원 삭제
	// 회원 상태만 0-> -1로 바꿔줌 실질적으로 삭제 x
	int delete(String id);

	// 관심 지역 넣기
	boolean insertInterest(@Param("id") String id, @Param("dongCode") String dongCode, @Param("rep")String rep);

	// 모든 회원 조회
	List<User> selectUsers();

	// 사용자 검색: 이름으로 검색
	List<User> selectByName(String name);

	boolean insertTimetable(String id);

}
