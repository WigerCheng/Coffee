import 'package:coffee/model/coffee.dart';
import 'package:coffee/model/result.dart';
import 'package:coffee/util/dio_app.dart';
import 'package:dio/dio.dart';

Future<Result<List<Coffee>>> getCoffeeList() async {
  Response response = await appDio.get("/coffee/coffeeList");
  Result<List<Coffee>> result = Result.fromJson(response.data,
      (coffees) => (coffees as List).map((e) => Coffee.fromJson(e)).toList());
  return result;
}

Future<Result<String>> deleteCoffee(int coffeeId) async {
  Response response = await appDio
      .post("/coffee/deleteCoffee", queryParameters: {"coffeeId": coffeeId});
  Result<String> result = Result.fromJson(response.data, (s) => s);
  return result;
}

Future<Result<String>> addOrUpdateCoffee(Coffee coffee) async {
  Response response =
      await appDio.post("/coffee/addOrUpdateCoffee", data: coffee);
  Result<String> result = Result.fromJson(response.data, (s) => s);
  return result;
}

Future<Result<String>> updateStatus(int coffeeId, int status) async {
  Response response = await appDio.post("/coffee/updateStatus",
      queryParameters: {"coffeeId": coffeeId, "status": status});
  Result<String> result = Result.fromJson(response.data, (s) => s);
  return result;
}
