package com.drink.coffee.controller;

import com.drink.coffee.model.Result;
import com.drink.coffee.pojo.Order;
import com.drink.coffee.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/order")
public class OrderController {
    @Autowired
    OrderService orderService;

    @GetMapping("/orderList")
    public Result<List<Order>> selectOrderList() {
        return orderService.orderList();
    }

    @PostMapping("/createOrder")
    public Result<String> createOrder(@RequestBody Order order) {
        return orderService.createOrder(order);
    }

    @PostMapping("/pushOrderFinish")
    public Result<String> pushOrderFinish(@RequestParam(value = "orderId") int userId) {
        return orderService.pushOrderFinish(userId);
    }

    @PostMapping("/returnOrder")
    public Result<String> returnOrder(@RequestParam(value = "orderId") int orderId, @RequestParam(value = "type") int type) {
        return orderService.returnOrder(orderId, type);
    }

    @PostMapping("/deleteOrder")
    public Result<String> deleteOrder(@RequestParam(value = "orderId") int orderId) {
        return orderService.deleteOrder(orderId);
    }

    @GetMapping("/getUserOrders")
    public Result<List<Order>> getUserOrder(@RequestParam(value = "userId") int userId) {
        return orderService.getOrderListByUserId(userId);
    }

    @PostMapping("/receiveOrder")
    public Result<String> receiveOrder(@RequestParam(value = "orderId") int userId) {
        return orderService.receiveOrder(userId);
    }
}
