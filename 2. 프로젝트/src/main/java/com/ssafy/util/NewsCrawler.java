package com.ssafy.util;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.mybatis.logging.Logger;
import org.mybatis.logging.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.jsoup.nodes.Element;
import com.ssafy.domain.News;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

@Component
public class NewsCrawler {
	private static final String CONNECT_URL = "https://news.naver.com/main/list.nhn?mode=LS2D&sid2=260&mid=shm&sid1=101&date=";
	static final Logger log = LoggerFactory.getLogger(Scheduled.class);
	/*

	 * Document 클래스 : 연결해서 얻어온 HTML 전체 문서

	 * Element 클래스 : Document의 HTML 요소

	 * Elements 클래스 : Element가 모인 자료형

	 */
	
	public String getCurrentTime() {
		Date date = new Date();
		SimpleDateFormat fdate = new SimpleDateFormat("yyyyMMdd");
		
		return fdate.format(date);
	}
	public int getMaxPage() throws IOException {
		String url = CONNECT_URL + getCurrentTime();
		String turl = "";
		Document document;
		Elements element;
		
		int index = 1;
		int maxPage = 0;
		boolean flag = false;
		
		while(true) {
			turl = url+"&page="+index;
			document = Jsoup.connect(turl).get();
			element = document.select("div.paging");
			flag = false;
			for(Element el:element.select("a")) {
				if("다음".equals(el.text())) {
					index++;
					flag = true;
				}
				else if("이전".equals(el.text())) {
					continue;
				}
				else {
					int tpage = Integer.parseInt(el.text());
					maxPage = maxPage < tpage? tpage:maxPage;
				}
			}
			if(!flag) break;
		}
		return maxPage;
	}
	public List<News> getList() throws Exception {
		String url = CONNECT_URL + getCurrentTime();
		String turl = "";
		Document document;
		Elements element;	
		int maxPage = getMaxPage();
		
		List<News> news = new ArrayList<News>();
		for(int page=1;page<=maxPage;page++){
			turl = url+"&page="+page;
			document = Jsoup.connect(turl).get();
			element = document.select("div.list_body.newsflash_body");
			for(Element el:element.select("dl")) {
				news.add(new News(el.select("a").text(), el.select("span.lede").text(), el.select("span.writing").text(), el.select("a").attr("abs:href")));
			}
		}
		
		return news;
	}
	
	public boolean insertNews(News news) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;

		String sql = "insert into news(title, content, writer, url) values (?,?,?,?)";
		try {
			conn = DBUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, news.getTitle());
			stmt.setString(2, news.getContent());
			stmt.setString(3, news.getWriter());
			stmt.setString(4, news.getUrl());
			
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(stmt);
			DBUtil.close(conn);
		}
		return false;
	}

	public boolean deleteAll() throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "delete from news";
		try {
			conn = DBUtil.getConnection();
			// step3. statement 준비
			stmt = conn.prepareStatement(sql);
			// step4. sql execute
			return stmt.executeUpdate() > 0;

		}catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(stmt);
			DBUtil.close(conn);
		}
		
		return false;
	}
	
	@Scheduled(cron = "0 0 0/1 * * *")
	public void scheduler() throws Exception {
		
		List<News> newsList = new ArrayList<>();
		newsList = getList();
		deleteAll();
		for(News news:newsList) {
			insertNews(news);
		}
	}
}
