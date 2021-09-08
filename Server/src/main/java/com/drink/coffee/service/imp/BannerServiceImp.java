package com.drink.coffee.service.imp;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.drink.coffee.mapper.BannerMapper;
import com.drink.coffee.model.Result;
import com.drink.coffee.model.ResultCode;
import com.drink.coffee.pojo.Banner;
import com.drink.coffee.service.BannerService;
import com.drink.coffee.utils.DeleteFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class BannerServiceImp implements BannerService {

    @Autowired
    BannerMapper bannerMapper;

    @Override
    public Result<List<Banner>> selectBannerList() {
        /*获取轮播图列表*/
        List<Banner> bannerList = bannerMapper.selectList(new QueryWrapper<>());
        if (bannerList == null) {
            bannerList = new ArrayList<>();
        }
        return Result.success(bannerList);
    }

    @Override
    @Transactional
    public Result<String> deleteBanner(int bannerId) {
        /*在数据库中获取该图片信息*/
        Banner banner = bannerMapper.selectById(bannerId);
        if (banner == null) {
            return new Result<>(ResultCode.ERROR_CODE, "传入的ID有误", "传入的ID有误");
        }
        /*在磁盘上删除该图片*/
        boolean deleteFile = DeleteFile.deleteFile(banner.getBannerImg());
        /*在数据库中删除该图片的信息*/
        int result = bannerMapper.deleteById(bannerId);
        if (result == 1) {
            return new Result<>(ResultCode.SUCCESS_CODE, "删除图片成功", "删除图片成功");
        } else {
            return new Result<>(ResultCode.ERROR_CODE, "删除图片失败", "删除图片失败");
        }
    }

    @Override
    public Result<String> addBanner(Banner banner) {
        //插入数据库
        int result = bannerMapper.insert(banner);
        if (result == 1) {
            return Result.result(ResultCode.SUCCESS_CODE, "插入轮播图成功");
        } else {
            return Result.result(ResultCode.ERROR_CODE, "插入轮播图失败");
        }
    }

}
