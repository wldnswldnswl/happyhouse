package com.ssafy.domain;

public class Screening {

	private String no;
	private String possible;
	private String sido;
	private String gugun;
	private String name;
	private String address;
	private String weektime;
	private String sattime;
	private String holidaytime;
	private String tel;

	public Screening() {
		super();
	}

	public Screening(String no, String possible, String sido, String gugun, String name, String address,
			String weektime, String sattime, String holidaytime, String tel) {
		super();
		this.no = no;
		this.possible = possible;
		this.sido = sido;
		this.gugun = gugun;
		this.name = name;
		this.address = address;
		this.weektime = weektime;
		this.sattime = sattime;
		this.holidaytime = holidaytime;
		this.tel = tel;
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getPossible() {
		return possible;
	}

	public void setPossible(String possible) {
		this.possible = possible;
	}

	public String getSido() {
		return sido;
	}

	public void setSido(String sido) {
		this.sido = sido;
	}

	public String getGugun() {
		return gugun;
	}

	public void setGugun(String gugun) {
		this.gugun = gugun;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getWeektime() {
		return weektime;
	}

	public void setWeektime(String weektime) {
		this.weektime = weektime;
	}

	public String getSattime() {
		return sattime;
	}

	public void setSattime(String sattime) {
		this.sattime = sattime;
	}

	public String getHolidaytime() {
		return holidaytime;
	}

	public void setHolidaytime(String holidaytime) {
		this.holidaytime = holidaytime;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

}
