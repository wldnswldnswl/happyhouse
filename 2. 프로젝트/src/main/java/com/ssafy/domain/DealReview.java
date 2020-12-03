package com.ssafy.domain;
//실물 후기
public class DealReview {
	private String no;
	private String title;
	private String content;
	private String writer;
	private String regtime;
	private String dong_code;
	private String dong_name;
	private int likes;

	
	public DealReview() {
		super();
	}

	public DealReview(String no, String title, String content, String writer, String regtime, String dong_code,
			int likes) {
		super();
		this.no = no;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.regtime = regtime;
		this.dong_code = dong_code;
		this.likes = likes;
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getRegtime() {
		return regtime;
	}

	public void setRegtime(String regtime) {
		this.regtime = regtime;
	}

	public String getDong_code() {
		return dong_code;
	}

	public void setDong_code(String dong_code) {
		this.dong_code = dong_code;
	}

	public String getDong_name() {
		return dong_name;
	}

	public void setDong_name(String dong_name) {
		this.dong_name = dong_name;
	}

	public int getLikes() {
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
	}

	@Override
	public String toString() {
		return "DealReview [no=" + no + ", title=" + title + ", content=" + content + ", writer=" + writer
				+ ", regtime=" + regtime + ", dong_code=" + dong_code + ", likes=" + likes + "]";
	}

}
