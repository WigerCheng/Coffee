package com.drink.coffee.exception;

public class ServiceException extends RuntimeException{
    //定义构造信息
    private String message;

    //定义构造函数
    public ServiceException(String message){
        super(message);
        this.message = message;
    }
}
