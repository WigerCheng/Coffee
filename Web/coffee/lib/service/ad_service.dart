import 'package:coffee/model/ad.dart';
import 'package:coffee/model/result.dart';
import 'package:coffee/util/dio_app.dart';
import 'package:dio/dio.dart';

Future<Result<String>> addBanner(AD ad) async {
  Response response = await appDio.post("/banner/addBanner", data: ad);
  Result<String> result = Result.fromJson(response.data, (s) => s);
  return result;
}

Future<Result<List<AD>>> getBanners() async {
  Response response = await appDio.get("/banner/selectBannerList");
  Result<List<AD>> result = Result.fromJson(response.data,
      (json) => List.from(json).map((e) => AD.fromJson(e)).toList());
  return result;
}

Future<Result<String>> deleteBanner(int bannerId) async {
  Response response = await appDio
      .post("/banner/deleteBanner", queryParameters: {"bannerId": bannerId});
  Result<String> result = Result.fromJson(response.data, (s) => s);
  return result;
}
