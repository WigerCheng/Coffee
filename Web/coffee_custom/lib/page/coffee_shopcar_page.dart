import 'package:coffee_custom/model/car_model.dart';
import 'package:coffee_custom/model/user_model.dart';
import 'package:coffee_custom/pojo/order.dart';
import 'package:coffee_custom/pojo/result.dart';
import 'package:coffee_custom/pojo/user.dart';
import 'package:coffee_custom/service/order_service.dart';
import 'package:coffee_custom/service/user_service.dart';
import 'package:coffee_custom/util/dio_app.dart';
import 'package:coffee_custom/util/flutter_web_tool.dart';
import 'package:coffee_custom/util/ui_tool.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../number_change.dart';
import 'login_page.dart';

class CoffeeShopCarPage extends StatefulWidget {
  static const String routeName = "shopCar";

  @override
  _CoffeeShopCarPageState createState() => _CoffeeShopCarPageState();
}

class _CoffeeShopCarPageState extends State<CoffeeShopCarPage> {
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Consumer<CarModel>(
          builder: (context, model, child) {
            return Text("购物车(${model.shopCarList.length})");
          },
        ),
        actions: [
          FlatButton.icon(
            label: Text(
              "清空购物车",
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.clear_all,
              color: Colors.white,
            ),
            onPressed: () {
              Provider.of<CarModel>(context, listen: false).removeAll();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Consumer<CarModel>(
              builder: (context, model, child) {
                return Column(children: _orderColumn(model));
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Consumer<CarModel>(
        builder: (context, model, child) {
          return FloatingActionButton.extended(
            label: Text("结算(￥${model.totalPlace})"),
            backgroundColor:
                model.shopCarList.isEmpty ? Colors.grey : Colors.blue,
            onPressed: model.shopCarList.isEmpty
                ? null
                : () async {
                    if (userModel.user == null) {
                      //登录
                      alert("结算需要先登录");
                      User loginUser = await showLoginDialog(context);
                      if (loginUser != null) {
                        Result<User> result = await loginHelper(loginUser);
                        if (result.code == 1) {
                          userModel.user = result.data;
                        } else {
                          showToast(result.message);
                        }
                      }
                      return;
                    }
                    int userId = userModel.userId;
                    Order order = Order.create(
                        userId: userId,
                        orderCoffees: model.shopCarList,
                        orderMoney: model.totalPlace);
                    Result<String> result = await createOrder(order);
                    if (result.code == 1) {
                      model.removeAll();
                      Navigator.pop(context);
                      showToast("下单成功");
                    } else {
                      showToast("下单失败");
                    }
                  },
          );
        },
      ),
    );
  }

  List<Widget> _orderColumn(CarModel carModel) {
    return carModel.shopCarList
        .map((order) => Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(8.0),
                      icon: Icon(
                        Icons.remove_circle,
                        color: Colors.pinkAccent,
                      ),
                      onPressed: () {
                        carModel.remove(order);
                      },
                    ),
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(imageUrl(order.coffeeUrl)),
                    ),
                    Spacer(),
                    Expanded(
                      child: Text(
                        order.coffeeName,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Spacer(),
                    Wrap(
                      spacing: 4.0,
                      runSpacing: 8.0,
                      children: [
                        Chip(
                            label: Text(
                              order.coffeeSizeStr(),
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.lightBlueAccent),
                        Chip(
                            label: Text(
                              order.coffeeTemperatureStr(),
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.lightBlueAccent),
                        Chip(
                            label: Text(
                              order.coffeeSugarStr(),
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.lightBlueAccent)
                      ],
                    ),
                    Spacer(),
                    NumChangeWidget(
                      num: order.quantity,
                      onValueChanged: (value) {
                        setState(() {
                          order.quantity = value;
                        });
                      },
                    ),
                    Spacer(),
                    Text("总价钱：${order.totalCast().toStringAsFixed(2)}")
                  ],
                ),
              ),
            ))
        .toList();
  }
}
