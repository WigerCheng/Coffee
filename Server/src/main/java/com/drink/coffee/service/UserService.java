package com.drink.coffee.service;

import com.drink.coffee.model.Result;
import com.drink.coffee.pojo.User;

import java.util.List;

public interface UserService {
    /**
     * 用户登录
     *
     * @param account  账号
     * @param password 密码
     * @param userType 用户类型
     * @return 登录的用户
     */
    Result<User> userLogin(String account, String password, int userType);

    /**
     * 用户列表
     *
     * @return 用户列表
     */
    Result<List<User>> userList();

    /**
     * 删除用户
     *
     * @param userId 用户Id
     * @return 删除结果
     */
    Result<String> deleteUser(int userId);

    /**
     * 更新用户信息
     *
     * @param user 更新的用户
     * @return 更新结果
     */
    Result<String> updateUser(User user);

    /**
     * 注册用户
     *
     * @param user 注册的用户
     * @return 注册的用户
     */
    Result<User> addUser(User user);

    /**
     * 获取用户
     *
     * @param userId 用户ID
     * @return 用户
     */
    Result<User> getUserById(int userId);
}
