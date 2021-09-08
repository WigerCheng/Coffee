import 'package:coffee/model/result.dart';
import 'package:coffee/model/user.dart';
import 'package:coffee/service/user_service.dart';
import 'package:coffee/util/dialog.dart';
import 'package:coffee/util/ui_tool.dart';
import 'package:flutter/material.dart';

class UserEditPage extends StatefulWidget {
  final User user;

  UserEditPage(this.user);

  @override
  _UserEditPage createState() => _UserEditPage();
}

class _UserEditPage extends State<UserEditPage> {
  User _user;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _user = widget.user;
    if (_user == null) {
      _user = User(userName: "", type: User.USER_MANAGER, sex: "男");
    }
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: _formList(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _formList() {
    var widgets = [
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
          return null;
        },
        onSaved: (value) {
          _user.account = value;
        },
      ),
      TextFormField(
        initialValue: _user.password ?? "",
        decoration:
            InputDecoration(labelText: "密码", prefixIcon: Icon(Icons.lock)),
        validator: (value) {
          if (value.isEmpty) {
            return "密码不能为空";
          }
          return null;
        },
        onSaved: (value) {
          _user.password = value;
        },
      ),
      TextFormField(
        initialValue: _user.userName ?? "",
        decoration:
            InputDecoration(labelText: "用户名", prefixIcon: Icon(Icons.label)),
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
        initialValue: _user.phone ?? "",
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
      DropdownButtonFormField(
        value: _user.type,
        decoration: InputDecoration(labelText: '用户类型'),
        items: [
          DropdownMenuItem(
            child: Text("管理员"),
            value: User.USER_MANAGER,
          ),
          DropdownMenuItem(
            child: Text("顾客"),
            value: User.USER_CUSTOMER,
          )
        ],
        onChanged: (value) {
          _user.type = value;
        },
      ),
      ButtonBar(
        children: [
          FlatButton(
            child: Text("返回"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          RaisedButton(
            child: Text("保存"),
            color: Colors.blue,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                Result result;
                if (_user.userId == null) {
                  result = await addUser(_user);
                } else {
                  result = await updateUser(_user);
                }
                if (result.code == 1) {
                  dismissDialog(context, result: true);
                  showToast(result.message);
                } else {
                  showToast(result.message);
                }
              }
            },
          )
        ],
      )
    ];
    return widgets
        .map(
          (e) => Padding(
            padding: EdgeInsets.all(8.0),
            child: e,
          ),
        )
        .toList();
  }
}

Future<bool> showUserManageDialog(context, user) => showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: 600,
          height: 600,
          child: UserEditPage(user),
        ),
      ),
    );

Future<User> showUserDialog(context, user) => showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: 600,
          height: 600,
          child: UserEditPage(user),
        ),
      ),
    );
