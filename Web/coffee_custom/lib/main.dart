import 'package:bot_toast/bot_toast.dart';
import 'package:coffee_custom/model/car_model.dart';
import 'package:coffee_custom/model/user_model.dart';
import 'package:coffee_custom/page/coffee_order_list_page.dart';
import 'package:coffee_custom/page/coffee_shopcar_page.dart';
import 'package:coffee_custom/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarModel()),
        ChangeNotifierProvider(
          create: (context) => UserModel(context),
        )
      ],
      child: MaterialApp(
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        title: '咖啡点单系统',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          CoffeeShopCarPage.routeName: (context) => CoffeeShopCarPage(),
          CoffeeOrderListPage.routeName: (context) => CoffeeOrderListPage()
        },
      ),
    );
  }
}
