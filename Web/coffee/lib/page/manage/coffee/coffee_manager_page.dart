import 'package:coffee/model/coffee.dart';
import 'package:coffee/model/coffee_status.dart';
import 'package:coffee/model/result.dart';
import 'package:coffee/page/manage/coffee/coffee_edit_page.dart';
import 'package:coffee/service/coffee_service.dart';
import 'package:coffee/util/dialog.dart';
import 'package:coffee/util/dio_app.dart';
import 'package:coffee/util/ui_tool.dart';
import 'package:flutter/material.dart';

class CoffeeManagePage extends StatefulWidget {
  @override
  _CoffeeManagePageState createState() => _CoffeeManagePageState();
}

class _CoffeeManagePageState extends State<CoffeeManagePage>
    with _CoffeeManageHandler {
  var _curFirstRowIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCoffeeList(),
      builder: (context, AsyncSnapshot<Result<List<Coffee>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          {
            return SingleChildScrollView(
              child: Container(
                child: PaginatedDataTable(
                  dataRowHeight: 100,
                  rowsPerPage: 6,
                  initialFirstRowIndex: _curFirstRowIndex,
                  header: Text("咖啡管理"),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () async {
                        bool isUpdate = await showCoffeeEdit(Coffee.add());
                        if (isUpdate) {
                          refresh();
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: refresh,
                    )
                  ],
                  columns: [
                    DataColumn(label: Text("咖啡ID")),
                    DataColumn(label: Text("咖啡名字")),
                    DataColumn(label: Text("咖啡图片")),
                    DataColumn(label: Text("咖啡单价")),
                    DataColumn(label: Text("咖啡上架状态")),
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
                  source: _CoffeeDataSource(context, this, snapshot.data.data),
                  onPageChanged: (value) {
                    _curFirstRowIndex = value;
                  },
                ),
              ),
            );
          }
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
  Future<bool> showCoffeeEdit(Coffee coffee) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: 800,
          height: 800,
          child: CoffeeEditPage(coffee),
        ),
      ),
    );
  }
}

class _CoffeeDataSource extends DataTableSource {
  List<Coffee> _coffees;
  BuildContext _context;
  _CoffeeManageHandler _handler;

  _CoffeeDataSource(this._context, this._handler, this._coffees);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _coffees.length) return null;
    final coffee = _coffees[index];
    return DataRow(cells: [
      DataCell(Text(coffee.coffeeId.toString())),
      DataCell(Text(coffee.coffeeName)),
      DataCell(
        SizedBox(
          width: 90,
          height: 90,
          child: Builder(
            builder: (context) {
              if (coffee.coffeeUrl.isEmpty) {
                return Container();
              } else {
                return Image.network(imageUrl(coffee.coffeeUrl));
              }
            },
          ),
        ),
      ),
      DataCell(Text(coffee.coffeePrice.toString())),
      DataCell(Text(coffee.status())),
      DataCell(ButtonBar(
        children: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.blue,
            ),
            onPressed: () async {
              bool isUpdate = await _handler.showCoffeeEdit(coffee);
              if (isUpdate) {
                _handler.refresh();
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.grey,
            ),
            onPressed: () {
              _deleteCoffee(_context, coffee);
            },
          ),
          IconButton(
            icon: Icon(coffee.coffeeStatus == OFF_SOLD
                ? Icons.arrow_circle_up
                : Icons.arrow_circle_down),
            color: coffee.coffeeStatus == OFF_SOLD ? Colors.green : Colors.red,
            onPressed: () async {
              int status = coffee.coffeeStatus == ON_SOLD ? OFF_SOLD : ON_SOLD;
              Result<String> result =
                  await updateStatus(coffee.coffeeId, status);
              showToast(result.message);
              _handler.refresh();
            },
          ),
        ],
      ))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _coffees.length;

  @override
  int get selectedRowCount => 0;

  _deleteCoffee(BuildContext context, Coffee coffee) async {
    bool isDelete = await showConfirmDialog(
        context, "删除确认", "是否删除ID为${coffee.coffeeId}的${coffee.coffeeName}");
    if (isDelete) {
      Result<String> result = await deleteCoffee(coffee.coffeeId);
      if (result.code == 1) {
        showToast("删除成功");
        _handler.refresh();
      }
    }
  }
}

abstract class _CoffeeManageHandler {
  void refresh();

  Future<bool> showCoffeeEdit(Coffee coffee);
}
