import 'package:flutter/material.dart';

Future<bool> showConfirmDialog(
    BuildContext context, String title, String text) {
  return _showDialog(context, (context) {
    return AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: [
        FlatButton(
          child: Text("取消"),
          onPressed: () => dismissDialog(context, result: false),
        ),
        FlatButton(
          child: Text("确定"),
          onPressed: () => dismissDialog(context, result: true),
        )
      ],
    );
  });
}

void dismissDialog(context, {result}) {
  Navigator.pop(context, result);
}

Future<bool> _showDialog(context, builder) =>
    showDialog(context: context, barrierDismissible: false, builder: builder);
