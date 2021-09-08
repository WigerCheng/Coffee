package com.drink.coffee;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan(basePackages = {"com.drink.coffee.mapper"})
public class CoffeeApplication {
    public static void main(String[] args) {
        SpringApplication.run(CoffeeApplication.class, args);
    }
}
