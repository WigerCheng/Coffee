package com.drink.coffee.controller;

import com.drink.coffee.model.Result;
import com.drink.coffee.pojo.Coffee;
import com.drink.coffee.service.CoffeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/coffee")
public class CoffeeController {
    @Autowired
    CoffeeService coffeeService;

    /**
     * 请求咖啡列表
     *
     * @return 咖啡列表
     */
    @GetMapping("/coffeeList")
    public Result<List<Coffee>> coffeeInfoList() {
        return coffeeService.getCoffeeList();
    }

    /**
     * 删除咖啡
     *
     * @param coffeeId 咖啡主键
     * @return 删除结果
     */
    @PostMapping("/deleteCoffee")
    public Result<String> deleteCoffee(@RequestParam(value = "coffeeId") Integer coffeeId) {
        return coffeeService.deleteCoffee(coffeeId);
    }

    /**
     * 更新咖啡
     *
     * @param coffee 咖啡对象
     * @return 成功信息
     */
    @PostMapping("/addOrUpdateCoffee")
    public Result<String> updateCoffee(@RequestBody Coffee coffee) {
        return coffeeService.addOrUpdateCoffee(coffee);
    }


    /**
     * 请求具体咖啡
     *
     * @param coffeeId 咖啡Id
     * @return 具体咖啡
     */
    @GetMapping("/coffeeInfo")
    public Result<Coffee> selectCoffeeInfo(@RequestParam(value = "coffeeId") Integer coffeeId) {
        return coffeeService.selectCoffeeInfo(coffeeId);
    }

    /**
     * 更新上架状态
     *
     * @param coffeeId 咖啡Id
     * @return 更新结果
     */
    @PostMapping("/updateStatus")
    public Result<String> updateStatus(@RequestParam(value = "coffeeId") Integer coffeeId, @RequestParam(value = "status") Integer status) {
        return coffeeService.updateStatus(coffeeId, status);
    }
}
