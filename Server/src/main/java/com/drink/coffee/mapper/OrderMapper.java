package com.drink.coffee.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.drink.coffee.pojo.Order;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderMapper extends BaseMapper<Order> {
}
