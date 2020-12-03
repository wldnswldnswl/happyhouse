package com.ssafy;

import static org.springframework.test.web.client.match.MockRestRequestMatchers.content;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
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
class HappyHouseRestApplicationTests {
	
	@Autowired
	private MockMvc mvc;

	@Test
	public void returnHello() throws Exception {
	String hello = "hello";
	mvc.perform(get("/"))
	.andExpect(status().isOk()).andExpect((ResultMatcher) content().string(hello));
	
	}
	

}
