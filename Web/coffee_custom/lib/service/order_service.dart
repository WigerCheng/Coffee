import 'package:coffee_custom/pojo/order.dart';
import 'package:coffee_custom/pojo/result.dart';
import 'package:coffee_custom/pojo/user.dart';
import 'package:coffee_custom/util/dio_app.dart';

Future<Result<String>> createOrder(Order order) async => await appDio
    .post("/order/createOrder", data: order)
    .then((value) => Result.fromJson(value.data, (s) => s));

Future<Result<List<Order>>> getUserOrders(int userId) async => await appDio
    .get("/order/getUserOrders", queryParameters: {"userId": userId}).then(
        (response) => Result.fromJson(response.data,
            (json) => (json as List).map((e) => Order.fromJson(e)).toList()));

Future<Result<String>> returnOrderNetwork(int orderId) async =>
    await appDio.post("/order/returnOrder", queryParameters: {
      "orderId": orderId,
      "type": User.USER_CUSTOMER
    }).then((response) => Result.fromJson(response.data, (s) => s));
