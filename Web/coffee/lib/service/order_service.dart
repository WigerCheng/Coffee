import 'package:coffee/model/order.dart';
import 'package:coffee/model/result.dart';
import 'package:coffee/model/user.dart';
import 'package:coffee/util/dio_app.dart';
import 'package:dio/dio.dart';

Future<Result<String>> pushOrderFinishNetwork(int orderId) async {
  Response response = await appDio
      .post("/order/pushOrderFinish", queryParameters: {"orderId": orderId});
  Result<String> result = Result.fromJson(response.data, (s) => s);
  return result;
}

Future<Result<String>> returnOrderNetwork(int orderId) async {
  Response response = await appDio.post("/order/returnOrder",
      queryParameters: {"orderId": orderId, "type": User.USER_MANAGER});
  Result<String> result = Result.fromJson(response.data, (s) => s);
  return result;
}

Future<Result<String>> deleteOrderNetwork(int orderId) async {
  Response response = await appDio
      .post("/order/deleteOrder", queryParameters: {"orderId": orderId});
  Result<String> result = Result.fromJson(response.data, (s) => s);
  return result;
}

Future<Result<List<Order>>> getOrderList() async =>
    await appDio.get("/order/orderList").then((value) => Result.fromJson(
        value.data,
        (orders) => (orders as List).map((e) => Order.fromJson(e)).toList()));

Future<Result<List<Order>>> getUserOrders(int userId) async => await appDio
    .get("/order/getUserOrders", queryParameters: {"userId": userId}).then(
        (value) => Result.fromJson(value.data,
            (json) => (json as List).map((e) => Order.fromJson(e)).toList()));

Future<Result<String>> receiveOrder(int orderId) async => await appDio
    .post("/order/receiveOrder", queryParameters: {"orderId": orderId}).then(
        (value) => Result.fromJson(value.data, (s) => s));
