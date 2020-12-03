package com.ssafy.domain;

public class InterestArea {

	//auto increment
	private String num;
	
	//foreign key
	private String userId;
	
	//지역명, 법정동 코드
	private String LocalName;
	private String LocalNumber;
	
	//대표 관심 지역 여부
	private String state;

	//기본 생성자
	public InterestArea() {
		super();
	}

	public InterestArea(String num, String userId, String localName, String localNumber, String state) {
		super();
		this.num = num;
		this.userId = userId;
		LocalName = localName;
		LocalNumber = localNumber;
		this.state = state;
	}

	//이하 getter, setter
	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getLocalName() {
		return LocalName;
	}

	public void setLocalName(String localName) {
		LocalName = localName;
	}

	public String getLocalNumber() {
		return LocalNumber;
	}

	public void setLocalNumber(String localNumber) {
		LocalNumber = localNumber;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Override
	public String toString() {
		return "InterestArea [num=" + num + ", userId=" + userId + ", LocalName=" + LocalName + ", LocalNumber="
				+ LocalNumber + ", state=" + state + "]";
	}
	
}
