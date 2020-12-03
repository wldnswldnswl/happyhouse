package com.ssafy.domain;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

@ApiModel(value = "SidoGugunCode : 지역 번호, 지역이름" , description = "지역의 이름과 코드를 나타낸다.")
public class SidoGugunCode {

	@ApiModelProperty(value="시,도 코드")
	private String sidoCode;
	@ApiModelProperty(value="시,도 이름")
	private String sidoName;
	private String gugunCode;
	private String gugunName;
	private String dongCode;
	private String dongName;

	public SidoGugunCode() {
		super();
	}

	public SidoGugunCode(String sidoCode, String sidoName, String gugunCode, String gugunName, String dongCode,
			String dongName) {
		super();
		this.sidoCode = sidoCode;
		this.sidoName = sidoName;
		this.gugunCode = gugunCode;
		this.gugunName = gugunName;
		this.dongCode = dongCode;
		this.dongName = dongName;
	}

	
	public SidoGugunCode(String sidoName, String gugunName, String dongName) {
		this.sidoName = sidoName;
		this.gugunName = gugunName;
		this.dongName = dongName;
	}

	public String getSidoCode() {
		return sidoCode;
	}

	public void setSidoCode(String sidoCode) {
		this.sidoCode = sidoCode;
	}

	public String getSidoName() {
		return sidoName;
	}

	public void setSidoName(String sidoName) {
		this.sidoName = sidoName;
	}

	public String getGugunCode() {
		return gugunCode;
	}

	public void setGugunCode(String gugunCode) {
		this.gugunCode = gugunCode;
	}

	public String getGugunName() {
		return gugunName;
	}

	public void setGugunName(String gugunName) {
		this.gugunName = gugunName;
	}

	public String getDongCode() {
		return dongCode;
	}

	public void setDongCode(String dongCode) {
		this.dongCode = dongCode;
	}

	public String getDongName() {
		return dongName;
	}

	public void setDongName(String dongName) {
		this.dongName = dongName;
	}

	@Override
	public String toString() {
		return "SidoGugunCode [sidoCode=" + sidoCode + ", sidoName=" + sidoName + ", gugunCode=" + gugunCode
				+ ", gugunName=" + gugunName + ", dongCode=" + dongCode + ", dongName=" + dongName + "]";
	}
	
	

}
