package com.drink.coffee.model;

import java.io.Serializable;

public class Result<T> implements Serializable {
    /*响应信息*/
    String message;

    /*响应码*/
    Integer code;

    /*数据对象*/
    T data;

    /*空的构造方法*/
    public Result() {

    }

    /*Result类的构造方法*/
    public Result(Integer code, String message) {
        this.code = code;
        this.message = message;
    }

    /*带数据对象的Result类的构造方法*/
    public Result(Integer code, String message, T data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

    /*成功返回信息*/
    public static <T> Result<T> success() {
        return new Result<>(ResultCode.SUCCESS_CODE, ResultCode.SUCCESS_MESSAGE);
    }

    /*返回带数据对象的成功信息*/
    public static <T> Result<T> success(T data) {
        return new Result<>(ResultCode.SUCCESS_CODE, ResultCode.SUCCESS_MESSAGE, data);
    }

    /*返回带字符串的成功信息*/
    public static Result success(String str) {
        return new Result(ResultCode.SUCCESS_CODE, ResultCode.SUCCESS_MESSAGE, str);
    }

    /*错误返回信息*/
    public static Result error() {
        return new Result(ResultCode.ERROR_CODE, ResultCode.ERROR_MESSAGE);
    }

    /*找不到返回信息*/
    public static Result notFound() {
        return new Result(ResultCode.NOT_FOUND_CODE, ResultCode.NOT_FOUND_MESSAGE);
    }

    /*返回对象为空信息*/
    public static Result isNull() {
        return new Result(ResultCode.IS_NULL_CODE, ResultCode.IS_NULL_MESSAGE);
    }

    /*业务异常信息*/
    public static Result serviceException(String msg) {
        return new Result(ResultCode.SERVICE_CODE, msg);
    }

    /*结果信息*/
    public static <T> Result<T> result(Integer code, String message) {
        return new Result<>(code, message);
    }

    /*序列化信息*/
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public Object getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

}
