package com.ssafy.domain;

public class BizInfo {

	int biz_id;
	String biz_name;
	String branch_name;
	String std_name;
	String dong_name;
	String dong_code;
	String lng;
	String lat;

	public BizInfo() {
		super();
	}

	public BizInfo(int biz_id, String biz_name, String branch_name, String std_name, String dong_name, String dong_code,
			String lng, String lat) {
		super();
		this.biz_id = biz_id;
		this.biz_name = biz_name;
		this.branch_name = branch_name;
		this.std_name = std_name;
		this.dong_name = dong_name;
		this.dong_code = dong_code;
		this.lng = lng;
		this.lat = lat;
	}

	public int getBiz_id() {
		return biz_id;
	}

	public void setBiz_id(int biz_id) {
		this.biz_id = biz_id;
	}

	public String getBiz_name() {
		return biz_name;
	}

	public void setBiz_name(String biz_name) {
		this.biz_name = biz_name;
	}

	public String getBranch_name() {
		return branch_name;
	}

	public void setBranch_name(String branch_name) {
		this.branch_name = branch_name;
	}

	public String getStd_name() {
		return std_name;
	}

	public void setStd_name(String std_name) {
		this.std_name = std_name;
	}

	public String getDong_name() {
		return dong_name;
	}

	public void setDong_name(String dong_name) {
		this.dong_name = dong_name;
	}

	public String getDong_code() {
		return dong_code;
	}

	public void setDong_code(String dong_code) {
		this.dong_code = dong_code;
	}

	public String getLng() {
		return lng;
	}

	public void setLng(String lng) {
		this.lng = lng;
	}

	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

}
