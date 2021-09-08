import 'package:coffee_custom/model/car_model.dart';
import 'package:coffee_custom/pojo/coffee.dart';
import 'package:coffee_custom/pojo/coffee_order.dart';
import 'package:coffee_custom/pojo/coffee_status.dart';
import 'package:coffee_custom/util/dialog.dart';
import 'package:coffee_custom/util/dio_app.dart';
import 'package:coffee_custom/util/ui_tool.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../number_change.dart';

class CoffeeOrderPage extends StatefulWidget {
  final Coffee coffee;

  CoffeeOrderPage(this.coffee);

  @override
  _CoffeeOrderPageState createState() => _CoffeeOrderPageState(coffee);
}

class _CoffeeOrderPageState extends State<CoffeeOrderPage> {
  CoffeeOrder order;

  Coffee _coffee;

  _CoffeeOrderPageState(this._coffee) {
    order = CoffeeOrder.fromCoffee(_coffee);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildOrderWidgets(),
      ),
    );
  }

  List<Widget> _buildOrderWidgets() {
    var _widgets = [
      Image.network(
        imageUrl(_coffee.coffeeUrl),
        height: 200,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
      Text(
        _coffee.coffeeName ?? "",
        style: Theme.of(context).textTheme.headline4,
      ),
      Text(_coffee.coffeeInformation),
      Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          Text("咖啡规格"),
          Visibility(
            child: ChoiceChip(
              label: Text("大杯"),
              selected: order.isBigCup(),
              onSelected: !_coffee.isSmallCup()
                  ? null
                  : (value) {
                      if (value) {
                        setState(() {
                          order.coffeeSize = 0;
                          order.coffeeSize |= COFFEE_BIG_CUP;
                        });
                      }
                    },
            ),
            visible: _coffee.isBigCup(),
          ),
          Visibility(
            child: ChoiceChip(
              label: Text("小杯"),
              selected: order.isSmallCup(),
              onSelected: !_coffee.isBigCup()
                  ? null
                  : (value) {
                      if (value) {
                        setState(() {
                          order.coffeeSize = 0;
                          order.coffeeSize |= COFFEE_SMALL_CUP;
                        });
                      }
                    },
            ),
            visible: _coffee.isSmallCup(),
          )
        ],
      ),
      Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          Text("咖啡温度"),
          Visibility(
            child: ChoiceChip(
              label: Text("热"),
              selected: order.isHot(),
              onSelected: !_coffee.isCold()
                  ? null
                  : (value) {
                      if (value) {
                        setState(() {
                          order.coffeeTemperature = 0;
                          order.coffeeTemperature |= COFFEE_HOT;
                        });
                      }
                    },
            ),
            visible: _coffee.isHot(),
          ),
          Visibility(
            child: ChoiceChip(
              label: Text("冰"),
              selected: order.isCold(),
              onSelected: !_coffee.isHot()
                  ? null
                  : (value) {
                      if (value) {
                        setState(() {
                          order.coffeeTemperature = 0;
                          order.coffeeTemperature |= COFFEE_COLD;
                        });
                      }
                    },
            ),
            visible: _coffee.isCold(),
          )
        ],
      ),
      Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          Text("咖啡糖分"),
          Visibility(
            child: ChoiceChip(
              label: Text("无糖"),
              selected: order.isNoSugar(),
              onSelected: !_coffee.isHalfSugar() && !_coffee.isAllSugar()
                  ? null
                  : (value) {
                      if (value) {
                        setState(() {
                          // order.coffeeSugar ^= COFFEE_HALF_SUGAR;
                          // order.coffeeSugar ^= COFFEE_ALL_SUGAR;
                          order.coffeeSugar = 0;
                          order.coffeeSugar |= COFFEE_NO_SUGAR;
                        });
                      }
                    },
            ),
            visible: _coffee.isNoSugar(),
          ),
          Visibility(
            child: ChoiceChip(
              label: Text("半份糖"),
              selected: order.isHalfSugar(),
              onSelected: !_coffee.isNoSugar() && !_coffee.isAllSugar()
                  ? null
                  : (value) {
                      if (value) {
                        setState(() {
                          // order.coffeeSugar ^= COFFEE_NO_SUGAR;
                          // order.coffeeSugar ^= COFFEE_ALL_SUGAR;
                          order.coffeeSugar = 0;
                          order.coffeeSugar |= COFFEE_HALF_SUGAR;
                        });
                      }
                    },
            ),
            visible: _coffee.isHalfSugar(),
          ),
          Visibility(
            child: ChoiceChip(
              label: Text("全糖"),
              selected: !_coffee.isNoSugar() && !_coffee.isHalfSugar()
                  ? null
                  : order.isAllSugar(),
              onSelected: (value) {
                if (value) {
                  setState(() {
                    // order.coffeeSugar ^= COFFEE_NO_SUGAR;
                    // order.coffeeSugar ^= COFFEE_HALF_SUGAR;
                    order.coffeeSugar = 0;
                    order.coffeeSugar |= COFFEE_ALL_SUGAR;
                  });
                }
              },
            ),
            visible: _coffee.isAllSugar(),
          ),
        ],
      ),
      Text("总价：${order.totalCast().toStringAsFixed(2)}"),
      Row(
        children: [
          Text("咖啡数量："),
          NumChangeWidget(
            num: order.quantity,
            onValueChanged: (value) {
              setState(() {
                order.quantity = value;
              });
            },
          )
        ],
      ),
      Align(
        child: RaisedButton(
          child: Text(
            "加入购物车",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Provider.of<CarModel>(context, listen: false).add(order);
            dismissDialog(context, result: true);
            showToast("已加入购物车");
          },
          color: Colors.blue,
        ),
        alignment: Alignment.centerRight,
      )
    ];

    return _widgets
        .map((e) => Padding(
              padding: EdgeInsets.all(8.0),
              child: e,
            ))
        .toList();
  }
}
