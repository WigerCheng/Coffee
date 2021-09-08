import 'dart:core';

import 'package:coffee/model/result.dart';
import 'package:coffee/model/user.dart';
import 'package:coffee/page/manage/user/user_manager_edit.dart';
import 'package:coffee/service/user_service.dart';
import 'package:coffee/util/dialog.dart';
import 'package:coffee/util/ui_tool.dart';
import 'package:flutter/material.dart';

class UserManagePage extends StatefulWidget {
  @override
  _UserManagePageState createState() => _UserManagePageState();
}

class _UserManagePageState extends State<UserManagePage>
    with _UserManageHandler {
  var _curFirstRowIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return SingleChildScrollView(
            child: PaginatedDataTable(
              header: Text('用户管理'),
              actions: [
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      showUserEdit(null);
                    }),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: refresh,
                )
              ],
              initialFirstRowIndex: _curFirstRowIndex,
              columns: [
                DataColumn(label: Text("用户名")),
                DataColumn(label: Text("用户类型")),
                DataColumn(label: Text("性别")),
                DataColumn(label: Text("手机")),
                DataColumn(
                  label: Expanded(
                    child: Align(
                      child: Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Text("操作"),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ),
              ],
              source: _UserDataSource(context, this, snapshot.data.data),
              rowsPerPage: 10,
              onPageChanged: (value) {
                _curFirstRowIndex = value;
              },
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  void refresh() {
    setState(() {});
  }

  @override
  void showUserEdit(User user) async {
    bool isUpdate = await showUserManageDialog(context, user);
    if (isUpdate) {
      refresh();
    }
  }
}

class _UserDataSource extends DataTableSource {
  _UserDataSource(this._context, this._handler, this._users);

  List<User> _users = List();
  BuildContext _context;
  _UserManageHandler _handler;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _users.length) return null;
    final user = _users[index];
    return DataRow(cells: [
      DataCell(Text(user.userName ?? "")),
      DataCell(Text(user.typeStr() ?? "")),
      DataCell(Text(user.sex ?? "")),
      DataCell(Text(user.phone ?? "")),
      DataCell(ButtonBar(
        children: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.blue,
            ),
            onPressed: () {
              _handler.showUserEdit(user);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.grey,
            ),
            onPressed: () async {
              bool delete = await showConfirmDialog(
                  _context, "警告", "是否删除${user.userName}这个用户");
              if (delete) {
                Result result = await deleteUser(user.userId);
                print(result.message);
                if (result.code == 1) {
                  showToast("用户删除成功");
                  _handler.refresh();
                } else {
                  print("删除失败");
                }
              } else {
                print("返回");
              }
            },
          )
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _users.length;

  @override
  int get selectedRowCount => 0;
}

abstract class _UserManageHandler {
  void refresh();

  void showUserEdit(User user);
}
