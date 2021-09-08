package com.drink.coffee.controller;

import com.drink.coffee.model.Result;
import com.drink.coffee.pojo.User;
import com.drink.coffee.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    UserService userService;

    /**
     * 登录
     *
     * @param account  账号
     * @param password 密码
     * @param userType 用户类型
     * @return 登录后的User
     */
    @PostMapping("/login")
    public Result<User> loginUser(
            @RequestParam(value = "account", required = false) String account,
            @RequestParam(value = "password", required = false) String password,
            @RequestParam(value = "type", required = false) int userType) {
        return userService.userLogin(account, password, userType);
    }

    @GetMapping("/userList")
    public Result<List<User>> getUserList() {
        return userService.userList();
    }

    /**
     * 删除用户
     *
     * @param userId 用户Id
     * @return 成功信息
     */
    @PostMapping("/deleteUser")
    public Result<String> deleteUser(@RequestParam(value = "userId") Integer userId) {
        return userService.deleteUser(userId);
    }

    /**
     * 更新用户
     *
     * @param user 用户Id
     * @return 成功信息
     */
    @PostMapping("/updateUser")
    public Result<String> updateUser(@RequestBody User user) {
        return userService.updateUser(user);
    }

    /**
     * 添加用户
     *
     * @param user 用户Id
     * @return 成功信息
     */
    @PostMapping("/addUser")
    public Result<User> addUser(@RequestBody User user) {
        return userService.addUser(user);
    }

    @GetMapping("/getUser")
    public Result<User> getUserById(@RequestParam(value = "userId") Integer userId) {
        return userService.getUserById(userId);
    }
}