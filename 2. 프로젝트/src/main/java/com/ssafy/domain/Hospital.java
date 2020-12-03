package com.ssafy.domain;

public class Hospital {
	private String no;
	private String sido;
	private String gungu;
	private String name;
	private String address;
	private String type;
	private String tel;

	public Hospital() {
		super();
	}

	public Hospital(String no, String sido, String gungu, String name, String address, String type, String tel) {
		super();
		this.no = no;
		this.sido = sido;
		this.gungu = gungu;
		this.name = name;
		this.address = address;
		this.type = type;
		this.tel = tel;
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getSido() {
		return sido;
	}

	public void setSido(String sido) {
		this.sido = sido;
	}

	public String getGungu() {
		return gungu;
	}

	public void setGungu(String gungu) {
		this.gungu = gungu;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	@Override
	public String toString() {
		return "Hospital [no=" + no + ", sido=" + sido + ", gungu=" + gungu + ", name=" + name + ", address=" + address
				+ ", type=" + type + ", tel=" + tel + "]";
	}

}
