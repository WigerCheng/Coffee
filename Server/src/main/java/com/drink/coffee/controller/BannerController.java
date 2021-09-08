package com.drink.coffee.controller;

import com.drink.coffee.model.Result;
import com.drink.coffee.pojo.Banner;
import com.drink.coffee.service.BannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/banner")
public class BannerController {
    @Autowired
    BannerService bannerService;

    /**
     * 轮播广告图列表
     *
     * @return 轮播广告图列表
     */
    @GetMapping("/selectBannerList")
    public Result<List<Banner>> selectBannerList() {
        return bannerService.selectBannerList();
    }

    /**
     * 添加轮播广告
     *
     * @param banner 轮播广告
     * @return 添加结果
     */
    @PostMapping("/addBanner")
    public Result<String> addBanner(@RequestBody Banner banner) {
        return bannerService.addBanner(banner);
    }

    /**
     * 删除轮播广告
     *
     * @param bannerId 轮播广告Id
     * @return 删除结果
     */
    @PostMapping("/deleteBanner")
    public Result<String> deleteBanner(@RequestParam("bannerId") int bannerId) {
        return bannerService.deleteBanner(bannerId);
    }
}
