package com.ssafy.domain;

public class Page {

	private int startPage;
	private int endPage;
	private int currentPage;
	private int lastPage;
	private int pageCount;
	private int rowCount;
	private int displayRow;
	private int offset;
	
	
	public Page(int startPage, int endPage, int currentPage, int lastPage, int pageCount, int rowCount, int displayRow, int offset) {
		super();
		this.startPage = startPage;
		this.endPage = endPage;
		this.currentPage = currentPage;
		this.lastPage = lastPage;
		this.pageCount = pageCount;
		this.rowCount = rowCount;
		this.displayRow = displayRow;
		this.offset = offset;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getRowCount() {
		return rowCount;
	}

	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
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

}
