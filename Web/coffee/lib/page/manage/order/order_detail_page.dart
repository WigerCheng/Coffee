import 'package:coffee/model/coffee_order.dart';
import 'package:coffee/model/order.dart';
import 'package:coffee/util/dio_app.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatefulWidget {
  final Order order;

  OrderDetailPage(this.order);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return _buildOrder(widget.order);
  }

  Widget _buildOrder(Order order) => Card(
        child: SingleChildScrollView(
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
                Divider(
                  height: 1,
                ),
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
              ],
            ),
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
            width: 100,
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
}

Future<void> showOrderManageDialog(context, order) => showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: 800,
          height: 600,
          child: OrderDetailPage(order),
        ),
      ),
    );
