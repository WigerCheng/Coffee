package com.drink.coffee.service.imp;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.drink.coffee.mapper.UserMapper;
import com.drink.coffee.model.Result;
import com.drink.coffee.model.ResultCode;
import com.drink.coffee.pojo.User;
import com.drink.coffee.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserServiceImp implements UserService {
    @Autowired
    UserMapper userMapper;

    public static final int USER_NOT_EXIST = 101;
    public static final int PASSWORD_WRONG = 102;

    /**
     * 用户登录
     *
     * @param account  账号
     * @param password 密码
     * @param userType 用户类型
     * @return 登录后的用户
     */
    @Override
    public Result<User> userLogin(String account, String password, int userType) {
        QueryWrapper<User> userQueryWrapper = new QueryWrapper<>();
        userQueryWrapper.eq("account", account);
        userQueryWrapper.eq("status", userType);
        if (userMapper.selectOne(userQueryWrapper) == null) {
            return new Result<>(USER_NOT_EXIST, "该账户不存在", null);
        }
        userQueryWrapper.eq("password", password);
        User user = userMapper.selectOne(userQueryWrapper);
        if (user == null) {
            return new Result<>(PASSWORD_WRONG, "密码错误", null);
        } else {
            return Result.success(user);
        }
    }

    /**
     * 用户列表
     *
     * @return 用户列表
     */
    @Override
    public Result<List<User>> userList() {
        List<User> userList = userMapper.selectList(new QueryWrapper<>());
        return Result.success(userList);
    }

    /**
     * 删除用户
     *
     * @param userId 用户Id
     * @return 删除结果
     */
    @Override
    @Transactional
    public Result<String> deleteUser(int userId) {
        int result = userMapper.deleteById(userId);
        if (result == 1) {
            return Result.result(ResultCode.SUCCESS_CODE, "删除用户成功");
        } else {
            return Result.result(ResultCode.ERROR_CODE, "删除用户失败");
        }
    }

    @Override
    @Transactional
    public Result<String> updateUser(User user) {
        if (userMapper.updateById(user) == 1) {
            return new Result<>(ResultCode.SUCCESS_CODE, "更新用户成功", "更新用户成功");
        } else {
            return new Result<>(ResultCode.ERROR_CODE, "更新用户失败", "更新用户失败");
        }
    }

    @Override
    @Transactional
    public Result<User> addUser(User user) {
        if (userMapper.selectById(user.getUserId()) == null) {
            if (userMapper.insert(user) == 1) {
                return new Result<>(ResultCode.SUCCESS_CODE, "新增用户成功", user);
            } else {
                return new Result<>(ResultCode.ERROR_CODE, "新增用户失败", null);
            }
        } else {
            return new Result<>(ResultCode.ERROR_CODE, "用户已存在", null);
        }
    }

    @Override
    public Result<User> getUserById(int userId) {
        User user = userMapper.selectById(userId);
        if (user != null) {
            return new Result<>(ResultCode.SUCCESS_CODE, "查询成功", user);
        } else {
            return new Result<>(ResultCode.ERROR_CODE, "查询失败，无此用户", null);
        }
    }
}
