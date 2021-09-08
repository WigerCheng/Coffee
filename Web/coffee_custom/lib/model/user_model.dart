import 'dart:convert';

import 'package:coffee_custom/pojo/message.dart';
import 'package:coffee_custom/pojo/result.dart';
import 'package:coffee_custom/pojo/user.dart';
import 'package:coffee_custom/service/user_service.dart';
import 'package:coffee_custom/util/dio_app.dart';
import 'package:coffee_custom/util/flutter_web_tool.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sse_client/html.dart';

class UserModel extends ChangeNotifier {
  User _user;
  final BuildContext context;
  SharedPreferences sharedPreferences;

  HtmlSseClient htmlSseClient;

  void initSse(int userId) {
    Uri url = Uri.parse(baseUrl + "notification/$userId");
    htmlSseClient = new HtmlSseClient.connect(url);
    htmlSseClient.stream.listen((event) {
      Map<String, dynamic> j = json.decode(event);
      String content = Message.fromJson(j).content;
      notification(content);
    });
  }

  UserModel(this.context) {
    initSP(context);
  }

  void initSP(context) async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("userId")) {
      int _userId = sharedPreferences.getInt("userId");
      Result<User> result = await getUserById(_userId);
      if (result.code == 1) {
        user = result.data;
      }
    }
  }

  set user(User u) {
    _user = u;
    sharedPreferences.setInt("userId", userId);
    initSse(userId);
    notifyListeners();
  }

  void clearUser() {
    sharedPreferences.remove("userId");
    _user = null;
    notifyListeners();
  }

  User get user => _user;

  int get userId => _user.userId;
}
