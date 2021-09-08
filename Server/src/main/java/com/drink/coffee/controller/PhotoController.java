package com.drink.coffee.controller;

import com.drink.coffee.model.Result;
import com.drink.coffee.model.ResultCode;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@RestController
public class PhotoController {

    @Value("${coffce.uploadDir}")
    private String uploadDir;

    @PostMapping("/upload")
    public Result<String> upload(@RequestParam("file") MultipartFile uploadFile) {
        if (uploadFile.isEmpty()) {
            return new Result<>(ResultCode.ERROR_CODE, "文件为空", "文件为空");
        }
        // 获取文件名
        String fileName = uploadFile.getOriginalFilename();
        // 获取文件的后缀名
        String suffixName = fileName.substring(fileName.lastIndexOf("."));
        fileName = UUID.randomUUID().toString().replace("-", "") + suffixName;
        File newFile = new File(uploadDir + fileName);
        if (!newFile.getParentFile().exists()) {
            newFile.getParentFile().mkdirs();
        }
        try {
            uploadFile.transferTo(newFile);
            return new Result<>(ResultCode.SUCCESS_CODE, "图片上传成功", fileName);
        } catch (IOException e) {
            e.printStackTrace();
            return new Result<>(ResultCode.ERROR_CODE, "内部错误", "图片上传失败");
        }
    }
}
