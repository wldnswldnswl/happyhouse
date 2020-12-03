package com.ssafy.domain;

public class User {
	
	private String id;
	private String pwd;
	private String name;
	private String email;
	//회원 등급 관리자 100 일반 회원 0 삭제된 회원 -1
	private String state;
	
	//항상 들고 다닐 대표 관심 지역
	private String interest;
	private String interest_name;
	private String interst_state; //대표관심지역:1, 일반관심지역:0
	//기본 생성자
	public User() {
		super();
	}

	public User(String id, String pwd, String name, String email, String state, String interest) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.state = state;
		this.interest = interest;
	}
	
	//이하 getter, setter
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getInterest() {
		return interest;
	}

	public void setInterest(String interest) {
		this.interest = interest;
	}

	public String getInterest_name() {
		return interest_name;
	}

	public void setInterest_name(String interest_name) {
		this.interest_name = interest_name;
	}

	
	public String getInterst_state() {
		return interst_state;
	}

	public void setInterst_state(String interst_state) {
		this.interst_state = interst_state;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", pwd=" + pwd + ", name=" + name + ", email=" + email + ", state=" + state
				+ ", interest=" + interest + "]";
	}

}
