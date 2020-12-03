package com.ssafy.controller;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.domain.Criteria;
import com.ssafy.domain.Notice;
import com.ssafy.domain.Page;
import com.ssafy.domain.pageResult;
import com.ssafy.service.NoticeService;

import io.swagger.annotations.Api;

@RestController
@CrossOrigin(origins = { "*" }, maxAge = 6000)
//@Api(value = "게시물 CRUD", description = "게시물에 관련된 등록/수정/삭제/출력")
public class NoticeController {

	private NoticeService noticeService;

	@Autowired
	public void setNoticeService(NoticeService noticeService) {
		this.noticeService = noticeService;
	}

	//게시물 등록
	@PostMapping("/notice/new")
	public ResponseEntity<String> registNotice(@RequestBody Notice vo) throws Exception {
		System.out.println("게시글을 등록하려합니다");
		boolean result = noticeService.registerNotice(vo);
		return result == true ? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("/notice/board/default")
	public ResponseEntity<pageResult> getNoticeList() throws Exception {
		pageResult pageResult = noticeService.getNotices(1);
		return new ResponseEntity<pageResult>(pageResult, HttpStatus.OK);
	}
	
	//자료형 바뀜
	//게시물 목록 출력
	@GetMapping("/notice/board/{pageNum}")
	public ResponseEntity<pageResult> getNoticeListtest(@PathVariable(required = false,name = "pageNum") int pageNum) throws Exception {
		pageResult pageResult = noticeService.getNotices(pageNum);
		return new ResponseEntity<pageResult>(pageResult, HttpStatus.OK);
	}

	//특정 게시물 출력
	@GetMapping("/notice/{idx}")
	public ResponseEntity<Notice> getNotice(@PathVariable("idx") String idx) throws Exception {
		return new ResponseEntity<Notice>(noticeService.getNotice(idx), HttpStatus.OK);
	}

	//게시물 수정
	@PutMapping("/notice/{idx}")
	public ResponseEntity<String> updateNotice(@PathVariable("idx") String idx, @RequestBody Notice vo)
			throws Exception {
		boolean result = noticeService.updateNotice(vo);
		return result == true ? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	//게시물 삭제
	@Transactional
	@DeleteMapping("/notice/{idx}")
	public ResponseEntity<String> deleteNotice(@PathVariable("idx") String idx) throws Exception {
		boolean result = noticeService.deleteNotice(idx);
		return result == true ? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
