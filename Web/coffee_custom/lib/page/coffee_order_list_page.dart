import 'package:coffee_custom/model/user_model.dart';
import 'package:coffee_custom/pojo/coffee_order.dart';
import 'package:coffee_custom/pojo/order.dart';
import 'package:coffee_custom/pojo/result.dart';
import 'package:coffee_custom/service/order_service.dart';
import 'package:coffee_custom/util/dialog.dart';
import 'package:coffee_custom/util/dio_app.dart';
import 'package:coffee_custom/util/ui_tool.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoffeeOrderListPage extends StatefulWidget {
  static const String routeName = "coffee_order_list_page";

  @override
  _CoffeeOrderListPageState createState() => _CoffeeOrderListPageState();
}

class _CoffeeOrderListPageState extends State<CoffeeOrderListPage> {
  @override
  Widget build(BuildContext context) {
    int _userId = Provider.of<UserModel>(context).userId;
    // int _userId = 34435;
    return Scaffold(
      appBar: AppBar(
        title: Text("订单列表"),
      ),
      body: FutureBuilder<Result<List<Order>>>(
        future: getUserOrders(_userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            if (snapshot.data.data.isNotEmpty) {
              return Container(
                padding: EdgeInsets.all(16.0),
                child: Scrollbar(
                  child: _buildOrderList(snapshot.data.data),
                ),
              );
            } else {
              return Center(
                child: Text("当前无订单"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  ListView _buildOrderList(List<Order> orders) => ListView.builder(
        itemBuilder: (_, int index) => _buildOrderColumn(orders[index]),
        itemCount: orders.length,
      );

  Widget _buildOrderColumn(Order order) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: order.typeBackgroundColor(),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      order.getOrderStatus(),
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "订单号：${order.orderId}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Text(DateTime.fromMillisecondsSinceEpoch(order.orderDate)
                      .toString())
                ],
              ),
              Column(
                children: order.orderCoffees
                    .map((e) => _buildOrderDetail(e))
                    .toList(),
              ),
              Divider(height: 1,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  child: Text(
                    "订单总价:   ${order.orderMoney}元",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  alignment: Alignment.centerRight,
                ),
              ),
              Visibility(
                visible: order.status == Order.ORDER_NON_RECEIVED ||
                    order.status == Order.ORDER_RECEIVED,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    child: RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {
                        _returnOrder(context, order.orderId);
                      },
                      child: Text("取消订单"),
                    ),
                    alignment: Alignment.centerRight,
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget _buildOrderDetail(CoffeeOrder order) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            imageUrl(order.coffeeUrl),
            width: 100,
            height: 100,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(
            width: 50,
          ),
          SizedBox(
            width: 200,
            child: Text(
              order.coffeeName,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Chip(
                      label: Text(
                        order.coffeeSizeStr(),
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.lightBlueAccent),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Chip(
                      label: Text(
                        order.coffeeTemperatureStr(),
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.lightBlueAccent),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Chip(
                      label: Text(
                        order.coffeeSugarStr(),
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.lightBlueAccent),
                )
              ],
            ),
          ),
          Text("×${order.quantity}"),
          SizedBox(width: 50),
          Text("单价:￥${order.coffeePrice}"),
          SizedBox(width: 50),
          Text("￥${order.totalCast().toStringAsFixed(2)}")
        ],
      ),
    );
  }

  _returnOrder(BuildContext context, int orderId) async {
    bool isReturn =
    await showConfirmDialog(context, "退单确认", "是否退掉ID为$orderId这份订单");
    if (isReturn) {
      Result<String> result = await returnOrderNetwork(orderId);
      if (result.code == 1) {
        setState(() {
          showToast("退单成功");
        });
      }
    }
  }

}
