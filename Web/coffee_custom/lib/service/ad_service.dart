import 'package:coffee_custom/pojo/ad.dart';
import 'package:coffee_custom/pojo/result.dart';
import 'package:coffee_custom/util/dio_app.dart';

Future<Result<List<AD>>> getBanners() async => await appDio
    .get("/banner/selectBannerList")
    .then((response) => Result.fromJson(response.data,
        (json) => List.from(json).map((e) => AD.fromJson(e)).toList()));