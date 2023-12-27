package com.example.demo;

import com.example.demo.Repository.ManagementUnitRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
class DemoApplicationTests {
	@Autowired
	private ManagementUnitRepository managementUnitRepository;
	@Test
	void contextLoads() {
		var managementUnits = managementUnitRepository.findAll();
		List<String> listId = managementUnits.stream().map(managementUnit -> managementUnit.getId()).toList();
		System.out.println(String.join(",", listId));
	}

}
