package com.ssafy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.ssafy.domain.Graph;
import com.ssafy.service.GraphService;

@RestController
public class GraphController {
	private GraphService graphService;
	
	@Autowired
	public void setGraphService(GraphService graphService) {
		this.graphService = graphService;
	}
	
	@GetMapping("/graph/{AptName}/{dong}")
	public @ResponseBody String getHouseDealGraph(@PathVariable("AptName") String AptName, @PathVariable("dong") String dong) throws Exception {
		Gson gson = new Gson();
		List<Graph> list = graphService.selectHouseDeals(dong, AptName);
		System.out.println(gson.toJson(list));
		return gson.toJson(list);
	}
}
