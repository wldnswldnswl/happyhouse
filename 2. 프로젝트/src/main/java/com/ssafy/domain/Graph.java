package com.ssafy.domain;

public class Graph {
	private String dong;
	private String AptName;
	private int dealAmount;
	private String dealYear;
	
	public Graph() {}
	public Graph(String dong, String aptName, int dealAmount, String dealYear) {
		super();
		this.dong = dong;
		AptName = aptName;
		this.dealAmount = dealAmount;
		this.dealYear = dealYear;
	}
	
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public String getAptName() {
		return AptName;
	}
	public void setAptName(String aptName) {
		AptName = aptName;
	}
	public int getDealAmount() {
		return dealAmount;
	}
	public void setDealAmount(int dealAmount) {
		this.dealAmount = dealAmount;
	}
	public String getDealYear() {
		return dealYear;
	}
	public void setDealYear(String dealYear) {
		this.dealYear = dealYear;
	}
	
	@Override
	public String toString() {
		return "Graph [dong=" + dong + ", AptName=" + AptName + ", dealAmount=" + dealAmount + ", dealYear=" + dealYear
				+ "]";
	}
}
