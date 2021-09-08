import 'dart:core';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:coffee/model/ad.dart';
import 'package:coffee/model/result.dart';
import 'package:coffee/service/ad_service.dart';
import 'package:coffee/util/dialog.dart';
import 'package:coffee/util/dio_app.dart';
import 'package:coffee/util/photo_tool.dart';
import 'package:coffee/util/ui_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ADManagePage extends StatefulWidget {
  @override
  _ADManagePageState createState() => _ADManagePageState();
}

class _ADManagePageState extends State<ADManagePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getBanners(),
      builder:
          (BuildContext context, AsyncSnapshot<Result<List<AD>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(minWidth: double.infinity),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    width: double.infinity,
                    height: 600,
                    child: Swiper(
                      itemBuilder: (context, index) {
                        return new Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              imageUrl(snapshot.data.data[index].bannerImg),
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              right: 8.0,
                              bottom: 8.0,
                              child: IconButton(
                                onPressed: () async {
                                  bool isDelete = await showConfirmDialog(
                                      context, "提示", "是否删除该广告");
                                  if (isDelete) {
                                    Result result = await deleteBanner(
                                        snapshot.data.data[index].bannerId);
                                    if (result.code == 1) {
                                      showToast("删除广告成功");
                                      setState(() {});
                                    } else {
                                      showToast(result.message);
                                    }
                                  }
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                      itemCount: snapshot.data.data.length ?? 0,
                      pagination: new SwiperPagination(),
                      control: new SwiperControl(),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      "添加广告图片",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      File photo = await pickImageFile();
                      Result<String> uploadPhotoResult =
                          await uploadImage(photo);
                      if (uploadPhotoResult.code == 1) {
                        Result<String> submitResult = await addBanner(
                            AD(bannerImg: uploadPhotoResult.data));
                        if (submitResult.code == 1) {
                          setState(() {
                            showToast("添加广告图片成功");
                          });
                        } else {
                          showToast("添加广告图片失败");
                        }
                      } else {
                        showToast("图片上传失败");
                      }
                    },
                  )
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
