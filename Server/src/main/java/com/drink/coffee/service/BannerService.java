package com.drink.coffee.service;

import com.drink.coffee.model.Result;
import com.drink.coffee.pojo.Banner;

import java.util.List;

public interface BannerService {

    /**
     * 轮播广告图列表
     *
     * @return 轮播广告图列表
     */
    Result<List<Banner>> selectBannerList();

    /**
     * 删除轮播广告
     *
     * @param bannerId 轮播广告Id
     * @return 删除结果
     */
    Result<String> deleteBanner(int bannerId);

    /**
     * 添加轮播广告
     *
     * @param banner 轮播广告
     * @return 添加结果
     */
    Result<String> addBanner(Banner banner);
}
