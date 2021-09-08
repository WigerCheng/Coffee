package com.drink.coffee.exception;

import com.drink.coffee.model.Result;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
public class GlobalException {
    //声明要捕获的异常类
    @ExceptionHandler(ServiceException.class)
    @ResponseBody
    public Result defaultExceptionHandler(Exception e) {
        e.printStackTrace();
        if (e instanceof ServiceException) {
            return Result.serviceException(e.getMessage());
        }
        return Result.result(-10, "系统异常" + e);
    }
}
