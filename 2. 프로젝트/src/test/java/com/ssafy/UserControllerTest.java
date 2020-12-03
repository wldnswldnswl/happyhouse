package com.ssafy;

import static org.hamcrest.CoreMatchers.is;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
public class UserControllerTest {

	@Autowired
	private MockMvc mvc;
	
	@Test
	public void testDomain() throws Exception{
		String id = "ssafy";
		String pwd="1234";
		
		mvc.perform(
				get("user/login.do")
				.param("pageNum", id) //string 형식만 받음
				.param("amount",pwd)
				)
		.andExpect(status().isOk())
		.andExpect(jsonPath("$.id", is(id))) //json형식의 개체를 확인
		.andExpect(jsonPath("$.pwd", is(pwd)));
	}

}
