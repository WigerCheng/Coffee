package com.drink.coffee.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.File;

@Component
public class DeleteFile {

    private static String folder;

    @Value("${coffce.uploadDir}")
    public void setFolder(String f) {
        folder = f;
    }

    public static boolean deleteFile(String fileUrl) {
        File file = new File(folder + fileUrl);
        return file.delete();
    }
}
