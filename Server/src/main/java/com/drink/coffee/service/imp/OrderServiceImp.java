package com.drink.coffee.service.imp;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.drink.coffee.controller.SseController;
import com.drink.coffee.mapper.CoffeeMapper;
import com.drink.coffee.mapper.OrderDetailMapper;
import com.drink.coffee.mapper.OrderMapper;
import com.drink.coffee.mapper.UserMapper;
import com.drink.coffee.model.Result;
import com.drink.coffee.model.ResultCode;
import com.drink.coffee.pojo.Coffee;
import com.drink.coffee.pojo.Order;
import com.drink.coffee.pojo.OrderDetail;
import com.drink.coffee.pojo.User;
import com.drink.coffee.service.OrderService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.stream.Collectors;

@Slf4j
@Service
public class OrderServiceImp implements OrderService {
    @Autowired
    OrderMapper orderMapper;

    @Autowired
    UserMapper userMapper;

    @Autowired
    CoffeeMapper coffeeMapper;

    @Autowired
    OrderDetailMapper orderDetailMapper;


    /**
     * 下单
     *
     * @param order 订单
     * @return 下单结果
     */
    @Override
    @Transactional
    public Result<String> createOrder(Order order) {
        order.setOrderStatus(Order.ORDER_NON_RECEIVED);
        order.setOrderDate(new Date());
        int insertOrderResult = orderMapper.insert(order);
        AtomicBoolean insertDetail = new AtomicBoolean(true);
        order.getOrderCoffees().forEach(orderDetail -> {
            orderDetail.setOrderId(order.getOrderId());
            int result = orderDetailMapper.insert(orderDetail);
            if (result != 1) {
                insertDetail.set(false);
            }
        });
        if (insertOrderResult == 1 && insertDetail.get()) {
            SseController.pushManagerMessage("有新的订单");
            return new Result<>(ResultCode.SUCCESS_CODE, "创建订单成功");
        } else {
            return new Result<>(ResultCode.ERROR_CODE, "创建订单失败");
        }
    }

    /**
     * 向用户发送取单信息
     *
     * @param orderId 用户Id
     */
    @Override
    @Transactional
    public Result<String> pushOrderFinish(int orderId) {
        Order order = orderMapper.selectById(orderId);
        if (order != null) {
            order.setOrderStatus(Order.ORDER_FINISH);
            int result = orderMapper.updateById(order);
            if (result == 1) {
                SseController.pushCustomerMessage(order.getUserId(), "订单已完成");
                return new Result<>(ResultCode.SUCCESS_CODE, "通知订单完成成功", "通知订单完成成功");
            } else {
                return new Result<>(ResultCode.ERROR_CODE, "通知订单完成失败", "通知订单完成失败");
            }
        } else {
            return new Result<>(ResultCode.ERROR_CODE, "通知订单完成失败", "通知订单完成失败");
        }
    }

    /**
     * 退单
     *
     * @param orderId 订单号
     * @return 退单结果
     */
    @Override
    @Transactional
    public Result<String> returnOrder(int orderId, int type) {
        /*在数据库中找出该数据对象，并把他的状态修改*/
        Order order = orderMapper.selectById(orderId);
        if (order != null) {
            order.setOrderStatus(Order.ORDER_RETURN);
            /*创建条件构造器，修改数据库的值*/
            QueryWrapper<Order> wrapper = new QueryWrapper<>();
            int result = orderMapper.update(order, wrapper.eq("order_id", order.getOrderId()));
            if (result == 1) {
                if (type == 1) {
                    SseController.pushCustomerMessage(order.getUserId(), "订单已被退单");
                } else {
                    SseController.pushManagerMessage("客户取消订单");
                }
                return new Result<>(ResultCode.SUCCESS_CODE, "退单成功", "退单成功");
            } else {
                return new Result<>(ResultCode.ERROR_CODE, "退单失败", "退单失败");
            }
        } else {
            return new Result<>(ResultCode.ERROR_CODE, "退单失败，数据库无此单", "退单失败，数据库无此单");
        }
    }

    /**
     * 删除该订单消息
     *
     * @param orderId 订单号
     * @return 删除结果
     */
    @Override
    @Transactional
    public Result<String> deleteOrder(int orderId) {
        int result = orderMapper.deleteById(orderId);
        if (result == 1) {
            return Result.result(ResultCode.SUCCESS_CODE, "删除订单成功");
        } else {
            return Result.result(ResultCode.ERROR_CODE, "删除订单失败");
        }
    }

    /**
     * 获取订单列表
     *
     * @return 获取订单列表
     */
    @Override
    public Result<List<Order>> orderList() {
        List<Order> orders = orderMapper.selectList(new QueryWrapper<>()).stream().peek(order -> {
            User user = userMapper.selectById(order.getUserId());
            order.setUserName(user.getUserName());
            QueryWrapper<OrderDetail> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("detail_order_id", order.getOrderId());
            List<OrderDetail> orderDetails = orderDetailMapper.selectList(queryWrapper).stream().peek(orderDetail -> {
                Coffee coffee = coffeeMapper.selectById(orderDetail.getCoffeeId());
                orderDetail.setCoffeePrice(coffee.getCoffeePrice());
                orderDetail.setCoffeeUrl(coffee.getCoffeeUrl());
                orderDetail.setCoffeeName(coffee.getCoffeeName());
            }).collect(Collectors.toList());
            order.setOrderCoffees(orderDetails);
        }).collect(Collectors.toList());
        return Result.success(orders);
    }

    /**
     * 通过用户ID获取订单列表
     *
     * @param userId 用户Id
     * @return 订单列表
     */
    @Override
    public Result<List<Order>> getOrderListByUserId(int userId) {
        QueryWrapper<Order> orderQueryWrapper = new QueryWrapper<>();
        orderQueryWrapper.eq("user_id", userId);
        List<Order> orders =
                orderMapper.selectList(orderQueryWrapper)
                        .stream()
                        .peek(order -> {
                            QueryWrapper<OrderDetail> detailQueryWrapper = new QueryWrapper<>();
                            detailQueryWrapper.eq("detail_order_id", order.getOrderId());
                            List<OrderDetail> orderDetails = orderDetailMapper.selectList(detailQueryWrapper).stream().peek(orderDetail -> {
                                Coffee coffee = coffeeMapper.selectById(orderDetail.getCoffeeId());
                                orderDetail.setCoffeePrice(coffee.getCoffeePrice());
                                orderDetail.setCoffeeUrl(coffee.getCoffeeUrl());
                                orderDetail.setCoffeeName(coffee.getCoffeeName());
                            }).collect(Collectors.toList());
                            order.setOrderCoffees(orderDetails);
                        })
                        .collect(Collectors.toList());

        return new Result<>(ResultCode.SUCCESS_CODE, "查询成功", orders);
    }

    /**
     * 接收订单
     *
     * @param orderId 订单Id
     * @return 接收结果
     */
    @Override
    public Result<String> receiveOrder(int orderId) {
        Order order = orderMapper.selectById(orderId);
        if (order != null) {
            order.setOrderStatus(Order.ORDER_RECEIVED);
            int result = orderMapper.updateById(order);
            if (result == 1) {
                SseController.pushCustomerMessage(order.getUserId(), "商家已接收您的订单");
                return new Result<>(ResultCode.SUCCESS_CODE, "已接收订单", "已接收订单");
            } else {
                return new Result<>(ResultCode.ERROR_CODE, "接收订单失败", "接收订单失败");
            }
        } else {
            return new Result<>(ResultCode.ERROR_CODE, "接收订单失败", "接收订单失败");
        }
    }
}
