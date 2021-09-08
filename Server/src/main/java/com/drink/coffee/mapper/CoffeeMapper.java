package com.drink.coffee.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.drink.coffee.pojo.Coffee;
import org.springframework.stereotype.Repository;

@Repository
public interface CoffeeMapper extends BaseMapper<Coffee> {
}
