import 'dart:collection';

import 'package:coffee_custom/pojo/coffee_order.dart';
import 'package:flutter/material.dart';

class CarModel extends ChangeNotifier {
  final List<CoffeeOrder> _shopCarList = [];

  UnmodifiableListView<CoffeeOrder> get shopCarList =>
      UnmodifiableListView(_shopCarList);

  double get totalPlace {
    double _sum = 0.0;
    _shopCarList.forEach((element) {
      _sum += element.totalCast();
    });
    return _sum;
  }

  void add(CoffeeOrder coffeeOrder) {
    _shopCarList.add(coffeeOrder);
    notifyListeners();
  }

  void remove(CoffeeOrder coffeeOrder) {
    _shopCarList.remove(coffeeOrder);
    notifyListeners();
  }

  void removeAll() {
    _shopCarList.clear();
    notifyListeners();
  }
}
