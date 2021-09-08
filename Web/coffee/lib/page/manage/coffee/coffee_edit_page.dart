// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:typed_data';

import 'package:coffee/model/coffee.dart';
import 'package:coffee/model/coffee_status.dart';
import 'package:coffee/model/result.dart';
import 'package:coffee/service/coffee_service.dart';
import 'package:coffee/util/dialog.dart';
import 'package:coffee/util/dio_app.dart';
import 'package:coffee/util/flutter_web_tool.dart';
import 'package:coffee/util/photo_tool.dart';
import 'package:coffee/util/ui_tool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoffeeEditPage extends StatefulWidget {
  final Coffee _coffee;

  CoffeeEditPage(this._coffee);

  @override
  _CoffeeEditPageState createState() => _CoffeeEditPageState();
}

class _CoffeeEditPageState extends State<CoffeeEditPage> {
  Coffee _coffee;
  final _formKey = GlobalKey<FormState>();
  File _tempFile;
  Uint8List _tempByte;
  bool _coffeeSizeVisibility = false;
  bool _coffeeTemperatureVisibility = false;
  bool _coffeeSugarVisibility = false;
  bool _coffeePhotoVisibility = false;

  @override
  Widget build(BuildContext context) {
    _coffee = widget._coffee;
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildCoffeeWidgets(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCoffeeWidgets() {
    var widgets = [
      TextFormField(
        initialValue: _coffee.coffeeName ?? "",
        decoration: InputDecoration(labelText: "咖啡名字"),
        validator: (value) {
          if (value.isEmpty) {
            return "咖啡名字不能为空";
          }
          return null;
        },
        onSaved: (value) {
          _coffee.coffeeName = value;
        },
      ),
      TextFormField(
        initialValue: _coffee.coffeePrice.toString() ?? "",
        decoration: InputDecoration(labelText: "咖啡价格"),
        validator: (value) {
          RegExp regexp = new RegExp(r"[0-9]*\.?[0-9]+$");
          if (regexp.hasMatch(value)) {
            return null;
          } else {
            return "输入的价格有误";
          }
        },
        onSaved: (value) {
          _coffee.coffeePrice = double.parse(value);
        },
      ),
      TextFormField(
        initialValue: _coffee.coffeeInformation ?? "",
        keyboardType: TextInputType.multiline,
        maxLines: 7,
        minLines: 1,
        decoration: InputDecoration(labelText: "咖啡文字介绍"),
        onSaved: (value) {
          _coffee.coffeeInformation = value;
        },
      ),
      Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          Text("咖啡规格"),
          ChoiceChip(
            label: Text("大杯"),
            selected: _coffee.isBigCup(),
            onSelected: (value) {
              if (value) {
                setState(() {
                  _coffee.coffeeSize |= COFFEE_BIG_CUP;
                });
              } else {
                setState(() {
                  _coffee.coffeeSize ^= COFFEE_BIG_CUP;
                });
              }
            },
          ),
          ChoiceChip(
            label: Text("小杯"),
            selected: _coffee.isSmallCup(),
            onSelected: (value) {
              if (value) {
                setState(() {
                  _coffee.coffeeSize |= COFFEE_SMALL_CUP;
                });
              } else {
                setState(() {
                  _coffee.coffeeSize ^= COFFEE_SMALL_CUP;
                });
              }
            },
          ),
          Visibility(
            child: Text(
              "咖啡规格至少选一个",
              style: TextStyle(color: Colors.red),
            ),
            visible: _coffeeSizeVisibility,
          )
        ],
      ),
      Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          Text("咖啡温度"),
          ChoiceChip(
            label: Text("热"),
            selected: _coffee.isHot(),
            onSelected: (value) {
              if (value) {
                setState(() {
                  _coffee.coffeeTemperature |= COFFEE_HOT;
                });
              } else {
                setState(() {
                  _coffee.coffeeTemperature ^= COFFEE_HOT;
                });
              }
            },
          ),
          ChoiceChip(
            label: Text("冰"),
            selected: _coffee.isCold(),
            onSelected: (value) {
              if (value) {
                setState(() {
                  _coffee.coffeeTemperature |= COFFEE_COLD;
                });
              } else {
                setState(() {
                  _coffee.coffeeTemperature ^= COFFEE_COLD;
                });
              }
            },
          ),
          Visibility(
            child: Text(
              "咖啡温度至少选一个",
              style: TextStyle(color: Colors.red),
            ),
            visible: _coffeeTemperatureVisibility,
          )
        ],
      ),
      Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          Text("咖啡糖分"),
          ChoiceChip(
            label: Text("无糖"),
            selected: _coffee.isNoSugar(),
            onSelected: (value) {
              if (value) {
                setState(() {
                  _coffee.coffeeSugar |= COFFEE_NO_SUGAR;
                });
              } else {
                setState(() {
                  _coffee.coffeeSugar ^= COFFEE_NO_SUGAR;
                });
              }
            },
          ),
          ChoiceChip(
            label: Text("半份糖"),
            selected: _coffee.isHalfSugar(),
            onSelected: (value) {
              if (value) {
                setState(() {
                  _coffee.coffeeSugar |= COFFEE_HALF_SUGAR;
                });
              } else {
                setState(() {
                  _coffee.coffeeSugar ^= COFFEE_HALF_SUGAR;
                });
              }
            },
          ),
          ChoiceChip(
            label: Text("全糖"),
            selected: _coffee.isAllSugar(),
            onSelected: (value) {
              if (value) {
                setState(() {
                  _coffee.coffeeSugar |= COFFEE_ALL_SUGAR;
                });
              } else {
                setState(() {
                  _coffee.coffeeSugar ^= COFFEE_ALL_SUGAR;
                });
              }
            },
          ),
          Visibility(
            child: Text(
              "咖啡糖分至少选一个",
              style: TextStyle(color: Colors.red),
            ),
            visible: _coffeeSugarVisibility,
          )
        ],
      ),
      Row(
        children: [
          Expanded(
            flex: 8,
            child: Row(
              children: [
                Text(
                  "咖啡图片",
                  style: TextStyle(color: Colors.grey),
                ),
                Visibility(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "没有添加咖啡图片",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  visible: _coffeePhotoVisibility,
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: FlatButton(
              child: Text("选择咖啡图片"),
              onPressed: () async {
                _tempFile = await pickImageFile();
                Uint8List i = await fileToUint8List(_tempFile);
                setState(() {
                  _tempByte = i;
                });
              },
            ),
          )
        ],
      ),
      Builder(
        builder: (context) {
          if (_tempByte == null && _coffee.coffeeUrl.isNotEmpty) {
            return Image.network(imageUrl(_coffee.coffeeUrl));
          }
          if (_tempByte == null) {
            return Container();
          } else {
            return Image.memory(
              _tempByte,
              height: 200,
            );
          }
        },
      ),
      Align(
        child: ButtonBar(
          children: [
            FlatButton(
              child: Text("返回"),
              onPressed: () {
                dismissDialog(context, result: false);
              },
            ),
            RaisedButton(
              child: Text(_coffee.coffeeId == null ? "添加" : "更新"),
              color: Colors.blue,
              onPressed: () async {
                setState(() {
                  _coffeeSizeVisibility = _coffee.coffeeSize == 0;
                  _coffeeTemperatureVisibility = _coffee.coffeeTemperature == 0;
                  _coffeeSugarVisibility = _coffee.coffeeSugar == 0;
                  _coffeePhotoVisibility =
                      _tempByte == null && _coffee.coffeeUrl.isEmpty;
                });
                if (_formKey.currentState.validate() &&
                    !_coffeeSugarVisibility &&
                    !_coffeeSizeVisibility &&
                    !_coffeeTemperatureVisibility &&
                    !_coffeePhotoVisibility) {
                  _formKey.currentState.save();
                  Result<String> result = await _updateCoffee(_coffee);
                  showToast(result.message);
                  if (result.code == 1) {
                    dismissDialog(context, result: true);
                  }
                }
              },
            )
          ],
        ),
      )
    ];
    return widgets
        .map((e) => Padding(
              padding: EdgeInsets.all(8.0),
              child: e,
            ))
        .toList();
  }

  Future<Result<String>> _updateCoffee(Coffee coffee) async {
    if (_tempFile == null) {
      return addOrUpdateCoffee(coffee);
    }
    Result<String> uploadPhotoResult = await uploadImage(_tempFile);
    if (uploadPhotoResult.code == 1) {
      _coffee.coffeeUrl = uploadPhotoResult.data;
      return addOrUpdateCoffee(coffee);
    } else {
      return uploadPhotoResult;
    }
  }
}
