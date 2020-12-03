package com.ssafy;

import static org.hamcrest.CoreMatchers.is;
import static org.springframework.test.web.client.match.MockRestRequestMatchers.content;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultMatcher;


@RunWith(SpringRunner.class)
@WebMvcTest
/**
 * HelloController 테스팅
 * @author choi
 *
 */
public class HelloControlletTest {
	
	@Autowired
	//웹 API를 테스트할 때 사용
	//스프링 MVC테스트의 시작점
	//해당 클래스를 통해 HTTP GET,POST 등에 대한 API테스트 가능
	private MockMvc mvc;

	@Test
	public void returnHello() throws Exception {
	String hello = "hello";
	mvc.perform(get("/")) //MockMvc를 통해 '/'주소로 HTTP GET요청을 보냄
	.andExpect(status().isOk()) //perform의 결과 검증, server state 200인지 확인
	.andExpect((ResultMatcher) content().string(hello));//응답 내용이 맞는지 검증

	}
	
	@Test
	public void testDomain() throws Exception{
		int pageNum = 1;
		int amount=10;
		
		mvc.perform(
				get("/dto")
				.param("pageNum", String.valueOf(pageNum)) //string 형식만 받음
				.param("amount",String.valueOf(amount))
				)
		.andExpect(status().isOk())
		.andExpect(jsonPath("$.pageNum", is(pageNum))) //json형식의 개체를 확인
		.andExpect(jsonPath("$.amount", is(amount)));
	}

}
