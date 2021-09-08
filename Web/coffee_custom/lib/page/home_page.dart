import 'package:coffee_custom/model/user_model.dart';
import 'package:coffee_custom/page/login_page.dart';
import 'package:coffee_custom/page/register_page.dart';
import 'package:coffee_custom/page/user_manager_edit.dart';
import 'package:coffee_custom/pojo/result.dart';
import 'package:coffee_custom/pojo/user.dart';
import 'package:coffee_custom/service/user_service.dart';
import 'package:coffee_custom/util/flutter_web_tool.dart';
import 'package:coffee_custom/util/ui_tool.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'coffee_list_page.dart';
import 'coffee_order_list_page.dart';
import 'coffee_shopcar_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = "customer_home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("咖啡点单系统"),
            actions: [
              Visibility(
                visible: model.user == null,
                child: FlatButton(
                  child: Text(
                    "注册",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    User registerUser = await showRegisterDialog(context);
                    if (registerUser != null) {
                      showToast("用户注册成功");
                      _login(registerUser);
                    }
                  },
                ),
              ),
              Visibility(
                visible: model.user == null,
                child: FlatButton(
                  child: Text(
                    "登录",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    User loginUser = await showLoginDialog(context);
                    if (loginUser != null) {
                      _login(loginUser);
                    }
                  },
                ),
              ),
              Visibility(
                child: ButtonBar(
                  children: [
                    FlatButton(
                      child: Text(
                        "欢迎你，${model.user == null ? "" : model.user.userName}",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        User _updateUser =
                            await showUserManageDialog(context, model.user);
                        if (_updateUser != null) {
                          updateUser(context, _updateUser);
                          showToast("用户信息更新成功");
                        }
                      },
                    ),
                    FlatButton(
                      child: Text(
                        "登出",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        model.clearUser();
                      },
                    )
                  ],
                ),
                visible: model.user != null,
              )
            ],
          ),
          body: CoffeeListPage(),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                heroTag: "shop_car",
                icon: Icon(Icons.shopping_cart),
                label: Text("购物车"),
                onPressed: () {
                  Navigator.pushNamed(context, CoffeeShopCarPage.routeName);
                },
              ),
              SizedBox(
                height: 20,
              ),
              FloatingActionButton.extended(
                heroTag: "order_list",
                icon: Icon(Icons.widgets),
                label: Text("订单列表"),
                onPressed: () async {
                  if (model.user == null) {
                    //登录
                    alert("打开订单列表需要先登录");
                    User loginUser = await showLoginDialog(context);
                    if (loginUser != null) {
                      _login(loginUser);
                    }
                    return;
                  } else {
                    Navigator.pushNamed(context, CoffeeOrderListPage.routeName);
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  void _login(User user) async {
    Result<User> result = await loginHelper(user);
    if (result.code == 1) {
      updateUser(context, result.data);
      showToast("用户登录成功");
    } else {
      showToast(result.message);
    }
  }

  void updateUser(context, User user) async {
    Provider.of<UserModel>(context, listen: false).user = user;
  }
}
