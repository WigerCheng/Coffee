package com.drink.coffee.service;

import com.drink.coffee.model.Result;
import com.drink.coffee.pojo.Order;

import java.util.List;

public interface OrderService {
    /**
     * 订单列表
     *
     * @return 订单列表
     */
    Result<List<Order>> orderList();

    /**
     * 下单
     *
     * @param order 订单
     * @return 创建结果
     */
    Result<String> createOrder(Order order);

    /**
     * 通知订单完成
     *
     * @param orderId 订单号
     * @return 通知结果
     */
    Result<String> pushOrderFinish(int orderId);

    /**
     * 退单
     *
     * @param orderId 订单号
     * @param type    退单人员
     * @return 退单结果
     */
    Result<String> returnOrder(int orderId, int type);

    /**
     * 删除订单
     *
     * @param orderId 订单号
     * @return 删除结果
     */
    Result<String> deleteOrder(int orderId);

    /**
     * 通过用户ID获取订单列表
     *
     * @param userId 用户Id
     * @return 订单列表
     */
    Result<List<Order>> getOrderListByUserId(int userId);

    /**
     * 接收订单
     *
     * @param orderId 订单Id
     * @return 接收结果
     */
    Result<String> receiveOrder(int orderId);
}
