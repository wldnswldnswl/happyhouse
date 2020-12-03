package com.ssafy.domain;

public class News {
	private String title;
	private String content;
	private String writer;
	private String url;
	
	public News() {}
	public News(String title, String content, String writer, String url) {
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.url = url;
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
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	@Override
	public String toString() {
		return "News [title=" + title + ", content=" + content + ", writer=" + writer + ", url=" + url + "]";
	}
}
