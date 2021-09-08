import 'package:coffee_custom/pojo/result.dart';
import 'package:coffee_custom/pojo/user.dart';
import 'package:coffee_custom/service/user_service.dart';
import 'package:coffee_custom/util/dialog.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  User _user = User(type: User.USER_CUSTOMER, sex: "男");
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();

  bool _isSamePassword() =>
      _passwordController.text == _passwordAgainController.text;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildRegisterWidgets(),
      ),
    );
  }

  List<Widget> _buildRegisterWidgets() {
    List<Widget> widgets = [
      Text('注册账号', style: Theme.of(context).textTheme.headline5)
    ];
    var paddingWidgets = [
      TextFormField(
        decoration: InputDecoration(
          labelText: "账号",
          prefixIcon: Icon(Icons.person),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "账号不能为空";
          }
          return null;
        },
        onSaved: (value) {
          _user.account = value;
        },
      ),
      TextFormField(
          obscureText: true,
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: "密码",
            prefixIcon: Icon(Icons.lock),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value.isEmpty) {
              return "密码不能为空";
            }
            return null;
          }),
      TextFormField(
        obscureText: true,
        controller: _passwordAgainController,
        decoration: InputDecoration(
          labelText: "再次输入密码",
          prefixIcon: Icon(Icons.lock),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value.isEmpty) {
            return "密码不能为空";
          }
          if (!_isSamePassword()) {
            return "两次密码不一样";
          }
          return null;
        },
        onSaved: (value) {
          _user.password = value;
        },
      ),
      TextFormField(
        decoration: InputDecoration(
          labelText: "用户名",
          prefixIcon: Icon(Icons.assignment_ind),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "用户名不能为空";
          }
          return null;
        },
        onSaved: (value) {
          _user.userName = value;
        },
      ),
      TextFormField(
        decoration: InputDecoration(
          labelText: "电话",
          prefixIcon: Icon(Icons.phone),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "电话不能为空";
          }
          return null;
        },
        onSaved: (value) {
          _user.phone = value;
        },
      ),
      DropdownButtonFormField(
        value: _user.sex,
        decoration: InputDecoration(labelText: '性别'),
        items: [
          DropdownMenuItem(
            child: Text("男"),
            value: "男",
          ),
          DropdownMenuItem(
            child: Text("女"),
            value: "女",
          )
        ],
        onChanged: (value) {
          _user.sex = value;
        },
      ),
      ButtonBar(
        children: [
          FlatButton(
            onPressed: () {
              dismissDialog(context);
            },
            child: Text("返回"),
          ),
          MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                Result<User> result = await addUser(_user);
                if (result.code == 1) {
                  dismissDialog(context, result: result.data);
                } else {
                  print(result.message);
                }
              }
            },
            child: Text("注册"),
          )
        ],
      )
    ];
    widgets.addAll(paddingWidgets.map((e) => Padding(
          padding: EdgeInsets.all(8.0),
          child: e,
        )));
    return widgets;
  }
}

Future<User> showRegisterDialog(context) => showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 400,
          child: RegisterPage(),
        ),
      ),
    );
