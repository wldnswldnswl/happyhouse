package com.ssafy.domain;

public class BizCategory {

	private String largeCode;
	private String largeName;
	private String midCode;
	private String midName;
	private String smallCode;
	private String smallName;

	public BizCategory() {
		super();
	}

	public BizCategory(String largeCode, String largeName, String midCode, String midName, String smallCode,
			String smallName) {
		super();
		this.largeCode = largeCode;
		this.largeName = largeName;
		this.midCode = midCode;
		this.midName = midName;
		this.smallCode = smallCode;
		this.smallName = smallName;
	}

	public String getLargeCode() {
		return largeCode;
	}

	public void setLargeCode(String largeCode) {
		this.largeCode = largeCode;
	}

	public String getLargeName() {
		return largeName;
	}

	public void setLargeName(String largeName) {
		this.largeName = largeName;
	}

	public String getMidCode() {
		return midCode;
	}

	public void setMidCode(String midCode) {
		this.midCode = midCode;
	}

	public String getMidName() {
		return midName;
	}

	public void setMidName(String midName) {
		this.midName = midName;
	}

	public String getSmallCode() {
		return smallCode;
	}

	public void setSmallCode(String smallCode) {
		this.smallCode = smallCode;
	}

	public String getSmallName() {
		return smallName;
	}

	public void setSmallName(String smallName) {
		this.smallName = smallName;
	}

}
