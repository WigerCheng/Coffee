import 'package:json_annotation/json_annotation.dart';

import 'coffee_status.dart';

part 'coffee.g.dart';

@JsonSerializable(nullable: true)
class Coffee extends CoffeeStatus {
  @JsonKey(name: "coffeeId")
  int coffeeId;
  @JsonKey(name: "coffeeName")
  String coffeeName;
  @JsonKey(name: "coffeeUrl", nullable: true, defaultValue: "")
  String coffeeUrl;
  @JsonKey(name: "coffeePrice")
  double coffeePrice;
  @JsonKey(name: "coffeeStatus")
  int coffeeStatus;
  @JsonKey(name: "coffeeInformation", nullable: true, defaultValue: "")
  String coffeeInformation;
  @JsonKey(name: "coffeeSugar")
  @override
  int coffeeSugar;
  @JsonKey(name: "coffeeTemperature")
  @override
  int coffeeTemperature;
  @override
  @JsonKey(name: "coffeeSize")
  int coffeeSize;

  Coffee(
      {this.coffeeId,
      this.coffeeName,
      this.coffeeUrl,
      this.coffeePrice,
      this.coffeeStatus,
      this.coffeeInformation,
      this.coffeeSugar,
      this.coffeeTemperature,
      this.coffeeSize});

  Coffee.add(
      {this.coffeePrice = 0.0,
      this.coffeeUrl = "",
      this.coffeeStatus = 0,
      this.coffeeSugar = 0,
      this.coffeeTemperature = 0,
      this.coffeeSize = 0});

  String status() => coffeeStatus == 0 ? "上架" : "下架";

  String size() => isBigCup() ? "大杯" : "小杯";

  String temperate() => isHot() ? "热" : "冷";

  String sugar() {
    if (isNoSugar()) {
      return "无糖";
    } else if (isHalfSugar()) {
      return "半糖";
    } else {
      return "一份糖";
    }
  }

  factory Coffee.fromJson(Map<String, dynamic> json) => _$CoffeeFromJson(json);

  Map<String, dynamic> toJson() => _$CoffeeToJson(this);
}
