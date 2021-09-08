package com.drink.coffee.service.imp;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.drink.coffee.mapper.CoffeeMapper;
import com.drink.coffee.model.Result;
import com.drink.coffee.model.ResultCode;
import com.drink.coffee.pojo.Coffee;
import com.drink.coffee.service.CoffeeService;
import com.drink.coffee.utils.DeleteFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CoffeeServiceImp implements CoffeeService {

    @Autowired
    CoffeeMapper coffeeMapper;

    @Override
    public Result<List<Coffee>> getCoffeeList() {
        List<Coffee> coffees = coffeeMapper.selectList(new QueryWrapper<>());
        return new Result<>(ResultCode.SUCCESS_CODE, "查询成功", coffees);
    }

    @Override
    @Transactional
    public Result<String> deleteCoffee(Integer coffeeId) {
        Coffee coffee = coffeeMapper.selectById(coffeeId);
        if (coffee != null) {
            DeleteFile.deleteFile(coffee.getCoffeeUrl());
        }
        int result = coffeeMapper.deleteById(coffeeId);
        if (result == 1) {
            return new Result<>(ResultCode.SUCCESS_CODE, "删除成功", "咖啡删除成功");
        } else {
            return new Result<>(ResultCode.ERROR_CODE, "删除失败", "删除失败");
        }
    }

    @Override
    public Result<String> addOrUpdateCoffee(Coffee coffee) {
        Coffee c = coffeeMapper.selectById(coffee.getCoffeeId());
        if (c != null) {
            int result = coffeeMapper.updateById(coffee);
            if (result == 1) {
                return new Result<>(ResultCode.SUCCESS_CODE, "更新成功", "咖啡更新成功");
            } else {
                return new Result<>(ResultCode.ERROR_CODE, "更新失败", "咖啡更新失败");
            }
        } else {
            int result = coffeeMapper.insert(coffee);
            if (result == 1) {
                return new Result<>(ResultCode.SUCCESS_CODE, "添加成功", "咖啡添加成功");
            } else {
                return new Result<>(ResultCode.ERROR_CODE, "添加失败", "咖啡添加失败");
            }
        }
    }

    @Override
    public Result<Coffee> selectCoffeeInfo(Integer coffeeId) {
        Coffee coffee = coffeeMapper.selectById(coffeeId);
        if (coffee != null) {
            return new Result<>(ResultCode.SUCCESS_CODE, "查询成功", coffee);
        } else {
            return new Result<>(ResultCode.ERROR_CODE, "没找到", null);
        }
    }

    @Override
    public Result<String> updateStatus(Integer coffeeId, Integer status) {
        UpdateWrapper<Coffee> updateWrapper = new UpdateWrapper<>();
        updateWrapper.set("coffee_status", status);
        updateWrapper.eq("coffee_id", coffeeId);
        int result = coffeeMapper.update(null, updateWrapper);
        if (result == 1) {
            return new Result<>(ResultCode.SUCCESS_CODE, status == 0 ? "上架成功" : "下架成功", status == 0 ? "上架成功" : "下架成功");
        } else {
            return new Result<>(ResultCode.ERROR_CODE, "修改状态失败", "修改状态失败");
        }
    }
}
