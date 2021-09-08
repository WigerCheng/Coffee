import 'package:coffee/model/order.dart';
import 'package:coffee/model/result.dart';
import 'package:coffee/service/order_service.dart';
import 'package:coffee/util/dialog.dart';
import 'package:coffee/util/ui_tool.dart';
import 'package:flutter/material.dart';

import 'order_detail_page.dart';

class OrderManagePage extends StatefulWidget {
  @override
  _OrderManagePageState createState() => _OrderManagePageState();
}

class _OrderManagePageState extends State<OrderManagePage>
    with _OrderManageHandler {
  var _curFirstRowIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getOrderList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SingleChildScrollView(
            child: PaginatedDataTable(
              header: Text("订单管理"),
              initialFirstRowIndex: _curFirstRowIndex,
              actions: [
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: refresh,
                )
              ],
              rowsPerPage: 10,
              columns: [
                DataColumn(label: Text("订单ID")),
                DataColumn(label: Text("用户名字")),
                DataColumn(label: Text("订单金额")),
                DataColumn(label: Text("订单状态")),
                DataColumn(label: Text("下单时间")),
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
              source: _OrderDataSource(context, this, snapshot.data.data),
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
}

class _OrderDataSource extends DataTableSource {
  List<Order> _orders;
  BuildContext _context;
  _OrderManageHandler _handler;

  _OrderDataSource(this._context, this._handler, this._orders);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _orders.length) return null;
    final order = _orders[index];
    return DataRow(cells: [
      DataCell(Text(order.orderId.toString())),
      DataCell(Text(order.userName)),
      DataCell(Text("￥${order.orderMoney}")),
      DataCell(
        Container(
          decoration: BoxDecoration(
            color: order.typeBackgroundColor(),
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: EdgeInsets.all(8.0),
          child: Text(
            order.getOrderStatus(),
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
      DataCell(Text(
          DateTime.fromMillisecondsSinceEpoch(order.orderDate).toString())),
      DataCell(
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  Icons.description_rounded,
                  color: Colors.blue,
                ),
                onPressed: () async {
                  await showOrderManageDialog(_context, order);
                },
              ),
              PopupMenuButton<Menu>(
                onSelected: (Menu result) async {
                  switch (result) {
                    case Menu.DELETE:
                      _deleteOrder(_context, order.orderId);
                      break;
                    case Menu.FINISH:
                      _pushOrderFinish(_context, order.orderId);
                      break;
                    case Menu.RETURN:
                      _returnOrder(_context, order.orderId);
                      break;
                    case Menu.RECEIVE:
                      _receiveOrder(_context, order.orderId);
                      break;
                  }
                },
                tooltip: "操作",
                itemBuilder: (context) => _buildPopupMenus(order),
              ),
            ],
          ),
        ),
      )
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _orders.length;

  @override
  int get selectedRowCount => 0;

  List<PopupMenuItem<Menu>> _buildPopupMenus(Order order) {
    var menus = List<PopItem>();
    if (order.status == Order.ORDER_NON_RECEIVED) {
      menus.add(
        PopItem(
          Menu.RECEIVE,
          "接收订单",
          Icon(
            Icons.call_received,
            color: Colors.yellow,
          ),
        ),
      );
    }
    if (order.status == Order.ORDER_RECEIVED) {
      menus.add(
        PopItem(
          Menu.FINISH,
          "订单完成",
          Icon(
            Icons.assignment_turned_in,
            color: Colors.green,
          ),
        ),
      );
      menus.add(
        PopItem(
          Menu.RETURN,
          "退单",
          Icon(
            Icons.cancel,
            color: Colors.red,
          ),
        ),
      );
    }
    menus.add(
      PopItem(
        Menu.DELETE,
        "删除订单",
        Icon(
          Icons.delete,
          color: Colors.grey,
        ),
      ),
    );
    return menus
        .map((e) => PopupMenuItem(
              value: e.value,
              child: Wrap(
                spacing: 10,
                children: [e.icon, Text(e.text)],
              ),
            ))
        .toList();
  }

  _receiveOrder(BuildContext context, int orderId) async {
    bool isReceive =
        await showConfirmDialog(context, "接收确认", "是否接收ID为$orderId这份订单");
    if (isReceive) {
      Result<String> result = await receiveOrder(orderId);
      if (result.code == 1) {
        showToast("接收成功");
        _handler.refresh();
      }
    }
  }

  _deleteOrder(BuildContext context, int orderId) async {
    bool isDelete =
        await showConfirmDialog(context, "删除确认", "是否删除ID为$orderId这份订单");
    if (isDelete) {
      Result<String> result = await deleteOrderNetwork(orderId);
      if (result.code == 1) {
        showToast("删除成功");
        _handler.refresh();
      }
    }
  }

  _returnOrder(BuildContext context, int orderId) async {
    bool isReturn =
        await showConfirmDialog(context, "退单确认", "是否退掉ID为$orderId这份订单");
    if (isReturn) {
      Result<String> result = await returnOrderNetwork(orderId);
      if (result.code == 1) {
        showToast("退单成功");
        _handler.refresh();
      }
    }
  }

  _pushOrderFinish(BuildContext context, int orderId) async {
    bool isFinish =
        await showConfirmDialog(context, "订单完成", "是否通知ID为$orderId这份订单已完成");
    if (isFinish) {
      Result<String> result = await pushOrderFinishNetwork(orderId);
      if (result.code == 1) {
        showToast("已通知用户订单完成");
        _handler.refresh();
      }
    }
  }
}

class PopItem {
  final Menu value;
  final String text;
  final Icon icon;

  PopItem(this.value, this.text, this.icon);
}

enum Menu { FINISH, RETURN, DELETE, RECEIVE }

abstract class _OrderManageHandler {
  void refresh();
}
