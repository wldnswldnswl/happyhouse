package com.ssafy.domain;

import java.util.List;

public class Criteria {
	private int displayRow;
	private int offset;
	private List<String> dong_list; //임의
	
	public Criteria() {
		super();
	}

	public Criteria(int displayRow, int offset) {
		super();
		this.displayRow = displayRow;
		this.offset = offset;
	}

	public int getDisplayRow() {
		return displayRow;
	}

	public void setDisplayRow(int displayRow) {
		this.displayRow = displayRow;
	}

	public int getOffset() {
		return offset;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}

	
	public List<String> getDong_list() {
		return dong_list;
	}

	public void setDong_list(List<String> dong_list) {
		this.dong_list = dong_list;
	}

	@Override
	public String toString() {
		return "Criteria [displayRow=" + displayRow + ", offset=" + offset + "]";
	}

}
