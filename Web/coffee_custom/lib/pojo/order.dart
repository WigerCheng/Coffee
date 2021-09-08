import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'coffee_order.dart';

part 'order.g.dart';

@JsonSerializable(includeIfNull: true)
class Order {
  @JsonKey(name: "orderId")
  int orderId;
  @JsonKey(name: "userId")
  int userId;
  @JsonKey(name: "userName")
  String userName;
  @JsonKey(name: "orderMoney")
  double orderMoney;
  @JsonKey(name: "orderStatus")
  int status;
  @JsonKey(name: "orderDate")
  int orderDate;
  @JsonKey(
      name: "orderCoffees",
      fromJson: orderCoffeesFromJson,
      toJson: orderCoffeesToJson)
  List<CoffeeOrder> orderCoffees;

  Order.create(
      {@required this.userId, @required this.orderCoffees, this.orderMoney});

  Order(
      {this.orderId,
      this.userId,
      this.userName,
      this.orderMoney,
      this.status,
      this.orderDate,
      this.orderCoffees});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  String getOrderStatus() {
    switch (status) {
      case ORDER_RECEIVED:
        return "已接单";
      case ORDER_NON_RECEIVED:
        return "未接单";
      case ORDER_RETURN:
        return "已退单";
      case ORDER_FINISH:
        return "已完成";
      default:
        return "未知状态";
    }
  }

  /// 已接单
  static const ORDER_RECEIVED = 0;

  /// 未接单
  static const ORDER_NON_RECEIVED = 1;

  /// 已退单
  static const ORDER_RETURN = 2;

  /// 已完成
  static const ORDER_FINISH = 3;

  Color typeBackgroundColor() {
    switch (status) {
      case Order.ORDER_RECEIVED:
        return Colors.yellow[400];
      case Order.ORDER_NON_RECEIVED:
        return Colors.pink[400];
      case Order.ORDER_RETURN:
        return Colors.red[400];
      case Order.ORDER_FINISH:
        return Colors.green[400];
      default:
        return Colors.blue[400];
    }
  }

}

List<CoffeeOrder> orderCoffeesFromJson(List<dynamic> json) {
  return json == null
      ? []
      : json.map((e) => CoffeeOrder.fromJson(e)).toList();
}

List<dynamic> orderCoffeesToJson(List<CoffeeOrder> coffees) {
  return coffees.map((e) => (e).toJson()).toList();
}
