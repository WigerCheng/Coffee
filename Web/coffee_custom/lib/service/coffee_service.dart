import 'package:coffee_custom/pojo/coffee.dart';
import 'package:coffee_custom/pojo/result.dart';
import 'package:coffee_custom/util/dio_app.dart';

Future<Result<List<Coffee>>> getCoffeeList() async =>
    await appDio.get("/coffee/coffeeList").then((response) => Result.fromJson(
        response.data,
        (coffees) =>
            (coffees as List).map((e) => Coffee.fromJson(e)).toList()));
