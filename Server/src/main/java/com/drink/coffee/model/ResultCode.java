package com.drink.coffee.model;

public class ResultCode {
    /*业务异常状态码*/
    public static final Integer SERVICE_CODE = -1;
    /*成功状态码*/
    public static final Integer SUCCESS_CODE = 1;
    /*失败状态码*/
    public static final Integer ERROR_CODE = 0;
    /*找不到状态码*/
    public static final Integer NOT_FOUND_CODE = 2;
    /*为空状态码*/
    public static final Integer IS_NULL_CODE = 3;
    /*成功信息*/
    public static final String SUCCESS_MESSAGE = "success";
    /*失败信息*/
    public static final String ERROR_MESSAGE = "error";
    /*找不到信息*/
    public static final String NOT_FOUND_MESSAGE = "not found";
    /*为空信息*/
    public static final String IS_NULL_MESSAGE = "is null";
}
