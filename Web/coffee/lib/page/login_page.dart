import 'package:coffee/model/result.dart';
import 'package:coffee/model/user.dart';
import 'package:coffee/page/register_page.dart';
import 'package:coffee/service/user_service.dart';
import 'package:coffee/util/ui_tool.dart';
import 'package:flutter/material.dart';

import 'manage/home_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  User _user = User(type: User.USER_MANAGER);
  String _passwordHelpText;
  String _accountHelpText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            width: 400,
            child: Card(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _buildLoginWidgets(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLoginWidgets() {
    List<Widget> widgets = [
      Text('咖啡点单管理系统', style: Theme.of(context).textTheme.headline5)
    ];
    var paddingList = [
      TextFormField(
        initialValue: _user.account ?? "",
        decoration: InputDecoration(
          labelText: "账号",
          prefixIcon: Icon(Icons.person),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "账号不能为空";
          }
          return _accountHelpText;
        },
        onSaved: (value) {
          _user.account = value;
        },
      ),
      TextFormField(
        initialValue: _user.password ?? "",
        obscureText: true,
        decoration: InputDecoration(
          labelText: "密码",
          prefixIcon: Icon(Icons.lock),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "密码不能为空";
          }
          return _passwordHelpText;
        },
        onSaved: (value) {
          _user.password = value;
        },
      ),
      ButtonBar(
        children: [
          RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () async {
              var _u = await Navigator.pushNamed(
                  context, RegisterPage.routeName);
              if (_u != null) {
                setState(() {
                  _user = _u as User;
                });
              }
            },
            child: Text("注册"),
          ),
          RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                Result<User> result =
                    await login(_user.account, _user.password, _user.type);
                if (result.code == 1) {
                  Navigator.pushReplacementNamed(
                      context, ManagerHomePage.routeName);
                  showToast("登录成功");
                } else if (result.code == 101) {
                  setState(() {
                    _accountHelpText = result.message;
                    _formKey.currentState.validate();
                    _accountHelpText = null;
                  });
                } else if (result.code == 102) {
                  setState(() {
                    _passwordHelpText = result.message;
                    _formKey.currentState.validate();
                    _passwordHelpText = null;
                  });
                } else {
                  showToast(result.message);
                }
              }
            },
            child: Text("登录"),
          )
        ],
      )
    ];
    widgets.addAll(paddingList.map((e) => Padding(
          padding: EdgeInsets.all(8.0),
          child: e,
        )));
    return widgets;
  }
}
