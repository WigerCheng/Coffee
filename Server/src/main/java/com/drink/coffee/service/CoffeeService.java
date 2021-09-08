package com.drink.coffee.service;

import com.drink.coffee.model.Result;
import com.drink.coffee.pojo.Coffee;

import java.util.List;

public interface CoffeeService {
    /**
     * 获取咖啡列表
     *
     * @return 咖啡列表
     */
    Result<List<Coffee>> getCoffeeList();

    /**
     * 删除咖啡
     *
     * @param coffeeId 咖啡Id
     * @return 删除结果
     */
    Result<String> deleteCoffee(Integer coffeeId);

    /**
     * 添加或更新咖啡信息
     *
     * @param coffee 咖啡实体
     * @return 更新结果
     */
    Result<String> addOrUpdateCoffee(Coffee coffee);

    /**
     * 查看咖啡详情
     *
     * @param coffeeId 咖啡Id
     * @return 咖啡
     */
    Result<Coffee> selectCoffeeInfo(Integer coffeeId);

    /**
     * 更新上架还是下架
     *
     * @param coffeeId 咖啡Id
     * @param status   上架0、下架1
     * @return 更新结果
     */
    Result<String> updateStatus(Integer coffeeId, Integer status);
}
