package com.ssafy.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.config.auth.dto.SessionUserSecure;

//import com.ssafy.config.auth.dto.SessionUserSecure;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class HomeController {
	
	private final HttpSession httpSession;
	
	
	//페이지 이동
	@GetMapping("/")
	public String baseUrl(Model model, HttpServletRequest session) {
		SessionUserSecure user = (SessionUserSecure)httpSession.getAttribute("user");
		if(user!=null)
		{
			session.setAttribute("userName",user.getName());
		}
		System.out.println("hi");
		return "index";
	}

	@RequestMapping("/searchPage.do")
	public String searchPage() {
		return "/01_search/search";
	}

	@RequestMapping("/surround.do")
	public String surroundPage() {
		return "/02_surround/surround";
	}

	@RequestMapping("/interest.do")
	public String interestPage() {
		return "/03_interest/interest";
	}

	@RequestMapping("/notice.do")
	public String noticePage() {
		return "/04_notice/notice";
	}
	
	@RequestMapping("/noticeWrite.do")
	public String noticeWritePage() {
		return "/04_notice/noticeWrite";
	}
	
	@RequestMapping("/noticeDetail.do")
	public String noticeDetailPage(@RequestParam(value = "no")String no,Model model) {
		model.addAttribute("no", no);
		return "/04_notice/noticeDetail";
	}

	@RequestMapping("/noticeModify.do")
	public String noticeModifyPage(@RequestParam(value = "no")String no,Model model) {
		model.addAttribute("no", no);
		return "/04_notice/noticeModify";
	}


	@RequestMapping("/userlist.do")
	public String userListPage() {
		return "/05_userlist/userlist";
	}
	
	@RequestMapping("/sitemap.do")
	public String siteMapPage() {
		return "/06_sitemap/sitemap";
	}
	
	@RequestMapping("/news.do")
	public String newsPage() {
		return "/07_news/news";
	}
	
	@RequestMapping("/dealReview.do")
	public String dealReviewPage() {
		return "/08_dealReview/dealReview";
	}

	@RequestMapping("/dealReviewWrite.do")
	public String dealReviewWritePage() {
		return "/08_dealReview/dealReviewWrite";
	}
	
	@RequestMapping("/dealReviewDetail.do")
	public String dealReviewDetailPage(@RequestParam(value = "no")String no,Model model) {
		model.addAttribute("no", no);
		return "/08_dealReview/dealReviewDetail";
	}

	@RequestMapping("/dealReviewModify.do")
	public String dealReviewModifyPage(@RequestParam(value = "no")String no,Model model) {
		model.addAttribute("no", no);
		return "/08_dealReview/dealReviewModify";
	}
}
