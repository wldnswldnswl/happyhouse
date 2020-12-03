package com.ssafy.domain;

import java.util.List;

public class pageResult {

	public Page pagenation;

	public List<DealReview> review;
	public List<Notice> notice;
	public List<HouseInfo> houseInfo;
	public List<News> news;
	public List<HouseDeal> houseDeal;

	public pageResult() {
		super();
	}

	public pageResult(Page pagenation) {
		super();
		this.pagenation = pagenation;
	}

	public List<HouseDeal> getHouseDeal() {
		return houseDeal;
	}

	public void setHouseDeal(List<HouseDeal> houseDeal) {
		this.houseDeal = houseDeal;
	}

	public List<HouseInfo> getHouseInfo() {
		return houseInfo;
	}

	public void setHouseInfo(List<HouseInfo> houseInfo) {
		this.houseInfo = houseInfo;
	}

	public List<Notice> getNotice() {
		return notice;
	}

	public void setNotice(List<Notice> notice) {
		this.notice = notice;
	}

	public List<News> getNews() {
		return news;
	}

	public void setNews(List<News> news) {
		this.news = news;
	}

	public List<DealReview> getReview() {
		return review;
	}

	public void setReview(List<DealReview> review) {
		this.review = review;
	}

	public Page getPagenation() {
		return pagenation;
	}

	public void setPagenation(Page pagenation) {
		this.pagenation = pagenation;
	}

	@Override
	public String toString() {
		return "pageResult [notice=" + notice + ", houseInfo=" + houseInfo + ", pagenation=" + pagenation + "]";
	}

}
