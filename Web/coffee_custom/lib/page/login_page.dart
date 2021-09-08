import 'package:coffee_custom/pojo/result.dart';
import 'package:coffee_custom/pojo/user.dart';
import 'package:coffee_custom/service/user_service.dart';
import 'package:coffee_custom/util/dialog.dart';
import 'package:coffee_custom/util/ui_tool.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  User _user = User(type: User.USER_CUSTOMER);
  String _passwordHelpText;
  String _accountHelpText;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildLoginWidgets(),
      ),
    );
  }

  List<Widget> _buildLoginWidgets() {
    List<Widget> widgets = [
      Text('登录', style: Theme.of(context).textTheme.headline5)
    ];
    var paddingList = [
      TextFormField(
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
          FlatButton(
            textColor: Colors.blue,
            onPressed: () {
              dismissDialog(context);
            },
            child: Text("返回"),
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
                  dismissDialog(context, result: result.data);
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

Future<User> showLoginDialog(context) => showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 400,
          child: LoginPage(),
        ),
      ),
    );
