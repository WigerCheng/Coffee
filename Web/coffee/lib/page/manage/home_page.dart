import 'dart:convert';

import 'package:coffee/model/message.dart';
import 'package:coffee/model/ui/tab_page.dart';
import 'package:coffee/page/login_page.dart';
import 'package:coffee/page/manage/ad_manager_page.dart';
import 'package:coffee/util/dio_app.dart';
import 'package:coffee/util/flutter_web_tool.dart';
import 'package:flutter/material.dart';
import 'package:sse_client/html.dart';

import 'coffee/coffee_manager_page.dart';
import 'order/order_manager_page.dart';
import 'user/user_manager_page.dart';

class ManagerHomePage extends StatefulWidget {
  static const routeName = "manage_home";

  @override
  _ManagerHomePageState createState() => _ManagerHomePageState();
}

class _ManagerHomePageState extends State<ManagerHomePage> {
  int _selectIndex = 0;

  HtmlSseClient htmlSseClient;

  @override
  void initState() {
    super.initState();
    Uri url = Uri.parse(baseUrl + "notification/manager");
    htmlSseClient = new HtmlSseClient.connect(url);
    htmlSseClient.stream.listen((event) {
      Map<String, dynamic> j = json.decode(event);
      String content = Message.fromJson(j).content;
      notification(content);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("咖啡点单后台管理系统"),
        actions: [
          FlatButton(
            textColor: Colors.white,
            child: Text("登出"),
            onPressed: () {
              Navigator.popAndPushNamed(context, LoginPage.routeName);
            },
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          children: [
            NavigationRail(
              selectedIndex: _selectIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _selectIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: _buildPage(),
            ),
            VerticalDivider(
              thickness: 1,
              width: 1,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: _pages[_selectIndex].child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<NavigationRailDestination> _buildPage() {
    return _pages
        .map(
          (e) => NavigationRailDestination(
            icon: e.icon,
            selectedIcon: e.selectedIcon,
            label: Text(e.label),
          ),
        )
        .toList();
  }

  //后台界面列表
  List<TabPage> _pages = [
    TabPage(
      label: "用户管理",
      routeName: "user_manage",
      icon: Icon(Icons.people_outline),
      selectedIcon: Icon(Icons.people),
      child: UserManagePage(),
    ),
    TabPage(
      label: "订单管理",
      routeName: "order_manager",
      icon: Icon(Icons.account_balance_wallet_outlined),
      selectedIcon: Icon(Icons.account_balance_wallet),
      child: OrderManagePage(),
    ),
    TabPage(
      label: "咖啡管理",
      routeName: "coffee_manager",
      icon: Icon(Icons.wine_bar_outlined),
      selectedIcon: Icon(Icons.wine_bar),
      child: CoffeeManagePage(),
    ),
    TabPage(
      label: "广告管理",
      routeName: "ad_manager",
      icon: Icon(Icons.assessment_outlined),
      selectedIcon: Icon(Icons.assessment),
      child: ADManagePage(),
    )
  ];
}
