import 'package:json_annotation/json_annotation.dart';

import 'coffee.dart';
import 'coffee_status.dart';

part 'coffee_order.g.dart';

@JsonSerializable()
class CoffeeOrder extends CoffeeStatus {
  @JsonKey(name: "coffeeId")
  int coffeeId;
  @JsonKey(name: "quantity")
  int quantity;
  @JsonKey(name: "coffeeSugar")
  int coffeeSugar;
  @JsonKey(name: "coffeeTemperature")
  int coffeeTemperature;
  @JsonKey(name: "coffeeSize")
  int coffeeSize;
  @JsonKey(name: "coffeePrice")
  double coffeePrice;
  @JsonKey(name: "coffeeUrl")
  String coffeeUrl;
  @JsonKey(name: "coffeeName")
  String coffeeName;

  CoffeeOrder();

  CoffeeOrder.fromCoffee(Coffee coffee) {
    coffeeId = coffee.coffeeId;
    coffeePrice = coffee.coffeePrice;
    coffeeName = coffee.coffeeName;
    coffeeUrl = coffee.coffeeUrl;
    quantity = 1;

    if (coffee.isBigCup() && coffee.isSmallCup()) {
      coffeeSize = COFFEE_BIG_CUP;
    } else {
      coffeeSize = coffee.coffeeSize;
    }
    if (coffee.isHot() && coffee.isCold()) {
      coffeeTemperature = COFFEE_HOT;
    } else {
      coffeeTemperature = coffee.coffeeTemperature;
    }
    Set<int> s = Set();
    if (coffee.isNoSugar()) {
      s.add(COFFEE_NO_SUGAR);
    } else if (coffee.isHalfSugar()) {
      s.add(COFFEE_HALF_SUGAR);
    } else {
      s.add(COFFEE_ALL_SUGAR);
    }
    coffeeSugar = s.toList()[0];
  }

  factory CoffeeOrder.fromJson(Map<String, dynamic> json) =>
      _$CoffeeOrderFromJson(json);

  Map<String, dynamic> toJson() => _$CoffeeOrderToJson(this);

  double totalCast() => quantity * coffeePrice;
}
