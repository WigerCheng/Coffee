class CoffeeStatus {
  int coffeeSugar;
  int coffeeTemperature;
  int coffeeSize;

  bool isBigCup() => (coffeeSize & COFFEE_BIG_CUP) != 0;

  bool isSmallCup() => (coffeeSize & COFFEE_SMALL_CUP) != 0;

  bool isHot() => (coffeeTemperature & COFFEE_HOT) != 0;

  bool isCold() => (coffeeTemperature & COFFEE_COLD) != 0;

  bool isNoSugar() => (coffeeSugar & COFFEE_NO_SUGAR) != 0;

  bool isHalfSugar() => (coffeeSugar & COFFEE_HALF_SUGAR) != 0;

  bool isAllSugar() => (coffeeSugar & COFFEE_ALL_SUGAR) != 0;

  String coffeeSizeStr() => isBigCup() ? "大杯" : "小杯";

  String coffeeTemperatureStr() => isHot() ? "热" : "冷";

  String coffeeSugarStr() {
    if (isNoSugar()) {
      return "无糖";
    } else if (isHalfSugar()) {
      return "半糖";
    } else {
      return "一份糖";
    }
  }
}

/// 上架
const int ON_SOLD = 0;

///下架
const int OFF_SOLD = 1;

/// 大杯
const COFFEE_BIG_CUP = 1;

/// 小杯
const COFFEE_SMALL_CUP = 2;

/// 热
const COFFEE_HOT = 1;

/// 冷
const COFFEE_COLD = 2;

/// 无糖
const COFFEE_NO_SUGAR = 1;

/// 半份糖
const COFFEE_HALF_SUGAR = 2;

/// 单份糖
const COFFEE_ALL_SUGAR = 4;
